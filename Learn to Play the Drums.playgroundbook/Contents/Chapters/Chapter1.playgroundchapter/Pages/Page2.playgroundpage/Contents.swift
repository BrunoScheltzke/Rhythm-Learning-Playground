/*:
 ## Here’s what you’ve done until now:
 
 - You learned a part of a beat of tons of famous songs like **Highway to Hell - AC/DC, Billie Jean - Michael Jackson**
 - You learned that the [hit-hat](glossary://hit-hat) is following the tempo at beats 1, 2, 3 and 4. And then it is repeated.
 
 # Up Next:
 
 Time to add [snare](glossary://snare) notes to the [hit-hat](glossary://hit-hat) notes we just played.
 \
 The [snare](glossary://snare) is represented by the **yellow section** in the very left.
 \
 So, along with the [hit-hat](glossary://hit-hat), play the yellow section at count 2 and count 4.
 
 - Important:
 It really helps if you count from 1 to 4 out loud along with the click sound.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController(lesson: Lesson.lesson2())

var metronome = vc.metronome

metronome.setTempo(105)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "That’s great, You are almost done learning your first beat🥇 You can move to the next exercise or you can practice more if you want.")
    vc.freePlayMode = true
    //PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
metronome.setTempo(/*#-editable-code Decrease or increase the speed*/105/*#-end-editable-code*/)

