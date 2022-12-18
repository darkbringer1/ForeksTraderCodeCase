//
//  StockServiceProvider.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 18.12.2022.
//

import Foundation
import DefaultNetworkOperationPackage

class StockServiceProvider: ApiServiceProvider<StockRequestModel> {
    init(request: StockRequestModel) {
        super.init(method: .get,
                   baseUrl: BaseUrl.main.value,
                   path: Path.stocks.value,
                   data: request)
    }
}
