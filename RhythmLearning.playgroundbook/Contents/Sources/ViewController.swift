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
    
    public let metronomeLabel = UILabel()
    
    public var currentLesson: Lesson = Lesson(name: "First Lesson", tablature: ["11": [DrumPart.hitHat], "12": [DrumPart.hitHat], "13": [DrumPart.hitHat], "14": [DrumPart.hitHat]], isLoop: true, snareGoal: 0, hitHatGoal: 16, bassGoal: 0) {
        didSet {
            snareView.noteGoal = currentLesson.snareGoal
            hitHatView.noteGoal = currentLesson.hitHatGoal
            bassView.noteGoal = currentLesson.bassGoal
        }
    }
    
    public var lesson2: Lesson = Lesson(name: "Second Lesson", tablature: ["11": [DrumPart.hitHat], "12": [DrumPart.hitHat, DrumPart.snare], "13": [DrumPart.hitHat], "14": [DrumPart.hitHat, DrumPart.snare]], isLoop: true, snareGoal: 8, hitHatGoal: 16, bassGoal: 0)
    
    public var lesson3: Lesson = Lesson(name: "Third Lesson", tablature: ["11": [DrumPart.hitHat, DrumPart.bass], "12": [DrumPart.hitHat], "13": [DrumPart.hitHat, DrumPart.bass], "14": [DrumPart.hitHat]], isLoop: true, snareGoal: 0, hitHatGoal: 16, bassGoal: 8)
    
    public var lesson4: Lesson = Lesson(name: "Fourth Lesson", tablature: ["11": [DrumPart.hitHat, DrumPart.bass], "12": [DrumPart.hitHat, DrumPart.snare], "13": [DrumPart.hitHat, DrumPart.bass], "14": [DrumPart.hitHat, DrumPart.snare]], isLoop: true, snareGoal: 8, hitHatGoal: 16, bassGoal: 8)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        snareView.delegate = self
        bassView.delegate = self
        hitHatView.delegate = self
        
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
        
        let instructionsView = UIView()
        instructionsView.addSubview(metronomeLabel)
        metronomeLabel.font = UIFont.boldSystemFont(ofSize: 200)
        metronomeLabel.textAlignment = NSTextAlignment.center
        metronomeLabel.text = "Here we go!"
        metronomeLabel.translatesAutoresizingMaskIntoConstraints = false
        metronomeLabel.centerXAnchor.constraint(equalTo: instructionsView.centerXAnchor).isActive = true
        metronomeLabel.centerYAnchor.constraint(equalTo: instructionsView.centerYAnchor).isActive = true
        metronomeLabel.widthAnchor.constraint(equalTo: instructionsView.widthAnchor).isActive = true
        metronomeLabel.heightAnchor.constraint(equalTo: instructionsView.heightAnchor).isActive = true
        
        //playgroundView.addArrangedSubview(instructionsView)
        playgroundView.addArrangedSubview(drumContainer)
        
        metronome.delegate = self
        metronome.start()
        tolerance = Double((60/metronome.tempoBPM)/3)
    }
}

extension ViewController: MetronomeDelegate {
    public func metronomeTicking(_ metronome: Metronome, bar: Int32, beat: Int32) {
        currentBarBeat = (bar, beat)
        
        latsBeatTime = CFAbsoluteTimeGetCurrent()
        
        DispatchQueue.main.async {
            self.metronomeLabel.text = "\(bar)/\(beat)"
        }
        
        if let oldSnareNote = nextSnareBarBeats.first {
            if oldSnareNote < currentBarBeat {
                nextSnareBarBeats.removeFirst()
            }
        }
        
        if let oldBassNote = nextBassBarBeats.first {
            if oldBassNote < currentBarBeat {
                nextBassBarBeats.removeFirst()
            }
        }
        
        if let oldHitHatNote = nextHitHatBarBeats.first {
            if oldHitHatNote < currentBarBeat {
                nextHitHatBarBeats.removeFirst()
            }
        }
        
        let barBeat = "\(bar + 1)\(beat)"
        
        let drumPartsToBePlayed = currentLesson.tablature[barBeat]
        drumPartsToBePlayed?.forEach({ (drumPart) in
            
            if currentLesson.isLoop {
                currentLesson.tablature["\(bar + 2)\(beat)"] = drumPartsToBePlayed!
            }
            
            switch drumPart {
            case .bass:
                nextBassBarBeats.append((bar + 1, beat))
                DispatchQueue.main.async {
                    self.bassView.createNote()
                }
            case .snare:
                nextSnareBarBeats.append((bar + 1, beat))
                DispatchQueue.main.async {
                    self.snareView.createNote()
                }
            case .hitHat:
                nextHitHatBarBeats.append((bar + 1, beat))
                DispatchQueue.main.async {
                    self.hitHatView.createNote()
                }
            }
        })
        
        if currentBarBeat != (0, 0) {
            DispatchQueue.main.async {
                self.snareView.updateNoteViews()
                self.hitHatView.updateNoteViews()
                self.bassView.updateNoteViews()
            }
        }
    }
    
    public func barBeat(after barBeat: BarBeat) -> BarBeat {
        return barBeat.beat == 4 ? (barBeat.bar + 1, 1) : (barBeat.bar, barBeat.beat + 1)
    }
}

extension ViewController: DrumItemDelegate {
    public func didPlayDrumItem(_ drumItem: DrumItem) {
        let timeSinceLastBeat = CFAbsoluteTimeGetCurrent() - latsBeatTime
        
        switch drumItem.drumPart {
        case .snare:
            guard let nextBarBeat = nextSnareBarBeats.first else { return }
            if (nextBarBeat == currentBarBeat && timeSinceLastBeat <= tolerance) || (barBeat(after: currentBarBeat) == nextBarBeat) && timeSinceLastBeat >= tolerance {
                drumItem.increaseProgress()
                nextSnareBarBeats.removeFirst()
            }
        case .bass:
            guard let nextBarBeat = nextBassBarBeats.first else { return }
            if (nextBarBeat == currentBarBeat && timeSinceLastBeat <= tolerance) || (barBeat(after: currentBarBeat) == nextBarBeat) && timeSinceLastBeat >= tolerance {
                drumItem.increaseProgress()
                nextBassBarBeats.removeFirst()
            }
        case .hitHat:
            guard let nextBarBeat = nextHitHatBarBeats.first else { return }
            if (nextBarBeat == currentBarBeat && timeSinceLastBeat <= tolerance) || (barBeat(after: currentBarBeat) == nextBarBeat) && timeSinceLastBeat >= tolerance {
                drumItem.increaseProgress()
                nextHitHatBarBeats.removeFirst()
            }
        }
        
        if snareView.notesPlayed >= snareView.noteGoal && hitHatView.notesPlayed >= hitHatView.noteGoal && bassView.notesPlayed >= bassView.noteGoal {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.finishAssessment()
            })
        }
    }
}

