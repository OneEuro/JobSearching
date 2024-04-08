//
//  VacancieCardView.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import UIKit

class VacancieCardView: UIView {
    
    private var viewModel: MainPageViewModelProtocol
    
    private var vStack: UIStackView = {
        let stack  = UIStackView()
        stack.backgroundColor = .purple
        let text = UILabel()
        text.text = "test"
        stack.addArrangedSubview(text)
        return stack
    }()
    
    init(viewModel: MainPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI() 
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
