//
//  UIView.swift
//  RhythmUI
//
//  Created by Bruno Scheltzke on 23/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

public extension UIView {
    public func circled() {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
}

public extension CABasicAnimation {
    public static func pulsate(toValue value: CGFloat = 1.2, withDuration duration: CFTimeInterval = 0.3) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = value
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = 1.0
        
        return animation
    }
    
    public static func bounce(from origin: CGFloat, by value: CGFloat, withDuration duration: CFTimeInterval = 0.3) -> CABasicAnimation {
        let bounceAnimation = CABasicAnimation(keyPath: "position.y")
        bounceAnimation.duration = duration
        bounceAnimation.speed = 1.2
        bounceAnimation.fromValue = origin
        bounceAnimation.byValue = value
        bounceAnimation.repeatCount = 1
        bounceAnimation.autoreverses = false
        bounceAnimation.fillMode = kCAFillModeForwards
        bounceAnimation.isRemovedOnCompletion = false
        bounceAnimation.isAdditive = true
        
        return bounceAnimation
    }
}

public extension CALayer {
    public func pulsate(toValue value: CGFloat = 1.2, withDuration duration: CFTimeInterval = 0.3) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = value
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = 1.0
        
        add(animation, forKey: "pulsation")
    }
    
    public func bounce(from origin: CGFloat, by value: CGFloat, withDuration duration: CFTimeInterval = 0.3) {
        let bounceAnimation = CABasicAnimation(keyPath: "position.y")
        bounceAnimation.duration = duration
        bounceAnimation.speed = 1.2
        bounceAnimation.fromValue = origin
        bounceAnimation.byValue = value
        bounceAnimation.repeatCount = 1
        bounceAnimation.autoreverses = false
        bounceAnimation.fillMode = kCAFillModeForwards
        bounceAnimation.isRemovedOnCompletion = false
        bounceAnimation.isAdditive = true
        
        add(bounceAnimation, forKey: "bounceAnimation")
    }
}

