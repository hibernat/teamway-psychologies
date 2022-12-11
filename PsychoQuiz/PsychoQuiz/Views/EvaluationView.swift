//
//  EvaluationView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 7.12.2022.
//

import SwiftUI
import PsychoQuizViewModels

struct EvaluationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let title: String
    let text: String
    
    var body: some View {
        VStack {
            // title and text
            ScrollView {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3)
                        .bold()
                    Divider()
                    Text(text)
                }
            }
            // close button
            Button(action: { dismiss() }) {
                Text(R.string.localizable.quizViewDismissButton)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct EvaluationView_Previews: PreviewProvider {
    
    static var previews: some View {
        EvaluationView(
            title: "You are more of a public extrovert and private introvert",
            text: "In public and at work you are a ball of energy perpetually on the move. You take the initiative, encourage others, hate waiting and are endlessly anticipating what’s going on around you. You take real pleasure in managing everything, much like the conductor of an orchestra. You enjoy being noticed by your work peers and your anxiety is linked more to the thought of leaving others indifferent. You need other’s attention to fully exist, but once you’ve crossed the threshold of your home, it’s another matter. You no longer take initiatives, but leave others to decide in your place. When your partner asks you to make a choice or give an opinion about holiday destinations, dinner menus or the children’s activities, you offer little or no input. You’re not comfortable and don’t know how to react and those around you often interpret your passiveness as a lack of interest or a certain reticence."
        )
        .environmentObject(QuizViewModel.preview)
        .previewLayout(.sizeThatFits)
    }
}
