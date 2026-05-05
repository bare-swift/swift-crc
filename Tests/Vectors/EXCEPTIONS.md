# Test-parity exceptions

Per [RFC-0002](https://github.com/bare-swift/bare-swift/blob/main/rfcs/0002-test-parity-policy.md), this file documents why some upstream test cases are not extracted as fixtures.

## Source: `crc` and `crc-catalog` (Rust crates)

Both crates use inline `#[test]` cases driven from the algorithm catalog. The
canonical correctness test for any CRC algorithm is: compute the CRC of the ASCII
string `b"123456789"` and verify it equals the algorithm's documented `check`
field. The Swift package translates this directly: every catalog entry carries
its `check` value, and `CRCComputeTests` iterates the catalog asserting
`compute(b"123456789", algorithm) == algorithm.check` for each one. This single
test catches any miscoded polynomial / initial value / reflection / xorOut.

Per-algorithm spot tests in `CRC{8,16,32,64}CatalogTests.swift` provide
additional coverage with named test cases.

## Source: `crc32fast` (Rust crate)

`crc32fast` is a SIMD-accelerated CRC-32/ISO-HDLC implementation. Its tests
verify equivalence with the table-driven reference. v0.1 of swift-crc uses only
the table-driven path, so SIMD-equivalence tests don't apply. (If we add SIMD
later, we'll add equivalence tests at that point.)

## Refresh

When upstream catalogs add new algorithms, add the corresponding Swift entries
and the `check`-value verification test will automatically cover them. Record
the source commit hash here when refreshing:

- `crc-catalog`: tracked at upstream commit (record at next refresh)
- `crc`: tracked at upstream commit (record at next refresh)
