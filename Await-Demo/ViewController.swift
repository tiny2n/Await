//
//  ViewController.swift
//  Await-Demo
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

public struct ACSum0To1000000000Odd: AwaitCompletable {
    public var timeout: DispatchTimeInterval?
    
    public func execute(_ completion: @escaping (AwaitCompletableResult<Int>) -> Void) {
        var sum = 0
        for i in 0...1000000000 where i % 2 == 1 {
            sum += i
        }
        
        completion(.success(sum))
    }
}

public struct ACSum0To1000000000Even: AwaitCompletable {
    public var timeout: DispatchTimeInterval?
    
    public func execute(_ completion: @escaping (AwaitCompletableResult<Int>) -> Void) {
        var sum = 0
        for i in 0...1000000000 where i % 2 == 0 {
            sum += i
        }
        
        completion(.success(sum))
    }
}


public struct ACResultSum: AwaitCompletable {
    public var timeout: DispatchTimeInterval?
    
    private var odd: Int
    private var even: Int
    
    public init(_ odd: Int, _ even: Int) {
        self.odd = odd
        self.even = even
    }
    
    public func execute(_ completion: @escaping (AwaitCompletableResult<String>) -> Void) {
        let sum = odd + even
        completion(.success(sum.description))
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // async block is Asynchronous
        // await block is Synchronous
        async {
            do {
                let odd = try await(ACSum0To1000000000Odd())
                let even = try await(ACSum0To1000000000Even())
                let sum = try await(ACResultSum(odd, even))

                print(">>> odd: \(odd)")
                print(">>> even: \(even)")
                print(">>> sum: \(sum)")
            }
            catch AwaitError.timeout {
                print("throw timeout")
            }
            catch {
                print("thorw unknown")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func onTouchUpInside (_ sender: Any) {
        print("touch up inside")
    }
}

