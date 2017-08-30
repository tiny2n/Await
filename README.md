

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/DeepLinkSDK.svg?style=flat)](https://developer.apple.com/ios)

<h1 align="center">AwaitKit</h1>

Overview
-------------
Asynchronous Programming with async and await base protocol oriented programming in Swift ver. 3.x<br/>
_AwaitKit_ is a powerful Swift library

C# async and await
https://msdn.microsoft.com/en-us//library/hh191443(v=vs.110).aspx

### Introducation

__Requires Swift 3 or later<br/>

### Installation

Add the files to your project manually by dragging the AwaitKit directory into your Xcode project.


### Usage

write this:
```swift
// async and await
async {
  let result: <#AwaitCompletableType#> = try await(AwaitExecute())
  ...
}

```

AwaitCompletable protocol this:
```swift
// AwaitCompletable
public protocol AwaitCompletable {
  associatedtype AwaitCompletableType

  var queue: DispatchQueue { get }
  var timeout: DispatchTimeInterval? { get }

  func should() -> Bool      
  func execute(_ completion: @escaping (AwaitCompletableType) throws -> Void) throws
}

```

Custom this:
```swift
// Custom Await Completable
public struct AwaitExecute: AwaitCompletable {
  public func execute(_ completion: @escaping (<#AwaitCompletableType#>) throws -> Void) {
    // execute work
    // need not async block
    <#code#>

    try? completion(<#await completable type#>)
  }
}

```

example this:
```swift
async {
  do {
    let odd: Int = try await(ACSum0To1000000000Odd())
    print(">>> odd: \(odd)")

    let even: Int = try await(ACSum0To1000000000Even())
    print(">>> even: \(even)")

    let sum: String = try await(ACResultSum(odd, even))
    print(">>> sum: \(sum)")
  }
  catch AwaitKitError.nil {
    print("throw nil")
  }
  catch AwaitKitError.timeout {
    print("throw timeout")
  }
  catch AwaitKitError.cancel {
    print("thorw await completable instace execute cancel")
  }
  catch {
    print("thorw unknown")
  }
}

```

<br/><br/>
### The MIT License (MIT)

Copyright (c) 2017 Choi Joongkwan. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
