//
//  HomeVc.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

final class HomeVc: ViewController<HomeVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvHome: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<HomeVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeVm()
        bindViewModel()
        lblTitle.text = UserDefaults.userName
        input.send(.getData)
    }
    
    override func setUi() {
        super.setUi()
        
        clvHome.delegate = self
        clvHome.dataSource = self
        clvHome.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            case .dataGet:
                strongSelf.clvHome.reload()
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return AppLayout.shared.profileSection()
        }
        clvHome.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.arrData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DataCell = clvHome.deque(indexPath: indexPath)
        guard let model = viewModel?.arrData[indexPath.row] else { return .init() }
        cell.model = model
        cell.btnStar.setTitle(UserDefaults.saveData.contains(where: { $0.id == model.id }) ? "Remove From Favorites!" : "Add To favorites!", for: .normal)
        cell.publisher.weekSink(self) { strongSelf, event in
            switch event {
            case .favorites(let model):
                if !UserDefaults.saveData.contains(where: { $0.id == model.id }) {
                    UserDefaults.saveData.append(model)
                } else {
                    if let index = UserDefaults.saveData.firstIndex(where: { $0.id == model.id }) {
                        UserDefaults.saveData.remove(at: index)
                    }
                }
                strongSelf.clvHome.reload()
            }
        }.store(in: &cell.bag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel?.currentPage ?? 0 < viewModel?.totalPage ?? 0 && indexPath.row == (viewModel?.arrData.count ?? 0) - 2 {
            viewModel?.currentPage += 1
            input.send(.getData)
        }
    }
}
