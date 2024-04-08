//
//  MainPageViewController.swift
//  JobSearching_2
//
//  Created by Владимир Малышев on 04.04.2024.
//

import UIKit

class MainPageViewController: UIViewController {
    
    private var coordinator: AppFlowCoordinatorProtocol
    private var viewModel: MainPageViewModel
    
    private var searchBlock: UISearchTextField!
    private var filterButton: UIButton!
    private var hCollectionView: UICollectionView!
    
    private var scrollView: UIScrollView!
    private var card: VacancieCardView!
    private var additionalVacanciesButton: LoginButtons!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    init(coordinator:AppFlowCoordinatorProtocol, viewModel:MainPageViewModel ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupSubviews()
        setupUI()
//        viewModel.getJobData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPageViewController {
    
    private func setupSubviews() {
        searchBlock = UISearchTextField()
        searchBlock.placeholder = "Должность, ключевые слова"
        
        filterButton = UIButton()
        filterButton.setBackgroundImage(UIImage(named: "filterIcon"), for: .normal)
        
        card = VacancieCardView(viewModel: viewModel)
        
        scrollView = UIScrollView()
        [searchBlock, filterButton].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.addSubview(searchBlock)
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let saveArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            searchBlock.topAnchor.constraint(equalTo: scrollView.topAnchor),
            searchBlock.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            searchBlock.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            searchBlock.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.04),
            searchBlock.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            filterButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            filterButton.heightAnchor.constraint(equalTo: filterButton.widthAnchor),
            filterButton.heightAnchor.constraint(equalTo: searchBlock.heightAnchor),
            filterButton.leadingAnchor.constraint(equalTo: searchBlock.trailingAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: saveArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: saveArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: saveArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor)
        ])
    }
}


