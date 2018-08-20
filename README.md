# SuperCodable

# Install

```
pod 'SuperCodable'
```
# Rx: Variable decode support

If you want to decode value to `Variable`, install:
```
pod 'SuperCodable/Rx'
```
## Usage

```swift
extension Int: DecodeFailable {
    public static var decodeFailedValue: Int { return 0 }
}

struct VariableModel: Codable {
    let code: Variable<Int>
    var stringValue: Variable<String?>
}
```

If you declare a Variable type property, we assume you don't want a optional Variable. Instead of optional property, you'd like to change it to optional Element. If Element is Optional, it will work as you wish. If Variable inner Element is not Optional, you should confrom Element type to `DecodeFailable`. Once Variable property decode failed, it will use `DecodeFailable.decodeFailedValue ` to init Variable.

# Inspired by

- [AnyCodable](https://github.com/Flight-School/AnyCodable)
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
- [CodableExtensions](https://github.com/jamesruston/CodableExtensions)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Type inference-powered serialization in Swift](https://www.swiftbysundell.com/posts/type-inference-powered-serialization-in-swift)