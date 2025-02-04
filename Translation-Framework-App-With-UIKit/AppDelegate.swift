//
//  AppDelegate.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/04.
//

import UIKit
import Translation

class AppDelegate: UIResponder, UIApplicationDelegate {
    var translationSession: TranslationSession?
    var foodItems = ["Salat 🥗", "Fritten 🍟", "Suppe 🍜"]
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // `UIApplication.shared.connectedScenes` から `UIWindowScene` を取得
//        if let windowScene = application.connectedScenes.first as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            
//            // エントリーポイントの ViewController を指定
//            let viewController = ViewController()
//            viewController.delegate = self
//            let navigationController = UINavigationController(rootViewController: viewController)
//            
//            // UIWindow の rootViewController を設定
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//            
//            self.window = window
//        }
        
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
}

extension AppDelegate: ViewControllerDelegate {
    func translateViewTexts() {
        print("DEBUG: translateViewTexts")
    }
}

