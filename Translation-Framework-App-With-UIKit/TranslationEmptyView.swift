//
//  TranslationEmptyView.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/18.
//

import SwiftUI
import Translation

struct TranslationEmptyView: View {
    @AppStorage("targetLanguage") private var targetLanguage = "ja"
    @State private var translationContext = TranslationContext()
    
    var body: some View {
        VStack{}
            .translationTask(translationContext.configuration) { session in
                TranslationService.shared.session = session
            }
            .background(.clear)
    }
}
