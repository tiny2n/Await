//
//  AwaitCompletable.swift
//  Await
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

public enum AwaitCompletableResult<T> {
    case success(T)
    case failure(Error)
}

public protocol AwaitCompletable {
    associatedtype AwaitCompletableType
    
    var queue: DispatchQueue { get }
    var timeout: DispatchTimeInterval? { get set }
    
    func execute(_ completion: @escaping (AwaitCompletableResult<AwaitCompletableType>) -> Void)
}

extension AwaitCompletable {
    public var queue: DispatchQueue {
        return DispatchQueue(label: "com.navercafe.queue.completable", attributes: .concurrent)
    }
}
