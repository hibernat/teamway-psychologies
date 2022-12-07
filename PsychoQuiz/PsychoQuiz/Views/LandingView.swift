//
//  LandingView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI
import PsychologiesService

struct LandingView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        Group {
            switch appViewModel.state {
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
            await appViewModel.loadTraitQuiz()
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
            
            Button(action: { appViewModel.startQuiz() }) {
                Text(R.string.localizable.landingViewWelcomePlayButton)
                    .padding()
            }
            .buttonStyle(.bordered)
            .padding(.top)
        }
    }
    
    private func errorText(for error: AppViewModel.QuizLoadingError) -> LocalizedStringKey {
        switch error {
        case .someError: return R.string.localizable.landingViewSomeError
        }
    }
    
    private func onErrorRetry() {
        Task {
            await appViewModel.loadTraitQuiz()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    
    static let appViewModel = AppViewModel(
        psychologiesService: PsychologiesService(
            sleepForMilliseconds: 0,
            failureRate: 0,
            errorThrownOnFailure: URLError(.unknown)
        )
    )
    
    static var previews: some View {
        LandingView()
            .environmentObject(Self.appViewModel)
    }
}
