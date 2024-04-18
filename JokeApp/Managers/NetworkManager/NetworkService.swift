//
//  NetworkService.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

protocol NetworkService {
    func getData(page: Int) async throws -> ResponseModel
}
