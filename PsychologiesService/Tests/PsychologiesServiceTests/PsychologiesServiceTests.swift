//
//  PsychologiesServiceTests.swift
//
//
//  Created by Michael Bernat on 03.12.2022.
//

import XCTest
@testable import PsychologiesService

final class PsychologiesServiceTests: XCTestCase {
    
    var psychologiesService: PsychologiesServiceProtocol!
    
    override func setUp() {
        super.setUp()
        psychologiesService = PsychologiesServiceMock()
    }
    
    func testGetTraitQuiz() async throws {
        let traitQuiz = try await psychologiesService.getTraitQuiz()
        XCTAssertEqual(traitQuiz.id, "Trait-Test-1")
        let question = traitQuiz.questions[0]
        XCTAssertEqual(question.id, "Q1")
        XCTAssertEqual(question.text, "Question 1")
        let answer = question.answers[0]
        XCTAssertEqual(answer.id, "Q1-A1")
        XCTAssertEqual(answer.text, "First answer choice for question 1")
    }
    
    func testValidSubmitAnswers() async throws {
        let evaluation = try await psychologiesService.submitTraitQuizAnswers(
            traitTestId: "",
            answerIds: []
        )
        XCTAssertEqual(evaluation.title, PsychologiesServiceMock.traitQuizEvaluationTitle)
        XCTAssertEqual(evaluation.text, PsychologiesServiceMock.traitQuizEvaluationText)
    }
    
    func testInvalidSubmitAnswers() async throws {
        let evaluation = try await psychologiesService.submitTraitQuizAnswers(
            traitTestId: PsychologiesServiceMock.invalidTraitTestId,
            answerIds: []
        )
        XCTAssertNil(evaluation.text)
    }
    
    func testThrowingSubmitAnswers() async throws {
        do {
            let _ = try await psychologiesService.submitTraitQuizAnswers(
                traitTestId: PsychologiesServiceMock.errorTraitTestId,
                answerIds: []
            )
            XCTFail("submitTraitQuizAnswers was expected to throw an error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
}
