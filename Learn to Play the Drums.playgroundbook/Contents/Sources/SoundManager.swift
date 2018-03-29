//
//  SoundManager.swift
//  SongGame
//
//  Created by Bruno Scheltzke on 19/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import Foundation
import AVFoundation

public enum Song {
    case billieJean
    case song1
    case song2
}

public class SoundManager {
    static let shared = SoundManager()
    
    var snarePlayer = AVAudioPlayer()
    var bassPlayer = AVAudioPlayer()
    var hitHatPlayer = AVAudioPlayer()
    var billieJeanPlayer = AVAudioPlayer()
    var song1Player = AVAudioPlayer()
    var song2Player = AVAudioPlayer()
    
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
            
            let urlBillieJean = URL.init(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.billieJeanSong, ofType: "mp3")!)
            billieJeanPlayer = try AVAudioPlayer(contentsOf: urlBillieJean)
            billieJeanPlayer.numberOfLoops = -1
            billieJeanPlayer.prepareToPlay()
            
            let urlSong1 = URL.init(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.song1, ofType: "mp3")!)
            song1Player = try AVAudioPlayer(contentsOf: urlSong1)
            song1Player.numberOfLoops = -1
            song1Player.prepareToPlay()
            
            let urlSong2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: GlobalConstants.song2, ofType: "mp3")!)
            song2Player = try AVAudioPlayer(contentsOf: urlSong2)
            song2Player.numberOfLoops = -1
            song2Player.prepareToPlay()
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
    
    func play(song: Song) {
        switch song {
        case .billieJean:
            billieJeanPlayer.currentTime = 0
            billieJeanPlayer.play()
        case .song1:
            song1Player.currentTime = 0
            song1Player.play()
        case .song2:
            song2Player.currentTime = 0
            song2Player.play()
        }
    }

    func stopAll() {
        bassPlayer.stop()
        snarePlayer.stop()
        hitHatPlayer.stop()
        billieJeanPlayer.stop()
        song1Player.stop()
        song2Player.stop()
    }
}
