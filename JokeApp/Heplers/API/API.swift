//
//  API.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

/// https://rapidapi.com/karanp41-eRiF1pYLK1P/api/world-of-jokes1

// MARK: - API
enum API {
    case jokes(page: Int)
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "https://world-of-jokes1.p.rapidapi.com/v1/"
    }
    
    var path: String {
        switch self {
        case .jokes:
            return "jokes"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .jokes:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case let .jokes(page):
            return .queryString(["limit": 100, "page": page])
        }
    }
    
    var header: [String: String] {
        switch self {
        case .jokes:
            return [
                "X-RapidAPI-Host" : "world-of-jokes1.p.rapidapi.com",
                "X-RapidAPI-Key" : "c5ecdcb441msh4bcc97d07e54768p185051jsn89591b4b06b1"
            ]
        }
    }
}
