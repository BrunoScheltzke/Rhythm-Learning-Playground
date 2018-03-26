//
//  Keys.swift
//  SongGame
//
//  Created by Bruno Scheltzke on 19/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

struct GlobalConstants {
    static let snareSound = "snareSound"
    static let bassSound = "bassSound"
    static let hitHatSound = "hitHatSound"
    
    static let snareImage = "snareDrum"
    static let bassImage = "bassDrum"
    static let hitHatImage = "hitHatDrum"
    
    static let kBipDurationSeconds: Float32 = 0.020
    static let kTempoChangeResponsivenessSeconds: Float32 = 0.250
}

//
//  Lesson.swift
//  RhythmUI
//
//  Created by Bruno Scheltzke on 23/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation

public struct Lesson {
    public var name: String
    
    /**
     The instruments to be played at a specific bar and beat;
     Exemple ["13"] = [.snare, .bass] -> snare and bass to be played at Bar 1 Beat 3
     */
    public var tablature: [String: [DrumPart]]
    
    public var isLoop: Bool = false
    
    public var snareGoal: Int
    public var hitHatGoal: Int
    public var bassGoal: Int
    
    public init(name: String, tablature: [String: [DrumPart]], isLoop: Bool, snareGoal: Int, hitHatGoal: Int, bassGoal: Int) {
        self.name = name
        self.tablature = tablature
        self.isLoop = isLoop
        self.bassGoal = bassGoal
        self.hitHatGoal = hitHatGoal
        self.snareGoal = snareGoal
    }
}

