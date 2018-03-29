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
    
    public static func lesson1() -> Lesson {
        return Lesson(name: "First Lesson", tablature: ["21": [DrumPart.hitHat], "22": [DrumPart.hitHat], "23": [DrumPart.hitHat], "24": [DrumPart.hitHat]], isLoop: true, snareGoal: 0, hitHatGoal: 16, bassGoal: 0)
    }
    
    public static func lesson2() -> Lesson {
        return Lesson(name: "Second Lesson", tablature: ["21": [DrumPart.hitHat], "22": [DrumPart.hitHat, DrumPart.snare], "23": [DrumPart.hitHat], "24": [DrumPart.hitHat, DrumPart.snare]], isLoop: true, snareGoal: 8, hitHatGoal: 16, bassGoal: 0)
    }
    
    public static func lesson3() -> Lesson {
        return Lesson(name: "Fourth Lesson", tablature: ["21": [DrumPart.hitHat, DrumPart.bass], "22": [DrumPart.hitHat, DrumPart.snare], "23": [DrumPart.hitHat, DrumPart.bass], "24": [DrumPart.hitHat, DrumPart.snare]], isLoop: true, snareGoal: 8, hitHatGoal: 16, bassGoal: 8)
    }
    
    public static func lesson4() -> Lesson {
        return Lesson(name: "Fourth Lesson", tablature: ["21": [DrumPart.hitHat, DrumPart.bass], "22": [DrumPart.hitHat, DrumPart.snare], "23": [DrumPart.hitHat, DrumPart.bass], "24": [DrumPart.hitHat, DrumPart.snare]], isLoop: true, snareGoal: 8, hitHatGoal: 16, bassGoal: 8, song: Song.song1)
    }
}
