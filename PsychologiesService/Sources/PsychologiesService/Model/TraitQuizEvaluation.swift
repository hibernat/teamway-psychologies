//
//  TraitQuizEvaluation.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

public struct TraitQuizEvaluation: Decodable, Sendable {
    
    public let title: String? // nil if quiz submission was invalid
    public let text: String? // nil if quiz submission was invalid
    
}
