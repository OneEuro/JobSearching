//
//  VerificationCodeViewController.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import UIKit
import Combine

class VerificationCodeViewController: UIViewController {

    var viewModel: VerificationCodeViewModelProtocol
    weak var coordinator: RegistrationFlowCoordinatorProtocol?

    private var vStack: UIStackView!
    private var recipientMailLabel: UILabel!
    private var helperLabel: UILabel!
    private var verifyView: VerifyView!
    private var confirmButton: LoginButtons!
    private var loginStatusLabel: UILabel!
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(
        viewModel: VerificationCodeViewModelProtocol,
        coordinator: RegistrationFlowCoordinatorProtocol)
    {
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension VerificationCodeViewController {
    
    private func bindViewModel() {
        
        confirmButton.publisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] event in
                self.viewModel.didConfirmButtonTap()
            }
            .store(in: &subscriptions)

        viewModel.userData
            .receive(on: DispatchQueue.main)
            .sink {[weak self] user in
                self?.coordinator?.endFlow(user: user)
            }.store(in: &subscriptions)
        
        viewModel.emailValue
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] text in
                self.recipientMailLabel.text = "Отправили код на \(text)"
            }.store(in: &subscriptions)
        
        viewModel.verificationCodeValue
            .receive(on: DispatchQueue.main)
            .map{ array in
                array.count == 4 ? true: false
            }
            .sink { [weak self] enable in
                if enable {
                    self?.confirmButton.isEnabled = enable
                    self?.confirmButton.backgroundColor = .systemBlue
                } else {
                    self?.confirmButton.isEnabled = enable
                    self?.confirmButton.backgroundColor = .systemGray
                }
            }
            .store(in: &subscriptions)
        
        Publishers.CombineLatest(viewModel.loginStatusValue, viewModel.loginStatusLabelHidden)
            .receive(on: DispatchQueue.main)
            .sink {[unowned self] (labelText, hidden) in
                self.loginStatusLabel.text = labelText
                self.loginStatusLabel.isHidden = hidden
            }.store(in: &subscriptions)
    }
    
    private func createSubViews() {
        recipientMailLabel = UILabel()
        recipientMailLabel.text = "Отправили код на example.com"
        recipientMailLabel.numberOfLines = 1
        recipientMailLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        helperLabel = UILabel()
        helperLabel.text = "Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет"
        helperLabel.numberOfLines = 0
        helperLabel.font = UIFont.systemFont(ofSize: 16)
        
        loginStatusLabel = UILabel()
        loginStatusLabel.textColor = .label
        loginStatusLabel.text = "Invalid username or password. Try again"
        loginStatusLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        loginStatusLabel.textAlignment = .left
        loginStatusLabel.isHidden = true
        loginStatusLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        loginStatusLabel.numberOfLines = 0
        
        verifyView = VerifyView()
        verifyView.delegate = self
        
        confirmButton = LoginButtons(title: "Подтвердить", background: .systemBlue, titleColor: .white, fontSize: .big, corner: 8)
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = .systemGray
        
        vStack = UIStackView(arrangedSubviews: [recipientMailLabel, helperLabel, verifyView, loginStatusLabel, confirmButton])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 16
        vStack.alignment = .leading

    }
    
    private func setupUI() {
        view.addSubview(vStack)
        view.backgroundColor = .black
        
        let saveArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
//            vStack.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: saveArea.topAnchor,constant: 200),
            vStack.leadingAnchor.constraint(equalTo: saveArea.leadingAnchor,constant: 16),
            vStack.trailingAnchor.constraint(equalTo: saveArea.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            verifyView.widthAnchor.constraint(equalTo: saveArea.widthAnchor, multiplier: 0.6),
            confirmButton.heightAnchor.constraint(equalTo: saveArea.heightAnchor, multiplier: 0.065),
            confirmButton.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 1)
        ])
        
    }
    
}
