// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC-32 catalog")
struct CRC32CatalogTests {
    static let probe = Array("123456789".utf8)

    @Test("CRC-32/ISO-HDLC (Ethernet, gzip, ZIP) check value")
    func iso_hdlc() {
        let alg = CRC.Algorithm<UInt32>.iso_hdlc
        #expect(alg.check == 0xCBF43926)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-32/ISCSI (Castagnoli) check value")
    func castagnoli() {
        let alg = CRC.Algorithm<UInt32>.castagnoli
        #expect(alg.check == 0xE3069283)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-32/BZIP2 check value")
    func bzip2() {
        let alg = CRC.Algorithm<UInt32>.bzip2
        #expect(alg.check == 0xFC891918)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-32/CKSUM (Unix cksum) check value")
    func cksum() {
        let alg = CRC.Algorithm<UInt32>.cksum
        #expect(alg.check == 0x765E7680)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-32/MPEG-2 check value")
    func mpeg2() {
        let alg = CRC.Algorithm<UInt32>.mpeg2
        #expect(alg.check == 0x0376E6E7)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("All catalog UInt32 algorithms self-verify against their check field")
    func allUInt32CatalogSelfVerify() {
        let all: [CRC.Algorithm<UInt32>] = [
            .iso_hdlc, .castagnoli, .bzip2, .cksum, .mpeg2,
        ]
        for alg in all {
            let actual = CRC.compute(Self.probe, algorithm: alg)
            #expect(actual == alg.check, "\(alg.name): expected check \(String(alg.check, radix: 16)), got \(String(actual, radix: 16))")
        }
    }
}
