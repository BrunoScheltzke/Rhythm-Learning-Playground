/*:
 Can you count to four? You can play the drums!!
 
 The first step is to count in the correct tempo. Once you hit the “Run my code” button, you will hear a tic sound indicating the tempo. This indicates how fast you are going to count to 4.
 
 After a while, a couple of blue notes will fall from the sky on each tic sound
 
 Try to hit the blue section whenever the note reaches the Blue instrument.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()
var metronome = vc.metronome

metronome.setTempo(105)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "That’s great! You are already used to the tempo. 😎")
    PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
//metronome.setTempo(/*#-editable-code Decrease or increase the speed*/100/*#-end-editable-code*/)
