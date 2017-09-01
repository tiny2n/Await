

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/DeepLinkSDK.svg?style=flat)](https://developer.apple.com/ios)

<h1 align="center">Await</h1>

Overview
-------------
Asynchronous Programming with async and await base protocol oriented programming<br/>
_Await_ is a powerful Swift library

C# async and await
https://msdn.microsoft.com/en-us//library/hh191443(v=vs.110).aspx

### Introducation

__Requires Swift 3 or later<br/>

### Installation

Add the files to your project manually by dragging the Await directory into your Xcode project.

or

[CocoaPods](https://cocoapods.org):

```ruby
pod 'Await', :git => 'https://github.com/tiny2n/Await.git'
```

### Usage

write this:
```swift
// async and await
async {
  let result = try await(AwaitExecute())    // AwaitCompletable Type
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

  func execute(_ completion: @escaping (AwaitCompletableType) throws -> Void) throws
}

```

Custom this:
```swift
// Custom Await Completable
public struct AwaitExecute: AwaitCompletable {
  public func execute(_ completion: @escaping (<#AwaitCompletableType#>) throws -> Void) {
    // No asynchronous blocks are needed.
    // execute work
    
    <#code#>

    try? completion(<#await completable type#>)
    // or
    // throw AwaitError or Custom Error
  }
}

```

example this:
```swift

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
  catch AwaitError.nil {
    print("throw nil")
  }
  catch AwaitError.timeout {
    print("throw timeout")
  }
  catch {
    print("thorw unknown")
  }
}

```

<br/><br/>
### License

**Await** is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
