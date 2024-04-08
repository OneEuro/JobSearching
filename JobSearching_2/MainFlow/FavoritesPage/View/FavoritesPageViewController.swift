//
//  FavoritesPageViewController.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 05.04.2024.
//

import UIKit

class FavoritesPageViewController: UIViewController {

    private var coordinator: AppFlowCoordinatorProtocol
    private var viewModel: FavoritesPageViewModel
    
    init(coordinator: AppFlowCoordinatorProtocol, viewModel: FavoritesPageViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        // Do any additional setup after loading the view.
    }

}
