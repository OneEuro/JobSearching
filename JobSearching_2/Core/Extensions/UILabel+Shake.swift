//
//  UILabel+Shake.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 06.04.2024.
//

import Foundation
import UIKit.UILabel

extension UILabel {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
