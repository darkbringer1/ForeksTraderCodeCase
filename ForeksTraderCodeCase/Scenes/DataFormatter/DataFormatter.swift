//
//  DataFormatter.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation
protocol DataFormatterProtocol {
    func setSettingsResponse(with response: PageSettingsResponseModel)
    func getMyPagePairs() -> [Mypage]?
    func getMyPageDefaults() -> [MypageDefault]?
    func setStocksResponse(with response: StockResponseModel)
    func getCellData(by index: Int, leftKey: String, rightKey: String) -> StockRowData?
    func getStockDetail(index: Int, forkey: String) -> String
    func numberOfItems() -> Int
    func getPickerData() -> [Mypage]?
    func getPickerCount() -> Int?
    func getPickerTitles(for row: Int) -> String?
    func firstSelected(row: Int) -> String?
    func secondSelected(row: Int) -> String?
    func selectedPickerData(row: Int, in component: Int) -> (String, String)
    func calculateStockState(by index: Int) -> StockState
}
class DataFormatter: DataFormatterProtocol {
    private var pageSettings: PageSettingsResponseModel?
    private var stocks: StockResponseModel?
    private var newStocks: StockResponseModel?
    
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
        if stocks == nil {
            stocks = response
        } else if newStocks == nil {
            newStocks = response
        } else if let stockstime = stocks?.updateTime, let newStocksTime = newStocks?.updateTime, stockstime < newStocksTime {
            stocks = newStocks
        }
    }
    
    func getCellData(by index: Int, leftKey: String, rightKey: String) -> StockRowData? {
        guard let stockItem = newStocks?.details else { return nil }
        let left = stockItem[index][leftKey] ?? ""
        let right = stockItem[index][rightKey] ?? ""
        let name = stockItem[index]["tke"] ?? ""
        let date = stockItem[index]["clo"] ?? ""
        let state = calculateStockState(by: index)
        return StockRowData(name: name, leftData: left, rightData: right, date: date, state: state)
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
    
    func calculateStockState(by index: Int) -> StockState {
        guard let oldStockItem = stocks?.details,
              let newStockItem = newStocks?.details else { return .stable }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        let oldLeft = formatter.number(from: oldStockItem[index]["las"] ?? "") ?? 0
        let newLeft = formatter.number(from: newStockItem[index]["las"] ?? "") ?? 0
        
        if newLeft.doubleValue < oldLeft.doubleValue {
            return .decreasing
        } else if newLeft.doubleValue > oldLeft.doubleValue {
            return .increasing
        } else {
            return .stable
        }
    }
}

enum StockState {
    case stable
    case increasing
    case decreasing
}
