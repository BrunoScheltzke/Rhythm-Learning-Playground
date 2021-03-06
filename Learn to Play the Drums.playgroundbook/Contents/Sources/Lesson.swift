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
     Exemple ["23"] = [.snare, .bass] -> snare and bass to be played at Bar 1 Beat 3
     
     The bar needs to be at least 2 so there will be at least 4 beats for the user to follow the rhythm
     */
    public var tablature: [String: [DrumPart]]
    
    /**
     When set to true, a tablature need to have the information related to the 4 beats of the first bar only. The next bars will have the same information of the first bar
     */
    public var isLoop: Bool = false
    
    public var snareGoal: Int
    public var hitHatGoal: Int
    public var bassGoal: Int
    
    public var song: Song?
    
    public var tempo: Float
    
    public init(name: String, tablature: [String: [DrumPart]], isLoop: Bool, snareGoal: Int, hitHatGoal: Int, bassGoal: Int, song: Song? = nil, tempo: Float = 105) {
        self.name = name
        self.tablature = tablature
        self.isLoop = isLoop
        self.bassGoal = bassGoal
        self.hitHatGoal = hitHatGoal
        self.snareGoal = snareGoal
        self.song = song
        self.tempo = tempo
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
        return Lesson(name: "Fourth Lesson", tablature: ["21": [DrumPart.hitHat, DrumPart.bass], "22": [DrumPart.hitHat, DrumPart.snare], "23": [DrumPart.hitHat, DrumPart.bass], "24": [DrumPart.hitHat, DrumPart.snare]], isLoop: true, snareGoal: 8, hitHatGoal: 16, bassGoal: 8, song: Song.song2, tempo: 117)
    }
}
