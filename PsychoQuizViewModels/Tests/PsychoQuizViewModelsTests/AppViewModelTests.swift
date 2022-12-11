//
//  AppViewModelTests.swift
//  PsychoQuizTests
//
//  Created by Michael Bernat on 06.12.2022.
//

import XCTest
import PsychologiesService
@testable import PsychoQuizViewModels

final class AppViewModelTests: XCTestCase {
    
    @MainActor
    func testLoadTraitQuizSuccessfully() async {
        let appViewModel = AppViewModel(
            psychologiesService: PsychologiesServiceMock(shouldThrowError: false)
        )
        XCTAssertEqual(appViewModel.state, .quizNotLoading)
        await appViewModel.loadTraitQuiz()
        XCTAssertTrue(isQuizAvailable(state: appViewModel.state))
    }
    
    @MainActor
    func testLoadTraitQuizLoadingError() async {
        let appViewModel = AppViewModel(
            psychologiesService: PsychologiesServiceMock(shouldThrowError: true)
        )
        XCTAssertEqual(appViewModel.state, .quizNotLoading)
        await appViewModel.loadTraitQuiz()
        XCTAssertTrue(isQuizLoadingError(state: appViewModel.state))
    }
    
    @MainActor
    func testPresentQuizViewWhenTraitQuizIsAvailable() async {
        let appViewModel = AppViewModel(
            psychologiesService: PsychologiesServiceMock(shouldThrowError: false)
        )
        await appViewModel.loadTraitQuiz()
        appViewModel.startQuiz()
        XCTAssertNotNil(appViewModel.quizViewModel)
    }
    
    @MainActor
    func testPresentQuizViewWhenTraitQuizIsNotAvailable() async {
        let appViewModel = AppViewModel(
            psychologiesService: PsychologiesServiceMock(shouldThrowError: true)
        )
        appViewModel.startQuiz()
        XCTAssertNil(appViewModel.quizViewModel)
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
