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
}
