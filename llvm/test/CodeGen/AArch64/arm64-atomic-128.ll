; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -mcpu=cyclone | FileCheck %s -check-prefixes=NOOUTLINE
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -mcpu=cyclone -mattr=+outline-atomics | FileCheck %s -check-prefixes=OUTLINE
; RUN: llc < %s -mtriple=arm64-linux-gnu -verify-machineinstrs -mcpu=cyclone -mattr=+lse | FileCheck %s -check-prefixes=LSE

@var = global i128 0

define i128 @val_compare_and_swap(ptr %p, i128 %oldval, i128 %newval) {
; NOOUTLINE-LABEL: val_compare_and_swap:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB0_1: // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x8, x1, [x0]
; NOOUTLINE-NEXT:    cmp x8, x2
; NOOUTLINE-NEXT:    cset w9, ne
; NOOUTLINE-NEXT:    cmp x1, x3
; NOOUTLINE-NEXT:    cinc w9, w9, ne
; NOOUTLINE-NEXT:    cbz w9, .LBB0_3
; NOOUTLINE-NEXT:  // %bb.2: // in Loop: Header=BB0_1 Depth=1
; NOOUTLINE-NEXT:    stxp w9, x8, x1, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB0_1
; NOOUTLINE-NEXT:    b .LBB0_4
; NOOUTLINE-NEXT:  .LBB0_3: // in Loop: Header=BB0_1 Depth=1
; NOOUTLINE-NEXT:    stxp w9, x4, x5, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB0_1
; NOOUTLINE-NEXT:  .LBB0_4:
; NOOUTLINE-NEXT:    mov x0, x8
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: val_compare_and_swap:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; OUTLINE-NEXT:    .cfi_def_cfa_offset 16
; OUTLINE-NEXT:    .cfi_offset w30, -16
; OUTLINE-NEXT:    mov x1, x3
; OUTLINE-NEXT:    mov x8, x0
; OUTLINE-NEXT:    mov x0, x2
; OUTLINE-NEXT:    mov x2, x4
; OUTLINE-NEXT:    mov x3, x5
; OUTLINE-NEXT:    mov x4, x8
; OUTLINE-NEXT:    bl __aarch64_cas16_acq
; OUTLINE-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: val_compare_and_swap:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; LSE-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; LSE-NEXT:    caspa x2, x3, x4, x5, [x0]
; LSE-NEXT:    mov x0, x2
; LSE-NEXT:    mov x1, x3
; LSE-NEXT:    ret
  %pair = cmpxchg ptr %p, i128 %oldval, i128 %newval acquire acquire
  %val = extractvalue { i128, i1 } %pair, 0
  ret i128 %val
}

define i128 @val_compare_and_swap_seqcst(ptr %p, i128 %oldval, i128 %newval) {
; NOOUTLINE-LABEL: val_compare_and_swap_seqcst:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB1_1: // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x8, x1, [x0]
; NOOUTLINE-NEXT:    cmp x8, x2
; NOOUTLINE-NEXT:    cset w9, ne
; NOOUTLINE-NEXT:    cmp x1, x3
; NOOUTLINE-NEXT:    cinc w9, w9, ne
; NOOUTLINE-NEXT:    cbz w9, .LBB1_3
; NOOUTLINE-NEXT:  // %bb.2: // in Loop: Header=BB1_1 Depth=1
; NOOUTLINE-NEXT:    stlxp w9, x8, x1, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB1_1
; NOOUTLINE-NEXT:    b .LBB1_4
; NOOUTLINE-NEXT:  .LBB1_3: // in Loop: Header=BB1_1 Depth=1
; NOOUTLINE-NEXT:    stlxp w9, x4, x5, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB1_1
; NOOUTLINE-NEXT:  .LBB1_4:
; NOOUTLINE-NEXT:    mov x0, x8
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: val_compare_and_swap_seqcst:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; OUTLINE-NEXT:    .cfi_def_cfa_offset 16
; OUTLINE-NEXT:    .cfi_offset w30, -16
; OUTLINE-NEXT:    mov x1, x3
; OUTLINE-NEXT:    mov x8, x0
; OUTLINE-NEXT:    mov x0, x2
; OUTLINE-NEXT:    mov x2, x4
; OUTLINE-NEXT:    mov x3, x5
; OUTLINE-NEXT:    mov x4, x8
; OUTLINE-NEXT:    bl __aarch64_cas16_acq_rel
; OUTLINE-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: val_compare_and_swap_seqcst:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; LSE-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; LSE-NEXT:    caspal x2, x3, x4, x5, [x0]
; LSE-NEXT:    mov x0, x2
; LSE-NEXT:    mov x1, x3
; LSE-NEXT:    ret
  %pair = cmpxchg ptr %p, i128 %oldval, i128 %newval seq_cst seq_cst
  %val = extractvalue { i128, i1 } %pair, 0
  ret i128 %val
}

