// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Stub — replaced in Task 6.

enum CRCTable {
    static func build<Width>(width: Int, polynomial: Width, refIn: Bool) -> [Width]
    where Width: FixedWidthInteger & UnsignedInteger {
        // Stub: returns 256 zero entries so Algorithm.init compiles.
        return Array(repeating: 0, count: 256)
    }

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
