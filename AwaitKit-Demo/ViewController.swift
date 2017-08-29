//
//  ViewController.swift
//  AwaitKit-Demo
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//

import UIKit

//
public struct ACSum0To1000000000Odd: AwaitCompletable {
    public func execute(_ completion: @escaping (Int) throws -> Void) throws {
        var sum = 0
        for i in 0...1000000000 where i % 2 == 1 {
            sum += i
        }
        
        try? completion(sum)
    }
}

public struct ACSum0To1000000000Even: AwaitCompletable {
    public func execute(_ completion: @escaping (Int) throws -> Void) {
        var sum = 0
        for i in 0...1000000000 where i % 2 == 0 {
            sum += i
        }
        
        try? completion(sum)
    }
}


public struct ACResultSum: AwaitCompletable {
    private var odd: Int
    private var even: Int
    
    public init(_ odd: Int, _ even: Int) {
        self.odd = odd
        self.even = even
    }
    
    public func execute(_ completion: @escaping (String) throws -> Void) {
        let sum = odd + even
        try? completion(sum.description)
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        async {
            do {
                let odd:  Int = try await(ACSum0To1000000000Odd())
                print(">>> odd: \(odd)")
                
                let even: Int = try await(ACSum0To1000000000Even())
                print(">>> even: \(even)")
                
                let sum: String = try await(ACResultSum(odd, even))
                print(">>> sum: \(sum)")
            }
            catch AwaitKitError.nilOrTimeout {
                print("throw nil or timeout")
            }
            catch AwaitKitError.cancel {
                print("thorw await completable instace execute cancel")
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

