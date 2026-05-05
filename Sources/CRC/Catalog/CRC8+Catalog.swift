// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension CRC.Algorithm where Width == UInt8 {
    /// CRC-8/SMBUS. Used by the SMBus / I²C / NVMe protocols.
    public static let smbus = CRC.Algorithm<UInt8>(
        width: 8, polynomial: 0x07, initial: 0,
        refIn: false, refOut: false, xorOut: 0,
        check: 0xF4, name: "CRC-8/SMBUS"
    )

    /// CRC-8/MAXIM-DOW (a.k.a. 1-Wire CRC, Dallas/Maxim).
    public static let maxim_dow = CRC.Algorithm<UInt8>(
        width: 8, polynomial: 0x31, initial: 0,
        refIn: true, refOut: true, xorOut: 0,
        check: 0xA1, name: "CRC-8/MAXIM-DOW"
    )
}
