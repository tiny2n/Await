//
//  AwaitCompletable.swift
//  AwaitKit-Demo
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

public protocol AwaitCompletable {
    associatedtype AwaitCompletableType
    
    var timeout: DispatchTimeInterval? { get }
    var queue: DispatchQueue { get }
    
    func execute(_ completion: @escaping (AwaitCompletableType) throws -> Void) throws
    func should() -> Bool
}

extension AwaitCompletable {
    public func should() -> Bool {
        return true
    }
    
    public var timeout: DispatchTimeInterval? {
        return nil
    }
    
    public var queue: DispatchQueue {
        return DispatchQueue(label: "com.tiny2n.queue.completable", attributes: .concurrent)
    }
}
