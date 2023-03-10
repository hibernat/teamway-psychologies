//
//  QuizViewModel.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import Foundation
import Combine
import PsychologiesService

@MainActor
public final class QuizViewModel: ObservableObject {
    
    // MARK: sub-types
    public enum Error: Swift.Error, Equatable {
        case someError
    }
    
    public struct Question: Identifiable {
        public struct Answer: Identifiable {
            public let id: String
            public let text: String
        }
        public let id: String
        public let index: Int
        public let text: String
        public let answers: [Question.Answer]
    }
    
    public enum State: Equatable {
        case playingQuiz
        case error(Error)
        case showingEvaluation(title: String, text: String)
    }
    
    // MARK: dependencies
    let psychologiesService: PsychologiesServiceProtocol
    
    // MARK: stored properties
    @Published public var state: State = .playingQuiz
    @Published public var currentQuestionIndex: Int = 0
    @Published public var chosenAnswerIds: [String?]
    
    private let _traitQuiz: () -> TraitQuiz
    private var isAnswerSubmissionInProgress = false
    
    // MARK: computed properties
    public var questions: [Question] {
        var questions: [Question] = []
        var index = 0
        for question in traitQuiz.questions {
            questions.append(
                .init(
                    id: question.id,
                    index: index,
                    text: question.text,
                    answers: question.answers.map { Question.Answer(id: $0.id, text: $0.text) }
                )
            )
            index += 1
        }
        return questions
    }
    public var isLastQuestion: Bool { currentQuestionIndex >= questions.count - 1 }
    public var chosenAnswerIdForCurrentQuestion: String? {
        get { chosenAnswerIds[currentQuestionIndex] }
        set { chosenAnswerIds[currentQuestionIndex] = newValue }
    }
    public var areChosenAnswersValid: Bool {
        chosenAnswerIds.contains(nil) == false
    }
    
    private var traitQuiz: TraitQuiz { _traitQuiz() }

    // MARK: initializers
    public init(psychologiesService: PsychologiesServiceProtocol, traitQuiz: @escaping () -> TraitQuiz) {
        self.psychologiesService = psychologiesService
        self._traitQuiz = traitQuiz
        self.chosenAnswerIds = Array(repeating: nil, count: traitQuiz().questions.count)
    }
    
    // MARK: methods
    public func goNext() {
        if isLastQuestion { return }
        currentQuestionIndex += 1
    }
    
    public func goBack() {
        guard currentQuestionIndex > 0 else { return }
        currentQuestionIndex -= 1
    }
    
    public func submit() async {
        if isAnswerSubmissionInProgress { return }
        guard areChosenAnswersValid else { return }
        let answerIds = chosenAnswerIds.compactMap { $0 }
        
        isAnswerSubmissionInProgress = true
        defer { isAnswerSubmissionInProgress = false }
        do {    
            let evaluation = try await psychologiesService.submitTraitQuizAnswers(
                traitTestId: traitQuiz.id,
                answerIds: answerIds
            )
            guard let title = evaluation.title, let text = evaluation.text else {
                state = .error(.someError)
                return
            }
            state = .showingEvaluation(title: title, text: text)
        } catch {
            state = .error(.someError)
        }
    }
    
}

extension QuizViewModel: Identifiable {
    
    // not used, just to comply with Identifiable protocol,
    // used in .fullScreenCover or .sheet view modifiers
    public nonisolated var id: Int { 0 }
    
}
