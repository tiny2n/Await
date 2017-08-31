//
//  AwaitKitError.swift
//  AwaitKit
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

public protocol AwaitError: Error {
}

public enum AwaitKitError: AwaitError {
    case `nil`
    case timeout
}
