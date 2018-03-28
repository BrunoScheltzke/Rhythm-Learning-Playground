/*:
 Time for the gig!
 
 Now that you are a pro, we are going to setup the song you just learned so you can play it along.
 It is a bit challenging since it is a little faster than what you have been practicing. But I’m sure you can do it.
 
 Have fun on your first beat.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()

vc.currentLesson = vc.lesson4

var metronome = vc.metronome
metronome.setTempo(117)

//playmichael jackson song

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "You are a pro! A great exercise now is to repeat the page 2  and ahead but every time you hit the bass drum you hit the floor with your foot. This time you’ll be almost set for real drums, since you play the bass drum with your foot. You can also increase the tempo and repeat the exercises.")
    //PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
//metronome.setTempo(/*#-editable-code Decrease or increase the speed*/100/*#-end-editable-code*/)
