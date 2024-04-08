//
//  VerifyView.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import UIKit
import Combine

class VerifyView: UIView {
    
    var fieldStack = UIStackView()
    var verifyFields = [VerifyTextField]()
        
    weak var delegate: VerificationCodeViewController?
    
    private var digits: [Int] = [Int]()
    private var subscriptions = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        verifyTextFieldConfiguration()
        setConstraints()
        verifyFields[0].becomeFirstResponder()
        translatesAutoresizingMaskIntoConstraints = false

        Publishers.CombineLatest4(verifyFields[0].textPublisher, verifyFields[1].textPublisher, verifyFields[2].textPublisher, verifyFields[3].textPublisher)
            .receive(on: DispatchQueue.main)
            .map({$0.0+$0.1+$0.2+$0.3})
            .sink {[weak self] array in
                self?.delegate?.viewModel.verificationCodeValue.send(array)
            }.store(in: &subscriptions)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func verifyTextFieldConfiguration() {
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        fieldStack.spacing = 5
        fieldStack.distribution = .fillEqually
        
        for number in 0..<4 {
            let verifyTextField = VerifyTextField()
            verifyTextField.tag = number
            verifyTextField.fieldDelegate = self
            verifyFields.append(verifyTextField)
            fieldStack.addArrangedSubview(verifyTextField)
        }
        
        addSubview(fieldStack)
    }
    
    func getFieldCode() -> String {
        var fieldCode = ""
        verifyFields.forEach {
            fieldCode.append($0.text ?? "")
        }
        return fieldCode
    }
}

extension VerifyView: FieldsProtocol {
    
    func activeNewField(tag: Int) {
        if tag != verifyFields.count - 1 {
            verifyFields[tag + 1].becomeFirstResponder()
        } else {
        }
    }
    
    func activePreviosField(tag: Int) {
        if tag != 0 {
            verifyFields[tag - 1].placeholder = "*"
            verifyFields[tag - 1].becomeFirstResponder()
        }
    }
}

extension VerifyView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            fieldStack.topAnchor.constraint(equalTo: topAnchor),
            fieldStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            fieldStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            fieldStack.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
}
