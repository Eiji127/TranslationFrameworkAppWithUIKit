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
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    let sourceText: String?
    
    var body: some View {
        VStack{}
            .translationTask(translationContext.configuration) { session in
                guard let sourceText else { return }
                let request: TranslationSession.Request = .init(sourceText: sourceText)
                
                appDelegate.translationSession = session
                appDelegate.translationRequest = request
            }
            .background(.clear)
    }
}
