/*:
 Did you see how we now play the snare drum and the hit hat at counts 2 and 4, and play the hit hat alone at count 1 and 3?
 
 Well, time the real challenge!!
 Time for the bass drums!!
 
 You are going to play the green section in the middle at counts 1 and 3 along with the hit hat. All together with what you learned in the previous exercises.
 
 An easy way to see that is that you can play the blue and green section together in the first count. In the second count you play the blue and the yellow. Then it is just a matter of repeating that. Blue and green, blue and yellow, blue and green, blue and yellow.
 
 If this exercise get’s complicated for you, you can slow down the tempo in the metronome.setTempo() piece of code below. The current tempo is set to 105

 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()

vc.currentLesson = vc.lesson4

var metronome = vc.metronome

metronome.setTempo(105)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "That's it! You're a pro! 🥇😎")
    PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/105/*#-end-editable-code*/)

