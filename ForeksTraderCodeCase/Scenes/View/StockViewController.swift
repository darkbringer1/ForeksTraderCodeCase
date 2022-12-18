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
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        view.backgroundColor = .brown
        addMainComponent()
        subscribeToViewModelListeners()
    }
    
    private func subscribeToViewModelListeners() {
        viewModel.getSettings()
        viewModel.subscribeToViewState { [weak self] state in
            switch state {
                case .loading:
                    break
                case .done:
                    self?.mainComponent.reloadTableView()
                case .error:
                    break
            }
        }
    }
    
    private func addMainComponent() {
        mainComponent = StocksTableView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        mainComponent.dataProvider = viewModel

        view.addSubview(mainComponent)

        NSLayoutConstraint.activate([
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
