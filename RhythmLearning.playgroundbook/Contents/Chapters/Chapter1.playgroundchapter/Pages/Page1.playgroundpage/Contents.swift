//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    var sectionWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let snareView = DrumItem(drumPart: .snare)
        view.addSubview(snareView)
        
        let bassView = DrumItem(frame: CGRect(x: snareView.frame.width, y: 0, width: snareView.frame.width, height: view.frame.height), drumPart: .bass)
        view.addSubview(bassView)
        
        let hitHatView = DrumItem(frame: CGRect(x: snareView.frame.width * 2, y: 0, width: snareView.frame.width, height: view.frame.height), drumPart: .hitHat)
        view.addSubview(hitHatView)
    }
}

PlaygroundPage.current.liveView = ViewController()
