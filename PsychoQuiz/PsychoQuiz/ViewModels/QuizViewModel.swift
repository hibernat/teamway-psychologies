//
//  QuizViewModel.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import Combine
import PsychologiesService

final class QuizViewModel: ObservableObject {
    
    // MARK: - dependencies
    let psychologiesService: PsychologiesServiceProtocol
    
    // MARK: - stored properties
    
    
    // MARK: - computed properties
    
    init(psychologiesService: PsychologiesServiceProtocol) {
        self.psychologiesService = psychologiesService
    }
}

