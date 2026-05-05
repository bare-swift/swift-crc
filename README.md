# swift-crc

Sendable, Foundation-free CRC8/16/32/64 computation for Swift 6 — a generic engine plus a curated catalog of well-known algorithms (Ethernet, iSCSI, MODBUS, XMODEM, XZ, and more).

Part of the [bare-swift](https://github.com/bare-swift) ecosystem.

## Install

Add to your `Package.swift`:

```swift
.package(url: "https://github.com/bare-swift/swift-crc.git", from: "0.1.0")
```

Then depend on the `CRC` product:

```swift
.product(name: "CRC", package: "swift-crc")
```

## Usage

```swift
import CRC

let bytes: [UInt8] = Array("123456789".utf8)

// One-shot
let ethernetCRC: UInt32 = CRC.compute(bytes, algorithm: .iso_hdlc)
// 0xCBF43926 — the canonical "check" value for CRC-32/ISO-HDLC

let modbus: UInt16 = CRC.compute(bytes, algorithm: .modbus)
// 0x4B37

// Incremental (for streaming / large inputs)
var digest = CRC.Digest(algorithm: CRC.Algorithm<UInt32>.castagnoli)
digest.update(Array("hello, ".utf8))
digest.update(Array("world".utf8))
let result = digest.finalize()

// Custom algorithm
let myAlg = CRC.Algorithm<UInt32>(
    width: 32,
    polynomial: 0x04C11DB7,
    initial: 0xFFFFFFFF,
    refIn: true, refOut: true,
    xorOut: 0xFFFFFFFF,
    check: 0xCBF43926,
    name: "my-CRC-32"
)
```

## Documentation

Full DocC documentation: <https://bare-swift.github.io/swift-crc/>

## Source

Translated from the Rust crates [`crc`](https://crates.io/crates/crc), [`crc-catalog`](https://crates.io/crates/crc-catalog), and [`crc32fast`](https://crates.io/crates/crc32fast).

## License

Apache 2.0 with LLVM exception. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE).
