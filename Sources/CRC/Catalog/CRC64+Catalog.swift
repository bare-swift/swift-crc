// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension CRC.Algorithm where Width == UInt64 {
    /// CRC-64/XZ (a.k.a. CRC-64/GO-ECMA). Used by the XZ compression format.
    public static let xz = CRC.Algorithm<UInt64>(
        width: 64, polynomial: 0x42F0E1EBA9EA3693, initial: 0xFFFFFFFFFFFFFFFF,
        refIn: true, refOut: true, xorOut: 0xFFFFFFFFFFFFFFFF,
        check: 0x995DC9BBDF1939FA, name: "CRC-64/XZ"
    )

    /// CRC-64/ECMA-182. The original ECMA-182 CRC-64.
    public static let ecma_182 = CRC.Algorithm<UInt64>(
        width: 64, polynomial: 0x42F0E1EBA9EA3693, initial: 0,
        refIn: false, refOut: false, xorOut: 0,
        check: 0x6C40DF5F0B497347, name: "CRC-64/ECMA-182"
    )
}
