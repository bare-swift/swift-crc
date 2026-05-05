// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

/// Sendable, Foundation-free CRC8/16/32/64 computation.
///
/// Use ``CRC/compute(_:algorithm:)`` for one-shot computation, or ``CRC/Digest``
/// for incremental updates. Algorithm parameters are carried by ``CRC/Algorithm``;
/// commonly-used algorithms are available as `static let` constants on
/// `CRC.Algorithm` (e.g. ``CRC/Algorithm/iso_hdlc``).
public enum CRC: Sendable {}
