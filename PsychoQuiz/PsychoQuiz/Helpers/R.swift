//
//  R.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI

enum R {
    
    enum String {
        
        enum Localizable {
            
            static let landingViewLoading: LocalizedStringKey = "LandingView.Loading"
            static let landingViewErrorRetry: LocalizedStringKey = "LandingView.ErrorRetry"
            static let landingViewSomeError: LocalizedStringKey = "LandingView.SomeError"
            static let landingViewWelcomeTitle: LocalizedStringKey = "LandingView.WelcomeTitle"
            static let landingViewWelcomeText: LocalizedStringKey = "LandingView.WelcomeText"
            static let landingViewWelcomePlayButton: LocalizedStringKey = "LandingView.WelcomePlayButton"
            
            static let quizViewNextButton: LocalizedStringKey = "QuizView.NextButton"
            static let quizViewBackButton: LocalizedStringKey = "QuizView.BackButton"
            static let quizViewSubmitButton: LocalizedStringKey = "QuizView.SubmitButton"
            static let quizViewErrorRetry: LocalizedStringKey = "QuizView.ErrorRetry"
            static let quizViewSomeError: LocalizedStringKey = "QuizView.SomeError"
            static let quizViewDismissButton: LocalizedStringKey = "QuizView.DismissButton"
        }
    
        static let localizable = R.String.Localizable.self
    }
    
    enum Image {
        
        enum System {
            
            static let exclamationMarkOctagon = "exclamationmark.octagon"
        }
        
        static let system = R.Image.System.self
    }
    
    static let string = R.String.self
    static let image = R.Image.self
    
}
