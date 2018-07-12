//
//  Question.swift
//  Pulse
//
//  Created by Justin Matsnev on 7/12/18.
//  Copyright © 2018 Justin Matsnev. All rights reserved.
//

import Foundation

class Question {
    var question : String
    var answer : String?
    var votes : Int = 0
    
    init(question : String, answer : String?, votes : Int = 0) {
        self.question = question
        self.answer = answer
    }
}
