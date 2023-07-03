// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme2 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sme2 < %s \
// RUN:        | llvm-objdump -d --mattr=+sme2 - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sme2 < %s \
// RUN:        | llvm-objdump -d --mattr=-sme2 - | FileCheck %s --check-prefix=CHECK-UNKNOWN
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sme2 < %s \
// RUN:        | sed '/.text/d' | sed 's/.*encoding: //g' \
// RUN:        | llvm-mc -triple=aarch64 -mattr=+sme2 -disassemble -show-encoding \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST


urshl   {z0.h, z1.h}, {z0.h, z1.h}, z0.h  // 11000001-01100000-10100010-00100001
// CHECK-INST: urshl   { z0.h, z1.h }, { z0.h, z1.h }, z0.h
// CHECK-ENCODING: [0x21,0xa2,0x60,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c160a221 <unknown>

urshl   {z20.h, z21.h}, {z20.h, z21.h}, z5.h  // 11000001-01100101-10100010-00110101
// CHECK-INST: urshl   { z20.h, z21.h }, { z20.h, z21.h }, z5.h
// CHECK-ENCODING: [0x35,0xa2,0x65,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c165a235 <unknown>

urshl   {z22.h, z23.h}, {z22.h, z23.h}, z8.h  // 11000001-01101000-10100010-00110111
// CHECK-INST: urshl   { z22.h, z23.h }, { z22.h, z23.h }, z8.h
// CHECK-ENCODING: [0x37,0xa2,0x68,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c168a237 <unknown>

urshl   {z30.h, z31.h}, {z30.h, z31.h}, z15.h  // 11000001-01101111-10100010-00111111
// CHECK-INST: urshl   { z30.h, z31.h }, { z30.h, z31.h }, z15.h
// CHECK-ENCODING: [0x3f,0xa2,0x6f,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c16fa23f <unknown>


urshl   {z0.h, z1.h}, {z0.h, z1.h}, {z0.h, z1.h}  // 11000001-01100000-10110010-00100001
// CHECK-INST: urshl   { z0.h, z1.h }, { z0.h, z1.h }, { z0.h, z1.h }
// CHECK-ENCODING: [0x21,0xb2,0x60,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c160b221 <unknown>

urshl   {z20.h, z21.h}, {z20.h, z21.h}, {z20.h, z21.h}  // 11000001-01110100-10110010-00110101
// CHECK-INST: urshl   { z20.h, z21.h }, { z20.h, z21.h }, { z20.h, z21.h }
// CHECK-ENCODING: [0x35,0xb2,0x74,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c174b235 <unknown>

urshl   {z22.h, z23.h}, {z22.h, z23.h}, {z8.h, z9.h}  // 11000001-01101000-10110010-00110111
// CHECK-INST: urshl   { z22.h, z23.h }, { z22.h, z23.h }, { z8.h, z9.h }
// CHECK-ENCODING: [0x37,0xb2,0x68,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c168b237 <unknown>

urshl   {z30.h, z31.h}, {z30.h, z31.h}, {z30.h, z31.h}  // 11000001-01111110-10110010-00111111
// CHECK-INST: urshl   { z30.h, z31.h }, { z30.h, z31.h }, { z30.h, z31.h }
// CHECK-ENCODING: [0x3f,0xb2,0x7e,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c17eb23f <unknown>


urshl   {z0.s, z1.s}, {z0.s, z1.s}, z0.s  // 11000001-10100000-10100010-00100001
// CHECK-INST: urshl   { z0.s, z1.s }, { z0.s, z1.s }, z0.s
// CHECK-ENCODING: [0x21,0xa2,0xa0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a0a221 <unknown>

urshl   {z20.s, z21.s}, {z20.s, z21.s}, z5.s  // 11000001-10100101-10100010-00110101
// CHECK-INST: urshl   { z20.s, z21.s }, { z20.s, z21.s }, z5.s
// CHECK-ENCODING: [0x35,0xa2,0xa5,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a5a235 <unknown>

urshl   {z22.s, z23.s}, {z22.s, z23.s}, z8.s  // 11000001-10101000-10100010-00110111
// CHECK-INST: urshl   { z22.s, z23.s }, { z22.s, z23.s }, z8.s
// CHECK-ENCODING: [0x37,0xa2,0xa8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a8a237 <unknown>

urshl   {z30.s, z31.s}, {z30.s, z31.s}, z15.s  // 11000001-10101111-10100010-00111111
// CHECK-INST: urshl   { z30.s, z31.s }, { z30.s, z31.s }, z15.s
// CHECK-ENCODING: [0x3f,0xa2,0xaf,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1afa23f <unknown>


