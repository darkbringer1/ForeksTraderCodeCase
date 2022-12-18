//
//  StockViewModel.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import Foundation
import DefaultNetworkOperationPackage

typealias SettingsResponseBlock = (Result<PageSettingsResponseModel, ErrorResponse>) -> Void
typealias StocksResponseBlock = (Result<StockResponseModel, ErrorResponse>) -> Void

class StockViewModel {
    
    let dataFormatter: DataFormatter
    
    init(dataFormatter: DataFormatter) {
        self.dataFormatter = dataFormatter
    }
    
    func getSettings() {
        do {
            guard let urlRequest = try? SettingsServiceProvider().returnUrlRequest(headerType: .contentTypeUTF8) else { return }
            debugPrint(urlRequest)
            fireSettingsApiCall(with: urlRequest, completion: settingsDataListener)
        }
    }
    
    private func fireSettingsApiCall(with urlRequest: URLRequest, completion: @escaping SettingsResponseBlock) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: completion)
    }
    
    lazy var settingsDataListener: SettingsResponseBlock = { [weak self] response in
        switch response {
            case .success(let data):
//                debugPrint(data)
                self?.dataFormatter.setSettingsResponse(with: data)
                self?.getStocks()
            case .failure(let error):
//                debugPrint(error)
                break
        }
    }
    
    func getStocks() {
        do {
            guard let requestModel = getRequestModel(), let urlRequest = try? StockServiceProvider(request: requestModel).returnUrlRequest(headerType: .contentTypeUTF8) else { return }
            debugPrint(urlRequest)
            fireStockApiCall(with: urlRequest, completion: stocksDataListener)
        }
    }
    
    private func fireStockApiCall(with urlRequest: URLRequest, completion: @escaping StocksResponseBlock) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: completion)
    }
    
    private lazy var stocksDataListener: StocksResponseBlock = { [weak self] response in
        switch response {
            case.success(let data):
                self?.dataFormatter.setStocksResponse(with: data)
            case .failure(let error):
//                debugPrint(error)
                break
        }
    }
    
    private func getRequestModel() -> StockRequestModel? {
        guard let mypage = dataFormatter.getMyPagePairs(), let myPageDefaults = dataFormatter.getMyPageDefaults() else { return nil }
        let fieldKeys = mypage.map({ $0.key ?? "" }).joined(separator: ",")
        let stcsKeys = myPageDefaults.map({ $0.tke ?? "" }).joined(separator: "~")
        return StockRequestModel(stcs: stcsKeys, fields: fieldKeys)
    }
}