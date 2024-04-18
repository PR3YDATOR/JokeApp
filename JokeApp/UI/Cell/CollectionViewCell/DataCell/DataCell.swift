//
//  DataCell.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

enum DataCellEvent {
    case favorites(model: ResultModel)
}

final class DataCell: UICollectionViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    
    //MARK: - Properties
    var model: ResultModel? {
        didSet {
            loadData()
        }
    }
    var bag = Bag()
    var subJect = AppSubject<DataCellEvent>()
    var publisher: AppAnyPublisher<DataCellEvent> {
        subJect.eraseToAnyPublisher()
    }
    
    //MARK: - Life-Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = Bag()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonStar(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard let model = model else { return }
        subJect.send(.favorites(model: model))
    }
    
    //MARK: - Functions
    private func loadData() {
        guard let model = model else { return }
        
        lblTitle.text = model.title
        lblSubTitle.text = model.body
    }
}
