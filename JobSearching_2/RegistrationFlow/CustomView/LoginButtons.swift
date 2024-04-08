//
//  LoginButtons.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import UIKit

class LoginButtons: UIButton {

    enum FontSize {
        case big
        case small
    }
    
    private var normalColor: UIColor = .clear
    private var selectedColor: UIColor = .darkGray
    
    override var isHighlighted: Bool {
          didSet {
              backgroundColor = isHighlighted ? selectedColor : normalColor
          }
    }
    
    init(title: String, background: UIColor, titleColor: UIColor, fontSize: FontSize, corner: CGFloat) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = corner
        layer.masksToBounds = true
        
        backgroundColor = background
        normalColor = background
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        case .small:
            titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
