//
//  AwaitTask.swift
//  Await-Demo
//
//  Created by joongkwan.choi on 15/10/2019.
//  Copyright © 2019 tiny2n. All rights reserved.
//

import Foundation

final public class AwaitTask<Value> {
    private var value: Value
    
    public init(value: Value) {
        self.value = value
    }
    
    public func await() -> Value {
        return value
    }
}

@discardableResult
public func await<Value>(_ task: AwaitTask<Value>) throws -> Value {
    return task.await()
}
