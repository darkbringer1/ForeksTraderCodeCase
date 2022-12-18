//
//  StockCellData.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import Foundation

class StockCellData {
    private(set) var direction: String
    private(set) var name: String
    private(set) var criteria: String
    private(set) var diff: String
    
    init(direction: String,
         name: String,
         criteria: String,
         diff: String) {
        self.direction = direction
        self.name = name
        self.criteria = criteria
        self.diff = diff
    }
}
