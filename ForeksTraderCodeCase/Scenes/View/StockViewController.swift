//
//  StockViewController.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import UIKit
import BaseComponents

class StockViewController: BaseViewController<StockViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        viewModel.getSettings()
    }
//    
//    private func subscribeToViewModelListeners() {
//        viewModel.getSettings()
//    }
}
