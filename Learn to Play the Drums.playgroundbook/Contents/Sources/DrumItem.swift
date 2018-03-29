//
//  DrumItem.swift
//  Rhythm Learning
//
//  Created by Bruno Scheltzke on 20/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

public enum DrumPart {
    case bass
    case snare
    case hitHat
    
    public func getCharacteristics() -> DrumCharacteristic {
        switch self {
        case .bass:
            return (#imageLiteral(resourceName: "bassDrum"), UIColor(red: 40/255, green: 186/255, blue: 108/255, alpha: 1), UIColor(red: 137/255, green: 180/255, blue: 157/255, alpha: 1))
        case .snare:
            return (#imageLiteral(resourceName: "snareDrum"), UIColor(red: 209/255, green: 157/255, blue: 35/255, alpha: 1), UIColor(red: 192/255, green: 173/255, blue: 129/255, alpha: 1))
        case .hitHat:
            return (#imageLiteral(resourceName: "hitHatDrum"), UIColor(red: 28/255, green: 210/255, blue: 204/255, alpha: 1), UIColor(red: 149/255, green: 180/255, blue: 179/255, alpha: 1))
        }
    }
}

public typealias DrumCharacteristic = (image: UIImage, mainColor: UIColor, secondaryColor: UIColor)

public class DrumItem: UIView {
    public var delegate: DrumItemDelegate!
    
    public var drumPart: DrumPart
    
    public var noteGoal: Int = 0
    public var notesPlayed: Int = 0
    
    var drumItemImage = UIImageView()
    
    var currentProgress: Double = 0
    
    let trackLineWidth: CGFloat = 16
    
    let progressCircleRadius: CGFloat = 71.5
    
    var drumCharacteristics: DrumCharacteristic
    
    let drumImageContainer = UIView()
    
    var emitter = CAEmitterLayer()
    
    var notes: [NoteView] = []
    
    let noteSize: CGFloat = 50
    
    //positions of the notes
    let notePositioningView = UIView()
    let notePosition1View = UIView()
    let notePosition2View = UIView()
    let notePosition3View = UIView()
    let notePosition4View = UIView()
    let notePosition5View = UIView()
    
    //track layer
    let trackLayer = CAShapeLayer()
    let shapeLayer = CAShapeLayer()
    let pulsatingLayer = CAShapeLayer()
    
    public init(drumPart: DrumPart) {
        self.drumPart = drumPart
        drumCharacteristics = drumPart.getCharacteristics()
        super.init(frame: CGRect.zero)
        self.isOpaque = false
        setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        drumPart = .bass
        drumCharacteristics = drumPart.getCharacteristics()
        super.init(coder: aDecoder)!
        self.isOpaque = false
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: drumImageContainer.frame.width/2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        shapeLayer.path = circularPath.cgPath
        pulsatingLayer.path = circularPath.cgPath
        
        trackLayer.position = drumImageContainer.center
        shapeLayer.position = drumImageContainer.center
        pulsatingLayer.position = drumImageContainer.center
        
        emitter.emitterPosition = drumImageContainer.center
        emitter.emitterShape = kCAEmitterLayerCircle
        emitter.emitterSize = drumImageContainer.frame.size
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: drumImageContainer.frame.width/2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //pulsating layer
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.fillColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = trackLineWidth
        pulsatingLayer.lineCap = kCALineCapRound
        pulsatingLayer.strokeColor = drumCharacteristics.mainColor.withAlphaComponent(1).cgColor
        pulsatingLayer.position = drumImageContainer.center
        
        layer.addSublayer(pulsatingLayer)
        
        //track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = drumCharacteristics.secondaryColor.cgColor
        trackLayer.lineWidth = trackLineWidth
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = drumImageContainer.center
        
        layer.addSublayer(trackLayer)
        
        //animation layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = drumCharacteristics.mainColor.cgColor
        shapeLayer.lineWidth = trackLineWidth
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = drumImageContainer.center
        
        layer.addSublayer(shapeLayer)
        
        emitter.emitterPosition = drumImageContainer.center
        emitter.emitterShape = kCAEmitterLayerCircle
        emitter.emitterSize = drumImageContainer.frame.size
        
        let cell1 = setUpEmitterCell()
        cell1.name = "cell1"
        let cell2 = setUpEmitterCell()
        cell2.name = "cell2"
        let cell3 = setUpEmitterCell()
        cell3.name = "cell3"
        
        emitter.emitterCells = [cell1, cell2, cell3]
        
        layer.addSublayer(emitter)
    }
    
    func setUpEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        
        let intensity = Float(0.2)
        
        cell.birthRate = 0
        cell.lifetime = intensity
        cell.lifetimeRange = 0
        cell.velocity = CGFloat(350.0 * intensity)
        cell.velocityRange = CGFloat(80.0 * intensity)
        cell.emissionLongitude = CGFloat(Double.pi)
        cell.emissionRange = CGFloat(Double.pi)
        cell.spin = CGFloat(3.5 * intensity)
        cell.spinRange = CGFloat(4.0 * intensity)
        cell.scale = 0.1
        cell.scaleRange = CGFloat(intensity)
        cell.scaleSpeed = CGFloat(0.1 * intensity)
        
        cell.contents = drumCharacteristics.image.cgImage
        
        return cell
    }
    
    func startEmission() {
        emitter.setValue(3, forKeyPath: "emitterCells.cell1.birthRate")
        emitter.setValue(3, forKeyPath: "emitterCells.cell2.birthRate")
        emitter.setValue(3, forKeyPath: "emitterCells.cell3.birthRate")
        
        emitter.birthRate = 3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopEmission()
        }
    }
    
    func stopEmission() {
        emitter.setValue(0, forKeyPath: "emitterCells.cell1.birthRate")
        emitter.setValue(0, forKeyPath: "emitterCells.cell2.birthRate")
        emitter.setValue(0, forKeyPath: "emitterCells.cell3.birthRate")
        
        emitter.birthRate = 0
    }
    
    func setup() {
        drumImageContainer.isOpaque = false
        addSubview(drumImageContainer)
        drumImageContainer.translatesAutoresizingMaskIntoConstraints = false
        drumImageContainer.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18).isActive = true
        drumImageContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18).isActive = true
        drumImageContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let bottomSpacing: CGFloat = -(trackLineWidth*1.5 + progressCircleRadius)
        