urshl   {z0.s, z1.s}, {z0.s, z1.s}, {z0.s, z1.s}  // 11000001-10100000-10110010-00100001
// CHECK-INST: urshl   { z0.s, z1.s }, { z0.s, z1.s }, { z0.s, z1.s }
// CHECK-ENCODING: [0x21,0xb2,0xa0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a0b221 <unknown>

urshl   {z20.s, z21.s}, {z20.s, z21.s}, {z20.s, z21.s}  // 11000001-10110100-10110010-00110101
// CHECK-INST: urshl   { z20.s, z21.s }, { z20.s, z21.s }, { z20.s, z21.s }
// CHECK-ENCODING: [0x35,0xb2,0xb4,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1b4b235 <unknown>

urshl   {z22.s, z23.s}, {z22.s, z23.s}, {z8.s, z9.s}  // 11000001-10101000-10110010-00110111
// CHECK-INST: urshl   { z22.s, z23.s }, { z22.s, z23.s }, { z8.s, z9.s }
// CHECK-ENCODING: [0x37,0xb2,0xa8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a8b237 <unknown>

urshl   {z30.s, z31.s}, {z30.s, z31.s}, {z30.s, z31.s}  // 11000001-10111110-10110010-00111111
// CHECK-INST: urshl   { z30.s, z31.s }, { z30.s, z31.s }, { z30.s, z31.s }
// CHECK-ENCODING: [0x3f,0xb2,0xbe,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1beb23f <unknown>


urshl   {z0.d, z1.d}, {z0.d, z1.d}, z0.d  // 11000001-11100000-10100010-00100001
// CHECK-INST: urshl   { z0.d, z1.d }, { z0.d, z1.d }, z0.d
// CHECK-ENCODING: [0x21,0xa2,0xe0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e0a221 <unknown>

urshl   {z20.d, z21.d}, {z20.d, z21.d}, z5.d  // 11000001-11100101-10100010-00110101
// CHECK-INST: urshl   { z20.d, z21.d }, { z20.d, z21.d }, z5.d
// CHECK-ENCODING: [0x35,0xa2,0xe5,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e5a235 <unknown>

urshl   {z22.d, z23.d}, {z22.d, z23.d}, z8.d  // 11000001-11101000-10100010-00110111
// CHECK-INST: urshl   { z22.d, z23.d }, { z22.d, z23.d }, z8.d
// CHECK-ENCODING: [0x37,0xa2,0xe8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e8a237 <unknown>

urshl   {z30.d, z31.d}, {z30.d, z31.d}, z15.d  // 11000001-11101111-10100010-00111111
// CHECK-INST: urshl   { z30.d, z31.d }, { z30.d, z31.d }, z15.d
// CHECK-ENCODING: [0x3f,0xa2,0xef,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1efa23f <unknown>


urshl   {z0.d, z1.d}, {z0.d, z1.d}, {z0.d, z1.d}  // 11000001-11100000-10110010-00100001
// CHECK-INST: urshl   { z0.d, z1.d }, { z0.d, z1.d }, { z0.d, z1.d }
// CHECK-ENCODING: [0x21,0xb2,0xe0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e0b221 <unknown>

urshl   {z20.d, z21.d}, {z20.d, z21.d}, {z20.d, z21.d}  // 11000001-11110100-10110010-00110101
// CHECK-INST: urshl   { z20.d, z21.d }, { z20.d, z21.d }, { z20.d, z21.d }
// CHECK-ENCODING: [0x35,0xb2,0xf4,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1f4b235 <unknown>

urshl   {z22.d, z23.d}, {z22.d, z23.d}, {z8.d, z9.d}  // 11000001-11101000-10110010-00110111
// CHECK-INST: urshl   { z22.d, z23.d }, { z22.d, z23.d }, { z8.d, z9.d }
// CHECK-ENCODING: [0x37,0xb2,0xe8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e8b237 <unknown>

urshl   {z30.d, z31.d}, {z30.d, z31.d}, {z30.d, z31.d}  // 11000001-11111110-10110010-00111111
// CHECK-INST: urshl   { z30.d, z31.d }, { z30.d, z31.d }, { z30.d, z31.d }
// CHECK-ENCODING: [0x3f,0xb2,0xfe,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1feb23f <unknown>


urshl   {z0.b, z1.b}, {z0.b, z1.b}, z0.b  // 11000001-00100000-10100010-00100001
// CHECK-INST: urshl   { z0.b, z1.b }, { z0.b, z1.b }, z0.b
// CHECK-ENCODING: [0x21,0xa2,0x20,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c120a221 <unknown>

