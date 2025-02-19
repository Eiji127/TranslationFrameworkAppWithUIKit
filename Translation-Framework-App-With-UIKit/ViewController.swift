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
        // ② 翻訳処理を実行
        if let sourceText = textLabel.text {
            Task { @MainActor in
                let targetedText = try? await TranslationService.shared.translate(on: self, from: sourceText)
                textLabel.text = targetedText
                view.layoutIfNeeded()
            }
        }
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
    
    @objc private func buttonTapped() {
        print("DEBUG: button tapped")
    }
}
