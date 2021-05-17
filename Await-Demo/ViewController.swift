//
//  ViewController.swift
//  Await-Demo
//
//  Created by Choi Joongkwan on 2017. 8. 28..
//  Copyright © 2017년 tiny2n. All rights reserved.
//
import UIKit

//public class ACSum0To1000000000Odd: AwaitConcurrentSupport<Int> {
//
//    public override func execute(_ completion: @escaping (AwaitCompletableResult<Int>) -> Void) {
//        var sum = 0
//        for i in 0...1000000000 where i % 2 == 1 {
//            sum += i
//        }
//
//        completion(.success(sum))
//    }
//}
//
//public class ACSum0To1000000000Even: AwaitConcurrentSupport<Int> {
//
//    public override func execute(_ completion: @escaping (AwaitCompletableResult<Int>) -> Void) {
//        var sum = 0
//        for i in 0...10000 where i % 2 == 0 {
//            sum += i
//        }
//
//        completion(.failure(AwaitError.timeout))//.success(sum))
//    }
//
//    public override var supported: Supported {
//        return .optional
//    }
//}
//
//
//public struct ACResultSum: AwaitCompletable {
//    public var timeout: DispatchTimeInterval?
//
//    private var odd: Int
//    private var even: Int
//
//    public init(_ odd: Int, _ even: Int) {
//        self.odd = odd
//        self.even = even
//    }
//
//    public func execute(_ completion: @escaping (AwaitCompletableResult<String>) -> Void) {
//        let sum = odd + even
//        completion(.success(sum.description))
//    }
//}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // async block is Asynchronous
        // await block is Synchronous
        
        // serial call
//        async {
//            do {
//                let odd = try await(ACSum0To1000000000Odd())
//                let even = try await(ACSum0To1000000000Even())
//                let sum = try await(ACResultSum(odd, even))
//                print(">>> odd: \(odd)")
//                print(">>> even: \(even)")
//                print(">>> sum: \(sum)")
//            }
//            catch {
//                // Type: AwaitError
//                print("[Error] \(error)")
//            }
//        }
//        
//        // concurrent call
//        async {
//            do {
//                let result = try await(ACSum0To1000000000Even(), ACSum0To1000000000Odd())
//                print(">>> count: \(result.count)")
//                print(">>> even: \(result[1])")
//                print(">>> odd: \(result[0])")
//            }
//            catch {
//                // Type: AwaitConcurrentError.concurrent<T>
//                print("[Error] \(error)")
//            }
//        }
    }
    
    @IBAction private func onTouchUpInside (_ sender: Any) {
        print("touch up inside")
    }
}
