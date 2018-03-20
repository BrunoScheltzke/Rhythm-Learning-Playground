//: Playground - noun: a place where people can play

import SpriteKit
import PlaygroundSupport

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))

class GameScene: SKScene {
    let snareNode = DrumItemNode(drumPart: .snare)
    let bassNode = DrumItemNode(drumPart: .bass)
    let hitHatNode = DrumItemNode(drumPart: .hitHat)
    
    let metronome = Metronome()
    
    override func didMove(to view: SKView) {
        snareNode.delegate = self
        bassNode.delegate = self
        hitHatNode.delegate = self
        
        snareNode.position = CGPoint(x: 0 + snareNode.frame.size.width/2, y: 0)
        bassNode.position = CGPoint(x: snareNode.position.x + snareNode.frame.size.width/2, y: 0)
        hitHatNode.position = CGPoint(x: bassNode.position.x + snareNode.frame.size.width/2, y: 0)
        
        addChild(snareNode)
        addChild(bassNode)
        addChild(hitHatNode)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if metronome.isPlaying {
            metronome.stop()
        } else {
            metronome.start()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}

extension GameScene: DrumItemDelegate {
    func didPlayDrumItem(_ drumItemNode: DrumItemNode) {
        print(drumItemNode)
    }
}

let gameScene = GameScene(size: CGSize(width: 640, height: 480))
sceneView.presentScene(gameScene)
PlaygroundPage.current.liveView = sceneView
