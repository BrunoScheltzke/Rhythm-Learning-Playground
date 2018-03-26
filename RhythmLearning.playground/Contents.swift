//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let vc = ViewController()

vc.finishAssessment = {
    print("Opa")
}

PlaygroundPage.current.liveView = vc
