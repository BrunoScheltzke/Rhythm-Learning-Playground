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
    
    public var barBeat: BarBeat
    
    public var position = 0
    
    public var wasHit: Bool = false
    
    public init(drumPart: DrumPart, barBeat: BarBeat) {
        self.barBeat = barBeat
        
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = drumPart.getCharacteristics().mainColor
        
        self.layer.zPosition = 2.0
    }
    
    public override func draw(_ rect: CGRect) {
        circled()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        circled()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

