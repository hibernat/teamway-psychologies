//
//  EnvironmentValues+.swift
//  PsychoQuiz
//
//  Created by Michael Bernat on 06.12.2022.
//

import SwiftUI

private struct ErrorViewActionKey: EnvironmentKey {
    static let defaultValue: ErrorViewAction = ErrorViewAction(onRetryButton: { })
}

extension EnvironmentValues {
    var errorViewAction: ErrorViewAction {
        get { self[ErrorViewActionKey.self] }
        set { self[ErrorViewActionKey.self] = newValue }
    }
}
