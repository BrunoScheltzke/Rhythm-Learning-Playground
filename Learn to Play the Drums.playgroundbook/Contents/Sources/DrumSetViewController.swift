//
//  DrumSetViewController.swift
//  RhythmUI
//
//  Created by Bruno Scheltzke on 22/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit
import PlaygroundSupport

public typealias BarBeat = (bar: Int32, beat: Int32)

public class DrumSetViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    public var metronome = Metronome()
    
    public var finishAssessment: (() -> Void)!
    
    public var tolerance: Double = 0
    
    public var freePlayMode: Bool = false
    
    var snareView = DrumItem(drumPart: .snare)
    var bassView = DrumItem(drumPart: .bass)
    var hitHatView = DrumItem(drumPart: .hitHat)
    
    let snareSection = DrumSectionView(drumPart: .snare)
    let bassSection = DrumSectionView(drumPart: .bass)
    let hitHatSection = DrumSectionView(drumPart: .hitHat)
    
    var currentBarBeat: BarBeat = (0,0)
    var latsBeatTime: CFAbsoluteTime = 0
    
    let metronomeLabel = UILabel()
    
    var currentLesson: Lesson = Lesson.lesson4() {
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
        
        view.isOpaque = false
        view.backgroundColor = .white
        
        metronome.start()
        currentLesson.playSong()
        
        setup()
    }
    
    func setup() {
        let drumSectionsStackView = UIStackView()
        drumSectionsStackView.distribution = .fillEqually
        
        view.addSubview(drumSectionsStackView)
        
        drumSectionsStackView.translatesAutoresizingMaskIntoConstraints = false
        drumSectionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        drumSectionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        drumSectionsStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        drumSectionsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        drumSectionsStackView.addArrangedSubview(snareSection)
        drumSectionsStackView.addArrangedSubview(bassSection)
        drumSectionsStackView.addArrangedSubview(hitHatSection)
        
        view.addSubview(metronomeLabel)
        metronomeLabel.font = UIFont.boldSystemFont(ofSize: 420)
        metronomeLabel.textAlignment = NSTextAlignment.center
        metronomeLabel.text = ""
        metronomeLabel.textColor = UIColor.white.withAlphaComponent(0.2)
        metronomeLabel.translatesAutoresizingMaskIntoConstraints = false
        metronomeLabel.centerXAnchor.constraint(equalTo: liveViewSafeAreaGuide.centerXAnchor).isActive = true
        metronomeLabel.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 65).isActive = true
        metronomeLabel.widthAnchor.constraint(equalTo: liveViewSafeAreaGuide.widthAnchor).isActive = true
        metronomeLabel.heightAnchor.constraint(equalTo: liveViewSafeAreaGuide.heightAnchor, multiplier: 0.5).isActive = true
        
        let drumContainer = UIStackView()
        drumContainer.distribution = .fillEqually
        
        view.addSubview(drumContainer)
        
        drumContainer.translatesAutoresizingMaskIntoConstraints = false
        drumContainer.leadingAnchor.constraint(equalTo: liveViewSafeAreaGuide.leadingAnchor).isActive = true
        drumContainer.trailingAnchor.constraint(equalTo: liveViewSafeAreaGuide.trailingAnchor).isActive = true
        drumContainer.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor).isActive = true
        drumContainer.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor).isActive = true
        
        drumContainer.addArrangedSubview(snareView)
        drumContainer.addArrangedSubview(bassView)
        drumContainer.addArrangedSubview(hitHatView)
    }
}

extension DrumSetViewController: MetronomeDelegate {
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
    
    fileprivate func barBeat(after barBeat: BarBeat) -> BarBeat {
        return barBeat.beat == 4 ? (barBeat.bar + 1, 1) : (barBeat.bar, barBeat.beat + 1)
    }
}

extension DrumSetViewController: DrumItemDelegate {
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

class DrumSectionView: UIView {
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    public var drumPart: DrumPart
    var drumCharacteristics: DrumCharacteristic
    
    public init(drumPart: DrumPart) {
        self.drumPart = drumPart
        drumCharacteristics = drumPart.getCharacteristics()
        super.init(frame: CGRect.zero)
        self.isOpaque = false
    }
    
    public required init(coder aDecoder: NSCoder) {
        drumPart = .bass
        drumCharacteristics = drumPart.getCharacteristics()
        super.init(coder: aDecoder)!
        self.isOpaque = false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradientLayer.frame = rect
        gradientLayer.colors = [drumCharacteristics.mainColor.withAlphaComponent(0.8).cgColor, drumCharacteristics.mainColor.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
