//
//  Route.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

// MARK: - Route
enum Route {
    case main
    case tab
    case home
    case favorites
}

extension Route {
    var viewController: UIViewController {
        switch self {
        case .main:
            guard let vc = R.storyboard.main.mainVc() else { return UIViewController() }
            return vc
        case .tab:
            guard let vc = R.storyboard.main.tabBarVc() else { return UIViewController() }
            return vc
        case .home:
            guard let vc = R.storyboard.main.homeVc() else { return UIViewController() }
            return vc
        case .favorites:
            guard let vc = R.storyboard.main.exploreVc() else { return UIViewController() }
            return vc
        }
    }
}
