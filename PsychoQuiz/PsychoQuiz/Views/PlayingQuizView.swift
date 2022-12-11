//
//  PlayingQuizView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 7.12.2022.
//

import SwiftUI
import PsychoQuizViewModels

struct PlayingQuizView: View {
    
    @EnvironmentObject var viewModel: QuizViewModel
    
    var body: some View {
        VStack {
            // questions with answers
            TabView(selection: $viewModel.currentQuestionIndex) {
                ForEach(viewModel.questions) { question in
                    questionAndAnswersView(questionText: question.text, answers: question.answers)
                        .tag(question.index)
                        .tabItem {
                            Text(question.id)
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            // buttons
            buttonsView
                .animation(.default, value: viewModel.currentQuestionIndex)
        }
    }
    
    @ViewBuilder var buttonsView: some View {
        VStack {
            HStack {
                // back button
                if viewModel.currentQuestionIndex > 0 {
                    Button(action: { viewModel.goBack() }) {
                        Text(R.string.localizable.quizViewBackButton)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                // next button
                if !viewModel.isLastQuestion {
                    Button(action: { viewModel.goNext() }) {
                        Text(R.string.localizable.quizViewNextButton)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            // submit button
            if viewModel.isLastQuestion {
                Button(action: { submit() }) {
                    Text(R.string.localizable.quizViewSubmitButton)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(!viewModel.areChosenAnswersValid)
            }
        }
    }
    
    @ViewBuilder func questionAndAnswersView(questionText: String, answers: [QuizViewModel.Question.Answer]) -> some View {
        VStack {
            Text(questionText)
                .font(.title3)
                .bold()
            List(answers, selection: $viewModel.chosenAnswerIdForCurrentQuestion) { answer in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(viewModel.chosenAnswerIdForCurrentQuestion == answer.id ? Color(uiColor: .systemGray2) : Color(uiColor: .secondarySystemBackground))
                    Text(answer.text)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .tag(answer.id)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
        }
    }
    
    private func submit() {
        Task {
            await viewModel.submit()
        }
    }
}

struct PlayingQuizView_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayingQuizView()
            .environmentObject(QuizViewModel.preview)
            .previewLayout(.sizeThatFits)
    }
}
