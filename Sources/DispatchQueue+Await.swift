//
//  DispatchQueue+Await.swift
//  Await
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

private let async = DispatchQueue(label: "com.navercafe.queue.async", attributes: .concurrent)
private let await = DispatchQueue(label: "com.navercafe.queue.await", attributes: .concurrent)

extension DispatchQueue {
    final public func await<T: AwaitCompletable>(_ completable: T) throws -> T.AwaitCompletableType {
        var result: T.AwaitCompletableType?
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        
        completable.queue.async {
            completable.execute({ (execute) in
                if case .success(let response) = execute {
                    result = response
                } else if case .failure(let err) = execute {
                    error = err
                } else {
                    fatalError("fatal Error")
                }
                
                semaphore.signal()
            })
        }
        
        // waiting for semaphore signal
        let timeout = waitingforTimeout(completable.timeout)
        _ = semaphore.wait(timeout: timeout)
        
        // return result or throws error
        if let unwrapped = result {
            return unwrapped
        } else if let error = error {
            throw AwaitError.failure(error)
        } else {
            throw AwaitError.timeout
        }
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
    return try await.await(completable)
}

public func async(_ block: @escaping () -> Void) {
    async.async { block() }
}
