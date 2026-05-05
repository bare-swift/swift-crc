# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-05-05

### Added
- `CRC.Algorithm<Width>` — generic algorithm parameter container with precomputed lookup table (`UInt8`/`UInt16`/`UInt32`/`UInt64`).
- `CRC.Digest<Width>` — incremental CRC computation; `update(_:)` then `finalize()`.
- `CRC.compute(_:algorithm:)` — one-shot convenience.
- Catalog of well-known algorithms:
  - **CRC-32**: `iso_hdlc` (Ethernet/gzip/ZIP), `castagnoli` (iSCSI/SCTP/Btrfs), `bzip2`, `cksum`, `mpeg2`.
  - **CRC-16**: `modbus`, `xmodem`, `ccitt_false`.
  - **CRC-8**: `smbus`, `maxim_dow`.
  - **CRC-64**: `xz`, `ecma_182`.
- Each catalog entry carries a `check` field (CRC of `b"123456789"`) for self-verification.
- DocC documentation, full README example, NOTICE crediting upstream `crc`, `crc-catalog`, and `crc32fast` Rust crates.

### Limitations (out of scope for v0.1)
- Only widths matching `Width.bitWidth` (8/16/32/64) supported. Non-byte-aligned algorithms (CRC-15/CAN, etc.) are not supported.
- Table-driven only; no SIMD acceleration.
