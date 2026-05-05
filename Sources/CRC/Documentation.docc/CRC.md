# ``CRC``

Sendable, Foundation-free CRC8/16/32/64 computation for Swift 6 — a generic engine plus a curated catalog of well-known algorithms.

## Overview

`CRC` translates two Rust crates into a single Swift module:

- A generic engine (``CRC/Algorithm`` and ``CRC/Digest``) parameterized over `UInt8` / `UInt16` / `UInt32` / `UInt64` (translated from `crc`).
- A catalog of named algorithms — Ethernet, iSCSI, MODBUS, XMODEM, XZ, and more — each with its known CRC of `b"123456789"` recorded as the `check` field for self-verification (translated from `crc-catalog`).

All public API is `Sendable`. No Foundation types appear in the public surface. Tables for catalog algorithms are precomputed at first access via `static let` and cached.

```swift
import CRC

// Ethernet / ZIP / gzip CRC
let crc: UInt32 = CRC.compute(Array("hello".utf8), algorithm: .iso_hdlc)
```

## Topics

### Computing a CRC

- ``CRC/compute(_:algorithm:)``
- ``CRC/Digest``

### Algorithm definitions

- ``CRC/Algorithm``

### Catalog (CRC-32)

- ``CRC/Algorithm/iso_hdlc``
- ``CRC/Algorithm/castagnoli``
- ``CRC/Algorithm/bzip2``
- ``CRC/Algorithm/cksum``
- ``CRC/Algorithm/mpeg2``

### Catalog (CRC-16)

- ``CRC/Algorithm/modbus``
- ``CRC/Algorithm/xmodem``
- ``CRC/Algorithm/ccitt_false``

### Catalog (CRC-8)

- ``CRC/Algorithm/smbus``
- ``CRC/Algorithm/maxim_dow``

### Catalog (CRC-64)

- ``CRC/Algorithm/xz``
- ``CRC/Algorithm/ecma_182``
