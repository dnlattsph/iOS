//
//  Questions.swift
//  QuizApp
//
//  Created by D Naung Latt on 16/08/2021.
//

import Foundation

struct Question: Codable {
    
    var question: String?
    var answers: [String]?
    var correctAnswerIndex:Int?
    var feedback: String?
}
