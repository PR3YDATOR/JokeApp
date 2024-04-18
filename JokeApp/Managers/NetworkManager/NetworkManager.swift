//
//  NetworkManager.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

final class NetworkManager: NetworkService {
    func getData(page: Int) async throws -> ResponseModel {
        return try await APIService.request(API.jokes(page: page))
    }
}
