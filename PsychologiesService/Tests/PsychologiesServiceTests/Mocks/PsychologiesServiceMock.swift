//
//  PsychologiesServiceMock.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

import XCTest
import Foundation
@testable import PsychologiesService

final class PsychologiesServiceMock: PsychologiesServiceProtocol {
    
    static let traitQuizEvaluationTitle = "Mocked evaluation title"
    static let traitQuizEvaluationText = "Mocked evaluation text"
    static let invalidTraitTestId = "invalid"
    static let errorTraitTestId = "error"
    
    func getTraitQuiz() async throws -> TraitQuiz {
        let url = Bundle.module.url(forResource: "TraitQuizTest", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let traitQuiz = try JSONDecoder().decode(TraitQuiz.self, from: data)
        return traitQuiz
    }
    
    func submitTraitQuizAnswers(traitTestId: String, answerIds: [String]) async throws -> TraitQuizEvaluation {
        if traitTestId == Self.invalidTraitTestId {
            return TraitQuizEvaluation(nil, nil)
        }
        if traitTestId == Self.errorTraitTestId {
            throw URLError(.unknown)
        }
        return TraitQuizEvaluation(Self.traitQuizEvaluationTitle, Self.traitQuizEvaluationText)
    }
    
}

fileprivate extension TraitQuizEvaluation {

    init(_ title: String?, _ text: String?) {
        self.init(title: title, text: text)
    }

}
