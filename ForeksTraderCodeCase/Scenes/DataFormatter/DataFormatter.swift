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
        guard let stockItem = stocks?.detailsList else { return nil }
        let name = stockItem[index]["tke"] ?? ""
        let date = stockItem[index]["clo"] ?? ""
        return StockRowData(name: name,
                            leftData: leftKey,
                            rightData: rightKey,
                            date: date,
                            newStockItem: newStocks?.detailsList[index],
                            oldStockItem: stocks?.detailsList[index])
    }
    
    func getStockDetail(index: Int, forkey: String) -> String {
        guard let stockItem = stocks?.detailsList[index] else { return "" }
        return stockItem[forkey] ?? ""
    }
    
    func numberOfItems() -> Int {
        return stocks?.detailsList.count ?? 0
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
