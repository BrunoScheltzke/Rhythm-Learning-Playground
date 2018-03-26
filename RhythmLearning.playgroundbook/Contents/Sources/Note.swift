//
//  Note.swift
//  RhythmUI
//
//  Created by Bruno Scheltzke on 23/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import UIKit

public class NoteView: UIView {
    public var yConstraint: NSLayoutConstraint!
    public var widthConstraint: NSLayoutConstraint!
    
    public var position = 0
    
    public init(drumPart: DrumPart) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = drumPart.getCharacteristics().mainColor
    }
    
    public override func draw(_ rect: CGRect) {
        circled()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
