//
//  TranslationService.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by eiji.shirakazu on 2025/02/04.
//

import Foundation
import UIKit
import SwiftUI
import Translation

class TranslationService {
    static let shared: TranslationService = .init()
    
    var session: TranslationSession? {
        didSet {
            print("DEBUG: Set Translation Session")
        }
    }
    
    private let cache = NSCache<NSString, NSString>()

    @MainActor
    func translate(on viewController: UIViewController, from text: String) async throws -> String {
        if let translation = cache.object(forKey: NSString(string: text)) {
            return String(translation)
        }
        guard let session = session else {
            return text
        }
        do {
            let availability = LanguageAvailability()
            let status = try await availability.status(for: text, to: session.targetLanguage)
            if status == .installed {
                let response = try await session.translate(text)
                cache.setObject(NSString(string: response.targetText), forKey: NSString(string: text))
                return response.targetText
            }
        } catch(let error) {
            print("Error: Translation Failed - \(error)")
        }
        return text
    }
    
    func setUp(viewController: UIViewController) {
        let translationEmptyView = TranslationEmptyView()
        let hostingController = UIHostingController(rootView: translationEmptyView)
        hostingController.view.backgroundColor = .clear
        hostingController.view.isUserInteractionEnabled = false
        
        viewController.addChild(hostingController)
        viewController.view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
        ])
        hostingController.didMove(toParent: viewController)
    }
}
