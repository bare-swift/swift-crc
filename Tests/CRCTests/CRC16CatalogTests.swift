// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC-16 catalog")
struct CRC16CatalogTests {
    static let probe = Array("123456789".utf8)

    @Test("CRC-16/MODBUS check value")
    func modbus() {
        let alg = CRC.Algorithm<UInt16>.modbus
        #expect(alg.check == 0x4B37)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-16/XMODEM check value")
    func xmodem() {
        let alg = CRC.Algorithm<UInt16>.xmodem
        #expect(alg.check == 0x31C3)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("CRC-16/IBM-3740 (a.k.a. CCITT-FALSE) check value")
    func ccitt_false() {
        let alg = CRC.Algorithm<UInt16>.ccitt_false
        #expect(alg.check == 0x29B1)
        #expect(CRC.compute(Self.probe, algorithm: alg) == alg.check)
    }

    @Test("All catalog UInt16 algorithms self-verify against their check field")
    func allUInt16CatalogSelfVerify() {
        let all: [CRC.Algorithm<UInt16>] = [.modbus, .xmodem, .ccitt_false]
        for alg in all {
            let actual = CRC.compute(Self.probe, algorithm: alg)
            #expect(actual == alg.check, "\(alg.name): expected \(String(alg.check, radix: 16)), got \(String(actual, radix: 16))")
        }
    }
}
