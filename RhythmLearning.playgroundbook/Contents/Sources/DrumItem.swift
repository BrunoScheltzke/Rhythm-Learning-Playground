//
//  DrumItem.swift
//  Rhythm Learning
//
//  Created by Bruno Scheltzke on 20/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import SpriteKit
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
    public var drumItemImage = UIImageView()
    
    public var currentProgress: Double = 0
    public var noteGoal: Int = 0
    public var notesPlayed: Int = 0
    
    
    public let progressCircleRadius: CGFloat = 71.5
    
    public var yBassPosition: CGFloat = 0
    public var yDrumPosition: CGFloat = 0
    
    public var drumCharacteristics: DrumCharacteristic
    
    public let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    public let drumImageContainer = UIView()
    
    public let notePositioningView = UIView()
    
    //track layer
    public let trackLayer = CAShapeLayer()
    public let shapeLayer = CAShapeLayer()
    public let pulsatingLayer = CAShapeLayer()
    
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
        
        gradientLayer.frame = bounds
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: drumImageContainer.frame.width/2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        shapeLayer.path = circularPath.cgPath
        pulsatingLayer.path = circularPath.cgPath
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer.frame = rect
        gradientLayer.colors = [drumCharacteristics.mainColor.withAlphaComponent(0.8).cgColor, drumCharacteristics.mainColor.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: drumImageContainer.frame.width/2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //pulsating layer
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.fillColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 16
        pulsatingLayer.lineCap = kCALineCapRound
        pulsatingLayer.strokeColor = drumCharacteristics.mainColor.withAlphaComponent(1).cgColor
        pulsatingLayer.position = drumImageContainer.center
        
        layer.addSublayer(pulsatingLayer)
        
        //track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = drumCharacteristics.secondaryColor.cgColor
        trackLayer.lineWidth = 16
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = drumImageContainer.center
        
        layer.addSublayer(trackLayer)
        
        //animation layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = drumCharacteristics.mainColor.cgColor
        shapeLayer.lineWidth = 16
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = drumImageContainer.center
        
        layer.addSublayer(shapeLayer)
    }
    
    public func setup() {
        drumImageContainer.isOpaque = false
        addSubview(drumImageContainer)
        drumImageContainer.translatesAutoresizingMaskIntoConstraints = false
        drumImageContainer.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18).isActive = true
        drumImageContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18).isActive = true
        drumImageContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let bottomSpacing: CGFloat = (drumPart == .bass) ? -200 : -270
        
        drumImageContainer.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomSpacing).isActive = true
        
        
        self.addSubview(notePositioningView)
        notePositioningView.translatesAutoresizingMaskIntoConstraints = false
        notePositioningView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        notePositioningView.bottomAnchor.constraint(equalTo: drumImageContainer.centerYAnchor, constant: (drumPart == .bass) ? -55 : -5).isActive = true
        notePositioningView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notePositioningView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        
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
        
        switch drumPart {
        case .bass:
            drumItemImage.image = #imageLiteral(resourceName: "bassDrum")
        case .hitHat:
            drumItemImage.image = #imageLiteral(resourceName: "hitHatDrum")
        case .snare:
            drumItemImage.image = #imageLiteral(resourceName: "snareDrum")
        }
        
        drumImageContainer.addSubview(drumItemImage)
        drumItemImage.centerXAnchor.constraint(equalTo: drumImageContainer.centerXAnchor).isActive = true
        drumItemImage.centerYAnchor.constraint(equalTo: drumImageContainer.centerYAnchor).isActive = true
    }
    
    public func createNote() {
        let note = NoteView(drumPart: drumPart)
        notePositioningView.addSubview(note)
        
        note.centerXAnchor.constraint(equalTo: notePositioningView.centerXAnchor)
.isActive = true
        note.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let widthConstraint = note.widthAnchor.constraint(equalToConstant: 50)
        widthConstraint.isActive = true
        let yConstraint = note.centerYAnchor.constraint(equalTo: notePositioningView.topAnchor, constant: 0)
        yConstraint.isActive = true
        note.yConstraint = yConstraint
        note.widthConstraint = widthConstraint
    }
    
    public func updateNoteViews() {
        notePositioningView.subviews.forEach { (view) in
            guard let note = view as? NoteView else { return }
            
            note.position += 1
            
            note.yConstraint.constant += self.notePositioningView.frame.height/5
            
            
//            UIView.animate(withDuration: 0.5, animations: {
//                UIView.setAnimationRepeatAutoreverses(true)
//                note.widthConstraint.constant = 25
//                note.yConstraint.constant += self.notePositioningView.frame.height/5
//                note.layoutIfNeeded()
//            }, completion: { (_) in
//                if note.position == 5 {
//                    note.removeFromSuperview()
//                }
//            })
            UIView.animate(withDuration: 0.3, animations: {
                note.layoutIfNeeded()
            }, completion: { (_) in
                if note.position == 5 {
                    note.removeFromSuperview()
                }
            })
        }
    }
    
    public func increaseProgress() {
        pulsatingLayer.pulsate()
        
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
    
    @objc public func didTapView() {
        SoundManager.shared.playSound(for: drumPart)
        delegate.didPlayDrumItem(self)
    }
}

public protocol DrumItemDelegate {
    func didPlayDrumItem(_ drumItem: DrumItem)
}
