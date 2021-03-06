/*:
 ## Can you count to four? You can play the drums!!😎
 
 - The first thing to learn is to count in the correct [tempo](glossary://tempo).
 
 Once you hit the **Run my code** button, you will hear a click sound to represent the [tempo](glossary://tempo).
 \
 This indicates how fast you are going to count to 4.
 \
 After a while, a couple of blue notes will fall from the sky on each click sound.
 \
 Try to hit the blue section whenever the note reaches the blue instrument.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = DrumSetViewController(lesson: Lesson.lesson1())
var metronome = vc.metronome

PlaygroundPage.current.assessmentStatus = .fail(hints: ["If it's too fast you can slow down the tempo by changing the value in the metronome.setTempo() function. The current tempo was set to 105"], solution: nil)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "That’s great! You are already used to the tempo😎 You can move to the next exercise or you can practice more if you want.")
    vc.freePlayMode = true
    //PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code

//here you can change the tempo to set how fast the metronome will play
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/105/*#-end-editable-code*/)
