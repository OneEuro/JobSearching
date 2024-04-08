//
//  LoggingPhysicalPersonView.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 05.04.2024.
//

import UIKit
import Combine


class LoggingPhysicalPersonView: UIView {
    
    var delegate: SignInViewController?
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Поиск работы"
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        l.textAlignment = .left
        l.textColor = .label
        return l
    }()
    
    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField(fieldType: .email)
        textField.tag = 101
        textField.leftViewMode = .unlessEditing
        textField.applyCustomClearButton()
        return textField
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private  let signInButton = {
        let button = LoginButtons(title: "Продолжить", background: .systemBlue, titleColor: .white, fontSize: .big, corner: 8)
        return button
    }()
    
    private lazy var loginStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Invalid username or password. Try again"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.isHidden = true
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var enterWithPasswordButton = {
        let button = LoginButtons(title: "Войти с паролем", background: .clear, titleColor: .systemBlue, fontSize: .small, corner: 0)
        button.addAction(
            UIAction(title: "didTapSignIn", handler: {[unowned self] _ in
                print("enter with password button has tapped")
            }),
            for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
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
        let justTap = signInButton.publisher.share()
        justTap.receive(on: DispatchQueue.main)
            .map { [weak self] in self?.emailTextField.text ?? ""}
            .sink {[unowned self] text in
                    self.delegate?.viewModel.emailTextFieldValue.send(text)
                }
            .store(in: &subscriptions)
                
        emailTextField.textPublisherDidChange.sink { [unowned self] text in
            delegate?.viewModel.loginStatusLabelHidden.send(true)
            if !text.isEmpty {
                delegate?.viewModel.signInButtonEnable.send(true)
                
                emailTextField.rightViewMode = .whileEditing
                emailTextField.leftViewMode = .never
            } else {
                delegate?.viewModel.signInButtonEnable.send(false)
                emailTextField.rightViewMode = .never
                emailTextField.leftViewMode = .always
            }
        }.store(in: &subscriptions)
        
        NotificationCenter.default.publisher(for: NSNotification.Name("ClearButtonTapped"))
                 .sink { [unowned self] _ in
                     delegate?.viewModel.signInButtonEnable.send(false)
                     delegate?.viewModel.loginStatusLabelHidden.send(true)
                 }
                 .store(in: &subscriptions)
            
        delegate?.viewModel.signInButtonEnable
            .receive(on: DispatchQueue.main)
            .sink {[unowned self] enable in
                    self.signInButton.isEnabled = enable
                    if enable {
                        signInButton.backgroundColor = .systemBlue
                    } else {
                        signInButton.backgroundColor = .systemGray
                    }
                }.store(in: &subscriptions)
        
        Publishers.CombineLatest(delegate!.viewModel.loginStatusValue, delegate!.viewModel.loginStatusLabelHidden)
            .receive(on: DispatchQueue.main)
            .sink {[unowned self] (labelText, hidden) in
                self.loginStatusLabel.text = labelText
                self.loginStatusLabel.isHidden = hidden
                self.emailTextField.addRedBorder = !hidden
                self.loginStatusLabel.shake()
            }.store(in: &subscriptions)
        
        
        delegate?.viewModel.credentialsData.receive(on: DispatchQueue.main)
            .sink {[weak self] credentials in
                self?.delegate?.coordinator?.showVerificationCode(credentials: credentials)
            }.store(in: &subscriptions)
    }
    
    
    private func setupUI() {
        backgroundColor = UIColor.substrateColor
        layer.cornerRadius = 8
        let saveArea = self.safeAreaLayoutGuide
        
        [signInButton,enterWithPasswordButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            hStack.addArrangedSubview($0)
        }
        
        [titleLabel, emailTextField,loginStatusLabel, hStack].forEach {
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
