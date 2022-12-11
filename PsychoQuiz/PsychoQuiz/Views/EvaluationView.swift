//
//  EvaluationView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 7.12.2022.
//

import SwiftUI
import PsychoQuizViewModels

struct EvaluationView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
    }
}

struct EvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluationView(text: "abc")
            .environmentObject(QuizViewModel.preview)
            .previewLayout(.sizeThatFits)
    }
}
