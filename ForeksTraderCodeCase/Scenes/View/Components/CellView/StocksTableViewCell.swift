//
//  StocksTableViewCell.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import UIKit
import BaseComponents

class StocksTableViewCell: GenericTableViewCell<StockCellData, StockCellView> {
    override func addViewComponents() {
        super.addViewComponents()
        backgroundColor = .blue
    }
}
