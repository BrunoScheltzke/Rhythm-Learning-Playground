/*:
 Here’s what you’ve done until now.
 
 You learned a part of a beat of a very famous Michael Jackson song. Billie Jean!
 
 You learned that the song goes with the hit hat (the blue instrument) at count 1, count 2, count 3 and count 4. And then repeat it is repeated.
 
 After Page 3 you will be able to play this song.
 
 But the next step is to add the snare drum to the hit hat we just played. Which is represented by the yellow section in the very left.
 
 So, along with the hit hat at count 1, count 2, count 3 and count 4, we are going to play the yellow section at count 2 and count 4. So it really helps if you count it all loud along with the tic sound.
 
 The notes will still fall from the sky in their respective sections to help you out.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = ViewController()

vc.currentLesson = vc.lesson2

var metronome = vc.metronome

metronome.setTempo(105)

vc.finishAssessment = {
    PlaygroundPage.current.assessmentStatus = .pass(message: "That’s great, You are almost done learning your first beat. 🥇")
    PlaygroundPage.current.finishExecution()
}

PlaygroundPage.current.liveView = vc

//#-end-hidden-code
//metronome.setTempo(/*#-editable-code Decrease or increase the speed*/100/*#-end-editable-code*/)