define i128 @val_compare_and_swap_release(ptr %p, i128 %oldval, i128 %newval) {
; NOOUTLINE-LABEL: val_compare_and_swap_release:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB2_1: // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp x8, x1, [x0]
; NOOUTLINE-NEXT:    cmp x8, x2
; NOOUTLINE-NEXT:    cset w9, ne
; NOOUTLINE-NEXT:    cmp x1, x3
; NOOUTLINE-NEXT:    cinc w9, w9, ne
; NOOUTLINE-NEXT:    cbz w9, .LBB2_3
; NOOUTLINE-NEXT:  // %bb.2: // in Loop: Header=BB2_1 Depth=1
; NOOUTLINE-NEXT:    stlxp w9, x8, x1, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB2_1
; NOOUTLINE-NEXT:    b .LBB2_4
; NOOUTLINE-NEXT:  .LBB2_3: // in Loop: Header=BB2_1 Depth=1
; NOOUTLINE-NEXT:    stlxp w9, x4, x5, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB2_1
; NOOUTLINE-NEXT:  .LBB2_4:
; NOOUTLINE-NEXT:    mov x0, x8
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: val_compare_and_swap_release:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; OUTLINE-NEXT:    .cfi_def_cfa_offset 16
; OUTLINE-NEXT:    .cfi_offset w30, -16
; OUTLINE-NEXT:    mov x1, x3
; OUTLINE-NEXT:    mov x8, x0
; OUTLINE-NEXT:    mov x0, x2
; OUTLINE-NEXT:    mov x2, x4
; OUTLINE-NEXT:    mov x3, x5
; OUTLINE-NEXT:    mov x4, x8
; OUTLINE-NEXT:    bl __aarch64_cas16_rel
; OUTLINE-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: val_compare_and_swap_release:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; LSE-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; LSE-NEXT:    caspl x2, x3, x4, x5, [x0]
; LSE-NEXT:    mov x0, x2
; LSE-NEXT:    mov x1, x3
; LSE-NEXT:    ret
  %pair = cmpxchg ptr %p, i128 %oldval, i128 %newval release monotonic
  %val = extractvalue { i128, i1 } %pair, 0
  ret i128 %val
}

define i128 @val_compare_and_swap_monotonic(ptr %p, i128 %oldval, i128 %newval) {
; NOOUTLINE-LABEL: val_compare_and_swap_monotonic:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB3_1: // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp x8, x1, [x0]
; NOOUTLINE-NEXT:    cmp x8, x2
; NOOUTLINE-NEXT:    cset w9, ne
; NOOUTLINE-NEXT:    cmp x1, x3
; NOOUTLINE-NEXT:    cinc w9, w9, ne
; NOOUTLINE-NEXT:    cbz w9, .LBB3_3
; NOOUTLINE-NEXT:  // %bb.2: // in Loop: Header=BB3_1 Depth=1
; NOOUTLINE-NEXT:    stxp w9, x8, x1, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB3_1
; NOOUTLINE-NEXT:    b .LBB3_4
; NOOUTLINE-NEXT:  .LBB3_3: // in Loop: Header=BB3_1 Depth=1
; NOOUTLINE-NEXT:    stxp w9, x4, x5, [x0]
; NOOUTLINE-NEXT:    cbnz w9, .LBB3_1
; NOOUTLINE-NEXT:  .LBB3_4:
; NOOUTLINE-NEXT:    mov x0, x8
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: val_compare_and_swap_monotonic:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; OUTLINE-NEXT:    .cfi_def_cfa_offset 16
; OUTLINE-NEXT:    .cfi_offset w30, -16
; OUTLINE-NEXT:    mov x1, x3
; OUTLINE-NEXT:    mov x8, x0
; OUTLINE-NEXT:    mov x0, x2
; OUTLINE-NEXT:    mov x2, x4
; OUTLINE-NEXT:    mov x3, x5
; OUTLINE-NEXT:    mov x4, x8
; OUTLINE-NEXT:    bl __aarch64_cas16_relax
; OUTLINE-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: val_compare_and_swap_monotonic:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; LSE-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; LSE-NEXT:    casp x2, x3, x4, x5, [x0]
; LSE-NEXT:    mov x0, x2
; LSE-NEXT:    mov x1, x3
; LSE-NEXT:    ret
  %pair = cmpxchg ptr %p, i128 %oldval, i128 %newval monotonic monotonic
  %val = extractvalue { i128, i1 } %pair, 0
  ret i128 %val
}

