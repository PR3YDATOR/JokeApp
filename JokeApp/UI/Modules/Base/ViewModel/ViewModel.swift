//
//  ViewModel.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

@MainActor
class ViewModel {
    // MARK: - Dependencies
    @Injected var router: Router
    @Injected var networkServices: NetworkService
}
