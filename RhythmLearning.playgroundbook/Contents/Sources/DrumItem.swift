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
}

public typealias DrumCharacteristic = (image: String, mainColor: UIColor, secondaryColor: UIColor, imageFrame: CGRect, yPosition: CGFloat)

public class DrumItem: UIView {
    public let shapeLayer = CAShapeLayer()
    public var delegate: DrumItemDelegate!
    public var drumPart: DrumPart
    public var currentProgress: Double = 0
    public var drumItemImage = UIImageView()
    
    public let drumViewWidth = 143
    public let drumSectionViewHeight = 480
    public let drumSectionViewWidth = 213
    
    public let progressCircleRadius: CGFloat = 71.5
    
    public init(frame: CGRect = CGRect(x: 0, y: 0, width: 170.6, height: 768), drumPart: DrumPart) {
        self.drumPart = drumPart
        super.init(frame: frame)
        setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        drumPart = .bass
        super.init(coder: aDecoder)!
        setup()
    }
    
    public func setup() {
        let drumCharacteristic = getCharacteristic(of: drumPart)
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = frame.size
        gradientLayer.colors = [drumCharacteristic.mainColor.withAlphaComponent(0.8).cgColor, drumCharacteristic.mainColor.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.addSublayer(gradientLayer)
        
        //add button to respond to interactions
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        button.addTarget(self, action: #selector(didTapView), for: .touchDown)
        addSubview(button)
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.width/2, y: drumCharacteristic.yPosition), radius: progressCircleRadius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //track layer
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = drumCharacteristic.secondaryColor.cgColor
        trackLayer.lineWidth = 16
        trackLayer.lineCap = kCALineCapRound
        trackLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(trackLayer)
        
        //animation layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = drumCharacteristic.mainColor.cgColor
        shapeLayer.lineWidth = 16
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
        
        drumItemImage = UIImageView(frame: drumCharacteristic.imageFrame)
        
        switch drumPart {
        case .bass:
            drumItemImage.image = #imageLiteral(resourceName: "bassDrum")
        case .hitHat:
            drumItemImage.image = #imageLiteral(resourceName: "hitHatDrum")
        case .snare:
            drumItemImage.image = #imageLiteral(resourceName: "snareDrum")
        }
        
        addSubview(drumItemImage)
    }
    
    //from 0 to 1
    func increaseProgress(by progress: Double) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = currentProgress
        basicAnimation.byValue = progress
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "strokeEnd")
        
        currentProgress += progress
    }
    
    @objc public func didTapView() {
        SoundManager.shared.playSound(for: drumPart)
        increaseProgress(by: 0.2)
        //delegate.didPlayDrumItem(self)
    }
    
    private func getCharacteristic(of drumPart: DrumPart) -> DrumCharacteristic {
        switch drumPart {
        case .bass:
            return (GlobalConstants.bassImage, UIColor(red: 40/255, green: 186/255, blue: 108/255, alpha: 1), UIColor(red: 137/255, green: 180/255, blue: 157/255, alpha: 1), CGRect(x: frame.width/2 - 30.5, y: 617 - 30, width: 61, height: 60), 617)
        case .snare:
            return (GlobalConstants.snareImage, UIColor(red: 209/255, green: 157/255, blue: 35/255, alpha: 1), UIColor(red: 192/255, green: 173/255, blue: 129/255, alpha: 1), CGRect(x: frame.width/2 - 30, y: 593 - 30, width: 60, height: 60), 593)
        case .hitHat:
            return (GlobalConstants.hitHatImage, UIColor(red: 28/255, green: 210/255, blue: 204/255, alpha: 1), UIColor(red: 149/255, green: 180/255, blue: 179/255, alpha: 1), CGRect(x: frame.width/2 - 32, y: 593 - 13.5, width: 64, height: 27), 593)
        }
    }
}

public protocol DrumItemDelegate {
    func didPlayDrumItem(_ drumItem: DrumItem)
}

