//
//  ExploreVm.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation


final class ExploreVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var networkService: NetworkService
    private var output = AppSubject<Output>()
    
    //MARK: - Life-Cycle
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    //MARK: - Enums
    enum Input {
        case viewWillAppear
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
        case dataGet
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .viewWillAppear: 
                strongSelf.output.send(.dataGet)
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
}