urshl   {z20.b, z21.b}, {z20.b, z21.b}, z5.b  // 11000001-00100101-10100010-00110101
// CHECK-INST: urshl   { z20.b, z21.b }, { z20.b, z21.b }, z5.b
// CHECK-ENCODING: [0x35,0xa2,0x25,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c125a235 <unknown>

urshl   {z22.b, z23.b}, {z22.b, z23.b}, z8.b  // 11000001-00101000-10100010-00110111
// CHECK-INST: urshl   { z22.b, z23.b }, { z22.b, z23.b }, z8.b
// CHECK-ENCODING: [0x37,0xa2,0x28,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c128a237 <unknown>

urshl   {z30.b, z31.b}, {z30.b, z31.b}, z15.b  // 11000001-00101111-10100010-00111111
// CHECK-INST: urshl   { z30.b, z31.b }, { z30.b, z31.b }, z15.b
// CHECK-ENCODING: [0x3f,0xa2,0x2f,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c12fa23f <unknown>


urshl   {z0.b, z1.b}, {z0.b, z1.b}, {z0.b, z1.b}  // 11000001-00100000-10110010-00100001
// CHECK-INST: urshl   { z0.b, z1.b }, { z0.b, z1.b }, { z0.b, z1.b }
// CHECK-ENCODING: [0x21,0xb2,0x20,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c120b221 <unknown>

urshl   {z20.b, z21.b}, {z20.b, z21.b}, {z20.b, z21.b}  // 11000001-00110100-10110010-00110101
// CHECK-INST: urshl   { z20.b, z21.b }, { z20.b, z21.b }, { z20.b, z21.b }
// CHECK-ENCODING: [0x35,0xb2,0x34,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c134b235 <unknown>

urshl   {z22.b, z23.b}, {z22.b, z23.b}, {z8.b, z9.b}  // 11000001-00101000-10110010-00110111
// CHECK-INST: urshl   { z22.b, z23.b }, { z22.b, z23.b }, { z8.b, z9.b }
// CHECK-ENCODING: [0x37,0xb2,0x28,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c128b237 <unknown>

urshl   {z30.b, z31.b}, {z30.b, z31.b}, {z30.b, z31.b}  // 11000001-00111110-10110010-00111111
// CHECK-INST: urshl   { z30.b, z31.b }, { z30.b, z31.b }, { z30.b, z31.b }
// CHECK-ENCODING: [0x3f,0xb2,0x3e,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c13eb23f <unknown>


urshl   {z0.h - z3.h}, {z0.h - z3.h}, z0.h  // 11000001-01100000-10101010-00100001
// CHECK-INST: urshl   { z0.h - z3.h }, { z0.h - z3.h }, z0.h
// CHECK-ENCODING: [0x21,0xaa,0x60,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c160aa21 <unknown>

urshl   {z20.h - z23.h}, {z20.h - z23.h}, z5.h  // 11000001-01100101-10101010-00110101
// CHECK-INST: urshl   { z20.h - z23.h }, { z20.h - z23.h }, z5.h
// CHECK-ENCODING: [0x35,0xaa,0x65,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c165aa35 <unknown>

urshl   {z20.h - z23.h}, {z20.h - z23.h}, z8.h  // 11000001-01101000-10101010-00110101
// CHECK-INST: urshl   { z20.h - z23.h }, { z20.h - z23.h }, z8.h
// CHECK-ENCODING: [0x35,0xaa,0x68,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c168aa35 <unknown>

urshl   {z28.h - z31.h}, {z28.h - z31.h}, z15.h  // 11000001-01101111-10101010-00111101
// CHECK-INST: urshl   { z28.h - z31.h }, { z28.h - z31.h }, z15.h
// CHECK-ENCODING: [0x3d,0xaa,0x6f,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c16faa3d <unknown>


urshl   {z0.h - z3.h}, {z0.h - z3.h}, {z0.h - z3.h}  // 11000001-01100000-10111010-00100001
// CHECK-INST: urshl   { z0.h - z3.h }, { z0.h - z3.h }, { z0.h - z3.h }
// CHECK-ENCODING: [0x21,0xba,0x60,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c160ba21 <unknown>

urshl   {z20.h - z23.h}, {z20.h - z23.h}, {z20.h - z23.h}  // 11000001-01110100-10111010-00110101
// CHECK-INST: urshl   { z20.h - z23.h }, { z20.h - z23.h }, { z20.h - z23.h }
// CHECK-ENCODING: [0x35,0xba,0x74,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c174ba35 <unknown>

