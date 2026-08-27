#!/usr/bin/env python3
"""Present a freely licensed font under the names the class asks for.

sharifthesis.cls requests XBZar, Yas and IranNastaliq. Those are not free and are
not in TeX Live, so they cannot be committed here or installed on a CI runner.
XeTeX resolves fonts by their internal family name, so this takes a font that IS
in TeX Live and writes copies of it whose name table reports the wanted names.

This exists only so CI can prove the template still compiles. The result is not
what a thesis should look like; build locally with the real fonts for that.
"""
import struct, sys, os

def read_table_dir(d):
    num = struct.unpack(">H", d[4:6])[0]
    for i in range(num):
        e = 12 + 16 * i
        yield e, bytes(d[e:e + 4])

def build_name_table(family, subfamily="Regular"):
    """A fresh name table carrying just the identifying records."""
    records, storage = [], b""
    for platform, encoding, language, encode in (
        (3, 1, 0x409, lambda s: s.encode("utf-16-be")),   # Windows
        (1, 0, 0,     lambda s: s.encode("latin-1")),     # Macintosh
    ):
        for name_id, value in ((1, family), (2, subfamily),
                               (4, family), (6, family.replace(" ", ""))):
            data = encode(value)
            records.append((platform, encoding, language, name_id,
                            len(data), len(storage)))
            storage += data
    records.sort(key=lambda r: (r[0], r[1], r[2], r[3]))
    offset = 6 + 12 * len(records)
    out = struct.pack(">HHH", 0, len(records), offset)
    for r in records:
        out += struct.pack(">HHHHHH", *r)
    return out + storage

def rename(src, dst, family, subfamily="Regular"):
    d = bytearray(open(src, "rb").read())
    table = build_name_table(family, subfamily)
    while len(d) % 4:                      # tables must be 4-byte aligned
        d += b"\0"
    offset = len(d)
    d += table
    for entry, tag in read_table_dir(d):
        if tag == b"name":
            struct.pack_into(">II", d, entry + 8, offset, len(table))
            break
    else:
        raise SystemExit("%s: no name table" % src)
    open(dst, "wb").write(bytes(d))

if __name__ == "__main__":
    src, outdir = sys.argv[1], sys.argv[2]
    os.makedirs(outdir, exist_ok=True)
    for family in ("XBZar", "Yas", "IranNastaliq"):
        rename(src, os.path.join(outdir, family + ".ttf"), family)
        print("  %s.ttf" % family)
