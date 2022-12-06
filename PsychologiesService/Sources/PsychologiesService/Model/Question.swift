//
//  Question.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

public struct Question: Identifiable, Decodable, Sendable {
    
    public let id: String
    public let text: String
    public let answers: [Answer]
    
}
