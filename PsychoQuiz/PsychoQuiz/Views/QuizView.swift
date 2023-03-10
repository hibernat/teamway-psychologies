//
//  QuizView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 07.12.2022.
//

import SwiftUI
import PsychoQuizViewModels

struct QuizView: View {
    
    @EnvironmentObject var viewModel: QuizViewModel
    
    var body: some View {
        switch viewModel.state {
        case .playingQuiz:
            PlayingQuizView()
                .padding()
        case .error(let submitError):
            ErrorView(
                text: errorText(for: submitError),
                buttonTitle: R.string.localizable.quizViewErrorRetry
            )
            .padding()
            .environment(\.errorViewAction, ErrorViewAction(onRetryButton: { onErrorRetry() }))
        case .showingEvaluation(let title, let text):
            EvaluationView(title: title, text: text)
                .padding()
        }
    }
    
    private func errorText(for error: QuizViewModel.Error) -> LocalizedStringKey {
        switch error {
        case .someError: return R.string.localizable.quizViewSomeError
        }
    }
    
    private func onErrorRetry() {
        Task {
            await viewModel.submit()
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    
    static var previews: some View {
        QuizView()
            .environmentObject(QuizViewModel.preview)
    }
}
