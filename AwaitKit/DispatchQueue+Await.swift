//
//  DispatchQueue+Await.swift
//  AwaitKit
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

extension DispatchQueue {
    static let async = DispatchQueue(label: "com.tiny2n.queue.async", attributes: .concurrent)
    static let await = DispatchQueue(label: "com.tiny2n.queue.await", attributes: .concurrent)
}

extension DispatchQueue {
    final public func await<T: AwaitCompletable, U>(_ completable: T) throws -> U {
        guard completable.should() else {
            throw AwaitKitError.cancel
        }
        
        var result: U?
        var executed = false
        let semaphore = DispatchSemaphore(value: 0)
        
        completable.queue.async {
            try? completable.execute { (completable) in
                executed = true
                result = completable as? U
                semaphore.signal()
            }
        }
        
        var timeout = DispatchTime.distantFuture
        if let interval = completable.timeout {
            timeout = DispatchTime.now() + interval
        }

        _ = semaphore.wait(timeout: timeout)
        
        if let unwrapped = result {
            return unwrapped
        }
        
        if executed {
            throw AwaitKitError.nil
        }
        
        throw AwaitKitError.timeout
    }
}

public func async(_ block: @escaping () throws -> Void) {
    DispatchQueue.async.async {
        try? block()
    }
}

public func await<T: AwaitCompletable>(_ completable: T) throws -> T.AwaitCompletableType {
    return try DispatchQueue.await.await(completable)
}
