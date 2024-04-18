//
//  Extention+UICollectionView.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation
import UIKit

extension UICollectionView {
    func deque<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
        else {
            fatalError("=====>Error in cell")
        }
        return cell
    }

    func deque<Cell: UICollectionViewCell>(indexPath: IndexPath, kind: String) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: identifier,
                                                          for: indexPath) as? Cell
        else {
            fatalError("=====>Error in cell")
        }
        return cell
    }

    func reload() {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve) {
            queue.async {
                self.reloadData()
            }
        }
    }
    
    func reloadSection(section: Int) {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve) {
            queue.async {
                self.reloadSections(IndexSet(integer: section))
            }
        }
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
