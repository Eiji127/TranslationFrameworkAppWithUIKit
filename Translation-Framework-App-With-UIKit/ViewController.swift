//
//  ViewController.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/04.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "The Best Food is Mcdonald's Fried Potato 🍟"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Please Tapp This Button"
        button.setTitle("Please Tap This Button", for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // ① 先にTranslationEmptyViewを画面にセット
        TranslationService.shared.setUp(viewController: self)
        
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ② self.viewに対して網羅的に翻訳を実行していく。
        translateSubviews(view: view)
    }

    private func configureView() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }
    
    func translateSubviews(view: UIView) {
        // UILabel のテキストを取得
        if let label = view as? UILabel, let text = label.text {
            Task { @MainActor in
                let targetedText = try? await TranslationService.shared.translate(on: self, from: text)
                label.text = targetedText
            }
        }
        
        // UIButton のタイトルを取得
        if let button = view as? UIButton, let title = button.title(for: .normal) {
            Task { @MainActor in
                let targetedText = try? await TranslationService.shared.translate(on: self, from: title)
                button.setTitle(targetedText, for: .normal)
            }
        }
        
        // UITextField のプレースホルダーとテキストを取得
        if let textField = view as? UITextField {
            if let text = textField.text, !text.isEmpty {
                Task { @MainActor in
                    let targetedText = try? await TranslationService.shared.translate(on: self, from: text)
                    textField.text = targetedText
                }
            }
            if let placeholder = textField.placeholder {
                Task { @MainActor in
                    let targetedText = try? await TranslationService.shared.translate(on: self, from: placeholder)
                    textField.placeholder = targetedText
                }
            }
        }
        
        // UITextView のテキストを取得
        if let textView = view as? UITextView, !textView.text.isEmpty {
            Task { @MainActor in
                let targetedText = try? await TranslationService.shared.translate(on: self, from: textView.text)
                textView.text = targetedText
            }
        }
        
        // 再帰的に子ビューを検索
        for subview in view.subviews {
            translateSubviews(view: subview)
        }
        
        view.layoutIfNeeded()
    }
    
    @objc private func buttonTapped() {
        print("DEBUG: button tapped")
    }
}
