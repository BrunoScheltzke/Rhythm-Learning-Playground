//: Can you count to four? You can play the drums!!

/*:
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()

vc.currentLesson = vc.lesson2

var metronome = vc.metronome

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/100/*#-end-editable-code*/)

