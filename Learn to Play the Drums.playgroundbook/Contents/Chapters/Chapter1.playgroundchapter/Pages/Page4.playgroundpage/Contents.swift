/*:
 ## Time for the gig 🥁
 
 Now that you are a pro😎, we are going to setup a song so you can play it along.
 
 Here is a couple of songs that you are already able to play with the beat you just learned:
 
 - Highway to Hell - AC/DC
 - Welcome to the jungle - Guns N' Roses
 - Billie Jean - Michael Jackson
 - Basket Case - Green Day
 - Holiday - Green Day
 - Alok - Hear me now
 
 
 **Have fun on playing your first song!!**
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = DrumSetViewController(lesson: Lesson.lesson4())

var metronome = vc.metronome

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "You are a pro! A great exercise now is to repeat the page 2 and ahead but every time you hit the bass drum you hit the floor with your foot. That way you’ll be almost set for real drums, since you use your foot to play the bass drum. You can also increase the tempo and repeat the exercises.")
    vc.freePlayMode = true
    //PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
