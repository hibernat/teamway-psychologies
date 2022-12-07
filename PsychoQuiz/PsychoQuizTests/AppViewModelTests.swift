//
//  AppViewModelTests.swift
//  PsychoQuizTests
//
//  Created by Michael Bernat on 06.12.2022.
//

import XCTest
import PsychologiesService
@testable import PsychoQuiz

final class AppViewModelTests: XCTestCase {
    
    @MainActor
    func testLoadTraitQuizSuccessfully() async {
        let appViewModel = AppViewModel(
            psychologiesService: PsychologiesServiceMock(shouldFail: false)
        )
        XCTAssertEqual(appViewModel.state, .quizNotLoading)
        await appViewModel.loadTraitQuiz()
        XCTAssertTrue(isQuizAvailable(state: appViewModel.state))
    }
    
    @MainActor
    func testLoadTraitQuizLoadingError() async {
        let appViewModel = AppViewModel(
            psychologiesService: PsychologiesServiceMock(shouldFail: true)
        )
        XCTAssertEqual(appViewModel.state, .quizNotLoading)
        await appViewModel.loadTraitQuiz()
        XCTAssertTrue(isQuizLoadingError(state: appViewModel.state))
    }
    
}

private extension AppViewModelTests {
    
    func isQuizAvailable(state: AppViewModel.State) -> Bool {
        switch state {
        case .quizAvailable: return true
        default: return false
        }
    }
    
    func isQuizLoadingError(state: AppViewModel.State) -> Bool {
        switch state {
        case .quizLoadingError: return true
        default: return false
        }
    }
    
}
