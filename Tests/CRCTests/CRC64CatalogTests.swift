// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC-64 catalog")
struct CRC64CatalogTests {
    static let probe = Array("123456789".utf8)

    @Test("CRC-64/XZ (a.k.a. CRC-64/GO-ECMA) check value")
    func xz() {
        let alg = CRC.Algorithm<UInt64>.xz
        #expect(alg.check == 0x995DC9BBDF1939FA)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-64/ECMA-182 check value")
    func ecma_182() {
        let alg = CRC.Algorithm<UInt64>.ecma_182
        #expect(alg.check == 0x6C40DF5F0B497347)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("All catalog UInt64 algorithms self-verify against their check field")
    func allUInt64CatalogSelfVerify() {
        let all: [CRC.Algorithm<UInt64>] = [.xz, .ecma_182]
        for alg in all {
            let actual = CRC.compute(Self.probe, algorithm: alg)
            #expect(actual == alg.check, "\(alg.name)")
        }
    }
}
