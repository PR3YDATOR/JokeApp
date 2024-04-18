//
//  Extention+DispatchQueue.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

public extension DispatchQueue {
    func after(time interval: TimeInterval, work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + interval) {
            work()
        }
    }
}
