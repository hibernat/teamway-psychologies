//
//  PsychologiesAPITests.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

import XCTest
@testable import PsychologiesService

final class PsychologiesAPITests: XCTestCase {
    
    func testGetTraitQuizRequest() throws {
        let request = try PsychologiesAPI.getTraitQuiz.makeURLRequest()
        XCTAssertEqual(request.url?.absoluteString, "https://api.psychologies.teamway/traitQuiz")
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testSubmitAnswers() throws {
        let traitQuizId = "ID1"
        let answerIds = ["idA1", "idA2", "idA3"]
        let request = try PsychologiesAPI
            .submitAnswers(
                traitQuizId: traitQuizId,
                answerIds: answerIds
            )
            .makeURLRequest()
        XCTAssertEqual(request.url?.absoluteString, "https://api.psychologies.teamway/traitQuiz")
        XCTAssertEqual(request.httpMethod, "POST")
        guard let body = request.httpBody else {
            XCTFail("httpBody does not contain encoded parameters")
            return
        }
        let submittedAnswer = try JSONDecoder().decode(SubmittedAnswer.self, from: body)
        XCTAssertEqual(submittedAnswer.traitQuizId, traitQuizId)
        XCTAssertEqual(submittedAnswer.answerIds, answerIds)
    }
    
}

fileprivate struct SubmittedAnswer: Decodable {
    let traitQuizId: String
    let answerIds: [String]
}
