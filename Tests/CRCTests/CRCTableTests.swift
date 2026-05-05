// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import CRC

@Suite("CRCTable internals")
struct CRCTableTests {
    @Test("reflect: 8-bit reverses bit order")
    func reflect8() {
        #expect(CRCTable.reflect(UInt8(0b1000_0001), width: 8) == 0b1000_0001)
        #expect(CRCTable.reflect(UInt8(0b1010_0000), width: 8) == 0b0000_0101)
        #expect(CRCTable.reflect(UInt8(0xFF), width: 8) == 0xFF)
        #expect(CRCTable.reflect(UInt8(0x80), width: 8) == 0x01)
        #expect(CRCTable.reflect(UInt8(0x00), width: 8) == 0x00)
    }

    @Test("reflect: 16-bit reverses bit order")
    func reflect16() {
        #expect(CRCTable.reflect(UInt16(0x8000), width: 16) == 0x0001)
        #expect(CRCTable.reflect(UInt16(0xC000), width: 16) == 0x0003)
        #expect(CRCTable.reflect(UInt16(0xFFFF), width: 16) == 0xFFFF)
    }

    @Test("reflect: 32-bit reverses bit order")
    func reflect32() {
        #expect(CRCTable.reflect(UInt32(0x80000000), width: 32) == 0x00000001)
        #expect(CRCTable.reflect(UInt32(0xFFFFFFFF), width: 32) == 0xFFFFFFFF)
        #expect(CRCTable.reflect(UInt32(0x12345678), width: 32) == 0x1E6A2C48)
    }

    @Test("forward (refIn=false) table for CRC-32/MPEG-2: known first entries")
    func forwardTableMPEG2() {
        // CRC-32/MPEG-2: poly=0x04C11DB7, refIn=false
        let table = CRCTable.build(width: 32, polynomial: UInt32(0x04C11DB7), refIn: false)
        #expect(table.count == 256)
        #expect(table[0] == 0x00000000)
        // table[1] for forward CRC-32 with poly 0x04C11DB7 is 0x04C11DB7
        #expect(table[1] == 0x04C11DB7)
    }

    @Test("reflected (refIn=true) table for CRC-32/ISO-HDLC: known first entries")
    func reflectedTableISO_HDLC() {
        // CRC-32/ISO-HDLC: poly=0x04C11DB7, refIn=true
        // Reflected polynomial = 0xEDB88320
        let table = CRCTable.build(width: 32, polynomial: UInt32(0x04C11DB7), refIn: true)
        #expect(table.count == 256)
        #expect(table[0] == 0x00000000)
        // Canonical first non-zero entry for the reflected gzip/Ethernet table
        #expect(table[1] == 0x77073096)
    }
}
