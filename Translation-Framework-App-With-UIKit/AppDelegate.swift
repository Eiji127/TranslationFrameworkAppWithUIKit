//
//  AppDelegate.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/04.
//

import UIKit
import Translation
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var translationSession: TranslationSession? {
        didSet {
            translate()
        }
    }
    let trasnlationService = TranslationService()
    var foodItems = ["The Best Food is Mcdonald's Fried Potato 🍟", "Salad 🥗", "Soup 🍜"]

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = ViewController()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

    private func translate() {
        Task { @MainActor in
            let translated = try? await trasnlationService.translate(using: translationSession, from: foodItems.first ?? "Failed")
            print("DEBUG: \(String(describing: translated))")
        }
    }
}

