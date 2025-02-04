//
//  ViewController.swift
//  Translation-Framework-App-With-UIKit
//
//  Created by 白数叡司 on 2025/02/04.
//

import UIKit
import Translation

protocol ViewControllerDelegate: AnyObject {
    func translateViewTexts()
}

class ViewController: UIViewController {
    
    weak var delegate: ViewControllerDelegate?
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Project"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addTextLabel()
        delegate?.translateViewTexts()
    }

    private func addTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

