// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

/// Internal: CRC lookup-table primitives. Not part of the public API.
enum CRCTable {
    /// Build a 256-entry lookup table for the given polynomial in the given
    /// orientation (`refIn` selects forward vs. reflected).
    ///
    /// Forward table (`refIn=false`): for index `i`, table[i] is the CRC
    /// of a single byte whose top byte equals `i`, processed left-to-right
    /// (MSB-first), with initial=0.
    ///
    /// Reflected table (`refIn=true`): for index `i`, table[i] is the CRC
    /// of a single byte whose bottom byte equals `i`, processed right-to-left
    /// (LSB-first), using the bit-reversed polynomial, with initial=0.
    static func build<Width>(width: Int, polynomial: Width, refIn: Bool) -> [Width]
    where Width: FixedWidthInteger & UnsignedInteger {
        precondition(width == Width.bitWidth,
                     "swift-crc v0.1 supports only widths matching Width.bitWidth (8/16/32/64)")
        var table = [Width](repeating: 0, count: 256)
        if refIn {
            let reflectedPoly = reflect(polynomial, width: width)
            for i in 0..<256 {
                var crc = Width(i)
                for _ in 0..<8 {
                    if (crc & 1) != 0 {
                        crc = (crc >> 1) ^ reflectedPoly
                    } else {
                        crc >>= 1
                    }
                }
                table[i] = crc
            }
        } else {
            let topBit = Width(1) << (width - 1)
            for i in 0..<256 {
                var crc = Width(i) << (width - 8)
                for _ in 0..<8 {
                    if (crc & topBit) != 0 {
                        crc = (crc << 1) ^ polynomial
                    } else {
                        crc <<= 1
                    }
                }
                table[i] = crc
            }
        }
        return table
    }

    /// Reverse the bit order of `value`, considering only the low `width` bits.
    static func reflect<Width>(_ value: Width, width: Int) -> Width
    where Width: FixedWidthInteger & UnsignedInteger {
        var result: Width = 0
        var v = value
        for _ in 0..<width {
            result = (result << 1) | (v & 1)
            v >>= 1
        }
        return result
    }
}
