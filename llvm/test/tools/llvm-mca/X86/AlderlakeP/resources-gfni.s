# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=alderlake -instruction-tables < %s | FileCheck %s

gf2p8affineinvqb    $0, %xmm0, %xmm1
gf2p8affineinvqb    $0, (%rax), %xmm1

gf2p8affineqb       $0, %xmm0, %xmm1
gf2p8affineqb       $0, (%rax), %xmm1

gf2p8mulb           %xmm0, %xmm1
gf2p8mulb           (%rax), %xmm1

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      5     0.50                        gf2p8affineinvqb	$0, %xmm0, %xmm1
# CHECK-NEXT:  2      12    0.50    *                   gf2p8affineinvqb	$0, (%rax), %xmm1
# CHECK-NEXT:  1      5     0.50                        gf2p8affineqb	$0, %xmm0, %xmm1
# CHECK-NEXT:  2      12    0.50    *                   gf2p8affineqb	$0, (%rax), %xmm1
# CHECK-NEXT:  1      5     0.50                        gf2p8mulb	%xmm0, %xmm1
# CHECK-NEXT:  2      12    0.50    *                   gf2p8mulb	(%rax), %xmm1

# CHECK:      Resources:
# CHECK-NEXT: [0]   - ADLPPort00
# CHECK-NEXT: [1]   - ADLPPort01
# CHECK-NEXT: [2]   - ADLPPort02
# CHECK-NEXT: [3]   - ADLPPort03
# CHECK-NEXT: [4]   - ADLPPort04
# CHECK-NEXT: [5]   - ADLPPort05
# CHECK-NEXT: [6]   - ADLPPort06
# CHECK-NEXT: [7]   - ADLPPort07
# CHECK-NEXT: [8]   - ADLPPort08
# CHECK-NEXT: [9]   - ADLPPort09
# CHECK-NEXT: [10]  - ADLPPort10
# CHECK-NEXT: [11]  - ADLPPort11
# CHECK-NEXT: [12]  - ADLPPortInvalid

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]
# CHECK-NEXT: 3.00   3.00   1.00   1.00    -      -      -      -      -      -      -     1.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     gf2p8affineinvqb	$0, %xmm0, %xmm1
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -      -     0.33    -     gf2p8affineinvqb	$0, (%rax), %xmm1
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     gf2p8affineqb	$0, %xmm0, %xmm1
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -      -     0.33    -     gf2p8affineqb	$0, (%rax), %xmm1
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     gf2p8mulb	%xmm0, %xmm1
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -      -     0.33    -     gf2p8mulb	(%rax), %xmm1