        drumImageContainer.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomSpacing).isActive = true
        
        self.addSubview(notePositioningView)
        notePositioningView.translatesAutoresizingMaskIntoConstraints = false
        notePositioningView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        notePositioningView.bottomAnchor.constraint(equalTo: drumImageContainer.topAnchor).isActive = true
        notePositioningView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notePositioningView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        let notePositionsStackView = UIStackView()
        notePositioningView.addSubview(notePositionsStackView)
        notePositionsStackView.translatesAutoresizingMaskIntoConstraints = false
        notePositionsStackView.topAnchor.constraint(equalTo: notePositioningView.topAnchor).isActive = true
        notePositionsStackView.bottomAnchor.constraint(equalTo: drumImageContainer.bottomAnchor, constant: -trackLineWidth*1.5).isActive = true
        notePositionsStackView.leadingAnchor.constraint(equalTo: notePositioningView.leadingAnchor).isActive = true
        notePositionsStackView.trailingAnchor.constraint(equalTo: notePositioningView.trailingAnchor).isActive = true
        
        notePositionsStackView.distribution = .fillEqually
        notePositionsStackView.axis = .vertical
        
        notePositionsStackView.addArrangedSubview(notePosition1View)
        notePositionsStackView.addArrangedSubview(notePosition2View)
        notePositionsStackView.addArrangedSubview(notePosition3View)
        notePositionsStackView.addArrangedSubview(notePosition4View)
        notePositionsStackView.addArrangedSubview(notePosition5View)
        
        //add button to respond to interactions
        let button = UIButton(type: .system)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        button.addTarget(self, action: #selector(didTapView), for: .touchDown)
        
        drumItemImage = UIImageView()
        drumItemImage.translatesAutoresizingMaskIntoConstraints = false
        
        drumItemImage.image = drumCharacteristics.image
        
        drumImageContainer.addSubview(drumItemImage)
        drumItemImage.centerXAnchor.constraint(equalTo: drumImageContainer.centerXAnchor).isActive = true
        drumItemImage.centerYAnchor.constraint(equalTo: drumImageContainer.centerYAnchor).isActive = true
        
        let bottomLineView1 = UIView()
        notePosition1View.addSubview(bottomLineView1)
        bottomLineView1.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView1.bottomAnchor.constraint(equalTo: notePosition1View.bottomAnchor).isActive = true
        bottomLineView1.leadingAnchor.constraint(equalTo: notePosition1View.leadingAnchor).isActive = true
        bottomLineView1.trailingAnchor.constraint(equalTo: notePosition1View.trailingAnchor).isActive = true
        bottomLineView1.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomLineView1.backgroundColor = drumCharacteristics.mainColor.withAlphaComponent(0.4)
        
        let bottomLineView2 = UIView()
        notePosition2View.addSubview(bottomLineView2)
        bottomLineView2.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView2.bottomAnchor.constraint(equalTo: notePosition2View.bottomAnchor).isActive = true
        bottomLineView2.leadingAnchor.constraint(equalTo: notePosition2View.leadingAnchor).isActive = true
        bottomLineView2.trailingAnchor.constraint(equalTo: notePosition2View.trailingAnchor).isActive = true
        bottomLineView2.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomLineView2.backgroundColor = drumCharacteristics.mainColor.withAlphaComponent(0.4)
        
        let bottomLineView3 = UIView()
        notePosition3View.addSubview(bottomLineView3)
        bottomLineView3.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView3.bottomAnchor.constraint(equalTo: notePosition3View.bottomAnchor).isActive = true
        bottomLineView3.leadingAnchor.constraint(equalTo: notePosition3View.leadingAnchor).isActive = true
        bottomLineView3.trailingAnchor.constraint(equalTo: notePosition3View.trailingAnchor).isActive = true
        bottomLineView3.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomLineView3.backgroundColor = drumCharacteristics.mainColor.withAlphaComponent(0.4)
        
        let bottomLineView4 = UIView()
        notePosition4View.addSubview(bottomLineView4)
        bottomLineView4.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView4.bottomAnchor.constraint(equalTo: notePosition4View.bottomAnchor).isActive = true
        bottomLineView4.leadingAnchor.constraint(equalTo: notePosition4View.leadingAnchor).isActive = true
        bottomLineView4.trailingAnchor.constraint(equalTo: notePosition4View.trailingAnchor).isActive = true
        bottomLineView4.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomLineView4.backgroundColor = drumCharacteristics.mainColor.withAlphaComponent(0.4)
    }
    
    public func createNote(barBeat: BarBeat) {
        let note = NoteView(drumPart: drumPart, barBeat: barBeat)
        notePositioningView.addSubview(note)
        
        notes.append(note)
        
        note.centerXAnchor.constraint(equalTo: notePositioningView.centerXAnchor)
            .isActive = true
        note.heightAnchor.constraint(equalToConstant: noteSize).isActive = true
        note.widthAnchor.constraint(equalToConstant: noteSize).isActive = true
        let yConstraint = note.centerYAnchor.constraint(equalTo: notePositioningView.topAnchor, constant: noteSize/2)
        yConstraint.isActive = true
        note.yConstraint = yConstraint
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 4.0, initialSpringVelocity: 20, options: [.curveEaseInOut], animations: {
                note.center.y += self.notePosition1View.center.y
                note.yConstraint.constant = self.notePosition1View.center.y
                note.position = 1
            }, completion: nil)
        }
    }
    
    public func updateNoteViews(withTolerance tolerance: Double) {
        notes.forEach { (note) in
            let increase = notePosition3View.center.y - notePosition2View.center.y
            
            switch note.position {
            case 1:
                UIView.animate(withDuration: tolerance, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 20, options: [.curveEaseInOut], animations: {
                    note.backgroundColor = self.drumCharacteristics.mainColor.withAlphaComponent(0.7)
                    note.center.y += increase
                    note.yConstraint.constant += increase
                }, completion: nil)
            case 2:
                UIView.animate(withDuration: tolerance, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 20, options: [.curveEaseInOut], animations: {
                    note.backgroundColor = self.drumCharacteristics.mainColor.withAlphaComponent(0.4)
                    note.center.y += increase
                    note.yConstraint.constant += increase
                }, completion: nil)
            case 3:
                UIView.animate(withDuration: tolerance, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 20, options: [.curveEaseInOut], animations: {
                    note.backgroundColor = self.drumCharacteristics.mainColor.withAlphaComponent(0.1)
                    note.center.y += increase
                    note.yConstraint.constant += increase
                }, completion: nil)
            case 4:
                note.backgroundColor = self.drumCharacteristics.mainColor.withAlphaComponent(0)
                UIView.animate(withDuration: tolerance, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 20, options: [.curveEaseInOut], animations: {
                    note.center.y += increase
                    note.yConstraint.constant += increase + self.trackLineWidth/1.5
                }, completion: { _ in
                    
                    if !note.wasHit {
                        self.notes.removeFirst()
                        
                        UIView.animate(withDuration: 1, animations: {
                            note.center.y = self.frame.height + self.noteSize
                            note.yConstraint.constant = self.frame.height + self.noteSize
                            
                            note.layer.pulsate(toValue: 0, withDuration: 2)
                            
                        }, completion: { (_) in
                            note.removeFromSuperview()
                        })
                    }
                })
            default:
                break
            }
            
            note.position += 1
        }
    }
    
    func hitNote() {
        startEmission()
        pulsatingLayer.pulsate()
        notes.first?.wasHit = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.notes.first?.removeFromSuperview()
            self.notes.removeFirst()
        }
    }
    
    public func increaseProgress() {
        hitNote()
        
        let progress = 0.788/Double(noteGoal)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = currentProgress
        basicAnimation.byValue = progress
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "strokeEnd")
        
        currentProgress += progress
        notesPlayed += 1
    }
    
    @objc func didTapView() {
        SoundManager.shared.playSound(for: drumPart)
        delegate.didPlayDrumItem(self)
    }
}

public protocol DrumItemDelegate {
    func didPlayDrumItem(_ drumItem: DrumItem)
}


