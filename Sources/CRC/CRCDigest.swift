// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension CRC {
    /// Incremental CRC computation. Initialize with a `CRC.Algorithm`, call
    /// ``update(_:)`` zero or more times, then ``finalize()`` to obtain the
    /// CRC value.
    public struct Digest<Width>: Sendable
    where Width: FixedWidthInteger & UnsignedInteger & Sendable {
        public let algorithm: Algorithm<Width>
        @usableFromInline var crc: Width

        /// Initialize with the given algorithm. The CRC register is loaded
        /// with the algorithm's initial value (reflected if `refIn` is true).
        public init(algorithm: Algorithm<Width>) {
            self.algorithm = algorithm
            // For reflected algorithms we operate in reflected space throughout
            // the loop, so the initial value must be reflected on entry.
            if algorithm.refIn {
                self.crc = CRCTable.reflect(algorithm.initial, width: algorithm.width)
            } else {
                self.crc = algorithm.initial
            }
        }

        /// Process the given bytes, updating the running CRC.
        public mutating func update(_ bytes: some Sequence<UInt8>) {
            let table = algorithm.table
            if algorithm.refIn {
                for byte in bytes {
                    let index = Int(UInt8(crc & 0xFF) ^ byte)
                    crc = (crc >> 8) ^ table[index]
                }
            } else {
                let topShift = algorithm.width - 8
                for byte in bytes {
                    let index = Int(UInt8((crc >> topShift) & 0xFF) ^ byte)
                    crc = (crc << 8) ^ table[index]
                }
            }
        }

        /// Return the final CRC value: applies refOut adjustment (if needed)
        /// and the algorithm's xorOut. The Digest itself is unchanged.
        public func finalize() -> Width {
            var result = crc
            // We worked in reflected space iff refIn. If refOut differs,
            // reflect back to the natural orientation for output.
            if algorithm.refIn != algorithm.refOut {
                result = CRCTable.reflect(result, width: algorithm.width)
            }
            return result ^ algorithm.xorOut
        }
    }
}
