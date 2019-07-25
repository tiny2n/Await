//
//  AwaitConcurrentSupport.swift
//  Await-Demo
//
//  Created by joongkwan.choi on 25/07/2019.
//  Copyright © 2019 tiny2n. All rights reserved.
//

import Foundation

public enum AwaitConcurrentError<T>: Error {
    case concurrent([AwaitConcurrentSupport<T>: Result<T, Error>])
}

public class AwaitConcurrentSupport<T>: AwaitCompletable {
    public enum Supported {
        case required
        case optional
    }
    
    public typealias AwaitCompletableType = T
    public var timeout: DispatchTimeInterval?
    
    public init(timeout: DispatchTimeInterval? = .never) {
        self.timeout = timeout
    }
    
    public var supported: Supported {
        return .required
    }

    public func execute(_ completion: @escaping (AwaitCompletableResult<T>) -> Void) {
        fatalError("You must override execute(:) in a subclass")
    }

}

// MARK: - Hashable

extension AwaitConcurrentSupport: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }
    
    public static func == (lhs: AwaitConcurrentSupport<T>, rhs: AwaitConcurrentSupport<T>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
