//
//  DispatchQueue+Await.swift
//  Await
//
//  Created by joongkwan.choi on 2017. 8. 28..
//  Copyright © 2017 tiny2n. All rights reserved.
//

import Foundation

public let async = DispatchQueue(label: "com.tiny2n.await.queue.async", attributes: .concurrent)
public let await = DispatchQueue(label: "com.tiny2n.await.queue.await", attributes: .concurrent)

extension DispatchQueue {
    
    final public func await<T: AwaitCompletable>(_ completable: T) throws -> T.AwaitCompletableType {
        var result: Result<T.AwaitCompletableType, Error> = .failure(AwaitError.timeout)
        let semaphore = DispatchSemaphore(value: 0)
        
        completable.queue.async {
            completable.execute({ (execute) in
                switch execute {
                case let .success(response):
                    result = .success(response)
                case let .failure(error):
                    result = .failure(error)
                }
                
                semaphore.signal()
            })
        }
        
        // waiting for semaphore signal
        let timeout = waitingforTimeout(completable.timeout)
        _ = semaphore.wait(timeout: timeout)
        
        // return result or throws error
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    private func waitingforTimeout(_ timeout: DispatchTimeInterval?) -> DispatchTime {
        var result: DispatchTime = .distantFuture
        if let timeout = timeout {
            result = .now() + timeout
        }
        
        return result
    }
}

public func await<T: AwaitCompletable>(_ completable: T) throws -> T.AwaitCompletableType {
    return try await.await(completable)
}

public func await<T: AwaitCompletable>(_ completable: AwaitTask<T>) throws -> T.AwaitCompletableType {
    return try await.await(completable.await())
}

public func async(_ block: @escaping () -> Void) {
    async.async { block() }
}
