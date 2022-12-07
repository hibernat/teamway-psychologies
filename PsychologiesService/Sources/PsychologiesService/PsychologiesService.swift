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

final public class PsychologiesService: PsychologiesServiceProtocol, Sendable {
    
    let sleepForMilliseconds: Int
    let successRate: Int // 0 == always throws, Int.max == never throws (unless there is some other error)
    let errorThrownOnFailure: Error & Sendable
    
    /// local PsychologiesService randomly throwing error
    /// - Parameters:
    ///   - sleepForMilliseconds: simulates delay on network, each request is delayd then
    ///   - failureRate: Int.max means it always throws an error, 0 means no intentional failures/throws
    ///   - errorThrownOnFailure: error thrown when random generator throws error
    public init(sleepForMilliseconds: Int, failureRate: Int, errorThrownOnFailure: Error & Sendable = URLError(.unknown)) {
        self.sleepForMilliseconds = max(0, sleepForMilliseconds)
        self.successRate = Int.max - max(0, failureRate)
        self.errorThrownOnFailure = errorThrownOnFailure
    }
    
    public func getTraitQuiz() async throws -> TraitQuiz {
        try await Task.sleep(for: .milliseconds(sleepForMilliseconds))
        try throwErrorIfNeeded()
        let url = Bundle.module.url(forResource: "TraitQuiz", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let traitQuiz = try JSONDecoder().decode(TraitQuiz.self, from: data)
        return traitQuiz
    }
    
    public func submitTraitQuizAnswers(traitTestId: String, answerIds: [String]) async throws -> TraitQuizEvaluation {
        try await Task.sleep(for: .milliseconds(sleepForMilliseconds))
        try throwErrorIfNeeded()
        let url = Bundle.module.url(forResource: "TraitQuizEvaluation", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let traitQuiz = try JSONDecoder().decode(TraitQuizEvaluation.self, from: data)
        return traitQuiz
    }
    
    private func throwErrorIfNeeded() throws {
        if successRate == Int.max { return }
        if (0...successRate).randomElement() == 0 {
            throw errorThrownOnFailure
        }
    }
    
}
