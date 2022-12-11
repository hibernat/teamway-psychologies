//
//  AppViewModel+preview.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 7.12.2022.
//

import Foundation
import PsychoQuizViewModels
import PsychologiesService

extension AppViewModel {
    
    static var preview = AppViewModel(
        psychologiesService: PsychologiesService(
            sleepForMilliseconds: 0,
            failureRate: 0,
            errorThrownOnFailure: URLError(.unknown)
        )
    )
    
}
