//
//  StockResponseModel.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation

struct StockResponseModel: Codable {
    let updateTime: Date = Date()
    
    enum StockKeys: String, CodingKey {
        case stockList = "l"
    }
    
    let detailsList: [[String: String]]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StockKeys.self)
        self.detailsList = try container.decode(Array.self, forKey: .stockList)
    }
}
