/*:
 ## Time for the gig!
 
 Now that you are a pro😎, we are going to setup the song you just learned: **Billie Jean by Michael Jackson** so you can play it along.
 
 **Have fun on your first beat!!**
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()

vc.currentLesson = vc.lesson4

var metronome = vc.metronome
metronome.setTempo(117)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "You are a pro! A great exercise now is to repeat the page 2 and ahead but every time you hit the bass drum you hit the floor with your foot. That way you’ll be almost set for real drums, since you use your foot to play the bass drum. You can also increase the tempo and repeat the exercises.")
    vc.freePlayMode = true
    //PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/117/*#-end-editable-code*/)
