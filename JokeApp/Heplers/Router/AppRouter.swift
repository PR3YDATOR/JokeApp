//
//  AppRouter.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

// MARK: - AppRouter
class AppRouter: Router {
    var navigationController: UINavigationController
    let intialRoute: Route

    init(navigationController: UINavigationController, intialRoute: Route) {
        self.navigationController = navigationController
        self.intialRoute = intialRoute
    }

    func start() {
        navigationController.setViewControllers([intialRoute.viewController], animated: true)
    }

    func setRoot(to route: Route, duration: TimeInterval?, options: UIView.AnimationOptions?) {
        let viewController = route.viewController
        if let duration = duration, let options = options {
            UIView.transition(with: navigationController.view, duration: duration, options: options, animations: {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.navigationController.setViewControllers([viewController], animated: false)
                UIView.setAnimationsEnabled(oldState)
            })
        } else {
            navigationController.setViewControllers([viewController], animated: false)
        }
    }

    func push(to route: Route, with transitionType: CATransitionType?, for interval: TimeInterval?) {
        let viewController = route.viewController
        if let transitionType = transitionType, let interval = interval {
            createTransition(with: transitionType, for: interval)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func pop(with transitionType: CATransitionType?, for interval: TimeInterval?) {
        if let transitionType = transitionType, let interval = interval {
            createTransition(with: transitionType, for: interval)
        }
        navigationController.popViewController(animated: true)
    }

    func pop(to route: Route, with transitionType: CATransitionType?, for interval: TimeInterval?) {
        if let targetViewController = navigationController.viewControllers.first(where: { $0.isKind(of: route.viewController.classForCoder) }) {
            if let transitionType = transitionType, let interval = interval {
                createTransition(with: transitionType, for: interval)
            }
            navigationController.popToViewController(targetViewController, animated: true)
        }
    }

    func show(sheet route: Route, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?) {
        let viewController = route.viewController
        if let presentationStyle = presentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }
        if let transitionStyle = transitionStyle {
            viewController.modalTransitionStyle = transitionStyle
        }
        navigationController.present(viewController, animated: true, completion: nil)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

extension AppRouter {
    private func createTransition(with transitionType: CATransitionType, for interval: TimeInterval) {
        let transition = CATransition()
        transition.duration = interval
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = transitionType
        navigationController.view.layer.add(transition, forKey: nil)
    }
}
