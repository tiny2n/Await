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
    final public func await<T: AwaitCompletable>(_ completable: T) throws -> T.AwaitCompletableType {
        var result: T.AwaitCompletableType?
        var executed = false
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        
        completable.queue.async {
            do {
                try completable.execute { (completable) in
                    executed = true
                    result = completable
                    semaphore.signal()
                }
            }
            catch let e {
                error = e
                semaphore.signal()
            }
        }
        
        // waiting for semaphore signal
        let timeout = waitingforTimeout(completable.timeout)
        _ = semaphore.wait(timeout: timeout)
        
        // return result or throws error
        if let unwrapped = result {
            return unwrapped
        }
        else if let error = error {
            throw error
        }
        else if executed {
            throw AwaitKitError.nil
        }
        
        throw AwaitKitError.timeout
    }
    
    private func waitingforTimeout(_ timeout: DispatchTimeInterval?) -> DispatchTime {
        var result = DispatchTime.distantFuture
        if let interval = timeout {
            result = DispatchTime.now() + interval
        }
        
        return result
    }
}

public func await<T: AwaitCompletable>(_ completable: T) throws -> T.AwaitCompletableType {
    return try DispatchQueue.await.await(completable)
}

public func async(_ block: @escaping () -> Void) {
    DispatchQueue.async.async { block() }
}
