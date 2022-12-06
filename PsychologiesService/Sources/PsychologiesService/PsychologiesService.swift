//
//  PsychologiesService.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

import Foundation

public protocol PsychologiesServiceProtocol {
    
    func getTraitQuiz() async throws -> TraitQuiz
    func submitTraitQuizAnswers(traitTestId: String, answerIds: [String]) async throws -> TraitQuizEvaluation
    
}

final class PsychologiesService: PsychologiesServiceProtocol, Sendable {
    
    let successRate: UInt // 0 == always throws, UInt.max == never throws (unless there is some other error)
    let errorThrownOnFailure: Error & Sendable
    
    /// local PsychologiesService randomly throwing error
    /// - Parameters:
    ///   - failureRate: UInt.max means it always throws an error, 0 means no intentional failures/throws
    ///   - errorThrownOnFailure: error thrown when random generator throws error
    init(failureRate: UInt, errorThrownOnFailure: Error & Sendable = URLError(.unknown)) {
        self.successRate = UInt.max - failureRate
        self.errorThrownOnFailure = errorThrownOnFailure
    }
    
    func getTraitQuiz() async throws -> TraitQuiz {
        try throwErrorIfNeeded()
        let url = Bundle.module.url(forResource: "TraitQuiz", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let traitQuiz = try JSONDecoder().decode(TraitQuiz.self, from: data)
        return traitQuiz
    }
    
    func submitTraitQuizAnswers(traitTestId: String, answerIds: [String]) async throws -> TraitQuizEvaluation {
        try throwErrorIfNeeded()
        let url = Bundle.module.url(forResource: "TraitQuizEvaluation", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let traitQuiz = try JSONDecoder().decode(TraitQuizEvaluation.self, from: data)
        return traitQuiz
    }
    
    private func throwErrorIfNeeded() throws {
        if successRate == UInt.max { return }
        if (0...successRate).randomElement() == 0 {
            throw errorThrownOnFailure
        }
    }
    
}
