// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC.Digest")
struct CRCDigestTests {
    // CRC-32/ISO-HDLC of "123456789" must be 0xCBF43926 (the canonical "check")
    static let isoHDLC = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF,
        refIn: true, refOut: true, xorOut: 0xFFFFFFFF,
        check: 0xCBF43926, name: "CRC-32/ISO-HDLC"
    )

    @Test("Digest produces the canonical check value in one update")
    func oneShotMatchesCheck() {
        var d = CRC.Digest(algorithm: Self.isoHDLC)
        d.update(Array("123456789".utf8))
        #expect(d.finalize() == Self.isoHDLC.check)
    }

    @Test("Digest is order-equivalent: split updates equal one update")
    func incrementalEqualsOneShot() {
        var d1 = CRC.Digest(algorithm: Self.isoHDLC)
        d1.update(Array("123".utf8))
        d1.update(Array("456789".utf8))

        var d2 = CRC.Digest(algorithm: Self.isoHDLC)
        d2.update(Array("123456789".utf8))

        #expect(d1.finalize() == d2.finalize())
    }

    @Test("Digest of empty input returns initial XOR xorOut for refIn==refOut")
    func emptyInput() {
        var d = CRC.Digest(algorithm: Self.isoHDLC)
        d.update([] as [UInt8])
        // For ISO-HDLC: initial=0xFFFFFFFF, refIn=refOut=true, xorOut=0xFFFFFFFF.
        // After init+finalize on empty input: reflected initial XOR xorOut.
        // Reflected initial = 0xFFFFFFFF (palindrome under reflect-32),
        // 0xFFFFFFFF XOR 0xFFFFFFFF = 0.
        #expect(d.finalize() == 0)
    }

    // CRC-16/XMODEM: poly=0x1021, refIn=false, refOut=false, init=0, xorOut=0
    // check = 0x31C3
    static let xmodem = CRC.Algorithm<UInt16>(
        width: 16, polynomial: 0x1021, initial: 0,
        refIn: false, refOut: false, xorOut: 0,
        check: 0x31C3, name: "CRC-16/XMODEM"
    )

    @Test("Forward (non-reflected) Digest produces correct CRC-16/XMODEM check")
    func forwardXMODEMMatchesCheck() {
        var d = CRC.Digest(algorithm: Self.xmodem)
        d.update(Array("123456789".utf8))
        #expect(d.finalize() == 0x31C3)
    }
}
