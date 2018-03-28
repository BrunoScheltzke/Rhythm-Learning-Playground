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
    
    public var song: Song?
    
    public init(name: String, tablature: [String: [DrumPart]], isLoop: Bool, snareGoal: Int, hitHatGoal: Int, bassGoal: Int, song: Song? = nil) {
        self.name = name
        self.tablature = tablature
        self.isLoop = isLoop
        self.bassGoal = bassGoal
        self.hitHatGoal = hitHatGoal
        self.snareGoal = snareGoal
        self.song = song
    }
    
    public func playSong() {
        guard let song = self.song else { return }
        
        SoundManager.shared.play(song: song)
    }
}

