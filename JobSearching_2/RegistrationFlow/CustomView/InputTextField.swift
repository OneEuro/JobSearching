//
//  InputTextField.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import UIKit

class InputTextField: UITextField {

    enum TextFieldsType {
        case userName
        case email
        case password
    }
    
    private let loginFieldType: TextFieldsType
    
    var addRedBorder: Bool = false {
        willSet {
            if newValue {
                layer.borderWidth = 2
                layer.borderColor = UIColor.red.cgColor
            } else {
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    let padding = UIEdgeInsets(top: 12, left: 40, bottom: 12, right: 0)
//    let editingPadding = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.inset(by: padding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 8, y: (self.bounds.height / 2) - 10, width: 24 , height: 20)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.offsetBy(dx: -10, dy: 0)
    }
    
    
    init(fieldType: TextFieldsType) {
        loginFieldType = fieldType
        super.init(frame: .zero)
        backgroundColor = UIColor.grayColor
        layer.cornerRadius = 8
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
                
        let imageView = UIImageView(image: UIImage(named: "feedbackIcon"))
        leftView = imageView
        
        font = UIFont.systemFont(ofSize: 15)
        
        switch fieldType {
        case .userName:
            placeholder = "Username"
            keyboardType = .default
        case .email:
            placeholder = "Электронная почта и телефон"
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = "Password"
            textContentType = .oneTimeCode
            keyboardType = .numbersAndPunctuation
            isSecureTextEntry = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
    }
    
    
    
}

extension InputTextField {
    func applyCustomClearButton() {
        clearButtonMode = .never

        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        clearButton.setImage(UIImage(named: "cancelIcon"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)

        rightView = clearButton
    }

    @objc func clearText(sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("ClearButtonTapped"), object: nil)
        text = ""
    }
    
}

