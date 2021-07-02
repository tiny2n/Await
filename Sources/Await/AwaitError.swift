//
//  AwaitError.swift
//  Await
//
//  Created by joongkwan.choi on 2017. 8. 28..
//  Copyright © 2017 tiny2n. All rights reserved.
//

import Foundation

public enum AwaitError: Error {
    case failure(Error)
    case timeout
}
