//
//  DataFormatter.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation

class DataFormatter {
    private var pageSettings: PageSettingsResponseModel?
    private var stocks: StockResponseModel?
    
    func setSettingsResponse(with response: PageSettingsResponseModel) {
        pageSettings = response
    }
    
    func getMyPagePairs() -> [Mypage]? {
        pageSettings?.mypage
    }
    
    func getMyPageDefaults() -> [MypageDefault]? {
        pageSettings?.mypageDefaults
    }
    
    func setStocksResponse(with response: StockResponseModel) {
        stocks = response
    }
    
    func getCellData(by index: Int) -> StockRowData? {
        guard let stockItem = stocks?.l?[index], let name = stockItem.tke, let criteria = stockItem.pdd else { return nil }
        return StockRowData(direction: "", name: name, criteria: criteria, diff: "")
    }
    
    func numberOfItems() -> Int {
        return stocks?.l?.count ?? 0
    }
}
