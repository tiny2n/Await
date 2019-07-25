//
//  DispatchQueue+AwaitConcurrentSupport.swift
//  Await-Demo
//
//  Created by joongkwan.choi on 25/07/2019.
//  Copyright © 2019 tiny2n. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    final public func await<T>(_ completables: [AwaitConcurrentSupport<T>]) throws -> [AwaitConcurrentSupport<T>: Result<T, Error>] {
        var result: [AwaitConcurrentSupport<T>: Result<T, Error>] = [:]
        let dispatch_group = DispatchGroup()
        
        completables.forEach({ element in
            result[element] = .failure(AwaitError.timeout)
            
            dispatch_group.enter()
            
            element.queue.async {
                element.execute({ (execute) in
                    switch execute {
                    case .success(let response):
                        result[element] = .success(response)
                    case .failure(let error):
                        result[element] = .failure(error)
                    }
                    
                    dispatch_group.leave()
                })
            }
        })
        
        // waiting for dispatch group all leave
        let timeout_max = completables.max { waitingforTimeout($0.timeout) < waitingforTimeout($1.timeout) }
        let timeout = waitingforTimeout(timeout_max?.timeout)
        _ = dispatch_group.wait(timeout: timeout)
        
        // return result or throws error
        return result
    }
    
    private func waitingforTimeout(_ timeout: DispatchTimeInterval?) -> DispatchTime {
        var result: DispatchTime = .distantFuture
        if let timeout = timeout {
            result = .now() + timeout
        }
        
        return result
    }
    
}

public func await<T>(_ completables: AwaitConcurrentSupport<T> ...) throws -> [AwaitCompletableResult<T>] {
    var result: [AwaitCompletableResult<T>] = []
    
    let awaits = try await.await(completables)
    for completable in completables {
        switch awaits[completable] {
        case .success(let value)?:
            result.append(.success(value))
        case .failure(let error)? where completable.supported == .optional:
            // pass by object supported condition is optional type
            result.append(.failure(error))
        case .none, .failure(_)?:
            throw AwaitConcurrentError<T>.concurrent(awaits)
        }
        
    }
    
    return result
}
