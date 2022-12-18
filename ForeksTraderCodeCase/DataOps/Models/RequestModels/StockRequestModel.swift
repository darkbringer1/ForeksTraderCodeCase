//
//  StockRequestModel.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation


/// - Parameters:
/// - fields: The list of field keys. You need to seperate them with ","
/// - stcs:  The list of stock keys. You need to seperate them with "~"

struct StockRequestModel: Codable {
    let stcs: String
    let fields: String
}
