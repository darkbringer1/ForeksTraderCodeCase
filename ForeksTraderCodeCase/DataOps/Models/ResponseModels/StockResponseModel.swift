//
//  StockResponseModel.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation

// MARK: - Welcome
//struct StockResponseModel: Codable {
//    var l: [Stock]?
//    var z: String?
//}

typealias SymbolDetailItem = [String: String]

struct StockResponseModel: Codable {
    
    enum SymbolKeys: String, CodingKey {
        case list = "l"
    }
    
    let details: [SymbolDetailItem]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SymbolKeys.self)
        self.details = try container.decode([[String: String]].self, forKey: .list)
    }
}
