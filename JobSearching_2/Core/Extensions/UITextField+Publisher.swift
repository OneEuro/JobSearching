//
//  UITextField+Publisher.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit.UITextField
import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidEndEditingNotification,
            object: self)
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }
    
    var textPublisherDidChange: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self)
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }
}
