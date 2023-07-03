# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -instruction-tables < %s | FileCheck %s

vpopcntb        %zmm1, %zmm0
vpopcntb        (%rdi), %zmm0
vpopcntb        %zmm1, %zmm0 {%k1}
vpopcntb        (%rdi), %zmm0 {%k1}
vpopcntb        %zmm1, %zmm0 {%k1} {z}
vpopcntb        (%rdi), %zmm0 {%k1} {z}

vpopcntw        %zmm1, %zmm0
vpopcntw        (%rdi), %zmm0
vpopcntw        %zmm1, %zmm0 {%k1}
vpopcntw        (%rdi), %zmm0 {%k1}
vpopcntw        %zmm1, %zmm0 {%k1} {z}
vpopcntw        (%rdi), %zmm0 {%k1} {z}

vpshufbitqmb    %zmm16, %zmm17, %k2
vpshufbitqmb    (%rdi), %zmm17, %k2
vpshufbitqmb    %zmm16, %zmm17, %k2 {%k1}
vpshufbitqmb    (%rdi), %zmm17, %k2 {%k1}

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        vpopcntb	%zmm1, %zmm0
# CHECK-NEXT:  2      8     0.50    *                   vpopcntb	(%rdi), %zmm0
# CHECK-NEXT:  1      1     0.50                        vpopcntb	%zmm1, %zmm0 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpopcntb	(%rdi), %zmm0 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpopcntb	%zmm1, %zmm0 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpopcntb	(%rdi), %zmm0 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpopcntw	%zmm1, %zmm0
# CHECK-NEXT:  2      8     0.50    *                   vpopcntw	(%rdi), %zmm0
# CHECK-NEXT:  1      1     0.50                        vpopcntw	%zmm1, %zmm0 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpopcntw	(%rdi), %zmm0 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpopcntw	%zmm1, %zmm0 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpopcntw	(%rdi), %zmm0 {%k1} {z}
# CHECK-NEXT:  1      5     1.00                        vpshufbitqmb	%zmm16, %zmm17, %k2
# CHECK-NEXT:  2      12    1.00    *                   vpshufbitqmb	(%rdi), %zmm17, %k2
# CHECK-NEXT:  1      5     1.00                        vpshufbitqmb	%zmm16, %zmm17, %k2 {%k1}
# CHECK-NEXT:  2      12    1.00    *                   vpshufbitqmb	(%rdi), %zmm17, %k2 {%k1}

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -     4.00   6.00    -     6.00   4.00   4.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpopcntb	%zmm1, %zmm0
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpopcntb	(%rdi), %zmm0
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpopcntb	%zmm1, %zmm0 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpopcntb	(%rdi), %zmm0 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpopcntb	%zmm1, %zmm0 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpopcntb	(%rdi), %zmm0 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpopcntw	%zmm1, %zmm0
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpopcntw	(%rdi), %zmm0
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpopcntw	%zmm1, %zmm0 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpopcntw	(%rdi), %zmm0 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpopcntw	%zmm1, %zmm0 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpopcntw	(%rdi), %zmm0 {%k1} {z}
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -     vpshufbitqmb	%zmm16, %zmm17, %k2
# CHECK-NEXT:  -      -     1.00    -      -      -     0.50   0.50   vpshufbitqmb	(%rdi), %zmm17, %k2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -     vpshufbitqmb	%zmm16, %zmm17, %k2 {%k1}
# CHECK-NEXT:  -      -     1.00    -      -      -     0.50   0.50   vpshufbitqmb	(%rdi), %zmm17, %k2 {%k1}
