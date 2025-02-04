//
//  TranslationService.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by eiji.shirakazu on 2025/02/04.
//

import Foundation
import Translation

struct TranslationService {
    private let cache = NSCache<NSString, NSString>()

    func translate(using session: TranslationSession?, from text: String) async throws -> String {
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
}
