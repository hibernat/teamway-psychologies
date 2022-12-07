//
//  PsychologiesServiceMock.swift
//  PsychoQuizTests
//
//  Created by Michael Bernat on 06.12.2022.
//

import XCTest
import Foundation
@testable import PsychologiesService

final class PsychologiesServiceMock: PsychologiesServiceProtocol {
    
    static let traitQuizEvaluationTitle = "Mocked evaluation title"
    static let traitQuizEvaluationText = "Mocked evaluation text"
    static let invalidTraitTestId = "invalid"
    static let errorTraitTestId = "error"
    
    let shouldFail: Bool
    
    func getTraitQuiz() async throws -> TraitQuiz {
        if shouldFail { throw URLError(.unknown) }
        let url = Bundle(for: PsychologiesServiceMock.self).url(forResource: "TraitQuizTest", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let traitQuiz = try JSONDecoder().decode(TraitQuiz.self, from: data)
        return traitQuiz
    }
    
    func submitTraitQuizAnswers(traitTestId: String, answerIds: [String]) async throws -> TraitQuizEvaluation {
        if shouldFail { throw URLError(.unknown) }
        if traitTestId == Self.invalidTraitTestId {
            return TraitQuizEvaluation(nil, nil)
        }
        if traitTestId == Self.errorTraitTestId {
            throw URLError(.unknown)
        }
        return TraitQuizEvaluation(Self.traitQuizEvaluationTitle, Self.traitQuizEvaluationText)
    }
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
    
}

fileprivate extension TraitQuizEvaluation {

    init(_ title: String?, _ text: String?) {
        self.init(title: title, text: text)
    }

}

