//
//  LoginEmployerView.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 08.04.2024.
//

import UIKit
import Combine


class LoginEmployerView: UIView {
    
    var delegate: SignInViewController?
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Поиск сотрудников"
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        l.textAlignment = .left
        l.textColor = .label
        return l
    }()
    
    private lazy var helperLabel: UILabel = {
        let l = UILabel()
        l.text = "Размещение вакансий и доступ к базе резюме"
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        l.textAlignment = .left
        l.textColor = .label
        return l
    }()


    private  let signInButton = {
        let button = LoginButtons(title: "Я ищу сотрудников", background: .systemGreen, titleColor: .white, fontSize: .big, corner: 8)
        return button
    }()

    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    init(delegate: SignInViewController) {
        self.delegate = delegate
        super.init(frame: .zero)
        bindViewModel()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func bindViewModel() {
       
    }
    
    
    private func setupUI() {
        backgroundColor = UIColor.substrateColor
        layer.cornerRadius = 8
        let saveArea = self.safeAreaLayoutGuide
        
        [titleLabel, helperLabel, signInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            vStack.addArrangedSubview($0)
        }
        addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: saveArea.topAnchor,constant: 24),
            vStack.leadingAnchor.constraint(equalTo: saveArea.leadingAnchor,constant: 16),
            vStack.trailingAnchor.constraint(equalTo: saveArea.trailingAnchor,constant: -16),
            vStack.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor,constant: -24)
        ])
    }
}

