// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC-8 catalog")
struct CRC8CatalogTests {
    static let probe = Array("123456789".utf8)

    @Test("CRC-8/SMBUS check value")
    func smbus() {
        let alg = CRC.Algorithm<UInt8>.smbus
        #expect(alg.check == 0xF4)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-8/MAXIM-DOW (a.k.a. 1-Wire) check value")
    func maxim_dow() {
        let alg = CRC.Algorithm<UInt8>.maxim_dow
        #expect(alg.check == 0xA1)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("All catalog UInt8 algorithms self-verify against their check field")
    func allUInt8CatalogSelfVerify() {
        let all: [CRC.Algorithm<UInt8>] = [.smbus, .maxim_dow]
        for alg in all {
            let actual = CRC.compute(Self.probe, algorithm: alg)
            #expect(actual == alg.check, "\(alg.name)")
        }
    }
}
