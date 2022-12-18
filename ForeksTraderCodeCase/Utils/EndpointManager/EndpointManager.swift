//
//  EndpointManager.swift
//  ForeksTraderCodeCase
//
//  Created by Doğukaan Kılıçarslan on 17.12.2022.
//

import Foundation
import BaseComponents

typealias BaseUrl = EndpointManager.BaseURL
typealias Path = EndpointManager.Paths

enum EndpointManager {
    
    enum BaseURL: GenericValueProtocol {
        
        typealias Value = String
        
        case main
        var value: String {
            switch self {
                case .main:
                    return "https://sui7963dq6.execute-api.eu-central-1.amazonaws.com/default/"
            }
        }
    }
    
    enum Paths: GenericValueProtocol {
        typealias Value = String
        
        case settings
        case stocks
        
        var value: String {
            switch self {
                case .settings:
                    return "ForeksMobileInterviewSettings"
                case .stocks:
                    return "ForeksMobileInterview"
            }
        }
    }
}
