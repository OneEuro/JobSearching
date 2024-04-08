//
//  SignInViewController.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import UIKit
import Combine

class SignInViewController: UIViewController {
    
    var viewModel: SignInViewModelProtocol
    weak var coordinator: RegistrationFlowCoordinatorProtocol?

    private var loginHeaderLabel: UILabel!
    private var loggingPhysicalPersonBlock: LoggingPhysicalPersonView!
    
    private var loginEmployerView: LoginEmployerView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Init()
    init(
        viewModel: SignInViewModelProtocol,
        coordinator: RegistrationFlowCoordinatorProtocol)
    {
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        createSubViews()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bindViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        viewModel.passwordVerification.loadUsers()
    }
    
    private func createSubViews() {
        loginHeaderLabel = UILabel()
        loginHeaderLabel.text = "Вход в личный кабинет"
        loginHeaderLabel.textColor = .white
        
        loggingPhysicalPersonBlock = LoggingPhysicalPersonView(delegate: self)
        loginEmployerView = LoginEmployerView(delegate: self)
    }
    
    private func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        initializeHideKeyboard()
        
        [loginHeaderLabel,loggingPhysicalPersonBlock, loginEmployerView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            loginHeaderLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            loginHeaderLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            loggingPhysicalPersonBlock.topAnchor.constraint(equalTo: loginHeaderLabel.bottomAnchor, constant: 140),
            loggingPhysicalPersonBlock.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 18),
            loggingPhysicalPersonBlock.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -18),
            
            loginEmployerView.topAnchor.constraint(equalTo: loggingPhysicalPersonBlock.bottomAnchor,constant: 22),
            loginEmployerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 18),
            loginEmployerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -18)
            
        ])

    }
    
    //MARK: - selectors
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

