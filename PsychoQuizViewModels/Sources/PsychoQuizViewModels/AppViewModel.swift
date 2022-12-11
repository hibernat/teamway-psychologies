//
//  LandingViewModel.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import Foundation
import Combine
import PsychologiesService

@MainActor
public final class AppViewModel: ObservableObject {
    
    // MARK: static
    public static var `default` = AppViewModel(
        psychologiesService: PsychologiesService(
            sleepForMilliseconds: 600,
            failureRate: Int.max - 2,
            errorThrownOnFailure: URLError(.unknown)
        )
    )

    // MARK: sub-types
    public enum QuizLoadingError: Error, Equatable {
        case someError
    }
    
    public enum State: Equatable {
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.quizNotLoading, .quizNotLoading): return true
            case (.quizLoadingInProgress, .quizLoadingInProgress): return true
            case (.quizLoadingError, .quizLoadingError): return true
            case (.quizAvailable, .quizAvailable): return true
            default: return false
            }
        }
        
        case quizNotLoading
        case quizLoadingInProgress
        case quizLoadingError(QuizLoadingError)
        case quizAvailable(TraitQuiz)
    }
    
    // MARK: dependencies
    let psychologiesService: PsychologiesServiceProtocol
    
    // MARK: stored properties
    @Published public private(set) var state: State = .quizNotLoading
    @Published public var quizViewModel: QuizViewModel?
    
    // MARK: initializers
    public init(psychologiesService: PsychologiesServiceProtocol) {
        self.psychologiesService = psychologiesService
    }
    
    // MARK: methods
    public func loadTraitQuiz() async {
        if case .quizLoadingInProgress = state { return }
        do {
            state = .quizLoadingInProgress
            let traitQuiz = try await psychologiesService.getTraitQuiz()
            state = .quizAvailable(traitQuiz)
        } catch {
            state = .quizLoadingError(.someError)
        }
    }
    
    public func startQuiz() {
        guard case .quizAvailable(let traitQuiz) = state else { return }
        quizViewModel = QuizViewModel(
            psychologiesService: psychologiesService,
            traitQuiz: { traitQuiz }
        )
    }
}
