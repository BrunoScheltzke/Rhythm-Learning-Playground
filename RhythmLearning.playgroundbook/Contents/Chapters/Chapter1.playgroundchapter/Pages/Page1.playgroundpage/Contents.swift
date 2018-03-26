//: Can you count to four? You can play the drums!!

/*:
 Blablablabla
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()
var metronome = vc.metronome

vc.finishAssessment = {
    metronome.stop()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/100/*#-end-editable-code*/)
