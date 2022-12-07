//
//  LandingViewModel.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import Combine
import PsychologiesService

@MainActor
final class AppViewModel: ObservableObject {
    
    enum QuizLoadingError: Error, Equatable {
        case someError
    }
    
    enum State: Equatable {
        
        static func == (lhs: State, rhs: State) -> Bool {
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
    @Published private(set) var state: State = .quizNotLoading
    @Published private(set) var quizViewModel: QuizViewModel?
    
    // MARK: initializers
    init(psychologiesService: PsychologiesServiceProtocol) {
        self.psychologiesService = psychologiesService
    }
    
    // MARK: methods
    func loadTraitQuiz() async {
        if case .quizLoadingInProgress = state { return }
        do {
            state = .quizLoadingInProgress
            let traitQuiz = try await psychologiesService.getTraitQuiz()
            state = .quizAvailable(traitQuiz)
        } catch {
            state = .quizLoadingError(.someError)
        }
    }
    
    func startQuiz() {
        guard case .quizAvailable(let traitQuiz) = state else { return }
        // quizViewModel =
    }
}
