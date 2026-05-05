// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension CRC.Algorithm where Width == UInt16 {
    /// CRC-16/MODBUS. Used by Modbus RTU.
    public static let modbus = CRC.Algorithm<UInt16>(
        width: 16, polynomial: 0x8005, initial: 0xFFFF,
        refIn: true, refOut: true, xorOut: 0,
        check: 0x4B37, name: "CRC-16/MODBUS"
    )

    /// CRC-16/XMODEM (a.k.a. CRC-16/ACORN, CRC-16/V-41-MSB).
    public static let xmodem = CRC.Algorithm<UInt16>(
        width: 16, polynomial: 0x1021, initial: 0,
        refIn: false, refOut: false, xorOut: 0,
        check: 0x31C3, name: "CRC-16/XMODEM"
    )

    /// CRC-16/IBM-3740 (a.k.a. CCITT-FALSE). Used in many telecom contexts.
    public static let ccitt_false = CRC.Algorithm<UInt16>(
        width: 16, polynomial: 0x1021, initial: 0xFFFF,
        refIn: false, refOut: false, xorOut: 0,
        check: 0x29B1, name: "CRC-16/IBM-3740"
    )
}
