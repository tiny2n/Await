

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

  func execute(_ completion: @escaping (AwaitCompletableResult<AwaitCompletableType>) -> Void)
}

```

Custom this:
```swift
// Custom Await Completable
public struct AsyncObjectTask: AwaitCompletable {
  func execute(_ completion: @escaping (AwaitCompletableResult<AwaitCompletableType>) -> Void) {
    // execute task
    
    <#async code#>

    completion(.success(<#await completable type#>))
    // or completion(.failure(<#error#>))
  }
}

```

example this:
```swift

// async block is Asynchronous
// await block is Synchronous

// serial call
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

```swift
// using subclassing by class AwaitConcurrentSupport<T>
// concurrent call
async {
  do {
    let result = try await(ACSum0To1000000000Even(), ACSum0To1000000000Odd())
    print(">>> count: \(result.count)")
    print(">>> even: \(result[1])")
    print(">>> odd: \(result[0])")
  }
   catch {
    // Type: AwaitConcurrentError.concurrent<T>
    print("[Error] \(error)")
  }
}
        
```

<br/><br/>
### License

**Await** is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
