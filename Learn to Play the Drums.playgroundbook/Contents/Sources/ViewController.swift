//
//  ViewController.swift
//  RhythmUI
//
//  Created by Bruno Scheltzke on 22/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

public typealias BarBeat = (bar: Int32, beat: Int32)

public class ViewController: UIViewController {
    public var metronome = Metronome()
    
    public var finishAssessment: (() -> Void)!
    
    public var snareView = DrumItem(drumPart: .snare)
    public var bassView = DrumItem(drumPart: .bass)
    public var hitHatView = DrumItem(drumPart: .hitHat)
    
    public var currentBarBeat: BarBeat = (0,0)
    
    public var nextSnareBarBeats: [BarBeat] = []
    public var nextBassBarBeats: [BarBeat] = []
    public var nextHitHatBarBeats: [BarBeat] = []
    
    public var tolerance: Double = 0
    public var latsBeatTime: CFAbsoluteTime = 0
    
    public var freePlayMode: Bool = false
    
    public let metronomeLabel = UILabel()
    
    public var currentLesson: Lesson = Lesson.lesson4() {
        didSet {
            snareView.noteGoal = currentLesson.snareGoal
            hitHatView.noteGoal = currentLesson.hitHatGoal
            bassView.noteGoal = currentLesson.bassGoal
        }
    }
    
    public init(lesson: Lesson) {
        self.currentLesson = lesson
        
        metronome.setTempo(lesson.tempo)
        tolerance = Double((60/metronome.tempoBPM)/2)
        
        super.init(nibName: nil, bundle: nil)
        
        snareView.delegate = self
        bassView.delegate = self
        hitHatView.delegate = self
        metronome.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let playgroundView = UIStackView()
        playgroundView.distribution = .fillEqually
        
        view.addSubview(playgroundView)
        
        playgroundView.translatesAutoresizingMaskIntoConstraints = false
        playgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let drumContainer = UIStackView()
        drumContainer.distribution = .fillEqually
        
        drumContainer.addArrangedSubview(snareView)
        drumContainer.addArrangedSubview(bassView)
        drumContainer.addArrangedSubview(hitHatView)
        
        //Used on ui testing project
        let instructionsView = UIView()
        
        view.addSubview(metronomeLabel)
        metronomeLabel.font = UIFont.boldSystemFont(ofSize: 450)
        metronomeLabel.textAlignment = NSTextAlignment.center
        metronomeLabel.text = ""
        metronomeLabel.textColor = UIColor.white.withAlphaComponent(0.2)
        metronomeLabel.translatesAutoresizingMaskIntoConstraints = false
        metronomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        metronomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        metronomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        metronomeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        metronomeLabel.layer.zPosition = 1.0
        
        //playgroundView.addArrangedSubview(instructionsView)
        playgroundView.addArrangedSubview(drumContainer)
        
        metronome.start()
        currentLesson.playSong()
    }
}

extension ViewController: MetronomeDelegate {
    public func metronomeTicking(_ metronome: Metronome, bar: Int32, beat: Int32) {
        currentBarBeat = (bar, beat)
        
        latsBeatTime = CFAbsoluteTimeGetCurrent()
        
        DispatchQueue.main.async {
            self.snareView.updateNoteViews(withTolerance: self.tolerance)
            self.hitHatView.updateNoteViews(withTolerance: self.tolerance)
            self.bassView.updateNoteViews(withTolerance: self.tolerance)
        }
        
        DispatchQueue.main.async {
            self.metronomeLabel.text = "\(beat)"
        }
        
        let barBeat = "\(bar + 1)\(beat)"
        
        let drumPartsToBePlayed = currentLesson.tablature[barBeat]
        drumPartsToBePlayed?.forEach({ (drumPart) in
            
            if currentLesson.isLoop {
                currentLesson.tablature["\(bar + 2)\(beat)"] = drumPartsToBePlayed!
            }
            
            switch drumPart {
            case .bass:
                DispatchQueue.main.async {
                    self.bassView.createNote(barBeat: (bar + 1, beat))
                }
            case .snare:
                DispatchQueue.main.async {
                    self.snareView.createNote(barBeat: (bar + 1, beat))
                }
            case .hitHat:
                DispatchQueue.main.async {
                    self.hitHatView.createNote(barBeat: (bar + 1, beat))
                }
            }
        })
    }
    
    public func barBeat(after barBeat: BarBeat) -> BarBeat {
        return barBeat.beat == 4 ? (barBeat.bar + 1, 1) : (barBeat.bar, barBeat.beat + 1)
    }
}

extension ViewController: DrumItemDelegate {
    public func didPlayDrumItem(_ drumItem: DrumItem) {
        
        let timeSinceLastBeat = CFAbsoluteTimeGetCurrent() - latsBeatTime
        
        guard let nextNote = drumItem.notes.first else { return }
        if (nextNote.barBeat == currentBarBeat && timeSinceLastBeat <= tolerance) || (barBeat(after: currentBarBeat) == nextNote.barBeat) && timeSinceLastBeat >= tolerance {
            drumItem.increaseProgress()
        }
        
        if snareView.notesPlayed >= snareView.noteGoal && hitHatView.notesPlayed >= hitHatView.noteGoal && bassView.notesPlayed >= bassView.noteGoal && !freePlayMode {
            finishAssessment()
        }
    }
}

