// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC.compute one-shot")
struct CRCComputeTests {
    static let isoHDLC = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF,
        refIn: true, refOut: true, xorOut: 0xFFFFFFFF,
        check: 0xCBF43926, name: "CRC-32/ISO-HDLC"
    )

    @Test("compute matches Digest for a sample input")
    func matchesDigest() {
        let bytes = Array("hello, world".utf8)
        var d = CRC.Digest(algorithm: Self.isoHDLC)
        d.update(bytes)
        #expect(CRC.compute(bytes, algorithm: Self.isoHDLC) == d.finalize())
    }

    @Test("compute returns the canonical check value for the standard probe")
    func computeMatchesCheck() {
        let probe = Array("123456789".utf8)
        #expect(CRC.compute(probe, algorithm: Self.isoHDLC) == Self.isoHDLC.check)
    }

    @Test("accepts any Sequence<UInt8>")
    func sequenceInput() {
        let arr = ContiguousArray<UInt8>("123456789".utf8)
        #expect(CRC.compute(arr, algorithm: Self.isoHDLC) == Self.isoHDLC.check)
    }
}
