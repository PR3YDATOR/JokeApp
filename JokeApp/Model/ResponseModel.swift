//
//  ResponseModel.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let results: [ResultModel]?
    let page, limit, totalPages, totalResults: Int?
}

// MARK: - Result
struct ResultModel: Codable {
    let isActive: Bool?
    let body, id: String?
    let score: Int?
    let title: String?
    let category: String?
}
