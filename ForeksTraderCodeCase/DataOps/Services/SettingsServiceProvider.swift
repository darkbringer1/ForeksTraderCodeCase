//
//  SettingsServiceProvider.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import Foundation
import DefaultNetworkOperationPackage

class SettingsServiceProvider: ApiServiceProvider<EmptyRequestModel> {
    init(request: EmptyRequestModel = EmptyRequestModel()) {
        super.init(method: .get,
                   baseUrl: BaseUrl.main.value,
                   path: Path.settings.value,
                   data: request)
    }
}
