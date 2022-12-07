//
//  PsychoQuizApp.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI
import PsychologiesService

@main
struct PsychoQuizApp: App {
    
    @StateObject var appViewModel = AppViewModel(
        psychologiesService: PsychologiesService(
            sleepForMilliseconds: 600,
            failureRate: Int.max - 2,
            errorThrownOnFailure: URLError(.unknown)
        )
    )
    
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(appViewModel)
        }
    }
}
