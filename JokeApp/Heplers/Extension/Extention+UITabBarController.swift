//
//  Extention+UITabBarController.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

public extension UITabBarController {
    func addTransition(to viewController: UIViewController,
                       time interval: TimeInterval = 0.35,
                       animation options: UIView.AnimationOptions = [.transitionCrossDissolve]) {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return
        }
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: interval, options: options, completion: nil)
        }
    }
}
