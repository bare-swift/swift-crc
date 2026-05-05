// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension CRC.Algorithm where Width == UInt32 {
    /// CRC-32/ISO-HDLC (a.k.a. CRC-32, IEEE 802.3, Ethernet, gzip, ZIP, PNG).
    /// Polynomial 0x04C11DB7 reflected; initial 0xFFFFFFFF; xor-out 0xFFFFFFFF.
    public static let iso_hdlc = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF,
        refIn: true, refOut: true, xorOut: 0xFFFFFFFF,
        check: 0xCBF43926, name: "CRC-32/ISO-HDLC"
    )

    /// CRC-32/ISCSI (a.k.a. Castagnoli, CRC-32C). Used by SCTP, iSCSI, Btrfs, Ext4.
    public static let castagnoli = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x1EDC6F41, initial: 0xFFFFFFFF,
        refIn: true, refOut: true, xorOut: 0xFFFFFFFF,
        check: 0xE3069283, name: "CRC-32/ISCSI"
    )

    /// CRC-32/BZIP2. Used by bzip2.
    public static let bzip2 = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF,
        refIn: false, refOut: false, xorOut: 0xFFFFFFFF,
        check: 0xFC891918, name: "CRC-32/BZIP2"
    )

    /// CRC-32/CKSUM. Used by the Unix `cksum` utility.
    public static let cksum = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x04C11DB7, initial: 0,
        refIn: false, refOut: false, xorOut: 0xFFFFFFFF,
        check: 0x765E7680, name: "CRC-32/CKSUM"
    )

    /// CRC-32/MPEG-2. Used in MPEG transport streams.
    public static let mpeg2 = CRC.Algorithm<UInt32>(
        width: 32, polynomial: 0x04C11DB7, initial: 0xFFFFFFFF,
        refIn: false, refOut: false, xorOut: 0,
        check: 0x0376E6E7, name: "CRC-32/MPEG-2"
    )
}
