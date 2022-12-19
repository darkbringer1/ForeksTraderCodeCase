//
//  StockViewController.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import UIKit
import BaseComponents

class StockViewController: BaseViewController<StockViewModel> {
    
    private var mainComponent: StocksTableView!
    private var headerComponent: StocksHeaderView!
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        return spinner
    }()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        view.backgroundColor = .lightGray
        addTableView()
        addHeaderView()
        addSpinner()
        subscribeToViewModelListeners()
    }
    
    private func addTableView() {
        mainComponent = StocksTableView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        mainComponent.dataProvider = viewModel
        
        view.addSubview(mainComponent)
        
        NSLayoutConstraint.activate([
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func addHeaderView() {
        headerComponent = StocksHeaderView()
        headerComponent.translatesAutoresizingMaskIntoConstraints = false
        headerComponent.dataProvider = viewModel
        
        view.addSubview(headerComponent)
        
        NSLayoutConstraint.activate([
            headerComponent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerComponent.bottomAnchor.constraint(equalTo: mainComponent.topAnchor)
        ])
    }
    
    private func addSpinner() {
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func subscribeToViewModelListeners() {
        viewModel.getSettings()
        viewModel.startTimer()
        viewModel.subscribeToViewState { [weak self] state in
            switch state {
                case .loading:
                    break
                case .done:
                    self?.mainComponent.reloadTableView()
                    self?.headerComponent.reloadPickerData()
                case .error:
                    break
            }
        }
    }
}
