//
//  StockViewBuilder.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import UIKit

final class StockViewBuilder {
    class func build() -> UIViewController {
        let dataFormatter = DataFormatter()
        let viewModel = StockViewModel(dataFormatter: dataFormatter)
        let vc = StockViewController(viewModel: viewModel)
        return vc
    }
}