urshl   {z20.h - z23.h}, {z20.h - z23.h}, {z8.h - z11.h}  // 11000001-01101000-10111010-00110101
// CHECK-INST: urshl   { z20.h - z23.h }, { z20.h - z23.h }, { z8.h - z11.h }
// CHECK-ENCODING: [0x35,0xba,0x68,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c168ba35 <unknown>

urshl   {z28.h - z31.h}, {z28.h - z31.h}, {z28.h - z31.h}  // 11000001-01111100-10111010-00111101
// CHECK-INST: urshl   { z28.h - z31.h }, { z28.h - z31.h }, { z28.h - z31.h }
// CHECK-ENCODING: [0x3d,0xba,0x7c,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c17cba3d <unknown>


urshl   {z0.s - z3.s}, {z0.s - z3.s}, z0.s  // 11000001-10100000-10101010-00100001
// CHECK-INST: urshl   { z0.s - z3.s }, { z0.s - z3.s }, z0.s
// CHECK-ENCODING: [0x21,0xaa,0xa0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a0aa21 <unknown>

urshl   {z20.s - z23.s}, {z20.s - z23.s}, z5.s  // 11000001-10100101-10101010-00110101
// CHECK-INST: urshl   { z20.s - z23.s }, { z20.s - z23.s }, z5.s
// CHECK-ENCODING: [0x35,0xaa,0xa5,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a5aa35 <unknown>

urshl   {z20.s - z23.s}, {z20.s - z23.s}, z8.s  // 11000001-10101000-10101010-00110101
// CHECK-INST: urshl   { z20.s - z23.s }, { z20.s - z23.s }, z8.s
// CHECK-ENCODING: [0x35,0xaa,0xa8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a8aa35 <unknown>

urshl   {z28.s - z31.s}, {z28.s - z31.s}, z15.s  // 11000001-10101111-10101010-00111101
// CHECK-INST: urshl   { z28.s - z31.s }, { z28.s - z31.s }, z15.s
// CHECK-ENCODING: [0x3d,0xaa,0xaf,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1afaa3d <unknown>


urshl   {z0.s - z3.s}, {z0.s - z3.s}, {z0.s - z3.s}  // 11000001-10100000-10111010-00100001
// CHECK-INST: urshl   { z0.s - z3.s }, { z0.s - z3.s }, { z0.s - z3.s }
// CHECK-ENCODING: [0x21,0xba,0xa0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a0ba21 <unknown>

urshl   {z20.s - z23.s}, {z20.s - z23.s}, {z20.s - z23.s}  // 11000001-10110100-10111010-00110101
// CHECK-INST: urshl   { z20.s - z23.s }, { z20.s - z23.s }, { z20.s - z23.s }
// CHECK-ENCODING: [0x35,0xba,0xb4,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1b4ba35 <unknown>

urshl   {z20.s - z23.s}, {z20.s - z23.s}, {z8.s - z11.s}  // 11000001-10101000-10111010-00110101
// CHECK-INST: urshl   { z20.s - z23.s }, { z20.s - z23.s }, { z8.s - z11.s }
// CHECK-ENCODING: [0x35,0xba,0xa8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1a8ba35 <unknown>

urshl   {z28.s - z31.s}, {z28.s - z31.s}, {z28.s - z31.s}  // 11000001-10111100-10111010-00111101
// CHECK-INST: urshl   { z28.s - z31.s }, { z28.s - z31.s }, { z28.s - z31.s }
// CHECK-ENCODING: [0x3d,0xba,0xbc,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1bcba3d <unknown>


urshl   {z0.d - z3.d}, {z0.d - z3.d}, z0.d  // 11000001-11100000-10101010-00100001
// CHECK-INST: urshl   { z0.d - z3.d }, { z0.d - z3.d }, z0.d
// CHECK-ENCODING: [0x21,0xaa,0xe0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e0aa21 <unknown>

urshl   {z20.d - z23.d}, {z20.d - z23.d}, z5.d  // 11000001-11100101-10101010-00110101
// CHECK-INST: urshl   { z20.d - z23.d }, { z20.d - z23.d }, z5.d
// CHECK-ENCODING: [0x35,0xaa,0xe5,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e5aa35 <unknown>

urshl   {z20.d - z23.d}, {z20.d - z23.d}, z8.d  // 11000001-11101000-10101010-00110101
// CHECK-INST: urshl   { z20.d - z23.d }, { z20.d - z23.d }, z8.d
// CHECK-ENCODING: [0x35,0xaa,0xe8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e8aa35 <unknown>

