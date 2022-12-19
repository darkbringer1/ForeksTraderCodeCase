//
//  PageSettingsResponseModel.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import Foundation

struct PageSettingsResponseModel: Codable {
    var mypageDefaults: [MypageDefault]?
    var mypage: [Mypage]?
}

// MARK: - Mypage
struct Mypage: Codable {
    var name, key: String?
}

// MARK: - MypageDefault
struct MypageDefault: Codable {
    var cod, gro, tke, def: String?
}
