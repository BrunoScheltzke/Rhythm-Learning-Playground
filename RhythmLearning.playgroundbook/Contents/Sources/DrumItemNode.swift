//
//  SnareDrum.swift
//  SongGame
//
//  Created by Bruno Scheltzke on 20/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

import SpriteKit

public enum DrumPart {
    case bass
    case snare
    case hitHat
}

public typealias DrumImage = (image: String, imagePlayed: String)

public class DrumItemNode: ButtonNode {

    public var drumPart: DrumPart

    public var image: String

    public var imagePlayed: String

    public var delegate: DrumItemDelegate!

    public init(drumPart: DrumPart, size: CGSize? = nil) {
        self.drumPart = drumPart
        
        let drumImages = DrumItemNode.getImages(of: drumPart)
        
        self.image = drumImages.image
        self.imagePlayed = drumImages.imagePlayed
        
        let normalTexture = SKTexture(imageNamed: image)
        let selectedTexture = SKTexture(imageNamed: imagePlayed)
        
        super.init(normalTexture: normalTexture, selectedTexture: selectedTexture, disabledTexture: nil, size: size ?? normalTexture.size(), text: nil)
    }
    
    static func getImages(of drumPart: DrumPart) -> DrumImage {
        switch drumPart {
        case .bass:
            return (GlobalConstants.bassImage, GlobalConstants.bassImagePlayed)
        case .snare:
            return (GlobalConstants.snareImage, GlobalConstants.snareImagePlayed)
        case .hitHat:
            return (GlobalConstants.hitHatImage, GlobalConstants.hitHatImagePlayed)
        }
    }

    public func playDrumItem() {
        SoundManager.shared.playSound(for: drumPart)
        delegate.didPlayDrumItem(self)
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        playDrumItem()
    }
}


public protocol DrumItemDelegate {
    func didPlayDrumItem(_ drumItemNode: DrumItemNode)
}

