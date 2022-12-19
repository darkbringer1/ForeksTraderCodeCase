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
    
    func getCellData(by index: Int, leftKey: String, rightKey: String) -> StockRowData? {
        guard let stockItem = stocks?.details else { return nil }
        let left = stockItem[index][leftKey] ?? ""
        let right = stockItem[index][rightKey] ?? ""
        let name = stockItem[index]["tke"] ?? ""
        let date = stockItem[index]["clo"] ?? ""
        return StockRowData(name: name, leftData: left, rightData: right, date: date, state: .stable)
    }
    
    func getStockDetail(index: Int, forkey: String) -> String {
        guard let stockItem = stocks?.details[index] else { return "" }
        return stockItem[forkey] ?? ""
    }
    
    func numberOfItems() -> Int {
        return stocks?.details.count ?? 0
    }
    
    func getPickerData() -> [Mypage]? {
        pageSettings?.mypage
    }
    
    func getPickerCount() -> Int? {
        return pageSettings?.mypage?.count
    }
    
    func getPickerTitles(for row: Int) -> String? {
        return pageSettings?.mypage?[row].name

    }
    
    func firstSelected(row: Int) -> String? {
        pageSettings?.mypage?[row].key
    }
    
    func secondSelected(row: Int) -> String? {
        pageSettings?.mypage?[row].key
    }
    
    func selectedPickerData(row: Int, in component: Int) -> (String, String) {
        var one = ""
        var two = ""
        switch component {
            case 0:
                one = pageSettings?.mypage?[row].key ?? ""
            case 1:
                two = pageSettings?.mypage?[row].key ?? ""
            default:
                break
        }
        return (one, two)
    }
}

enum StockState {
    case stable
    case increasing
    case decreasing
}