define void @fetch_and_nand(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_nand:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB4_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp x9, x8, [x0]
; NOOUTLINE-NEXT:    and x10, x9, x2
; NOOUTLINE-NEXT:    and x11, x8, x3
; NOOUTLINE-NEXT:    mvn x11, x11
; NOOUTLINE-NEXT:    mvn x10, x10
; NOOUTLINE-NEXT:    stlxp w12, x10, x11, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB4_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_nand:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB4_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldxp x9, x8, [x0]
; OUTLINE-NEXT:    and x10, x9, x2
; OUTLINE-NEXT:    and x11, x8, x3
; OUTLINE-NEXT:    mvn x11, x11
; OUTLINE-NEXT:    mvn x10, x10
; OUTLINE-NEXT:    stlxp w12, x10, x11, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB4_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_nand:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB4_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    and x8, x7, x3
; LSE-NEXT:    and x9, x4, x2
; LSE-NEXT:    mvn x10, x9
; LSE-NEXT:    mvn x11, x8
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspl x4, x5, x10, x11, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB4_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret

  %val = atomicrmw nand ptr %p, i128 %bits release
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_or(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_or:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB5_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    orr x10, x8, x3
; NOOUTLINE-NEXT:    orr x11, x9, x2
; NOOUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB5_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_or:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB5_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    orr x10, x8, x3
; OUTLINE-NEXT:    orr x11, x9, x2
; OUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB5_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_or:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB5_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    orr x8, x4, x2
; LSE-NEXT:    orr x9, x7, x3
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB5_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret

  %val = atomicrmw or ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_add(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_add:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB6_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    adds x10, x9, x2
; NOOUTLINE-NEXT:    adc x11, x8, x3
; NOOUTLINE-NEXT:    stlxp w12, x10, x11, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB6_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_add:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB6_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    adds x10, x9, x2
; OUTLINE-NEXT:    adc x11, x8, x3
; OUTLINE-NEXT:    stlxp w12, x10, x11, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB6_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_add:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB6_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    adds x8, x4, x2
; LSE-NEXT:    adc x9, x7, x3
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB6_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret
  %val = atomicrmw add ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_sub(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_sub:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB7_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    subs x10, x9, x2
; NOOUTLINE-NEXT:    sbc x11, x8, x3
; NOOUTLINE-NEXT:    stlxp w12, x10, x11, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB7_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_sub:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB7_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    subs x10, x9, x2
; OUTLINE-NEXT:    sbc x11, x8, x3
; OUTLINE-NEXT:    stlxp w12, x10, x11, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB7_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_sub:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB7_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    subs x8, x4, x2
; LSE-NEXT:    sbc x9, x7, x3
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB7_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret
  %val = atomicrmw sub ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_min(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_min:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB8_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    cmp x2, x9
; NOOUTLINE-NEXT:    sbcs xzr, x3, x8
; NOOUTLINE-NEXT:    csel x10, x8, x3, ge
; NOOUTLINE-NEXT:    csel x11, x9, x2, ge
; NOOUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB8_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_min:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB8_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    cmp x2, x9
; OUTLINE-NEXT:    sbcs xzr, x3, x8
; OUTLINE-NEXT:    csel x10, x8, x3, ge
; OUTLINE-NEXT:    csel x11, x9, x2, ge
; OUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB8_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_min:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB8_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    cmp x2, x4
; LSE-NEXT:    sbcs xzr, x3, x7
; LSE-NEXT:    csel x9, x7, x3, ge
; LSE-NEXT:    csel x8, x4, x2, ge
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB8_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret
  %val = atomicrmw min ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_max(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_max:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB9_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    cmp x2, x9
; NOOUTLINE-NEXT:    sbcs xzr, x3, x8
; NOOUTLINE-NEXT:    csel x10, x8, x3, lt
; NOOUTLINE-NEXT:    csel x11, x9, x2, lt
; NOOUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB9_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_max:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB9_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    cmp x2, x9
; OUTLINE-NEXT:    sbcs xzr, x3, x8
; OUTLINE-NEXT:    csel x10, x8, x3, lt
; OUTLINE-NEXT:    csel x11, x9, x2, lt
; OUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB9_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_max:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB9_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    cmp x2, x4
; LSE-NEXT:    sbcs xzr, x3, x7
; LSE-NEXT:    csel x9, x7, x3, lt
; LSE-NEXT:    csel x8, x4, x2, lt
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB9_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret
  %val = atomicrmw max ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_umin(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_umin:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB10_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    cmp x2, x9
; NOOUTLINE-NEXT:    sbcs xzr, x3, x8
; NOOUTLINE-NEXT:    csel x10, x8, x3, hs
; NOOUTLINE-NEXT:    csel x11, x9, x2, hs
; NOOUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB10_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_umin:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB10_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    cmp x2, x9
; OUTLINE-NEXT:    sbcs xzr, x3, x8
; OUTLINE-NEXT:    csel x10, x8, x3, hs
; OUTLINE-NEXT:    csel x11, x9, x2, hs
; OUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB10_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_umin:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB10_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    cmp x2, x4
; LSE-NEXT:    sbcs xzr, x3, x7
; LSE-NEXT:    csel x9, x7, x3, hs
; LSE-NEXT:    csel x8, x4, x2, hs
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB10_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret
  %val = atomicrmw umin ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define void @fetch_and_umax(ptr %p, i128 %bits) {
; NOOUTLINE-LABEL: fetch_and_umax:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB11_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x9, x8, [x0]
; NOOUTLINE-NEXT:    cmp x2, x9
; NOOUTLINE-NEXT:    sbcs xzr, x3, x8
; NOOUTLINE-NEXT:    csel x10, x8, x3, lo
; NOOUTLINE-NEXT:    csel x11, x9, x2, lo
; NOOUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; NOOUTLINE-NEXT:    cbnz w12, .LBB11_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    adrp x10, :got:var
; NOOUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; NOOUTLINE-NEXT:    stp x9, x8, [x10]
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: fetch_and_umax:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB11_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x9, x8, [x0]
; OUTLINE-NEXT:    cmp x2, x9
; OUTLINE-NEXT:    sbcs xzr, x3, x8
; OUTLINE-NEXT:    csel x10, x8, x3, lo
; OUTLINE-NEXT:    csel x11, x9, x2, lo
; OUTLINE-NEXT:    stlxp w12, x11, x10, [x0]
; OUTLINE-NEXT:    cbnz w12, .LBB11_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    adrp x10, :got:var
; OUTLINE-NEXT:    ldr x10, [x10, :got_lo12:var]
; OUTLINE-NEXT:    stp x9, x8, [x10]
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: fetch_and_umax:
; LSE:       // %bb.0:
; LSE-NEXT:    ldp x4, x5, [x0]
; LSE-NEXT:  .LBB11_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    cmp x2, x4
; LSE-NEXT:    sbcs xzr, x3, x7
; LSE-NEXT:    csel x9, x7, x3, lo
; LSE-NEXT:    csel x8, x4, x2, lo
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    caspal x4, x5, x8, x9, [x0]
; LSE-NEXT:    cmp x5, x7
; LSE-NEXT:    ccmp x4, x6, #0, eq
; LSE-NEXT:    b.ne .LBB11_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    adrp x8, :got:var
; LSE-NEXT:    ldr x8, [x8, :got_lo12:var]
; LSE-NEXT:    stp x4, x5, [x8]
; LSE-NEXT:    ret
  %val = atomicrmw umax ptr %p, i128 %bits seq_cst
  store i128 %val, ptr @var, align 16
  ret void
}

define i128 @atomic_load_seq_cst(ptr %p) {
; NOOUTLINE-LABEL: atomic_load_seq_cst:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:    mov x8, x0
; NOOUTLINE-NEXT:  .LBB12_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp x0, x1, [x8]
; NOOUTLINE-NEXT:    stlxp w9, x0, x1, [x8]
; NOOUTLINE-NEXT:    cbnz w9, .LBB12_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: atomic_load_seq_cst:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:    mov x8, x0
; OUTLINE-NEXT:  .LBB12_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp x0, x1, [x8]
; OUTLINE-NEXT:    stlxp w9, x0, x1, [x8]
; OUTLINE-NEXT:    cbnz w9, .LBB12_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: atomic_load_seq_cst:
; LSE:       // %bb.0:
; LSE-NEXT:    mov x2, #0
; LSE-NEXT:    mov x3, #0
; LSE-NEXT:    caspal x2, x3, x2, x3, [x0]
; LSE-NEXT:    mov x0, x2
; LSE-NEXT:    mov x1, x3
; LSE-NEXT:    ret
   %r = load atomic i128, ptr %p seq_cst, align 16
   ret i128 %r
}

define i128 @atomic_load_relaxed(i64, i64, ptr %p) {
; NOOUTLINE-LABEL: atomic_load_relaxed:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB13_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp x0, x1, [x2]
; NOOUTLINE-NEXT:    stxp w8, x0, x1, [x2]
; NOOUTLINE-NEXT:    cbnz w8, .LBB13_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: atomic_load_relaxed:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB13_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldxp x0, x1, [x2]
; OUTLINE-NEXT:    stxp w8, x0, x1, [x2]
; OUTLINE-NEXT:    cbnz w8, .LBB13_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: atomic_load_relaxed:
; LSE:       // %bb.0:
; LSE-NEXT:    mov x0, #0
; LSE-NEXT:    mov x1, #0
; LSE-NEXT:    casp x0, x1, x0, x1, [x2]
; LSE-NEXT:    ret
    %r = load atomic i128, ptr %p monotonic, align 16
    ret i128 %r
}


define void @atomic_store_seq_cst(i128 %in, ptr %p) {
; NOOUTLINE-LABEL: atomic_store_seq_cst:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB14_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldaxp xzr, x8, [x2]
; NOOUTLINE-NEXT:    stlxp w8, x0, x1, [x2]
; NOOUTLINE-NEXT:    cbnz w8, .LBB14_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: atomic_store_seq_cst:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB14_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldaxp xzr, x8, [x2]
; OUTLINE-NEXT:    stlxp w8, x0, x1, [x2]
; OUTLINE-NEXT:    cbnz w8, .LBB14_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: atomic_store_seq_cst:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x1 killed $x1 killed $x0_x1 def $x0_x1
; LSE-NEXT:    ldp x4, x5, [x2]
; LSE-NEXT:    // kill: def $x0 killed $x0 killed $x0_x1 def $x0_x1
; LSE-NEXT:  .LBB14_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    caspal x6, x7, x0, x1, [x2]
; LSE-NEXT:    cmp x7, x5
; LSE-NEXT:    ccmp x6, x4, #0, eq
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    b.ne .LBB14_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    ret
   store atomic i128 %in, ptr %p seq_cst, align 16
   ret void
}

define void @atomic_store_release(i128 %in, ptr %p) {
; NOOUTLINE-LABEL: atomic_store_release:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB15_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp xzr, x8, [x2]
; NOOUTLINE-NEXT:    stlxp w8, x0, x1, [x2]
; NOOUTLINE-NEXT:    cbnz w8, .LBB15_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: atomic_store_release:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB15_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldxp xzr, x8, [x2]
; OUTLINE-NEXT:    stlxp w8, x0, x1, [x2]
; OUTLINE-NEXT:    cbnz w8, .LBB15_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: atomic_store_release:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x1 killed $x1 killed $x0_x1 def $x0_x1
; LSE-NEXT:    ldp x4, x5, [x2]
; LSE-NEXT:    // kill: def $x0 killed $x0 killed $x0_x1 def $x0_x1
; LSE-NEXT:  .LBB15_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    caspl x6, x7, x0, x1, [x2]
; LSE-NEXT:    cmp x7, x5
; LSE-NEXT:    ccmp x6, x4, #0, eq
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    b.ne .LBB15_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    ret
   store atomic i128 %in, ptr %p release, align 16
   ret void
}

define void @atomic_store_relaxed(i128 %in, ptr %p) {
; NOOUTLINE-LABEL: atomic_store_relaxed:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB16_1: // %atomicrmw.start
; NOOUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp xzr, x8, [x2]
; NOOUTLINE-NEXT:    stxp w8, x0, x1, [x2]
; NOOUTLINE-NEXT:    cbnz w8, .LBB16_1
; NOOUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: atomic_store_relaxed:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:  .LBB16_1: // %atomicrmw.start
; OUTLINE-NEXT:    // =>This Inner Loop Header: Depth=1
; OUTLINE-NEXT:    ldxp xzr, x8, [x2]
; OUTLINE-NEXT:    stxp w8, x0, x1, [x2]
; OUTLINE-NEXT:    cbnz w8, .LBB16_1
; OUTLINE-NEXT:  // %bb.2: // %atomicrmw.end
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: atomic_store_relaxed:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x1 killed $x1 killed $x0_x1 def $x0_x1
; LSE-NEXT:    ldp x4, x5, [x2]
; LSE-NEXT:    // kill: def $x0 killed $x0 killed $x0_x1 def $x0_x1
; LSE-NEXT:  .LBB16_1: // %atomicrmw.start
; LSE-NEXT:    // =>This Inner Loop Header: Depth=1
; LSE-NEXT:    mov x6, x4
; LSE-NEXT:    mov x7, x5
; LSE-NEXT:    casp x6, x7, x0, x1, [x2]
; LSE-NEXT:    cmp x7, x5
; LSE-NEXT:    ccmp x6, x4, #0, eq
; LSE-NEXT:    mov x4, x6
; LSE-NEXT:    mov x5, x7
; LSE-NEXT:    b.ne .LBB16_1
; LSE-NEXT:  // %bb.2: // %atomicrmw.end
; LSE-NEXT:    ret
   store atomic i128 %in, ptr %p unordered, align 16
   ret void
}

; Since we store the original value to ensure no tearing for the unsuccessful
; case, the register used must not be xzr.
define void @cmpxchg_dead(ptr %ptr, i128 %desired, i128 %new) {
; NOOUTLINE-LABEL: cmpxchg_dead:
; NOOUTLINE:       // %bb.0:
; NOOUTLINE-NEXT:  .LBB17_1: // =>This Inner Loop Header: Depth=1
; NOOUTLINE-NEXT:    ldxp x8, x9, [x0]
; NOOUTLINE-NEXT:    cmp x8, x2
; NOOUTLINE-NEXT:    cset w10, ne
; NOOUTLINE-NEXT:    cmp x9, x3
; NOOUTLINE-NEXT:    cinc w10, w10, ne
; NOOUTLINE-NEXT:    cbz w10, .LBB17_3
; NOOUTLINE-NEXT:  // %bb.2: // in Loop: Header=BB17_1 Depth=1
; NOOUTLINE-NEXT:    stxp w10, x8, x9, [x0]
; NOOUTLINE-NEXT:    cbnz w10, .LBB17_1
; NOOUTLINE-NEXT:    b .LBB17_4
; NOOUTLINE-NEXT:  .LBB17_3: // in Loop: Header=BB17_1 Depth=1
; NOOUTLINE-NEXT:    stxp w10, x4, x5, [x0]
; NOOUTLINE-NEXT:    cbnz w10, .LBB17_1
; NOOUTLINE-NEXT:  .LBB17_4:
; NOOUTLINE-NEXT:    ret
;
; OUTLINE-LABEL: cmpxchg_dead:
; OUTLINE:       // %bb.0:
; OUTLINE-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; OUTLINE-NEXT:    .cfi_def_cfa_offset 16
; OUTLINE-NEXT:    .cfi_offset w30, -16
; OUTLINE-NEXT:    mov x1, x3
; OUTLINE-NEXT:    mov x8, x0
; OUTLINE-NEXT:    mov x0, x2
; OUTLINE-NEXT:    mov x2, x4
; OUTLINE-NEXT:    mov x3, x5
; OUTLINE-NEXT:    mov x4, x8
; OUTLINE-NEXT:    bl __aarch64_cas16_relax
; OUTLINE-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; OUTLINE-NEXT:    ret
;
; LSE-LABEL: cmpxchg_dead:
; LSE:       // %bb.0:
; LSE-NEXT:    // kill: def $x5 killed $x5 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x3 killed $x3 killed $x2_x3 def $x2_x3
; LSE-NEXT:    // kill: def $x4 killed $x4 killed $x4_x5 def $x4_x5
; LSE-NEXT:    // kill: def $x2 killed $x2 killed $x2_x3 def $x2_x3
; LSE-NEXT:    casp x2, x3, x4, x5, [x0]
; LSE-NEXT:    ret
  cmpxchg ptr %ptr, i128 %desired, i128 %new monotonic monotonic
  ret void
}
