//
//  ExploreVc.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

final class ExploreVc: ViewController<ExploreVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvExplore: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<ExploreVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ExploreVm()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        input.send(.viewWillAppear)
    }
    
    override func setUi() {
        super.setUi()
        
        clvExplore.delegate = self
        clvExplore.dataSource = self
        clvExplore.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case .loader(let isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case .showError(let msg):
                strongSelf.showAlert(msg: msg)
            case .dataGet:
                strongSelf.clvExplore.reload()
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return AppLayout.shared.profileSection()
        }
        clvExplore.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ExploreVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UserDefaults.saveData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DataCell = clvExplore.deque(indexPath: indexPath)
        cell.model = UserDefaults.saveData[indexPath.row]
        cell.btnStar.setTitle("Remove From Favorites!", for: .normal)
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
                strongSelf.clvExplore.reload()
            }
        }.store(in: &cell.bag)
        return cell
    }
}
