/*:
 ## Time for the real challenge!!
 
 Play the [bass](glossary://bass) (green section in the middle) at beats **1** and **3** along with the [hit-hat](glossary://hit-hat).
 \
 All together with what you learned in the previous exercises.
 
 - Important:
 Putting all the instruments together may be tough, so you can slow the [tempo](glossary://tempo) in the function [metronome](glossary://metronome).setTempo() if you need.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = DrumSetViewController(lesson: Lesson.lesson3())

var metronome = vc.metronome

PlaygroundPage.current.assessmentStatus = .fail(hints: [" An easy way to see that is that you can play the blue and green section together in the first count. In the second count you play the blue and the yellow. Then it is just a matter of repeating that. Blue and green, blue and yellow, blue and green, blue and yellow."], solution: nil)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "That's it! You're a pro🥇😎 You can move to the next exercise or you can practice more if you want.")
    vc.freePlayMode = true
    //PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/105/*#-end-editable-code*/)

