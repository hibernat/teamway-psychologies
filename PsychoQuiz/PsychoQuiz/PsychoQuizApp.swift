//
//  PsychoQuizApp.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI
import PsychoQuizViewModels

@main
struct PsychoQuizApp: App {
    
    @StateObject var appViewModel = AppViewModel.default
    
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(appViewModel)
        }
    }
}
