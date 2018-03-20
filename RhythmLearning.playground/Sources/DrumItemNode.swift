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

public class DrumItemNode: ButtonNode {

    public var drumPart: DrumPart

    public var image: String

    public var imagePlayed: String

    public var delegate: DrumItemDelegate!

    public init(drumPart: DrumPart) {
        self.drumPart = drumPart

        switch drumPart {
        case .bass:
            self.image = GlobalConstants.bassImage
            self.imagePlayed = GlobalConstants.bassImagePlayed
        case .snare:
            self.image = GlobalConstants.snareImage
            self.imagePlayed = GlobalConstants.snareImagePlayed
        case .hitHat:
            self.image = GlobalConstants.hitHatImage
            self.imagePlayed = GlobalConstants.hitHatImagePlayed
        }

        let normalTexture = SKTexture(imageNamed: image)
        let selectedTexture = SKTexture(imageNamed: imagePlayed)

        super.init(normalTexture: normalTexture, selectedTexture: selectedTexture, disabledTexture: nil, size: CGSize(width: 200, height: 200), text: nil)
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

