// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRC.Algorithm")
struct CRCAlgorithmTests {
    @Test("Algorithm carries all parameters and is Sendable")
    func storesParameters() {
        let alg = CRC.Algorithm<UInt32>(
            width: 32,
            polynomial: 0x04C11DB7,
            initial: 0xFFFFFFFF,
            refIn: true, refOut: true,
            xorOut: 0xFFFFFFFF,
            check: 0xCBF43926,
            name: "test"
        )
        #expect(alg.width == 32)
        #expect(alg.polynomial == 0x04C11DB7)
        #expect(alg.initial == 0xFFFFFFFF)
        #expect(alg.refIn == true)
        #expect(alg.refOut == true)
        #expect(alg.xorOut == 0xFFFFFFFF)
        #expect(alg.check == 0xCBF43926)
        #expect(alg.name == "test")
        let _: any Sendable = alg
    }

    @Test("Algorithm precomputes a 256-entry lookup table at init")
    func tableSizeIs256() {
        let alg = CRC.Algorithm<UInt32>(
            width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF,
            refIn: true, refOut: true, xorOut: 0xFFFFFFFF,
            check: 0xCBF43926, name: "iso-hdlc"
        )
        #expect(alg.table.count == 256)
    }

    @Test("Algorithm is generic over UInt8 / UInt16 / UInt32 / UInt64")
    func genericOverWidths() {
        let a8  = CRC.Algorithm<UInt8>(width: 8, polynomial: 0x07, initial: 0, refIn: false, refOut: false, xorOut: 0, check: 0xF4, name: "smbus")
        let a16 = CRC.Algorithm<UInt16>(width: 16, polynomial: 0x1021, initial: 0, refIn: false, refOut: false, xorOut: 0, check: 0x31C3, name: "xmodem")
        let a32 = CRC.Algorithm<UInt32>(width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF, refIn: true, refOut: true, xorOut: 0xFFFFFFFF, check: 0xCBF43926, name: "iso-hdlc")
        let a64 = CRC.Algorithm<UInt64>(width: 64, polynomial: 0x42F0E1EBA9EA3693, initial: 0, refIn: false, refOut: false, xorOut: 0, check: 0x6C40DF5F0B497347, name: "ecma-182")
        #expect(a8.width == 8)
        #expect(a16.width == 16)
        #expect(a32.width == 32)
        #expect(a64.width == 64)
    }
}
