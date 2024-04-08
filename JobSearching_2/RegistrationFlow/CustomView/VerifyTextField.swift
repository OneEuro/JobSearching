//
//  VerifyTextField.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 07.04.2024.
//

import UIKit
import Combine

protocol FieldsProtocol: AnyObject {
    func activeNewField(tag: Int)
    func activePreviosField(tag: Int)
}

class VerifyTextField: UITextField {
    
    weak var fieldDelegate: FieldsProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = UIColor.substrateColor
        layer.cornerRadius = 8
        tintColor = .clear
        layer.borderColor = UIColor.purple.cgColor
        textColor = .darkGray
        font = UIFont.boldSystemFont(ofSize: 40)
        textAlignment = .center
        keyboardType = .namePhonePad
        placeholder = "*"
    }

    
    override func deleteBackward() {
        fieldDelegate?.activePreviosField(tag: tag)
    }
}

extension VerifyTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if range.length == 0  && allowedCharacters.isSuperset(of: characterSet) {
            text = string
            fieldDelegate?.activeNewField(tag: tag)
            resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }
}
