//
//  StockResponseModel.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation

// MARK: - Welcome
struct StockResponseModel: Codable {
    var l: [L]?
    var z: String?
}

// MARK: - L
struct L: Codable {
    var tke, clo, pdd, las: String?
}
