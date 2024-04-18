//
//  HomeVm.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation


final class HomeVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var output = AppSubject<Output>()
    var arrData: [ResultModel] = []
    var currentPage: Int = 1
    var totalPage: Int = 0
    
    //MARK: - Enums
    enum Input {
        case getData
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
            case .getData:
                strongSelf.getData()
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
    
    private func getData() {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkServices.getData(page: currentPage)
                arrData.append(contentsOf: model.results ?? [])
                totalPage = model.totalPages ?? 0
                output.send(.loader(isLoading: false))
                output.send(.dataGet)
            } catch let error as APIError {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.description))
            } catch {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.localizedDescription))
            }
        }.store(in: &taskBag)
    }
}

