//
//  AwaitKitError.swift
//  AwaitKit-Demo
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

enum AwaitKitError: Error {
    case nilOrTimeout
    case cancel
    case unknown
}
