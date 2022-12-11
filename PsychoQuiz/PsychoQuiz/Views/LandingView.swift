//
//  LandingView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI
import PsychoQuizViewModels

struct LandingView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .quizNotLoading, .quizLoadingInProgress:
                quizNotAvailableView
            case .quizLoadingError(let quizLoadingError):
                ErrorView(
                    text: errorText(for: quizLoadingError),
                    buttonTitle: R.string.localizable.landingViewErrorRetry
                )
                .environment(\.errorViewAction, ErrorViewAction(onRetryButton: { onErrorRetry() }))
            case .quizAvailable:
                quizAvailableView
            }
        }
        .padding()
    }
    
    @ViewBuilder var quizNotAvailableView: some View {
        VStack {
            Text(R.string.localizable.landingViewLoading)
                .multilineTextAlignment(.center)
        }
        .task {
            await viewModel.loadTraitQuiz()
        }
    }
    
    @ViewBuilder var quizAvailableView: some View {
        VStack {
            Text(R.string.localizable.landingViewWelcomeTitle)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Text(R.string.localizable.landingViewWelcomeText)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding()
            
            Button(action: { viewModel.startQuiz() }) {
                Text(R.string.localizable.landingViewWelcomePlayButton)
                    .padding()
            }
            .buttonStyle(.bordered)
            .padding(.top)
        }
        // presenting quiz view
        .fullScreenCover(item: $viewModel.quizViewModel) { quizViewModel in
            QuizView()
                .environmentObject(quizViewModel)
        }
    }
    
    private func errorText(for error: AppViewModel.QuizLoadingError) -> LocalizedStringKey {
        switch error {
        case .someError: return R.string.localizable.landingViewSomeError
        }
    }
    
    private func onErrorRetry() {
        Task {
            await viewModel.loadTraitQuiz()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LandingView()
            .environmentObject(AppViewModel.preview)
    }
}
