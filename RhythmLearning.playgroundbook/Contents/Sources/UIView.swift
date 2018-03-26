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
