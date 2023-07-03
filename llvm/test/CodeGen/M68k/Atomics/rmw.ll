; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68000 | FileCheck %s --check-prefix=NO-ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68010 | FileCheck %s --check-prefix=NO-ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68020 | FileCheck %s --check-prefix=ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68030 | FileCheck %s --check-prefix=ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68040 | FileCheck %s --check-prefix=ATOMIC

define i8 @atomicrmw_add_i8(i8 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_add_i8:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.b (19,%sp), %d0
; NO-ATOMIC-NEXT:    and.l #255, %d0
; NO-ATOMIC-NEXT:    move.l %d0, (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_add_1@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_add_i8:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.b (15,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.b (%a0), %d2
; ATOMIC-NEXT:    move.b %d2, %d0
; ATOMIC-NEXT:  .LBB0_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.b %d2, %d3
; ATOMIC-NEXT:    add.b %d1, %d3
; ATOMIC-NEXT:    cas.b %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.b %d0, %d3
; ATOMIC-NEXT:    sub.b %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.b %d0, %d2
; ATOMIC-NEXT:    bne .LBB0_1
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw add ptr %ptr, i8 %val monotonic
  ret i8 %old
}

define i16 @atomicrmw_sub_i16(i16 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_sub_i16:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.w (18,%sp), %d0
; NO-ATOMIC-NEXT:    and.l #65535, %d0
; NO-ATOMIC-NEXT:    move.l %d0, (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_sub_2@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_sub_i16:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.w (14,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.w (%a0), %d2
; ATOMIC-NEXT:    move.w %d2, %d0
; ATOMIC-NEXT:  .LBB1_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.w %d2, %d3
; ATOMIC-NEXT:    sub.w %d1, %d3
; ATOMIC-NEXT:    cas.w %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.w %d0, %d3
; ATOMIC-NEXT:    sub.w %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.w %d0, %d2
; ATOMIC-NEXT:    bne .LBB1_1
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw sub ptr %ptr, i16 %val acquire
  ret i16 %old
}

define i32 @atomicrmw_and_i32(i32 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_and_i32:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.l (16,%sp), (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_and_4@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_and_i32:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.l (12,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.l (%a0), %d2
; ATOMIC-NEXT:    move.l %d2, %d0
; ATOMIC-NEXT:  .LBB2_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.l %d2, %d3
; ATOMIC-NEXT:    and.l %d1, %d3
; ATOMIC-NEXT:    cas.l %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.l %d0, %d3
; ATOMIC-NEXT:    sub.l %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.l %d0, %d2
; ATOMIC-NEXT:    bne .LBB2_1
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw and ptr %ptr, i32 %val seq_cst
  ret i32 %old
}

define i64 @atomicrmw_xor_i64(i64 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_xor_i64:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #20, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -24
; NO-ATOMIC-NEXT:    move.l #3, (12,%sp)
; NO-ATOMIC-NEXT:    move.l (28,%sp), (8,%sp)
; NO-ATOMIC-NEXT:    move.l (24,%sp), (4,%sp)
; NO-ATOMIC-NEXT:    move.l (32,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __atomic_fetch_xor_8@PLT
; NO-ATOMIC-NEXT:    adda.l #20, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_xor_i64:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #20, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -24
; ATOMIC-NEXT:    move.l #3, (12,%sp)
; ATOMIC-NEXT:    move.l (28,%sp), (8,%sp)
; ATOMIC-NEXT:    move.l (24,%sp), (4,%sp)
; ATOMIC-NEXT:    move.l (32,%sp), (%sp)
; ATOMIC-NEXT:    jsr __atomic_fetch_xor_8@PLT
; ATOMIC-NEXT:    adda.l #20, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw xor ptr %ptr, i64 %val release
  ret i64 %old
}

define i8 @atomicrmw_or_i8(i8 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_or_i8:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.b (19,%sp), %d0
; NO-ATOMIC-NEXT:    and.l #255, %d0
; NO-ATOMIC-NEXT:    move.l %d0, (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_or_1@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_or_i8:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.b (15,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.b (%a0), %d2
; ATOMIC-NEXT:    move.b %d2, %d0
; ATOMIC-NEXT:  .LBB4_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.b %d2, %d3
; ATOMIC-NEXT:    or.b %d1, %d3
; ATOMIC-NEXT:    cas.b %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.b %d0, %d3
; ATOMIC-NEXT:    sub.b %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.b %d0, %d2
; ATOMIC-NEXT:    bne .LBB4_1
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw or ptr %ptr, i8 %val monotonic
  ret i8 %old
}

define i16 @atmoicrmw_nand_i16(i16 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atmoicrmw_nand_i16:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    movem.l %d2, (8,%sp) ; 8-byte Folded Spill
; NO-ATOMIC-NEXT:    move.w (18,%sp), %d2
; NO-ATOMIC-NEXT:    move.l %d2, %d0
; NO-ATOMIC-NEXT:    and.l #65535, %d0
; NO-ATOMIC-NEXT:    move.l %d0, (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_nand_2@PLT
; NO-ATOMIC-NEXT:    move.w %d2, %d0
; NO-ATOMIC-NEXT:    movem.l (8,%sp), %d2 ; 8-byte Folded Reload
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atmoicrmw_nand_i16:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.w (14,%sp), %d0
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.w (%a0), %d2
; ATOMIC-NEXT:    move.w %d2, %d1
; ATOMIC-NEXT:  .LBB5_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.w %d2, %d3
; ATOMIC-NEXT:    and.w %d0, %d3
; ATOMIC-NEXT:    eori.w #-1, %d3
; ATOMIC-NEXT:    cas.w %d1, %d3, (%a0)
; ATOMIC-NEXT:    move.w %d1, %d3
; ATOMIC-NEXT:    sub.w %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.w %d1, %d2
; ATOMIC-NEXT:    bne .LBB5_1
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw nand ptr %ptr, i16 %val seq_cst
  ret i16 %val
}

define i32 @atomicrmw_min_i32(i32 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_min_i32:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.l (16,%sp), (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_min_4@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_min_i32:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.l (12,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.l (%a0), %d2
; ATOMIC-NEXT:    bra .LBB6_1
; ATOMIC-NEXT:  .LBB6_3: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB6_1 Depth=1
; ATOMIC-NEXT:    move.l %d2, %d0
; ATOMIC-NEXT:    cas.l %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.l %d0, %d3
; ATOMIC-NEXT:    sub.l %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.l %d0, %d2
; ATOMIC-NEXT:    beq .LBB6_4
; ATOMIC-NEXT:  .LBB6_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.l %d2, %d0
; ATOMIC-NEXT:    sub.l %d1, %d0
; ATOMIC-NEXT:    move.l %d2, %d3
; ATOMIC-NEXT:    ble .LBB6_3
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB6_1 Depth=1
; ATOMIC-NEXT:    move.l %d1, %d3
; ATOMIC-NEXT:    bra .LBB6_3
; ATOMIC-NEXT:  .LBB6_4: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw min ptr %ptr, i32 %val acquire
  ret i32 %old
}

define i64 @atomicrmw_max_i64(i64 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_max_i64:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #52, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -56
; NO-ATOMIC-NEXT:    movem.l %d2-%d4/%a2-%a3, (32,%sp) ; 24-byte Folded Spill
; NO-ATOMIC-NEXT:    move.l (60,%sp), %d3
; NO-ATOMIC-NEXT:    move.l (56,%sp), %d4
; NO-ATOMIC-NEXT:    move.l (64,%sp), %a2
; NO-ATOMIC-NEXT:    move.l (4,%a2), %d1
; NO-ATOMIC-NEXT:    move.l (%a2), %d0
; NO-ATOMIC-NEXT:    lea (24,%sp), %a3
; NO-ATOMIC-NEXT:    bra .LBB7_1
; NO-ATOMIC-NEXT:  .LBB7_3: ; %atomicrmw.start
; NO-ATOMIC-NEXT:    ; in Loop: Header=BB7_1 Depth=1
; NO-ATOMIC-NEXT:    move.l %d1, (12,%sp)
; NO-ATOMIC-NEXT:    move.l %d0, (8,%sp)
; NO-ATOMIC-NEXT:    move.l #5, (20,%sp)
; NO-ATOMIC-NEXT:    move.l #5, (16,%sp)
; NO-ATOMIC-NEXT:    jsr __atomic_compare_exchange_8@PLT
; NO-ATOMIC-NEXT:    move.b %d0, %d2
; NO-ATOMIC-NEXT:    move.l (28,%sp), %d1
; NO-ATOMIC-NEXT:    move.l (24,%sp), %d0
; NO-ATOMIC-NEXT:    cmpi.b #0, %d2
; NO-ATOMIC-NEXT:    bne .LBB7_4
; NO-ATOMIC-NEXT:  .LBB7_1: ; %atomicrmw.start
; NO-ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; NO-ATOMIC-NEXT:    move.l %d0, (24,%sp)
; NO-ATOMIC-NEXT:    move.l %d1, (28,%sp)
; NO-ATOMIC-NEXT:    move.l %a2, (%sp)
; NO-ATOMIC-NEXT:    move.l %a3, (4,%sp)
; NO-ATOMIC-NEXT:    move.l %d3, %d2
; NO-ATOMIC-NEXT:    sub.l %d1, %d2
; NO-ATOMIC-NEXT:    move.l %d4, %d2
; NO-ATOMIC-NEXT:    subx.l %d0, %d2
; NO-ATOMIC-NEXT:    slt %d2
; NO-ATOMIC-NEXT:    cmpi.b #0, %d2
; NO-ATOMIC-NEXT:    bne .LBB7_3
; NO-ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.start
; NO-ATOMIC-NEXT:    ; in Loop: Header=BB7_1 Depth=1
; NO-ATOMIC-NEXT:    move.l %d3, %d1
; NO-ATOMIC-NEXT:    move.l %d4, %d0
; NO-ATOMIC-NEXT:    bra .LBB7_3
; NO-ATOMIC-NEXT:  .LBB7_4: ; %atomicrmw.end
; NO-ATOMIC-NEXT:    movem.l (32,%sp), %d2-%d4/%a2-%a3 ; 24-byte Folded Reload
; NO-ATOMIC-NEXT:    adda.l #52, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_max_i64:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #52, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -56
; ATOMIC-NEXT:    movem.l %d2-%d4/%a2-%a3, (32,%sp) ; 24-byte Folded Spill
; ATOMIC-NEXT:    move.l (60,%sp), %d3
; ATOMIC-NEXT:    move.l (56,%sp), %d4
; ATOMIC-NEXT:    move.l (64,%sp), %a2
; ATOMIC-NEXT:    move.l (4,%a2), %d1
; ATOMIC-NEXT:    move.l (%a2), %d0
; ATOMIC-NEXT:    lea (24,%sp), %a3
; ATOMIC-NEXT:    bra .LBB7_1
; ATOMIC-NEXT:  .LBB7_3: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB7_1 Depth=1
; ATOMIC-NEXT:    move.l %d1, (12,%sp)
; ATOMIC-NEXT:    move.l %d0, (8,%sp)
; ATOMIC-NEXT:    move.l #5, (20,%sp)
; ATOMIC-NEXT:    move.l #5, (16,%sp)
; ATOMIC-NEXT:    jsr __atomic_compare_exchange_8@PLT
; ATOMIC-NEXT:    move.b %d0, %d2
; ATOMIC-NEXT:    move.l (28,%sp), %d1
; ATOMIC-NEXT:    move.l (24,%sp), %d0
; ATOMIC-NEXT:    cmpi.b #0, %d2
; ATOMIC-NEXT:    bne .LBB7_4
; ATOMIC-NEXT:  .LBB7_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.l %d0, (24,%sp)
; ATOMIC-NEXT:    move.l %d1, (28,%sp)
; ATOMIC-NEXT:    move.l %a2, (%sp)
; ATOMIC-NEXT:    move.l %a3, (4,%sp)
; ATOMIC-NEXT:    move.l %d3, %d2
; ATOMIC-NEXT:    sub.l %d1, %d2
; ATOMIC-NEXT:    move.l %d4, %d2
; ATOMIC-NEXT:    subx.l %d0, %d2
; ATOMIC-NEXT:    slt %d2
; ATOMIC-NEXT:    cmpi.b #0, %d2
; ATOMIC-NEXT:    bne .LBB7_3
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB7_1 Depth=1
; ATOMIC-NEXT:    move.l %d3, %d1
; ATOMIC-NEXT:    move.l %d4, %d0
; ATOMIC-NEXT:    bra .LBB7_3
; ATOMIC-NEXT:  .LBB7_4: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (32,%sp), %d2-%d4/%a2-%a3 ; 24-byte Folded Reload
; ATOMIC-NEXT:    adda.l #52, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw max ptr %ptr, i64 %val seq_cst
  ret i64 %old
}

define i8 @atomicrmw_i8_umin(i8 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_i8_umin:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.b (19,%sp), %d0
; NO-ATOMIC-NEXT:    and.l #255, %d0
; NO-ATOMIC-NEXT:    move.l %d0, (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_umin_1@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_i8_umin:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.b (15,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.b (%a0), %d2
; ATOMIC-NEXT:    bra .LBB8_1
; ATOMIC-NEXT:  .LBB8_3: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB8_1 Depth=1
; ATOMIC-NEXT:    move.b %d2, %d0
; ATOMIC-NEXT:    cas.b %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.b %d0, %d3
; ATOMIC-NEXT:    sub.b %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.b %d0, %d2
; ATOMIC-NEXT:    beq .LBB8_4
; ATOMIC-NEXT:  .LBB8_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.b %d2, %d0
; ATOMIC-NEXT:    sub.b %d1, %d0
; ATOMIC-NEXT:    move.b %d2, %d3
; ATOMIC-NEXT:    bls .LBB8_3
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB8_1 Depth=1
; ATOMIC-NEXT:    move.b %d1, %d3
; ATOMIC-NEXT:    bra .LBB8_3
; ATOMIC-NEXT:  .LBB8_4: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw umin ptr %ptr, i8 %val release
  ret i8 %old
}

define i16 @atomicrmw_umax_i16(i16 %val, ptr %ptr) {
; NO-ATOMIC-LABEL: atomicrmw_umax_i16:
; NO-ATOMIC:         .cfi_startproc
; NO-ATOMIC-NEXT:  ; %bb.0:
; NO-ATOMIC-NEXT:    suba.l #12, %sp
; NO-ATOMIC-NEXT:    .cfi_def_cfa_offset -16
; NO-ATOMIC-NEXT:    move.w (18,%sp), %d0
; NO-ATOMIC-NEXT:    and.l #65535, %d0
; NO-ATOMIC-NEXT:    move.l %d0, (4,%sp)
; NO-ATOMIC-NEXT:    move.l (20,%sp), (%sp)
; NO-ATOMIC-NEXT:    jsr __sync_fetch_and_umax_2@PLT
; NO-ATOMIC-NEXT:    adda.l #12, %sp
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomicrmw_umax_i16:
; ATOMIC:         .cfi_startproc
; ATOMIC-NEXT:  ; %bb.0:
; ATOMIC-NEXT:    suba.l #8, %sp
; ATOMIC-NEXT:    .cfi_def_cfa_offset -12
; ATOMIC-NEXT:    movem.l %d2-%d3, (0,%sp) ; 12-byte Folded Spill
; ATOMIC-NEXT:    move.w (14,%sp), %d1
; ATOMIC-NEXT:    move.l (16,%sp), %a0
; ATOMIC-NEXT:    move.w (%a0), %d2
; ATOMIC-NEXT:    bra .LBB9_1
; ATOMIC-NEXT:  .LBB9_3: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB9_1 Depth=1
; ATOMIC-NEXT:    move.w %d2, %d0
; ATOMIC-NEXT:    cas.w %d0, %d3, (%a0)
; ATOMIC-NEXT:    move.w %d0, %d3
; ATOMIC-NEXT:    sub.w %d2, %d3
; ATOMIC-NEXT:    seq %d2
; ATOMIC-NEXT:    sub.b #1, %d2
; ATOMIC-NEXT:    move.w %d0, %d2
; ATOMIC-NEXT:    beq .LBB9_4
; ATOMIC-NEXT:  .LBB9_1: ; %atomicrmw.start
; ATOMIC-NEXT:    ; =>This Inner Loop Header: Depth=1
; ATOMIC-NEXT:    move.w %d2, %d0
; ATOMIC-NEXT:    sub.w %d1, %d0
; ATOMIC-NEXT:    move.w %d2, %d3
; ATOMIC-NEXT:    bhi .LBB9_3
; ATOMIC-NEXT:  ; %bb.2: ; %atomicrmw.start
; ATOMIC-NEXT:    ; in Loop: Header=BB9_1 Depth=1
; ATOMIC-NEXT:    move.w %d1, %d3
; ATOMIC-NEXT:    bra .LBB9_3
; ATOMIC-NEXT:  .LBB9_4: ; %atomicrmw.end
; ATOMIC-NEXT:    movem.l (0,%sp), %d2-%d3 ; 12-byte Folded Reload
; ATOMIC-NEXT:    adda.l #8, %sp
; ATOMIC-NEXT:    rts
  %old = atomicrmw umax ptr %ptr, i16 %val seq_cst
  ret i16 %old
}