urshl   {z28.d - z31.d}, {z28.d - z31.d}, z15.d  // 11000001-11101111-10101010-00111101
// CHECK-INST: urshl   { z28.d - z31.d }, { z28.d - z31.d }, z15.d
// CHECK-ENCODING: [0x3d,0xaa,0xef,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1efaa3d <unknown>


urshl   {z0.d - z3.d}, {z0.d - z3.d}, {z0.d - z3.d}  // 11000001-11100000-10111010-00100001
// CHECK-INST: urshl   { z0.d - z3.d }, { z0.d - z3.d }, { z0.d - z3.d }
// CHECK-ENCODING: [0x21,0xba,0xe0,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e0ba21 <unknown>

urshl   {z20.d - z23.d}, {z20.d - z23.d}, {z20.d - z23.d}  // 11000001-11110100-10111010-00110101
// CHECK-INST: urshl   { z20.d - z23.d }, { z20.d - z23.d }, { z20.d - z23.d }
// CHECK-ENCODING: [0x35,0xba,0xf4,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1f4ba35 <unknown>

urshl   {z20.d - z23.d}, {z20.d - z23.d}, {z8.d - z11.d}  // 11000001-11101000-10111010-00110101
// CHECK-INST: urshl   { z20.d - z23.d }, { z20.d - z23.d }, { z8.d - z11.d }
// CHECK-ENCODING: [0x35,0xba,0xe8,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1e8ba35 <unknown>

urshl   {z28.d - z31.d}, {z28.d - z31.d}, {z28.d - z31.d}  // 11000001-11111100-10111010-00111101
// CHECK-INST: urshl   { z28.d - z31.d }, { z28.d - z31.d }, { z28.d - z31.d }
// CHECK-ENCODING: [0x3d,0xba,0xfc,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c1fcba3d <unknown>


urshl   {z0.b - z3.b}, {z0.b - z3.b}, z0.b  // 11000001-00100000-10101010-00100001
// CHECK-INST: urshl   { z0.b - z3.b }, { z0.b - z3.b }, z0.b
// CHECK-ENCODING: [0x21,0xaa,0x20,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c120aa21 <unknown>

urshl   {z20.b - z23.b}, {z20.b - z23.b}, z5.b  // 11000001-00100101-10101010-00110101
// CHECK-INST: urshl   { z20.b - z23.b }, { z20.b - z23.b }, z5.b
// CHECK-ENCODING: [0x35,0xaa,0x25,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c125aa35 <unknown>

urshl   {z20.b - z23.b}, {z20.b - z23.b}, z8.b  // 11000001-00101000-10101010-00110101
// CHECK-INST: urshl   { z20.b - z23.b }, { z20.b - z23.b }, z8.b
// CHECK-ENCODING: [0x35,0xaa,0x28,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c128aa35 <unknown>

urshl   {z28.b - z31.b}, {z28.b - z31.b}, z15.b  // 11000001-00101111-10101010-00111101
// CHECK-INST: urshl   { z28.b - z31.b }, { z28.b - z31.b }, z15.b
// CHECK-ENCODING: [0x3d,0xaa,0x2f,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c12faa3d <unknown>


urshl   {z0.b - z3.b}, {z0.b - z3.b}, {z0.b - z3.b}  // 11000001-00100000-10111010-00100001
// CHECK-INST: urshl   { z0.b - z3.b }, { z0.b - z3.b }, { z0.b - z3.b }
// CHECK-ENCODING: [0x21,0xba,0x20,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c120ba21 <unknown>

urshl   {z20.b - z23.b}, {z20.b - z23.b}, {z20.b - z23.b}  // 11000001-00110100-10111010-00110101
// CHECK-INST: urshl   { z20.b - z23.b }, { z20.b - z23.b }, { z20.b - z23.b }
// CHECK-ENCODING: [0x35,0xba,0x34,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c134ba35 <unknown>

urshl   {z20.b - z23.b}, {z20.b - z23.b}, {z8.b - z11.b}  // 11000001-00101000-10111010-00110101
// CHECK-INST: urshl   { z20.b - z23.b }, { z20.b - z23.b }, { z8.b - z11.b }
// CHECK-ENCODING: [0x35,0xba,0x28,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c128ba35 <unknown>

urshl   {z28.b - z31.b}, {z28.b - z31.b}, {z28.b - z31.b}  // 11000001-00111100-10111010-00111101
// CHECK-INST: urshl   { z28.b - z31.b }, { z28.b - z31.b }, { z28.b - z31.b }
// CHECK-ENCODING: [0x3d,0xba,0x3c,0xc1]
// CHECK-ERROR: instruction requires: sme2
// CHECK-UNKNOWN: c13cba3d <unknown>


