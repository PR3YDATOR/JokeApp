//
//  OptionalInjected.swift
//
//
//  Created by user238804 on 08/04/24.
//

import Foundation

@propertyWrapper
public class OptionalInjected<Service> {
    public var wrappedValue: Service?

    public init(resolver: Resolver = .default, tag: String? = nil) {
        wrappedValue = resolver.resolve(type: Service.self, tag: tag)
    }
}
