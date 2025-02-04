//
//  TranslationContext.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by eiji.shirakazu on 2025/02/04.
//

import SwiftUI
import Translation

@Observable
class TranslationContext {
    var configuration = {
        let userDefaults = UserDefaults.standard
        let sourceLanguage = userDefaults.string(forKey: "sourceLanguage") ?? "en-Latn-US"
        let targetLanguage = userDefaults.string(forKey: "targetLanguage") ?? "ja-Jpan-JP"
        return TranslationSession.Configuration(
            source: Locale.Language(identifier: sourceLanguage),
            target: Locale.Language(identifier: targetLanguage)
        )
    }()

    var session: TranslationSession?
}

extension EnvironmentValues {
    @Entry var translationContext = TranslationContext()
}
