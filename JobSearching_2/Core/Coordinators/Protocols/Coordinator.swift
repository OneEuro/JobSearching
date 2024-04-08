//
//  Coordinator.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import Foundation
import UIKit.UINavigationController

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
