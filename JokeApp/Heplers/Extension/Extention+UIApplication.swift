//
//  Extention+UIApplication.swift
//
//
//  Created by user238804 on 08/04/24.
//

import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
    }
}
