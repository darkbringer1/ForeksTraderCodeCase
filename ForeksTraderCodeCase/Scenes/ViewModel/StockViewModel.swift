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
    
    private let dataFormatter: DataFormatterProtocol
    private var viewState: ((ViewState) -> Void)?
    private var requestModel: StockRequestModel?
    private var firstQ: String?
    private var secondQ: String?
    private var timer: Timer?
    
    init(dataFormatter: DataFormatterProtocol) {
        self.dataFormatter = dataFormatter
    }
    
    func subscribeToViewState(with completion: @escaping (ViewState) -> Void) {
        viewState = completion
    }
    
    func getSettings() {
        viewState?(.loading)
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
                self?.viewState?(.headerDone)
            case .failure(let error):
//                debugPrint(error)
                break
        }
    }
    
    func getStocks() {
        viewState?(.loading)
        do {
            guard let requestModel = requestModel, let urlRequest = try? StockServiceProvider(request: requestModel).returnUrlRequest(headerType: .contentTypeUTF8) else { return }
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
                self?.viewState?(.done)
            case .failure(let error):
//                debugPrint(error)
                break
        }
    }
    
    private func getRequestModel(row: Int) -> StockRequestModel? {
        guard let myPageDefaults = dataFormatter.getMyPageDefaults(), let firstQ = firstQ, let secondQ = secondQ else { return nil }
        let stcsKeys = myPageDefaults.map({ $0.tke ?? "" }).joined(separator: "~")
        return StockRequestModel(stcs: stcsKeys, fields: firstQ + "," + secondQ)
    }
}

extension StockViewModel: StocksTableViewDataProvider {
    func numberOfItems() -> Int {
        debugPrint(dataFormatter.numberOfItems())
        return dataFormatter.numberOfItems()
    }
    
    func cellForItem(at indexPath: IndexPath) -> StockRowData? {
        return dataFormatter.getCellData(by: indexPath.row,
                                         leftKey: firstQ ?? "",
                                         rightKey: secondQ ?? "")
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        debugPrint("Selected row \(indexPath.row)")
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.getStocks()
        }
    }
}

extension StockViewModel: StocksHeaderDataProvider {
    func numberOfComponents() -> Int? {
        2
    }
    
    func numberOfRows(in component: Int) -> Int {
        dataFormatter.getPickerCount() ?? 0
    }
    
    func titleForRow(row: Int, in component: Int) -> String? {
        dataFormatter.getPickerTitles(for: row)
    }
    
    func didSelect(row: Int, in component: Int) {
        switch component {
            case 0:
                firstQ = dataFormatter.firstSelected(row: row)
            case 1:
                secondQ = dataFormatter.secondSelected(row: row)
            default:
                break
        }
        requestModel = getRequestModel(row: row)
        getStocks()
    }
}

enum ViewState {
    case loading
    case done
    case error
    case headerDone
}
