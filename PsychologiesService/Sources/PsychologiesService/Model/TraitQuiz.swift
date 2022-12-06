//
//  TraitQuiz.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

public struct TraitQuiz: Identifiable, Decodable, Sendable {
    
    public let id: String
    public let questions: [Question]
    
}
