//
//  App.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/04.
//

import SwiftUI
import Observation
import Translation

@main
struct EntryPoint: App {
    
    @AppStorage("targetLanguage") private var targetLanguage = "ja"

    @State private var configuration = TranslationSession.Configuration()
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
          VStack {}
            .translationTask(configuration) { (session) in
              appDelegate.translationSession = session
            }
        }
    }
}

