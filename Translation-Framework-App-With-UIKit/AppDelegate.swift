//
//  AppDelegate.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/04.
//

import UIKit
import Translation

class AppDelegate: UIResponder, UIApplicationDelegate {
    var translationSession: TranslationSession? {
        didSet {
            translate()
        }
    }
    private let service = TranslationService()
    var foodItems = ["The Best Food is Mcdonald's Fried Potato 🍟", "Salad 🥗", "Soup 🍜"]

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func translate() {
        Task { @MainActor in
            let translated = try? await service.translate(using: translationSession, from: foodItems.first ?? "Failed")
            print("DEBUG: \(String(describing: translated))")
        }
    }
}

extension AppDelegate: ViewControllerDelegate {
    func translateViewTexts() {
        print("DEBUG: translateViewTexts")
    }
}

