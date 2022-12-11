//
//  QuizViewModelTests.swift
//  PsychoQuizTests
//
//  Created by Michael Bernat on 06.12.2022.
//

import XCTest
import PsychologiesService
@testable import PsychoQuizViewModels

@MainActor
final class QuizViewModelTests: XCTestCase {

    var viewModel: QuizViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = QuizViewModel(
            psychologiesService: PsychologiesServiceMock(shouldThrowError: false),
            traitQuiz: {
                let url = Bundle.module.url(forResource: "TraitQuizTest", withExtension: "json")!
                let data = try! Data(contentsOf: url)
                return try! JSONDecoder().decode(TraitQuiz.self, from: data)
            }
        )
    }
    
    func testPlayingQuizBeforeAnswerSelection() {
        XCTAssertEqual(viewModel.questions[0].id, "Q1")
        XCTAssertEqual(viewModel.questions[0].answers[0].id, "Q1-A1")
        XCTAssertEqual(viewModel.currentQuestionIndex, 0)
        XCTAssertFalse(viewModel.isLastQuestion)
        XCTAssertEqual(viewModel.chosenAnswerIds, [nil, nil])
        XCTAssertNil(viewModel.chosenAnswerIdForCurrentQuestion)
        XCTAssertFalse(viewModel.areChosenAnswersValid)
    }
    
    func testPlayingQuizAnsweringFirstQuestion() {
        let chosenAnswerId = "Q1-A2"
        viewModel.chosenAnswerIdForCurrentQuestion = chosenAnswerId
        XCTAssertEqual(viewModel.currentQuestionIndex, 0)
        XCTAssertFalse(viewModel.isLastQuestion)
        XCTAssertEqual(viewModel.chosenAnswerIds, [chosenAnswerId, nil])
        XCTAssertEqual(viewModel.chosenAnswerIdForCurrentQuestion, chosenAnswerId)
        XCTAssertFalse(viewModel.areChosenAnswersValid)
    }
    
    func testPlayingQuizWithAnsweringFirstQuestionAndNext() {
        let chosenAnswerId = "Q1-A2"
        viewModel.chosenAnswerIdForCurrentQuestion = chosenAnswerId
        viewModel.goNext()
        XCTAssertEqual(viewModel.currentQuestionIndex, 1)
        XCTAssertTrue(viewModel.isLastQuestion)
        XCTAssertEqual(viewModel.chosenAnswerIds, [chosenAnswerId, nil])
        XCTAssertNil(viewModel.chosenAnswerIdForCurrentQuestion)
        XCTAssertFalse(viewModel.areChosenAnswersValid)
    }
    
    func testPlayingQuizWithoutAnsweringFirstQuestionAndNext() {
        viewModel.goNext()
        XCTAssertEqual(viewModel.currentQuestionIndex, 1)
        XCTAssertTrue(viewModel.isLastQuestion)
        XCTAssertEqual(viewModel.chosenAnswerIds, [nil, nil])
        XCTAssertNil(viewModel.chosenAnswerIdForCurrentQuestion)
        XCTAssertFalse(viewModel.areChosenAnswersValid)
    }
    
    func testPlayingQuizWithAnsweringFirstAndSecondQuestion() {
        let chosenQ1AnswerId = "Q1-A2"
        let chosenQ2AnswerId = "Q2-A1"
        viewModel.chosenAnswerIdForCurrentQuestion = chosenQ1AnswerId
        viewModel.goNext()
        viewModel.chosenAnswerIdForCurrentQuestion = chosenQ2AnswerId
        XCTAssertEqual(viewModel.currentQuestionIndex, 1)
        XCTAssertTrue(viewModel.isLastQuestion)
        XCTAssertEqual(viewModel.chosenAnswerIds, [chosenQ1AnswerId, chosenQ2AnswerId])
        XCTAssertEqual(viewModel.chosenAnswerIdForCurrentQuestion, chosenQ2AnswerId)
        XCTAssertTrue(viewModel.areChosenAnswersValid)
    }
    
    func testSubmit() async {
        let chosenQ1AnswerId = "Q1-A2"
        let chosenQ2AnswerId = "Q2-A1"
        viewModel.chosenAnswerIdForCurrentQuestion = chosenQ1AnswerId
        viewModel.goNext()
        viewModel.chosenAnswerIdForCurrentQuestion = chosenQ2AnswerId
        await viewModel.submit()
        XCTAssertEqual(viewModel.state, .showingEvaluation(title: "Mocked evaluation title", text: "Mocked evaluation text"))
    }
    
}

