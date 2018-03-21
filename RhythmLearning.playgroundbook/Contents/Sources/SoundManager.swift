//
//  SoundManager.swift
//  SongGame
//
//  Created by Bruno Scheltzke on 19/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    var snarePlayer = AVAudioPlayer()
    var bassPlayer = AVAudioPlayer()
    var hitHatPlayer = AVAudioPlayer()
    
    private init() {
        do {
            let urlSnare = URL.init(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.snareSound, ofType: "mp3")!)
            snarePlayer = try AVAudioPlayer(contentsOf: urlSnare)
            snarePlayer.prepareToPlay()
            
            let urlBass = URL.init(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.bassSound, ofType: "mp3")!)
            bassPlayer = try AVAudioPlayer(contentsOf: urlBass)
            bassPlayer.prepareToPlay()
            
            let urlHitHat = URL.init(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.hitHatSound, ofType: "mp3")!)
            hitHatPlayer = try AVAudioPlayer(contentsOf: urlHitHat)
            hitHatPlayer.prepareToPlay()
        } catch {
            print(error)
        }
    }
    
    func playSound(for drumPart: DrumPart) {
        switch drumPart {
        case .bass:
            bassPlayer.currentTime = 0
            bassPlayer.play()
        case .hitHat:
            hitHatPlayer.currentTime = 0
            hitHatPlayer.play()
        case .snare:
            snarePlayer.currentTime = 0
            snarePlayer.play()
        }
    }
    
    func playMetronome() {
        
    }
    
    func stopAll() {
        
    }
}
