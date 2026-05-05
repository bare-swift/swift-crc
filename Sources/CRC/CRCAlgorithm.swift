// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension CRC {
    /// Parameters describing a CRC algorithm.
    ///
    /// `Width` selects the natural integer type holding the CRC value
    /// (`UInt8`/`UInt16`/`UInt32`/`UInt64`). v0.1 supports only `width` values
    /// equal to `Width.bitWidth` (i.e., 8/16/32/64); non-byte-aligned widths
    /// are out of scope.
    public struct Algorithm<Width>: Sendable
    where Width: FixedWidthInteger & UnsignedInteger & Sendable {
        public let width: Int
        public let polynomial: Width
        public let initial: Width
        public let refIn: Bool
        public let refOut: Bool
        public let xorOut: Width
        public let check: Width
        public let name: String

        /// Precomputed 256-entry lookup table. Internal; `Digest` consumes it.
        let table: [Width]

        public init(
            width: Int,
            polynomial: Width,
            initial: Width,
            refIn: Bool,
            refOut: Bool,
            xorOut: Width,
            check: Width,
            name: String
        ) {
            self.width = width
            self.polynomial = polynomial
            self.initial = initial
            self.refIn = refIn
            self.refOut = refOut
            self.xorOut = xorOut
            self.check = check
            self.name = name
            self.table = CRCTable.build(width: width, polynomial: polynomial, refIn: refIn)
        }
    }
}
