//
//  QuizViewModel+preview.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 7.12.2022.
//

import Foundation
import PsychoQuizViewModels
import PsychologiesService

extension QuizViewModel {
    
    public static var preview = QuizViewModel(
        psychologiesService: PsychologiesService(
            sleepForMilliseconds: 0,
            failureRate: 0,
            errorThrownOnFailure: URLError(.unknown)
        ),
        traitQuiz: {
            let url = Bundle(for: QuizViewModel.self).url(forResource: "TraitQuiz", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            let traitQuiz = try! JSONDecoder().decode(TraitQuiz.self, from: data)
            return traitQuiz
        }
    )
    
}
