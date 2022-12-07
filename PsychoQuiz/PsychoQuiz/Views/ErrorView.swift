//
//  ErrorView.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI

struct ErrorView: View {
    
    let text: LocalizedStringKey
    let buttonTitle: LocalizedStringKey
    @Environment(\.errorViewAction) private var errorViewAction
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: R.Image.System.exclamationMarkOctagon)
                    .resizable()
                    .foregroundColor(Color(uiColor: UIColor.systemRed))
                    .frame(width: 30, height: 30)
                Text(text)
            }
            .padding()
            
            Button(action: { errorViewAction() }) {
                Text(buttonTitle)
                    .padding()
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ErrorViewAction {
 
    let onRetryButton: () -> Void
    
    func callAsFunction() {
        onRetryButton()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text: "Error", buttonTitle: "Retry")
            .previewLayout(.sizeThatFits)
    }
}
