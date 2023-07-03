; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=csky -verify-machineinstrs -csky-no-aliases -mattr=+2e3 < %s \
; RUN:   | FileCheck -check-prefix=CSKY %s

define i8 @atomic_load_i8_unordered(i8 *%a) nounwind {
; CSKY-LABEL: atomic_load_i8_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI0_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI0_0:
; CSKY-NEXT:    .long __atomic_load_1
;
  %1 = load atomic i8, i8* %a unordered, align 1
  ret i8 %1
}

define i8 @atomic_load_i8_monotonic(i8 *%a) nounwind {
; CSKY-LABEL: atomic_load_i8_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI1_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI1_0:
; CSKY-NEXT:    .long __atomic_load_1
;
  %1 = load atomic i8, i8* %a monotonic, align 1
  ret i8 %1
}

define i8 @atomic_load_i8_acquire(i8 *%a) nounwind {
; CSKY-LABEL: atomic_load_i8_acquire:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 2
; CSKY-NEXT:    jsri32 [.LCPI2_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI2_0:
; CSKY-NEXT:    .long __atomic_load_1
;
  %1 = load atomic i8, i8* %a acquire, align 1
  ret i8 %1
}

define i8 @atomic_load_i8_seq_cst(i8 *%a) nounwind {
; CSKY-LABEL: atomic_load_i8_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 5
; CSKY-NEXT:    jsri32 [.LCPI3_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI3_0:
; CSKY-NEXT:    .long __atomic_load_1
;
  %1 = load atomic i8, i8* %a seq_cst, align 1
  ret i8 %1
}

define i16 @atomic_load_i16_unordered(i16 *%a) nounwind {
; CSKY-LABEL: atomic_load_i16_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI4_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI4_0:
; CSKY-NEXT:    .long __atomic_load_2
;
  %1 = load atomic i16, i16* %a unordered, align 2
  ret i16 %1
}

define i16 @atomic_load_i16_monotonic(i16 *%a) nounwind {
; CSKY-LABEL: atomic_load_i16_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI5_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI5_0:
; CSKY-NEXT:    .long __atomic_load_2
;
  %1 = load atomic i16, i16* %a monotonic, align 2
  ret i16 %1
}

define i16 @atomic_load_i16_acquire(i16 *%a) nounwind {
; CSKY-LABEL: atomic_load_i16_acquire:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 2
; CSKY-NEXT:    jsri32 [.LCPI6_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI6_0:
; CSKY-NEXT:    .long __atomic_load_2
;
  %1 = load atomic i16, i16* %a acquire, align 2
  ret i16 %1
}

define i16 @atomic_load_i16_seq_cst(i16 *%a) nounwind {
; CSKY-LABEL: atomic_load_i16_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 5
; CSKY-NEXT:    jsri32 [.LCPI7_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI7_0:
; CSKY-NEXT:    .long __atomic_load_2
;
  %1 = load atomic i16, i16* %a seq_cst, align 2
  ret i16 %1
}

define i32 @atomic_load_i32_unordered(i32 *%a) nounwind {
; CSKY-LABEL: atomic_load_i32_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI8_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI8_0:
; CSKY-NEXT:    .long __atomic_load_4
;
  %1 = load atomic i32, i32* %a unordered, align 4
  ret i32 %1
}

define i32 @atomic_load_i32_monotonic(i32 *%a) nounwind {
; CSKY-LABEL: atomic_load_i32_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI9_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI9_0:
; CSKY-NEXT:    .long __atomic_load_4
;
  %1 = load atomic i32, i32* %a monotonic, align 4
  ret i32 %1
}

define i32 @atomic_load_i32_acquire(i32 *%a) nounwind {
; CSKY-LABEL: atomic_load_i32_acquire:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 2
; CSKY-NEXT:    jsri32 [.LCPI10_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI10_0:
; CSKY-NEXT:    .long __atomic_load_4
;
  %1 = load atomic i32, i32* %a acquire, align 4
  ret i32 %1
}

define i32 @atomic_load_i32_seq_cst(i32 *%a) nounwind {
; CSKY-LABEL: atomic_load_i32_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 5
; CSKY-NEXT:    jsri32 [.LCPI11_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI11_0:
; CSKY-NEXT:    .long __atomic_load_4
;
  %1 = load atomic i32, i32* %a seq_cst, align 4
  ret i32 %1
}

define i64 @atomic_load_i64_unordered(i64 *%a) nounwind {
; CSKY-LABEL: atomic_load_i64_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI12_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI12_0:
; CSKY-NEXT:    .long __atomic_load_8
;
  %1 = load atomic i64, i64* %a unordered, align 8
  ret i64 %1
}

define i64 @atomic_load_i64_monotonic(i64 *%a) nounwind {
; CSKY-LABEL: atomic_load_i64_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 0
; CSKY-NEXT:    jsri32 [.LCPI13_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI13_0:
; CSKY-NEXT:    .long __atomic_load_8
;
  %1 = load atomic i64, i64* %a monotonic, align 8
  ret i64 %1
}

define i64 @atomic_load_i64_acquire(i64 *%a) nounwind {
; CSKY-LABEL: atomic_load_i64_acquire:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 2
; CSKY-NEXT:    jsri32 [.LCPI14_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI14_0:
; CSKY-NEXT:    .long __atomic_load_8
;
  %1 = load atomic i64, i64* %a acquire, align 8
  ret i64 %1
}

define i64 @atomic_load_i64_seq_cst(i64 *%a) nounwind {
; CSKY-LABEL: atomic_load_i64_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a1, 5
; CSKY-NEXT:    jsri32 [.LCPI15_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI15_0:
; CSKY-NEXT:    .long __atomic_load_8
;
  %1 = load atomic i64, i64* %a seq_cst, align 8
  ret i64 %1
}

define void @atomic_store_i8_unordered(i8 *%a, i8 %b) nounwind {
; CSKY-LABEL: atomic_store_i8_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 0
; CSKY-NEXT:    jsri32 [.LCPI16_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI16_0:
; CSKY-NEXT:    .long __atomic_store_1
;
  store atomic i8 %b, i8* %a unordered, align 1
  ret void
}

define void @atomic_store_i8_monotonic(i8 *%a, i8 %b) nounwind {
; CSKY-LABEL: atomic_store_i8_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 0
; CSKY-NEXT:    jsri32 [.LCPI17_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI17_0:
; CSKY-NEXT:    .long __atomic_store_1
;
  store atomic i8 %b, i8* %a monotonic, align 1
  ret void
}

define void @atomic_store_i8_release(i8 *%a, i8 %b) nounwind {
; CSKY-LABEL: atomic_store_i8_release:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 3
; CSKY-NEXT:    jsri32 [.LCPI18_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI18_0:
; CSKY-NEXT:    .long __atomic_store_1
;
  store atomic i8 %b, i8* %a release, align 1
  ret void
}

define void @atomic_store_i8_seq_cst(i8 *%a, i8 %b) nounwind {
; CSKY-LABEL: atomic_store_i8_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 5
; CSKY-NEXT:    jsri32 [.LCPI19_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI19_0:
; CSKY-NEXT:    .long __atomic_store_1
;
  store atomic i8 %b, i8* %a seq_cst, align 1
  ret void
}

define void @atomic_store_i16_unordered(i16 *%a, i16 %b) nounwind {
; CSKY-LABEL: atomic_store_i16_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 0
; CSKY-NEXT:    jsri32 [.LCPI20_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI20_0:
; CSKY-NEXT:    .long __atomic_store_2
;
  store atomic i16 %b, i16* %a unordered, align 2
  ret void
}

define void @atomic_store_i16_monotonic(i16 *%a, i16 %b) nounwind {
; CSKY-LABEL: atomic_store_i16_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 0
; CSKY-NEXT:    jsri32 [.LCPI21_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI21_0:
; CSKY-NEXT:    .long __atomic_store_2
;
  store atomic i16 %b, i16* %a monotonic, align 2
  ret void
}

define void @atomic_store_i16_release(i16 *%a, i16 %b) nounwind {
; CSKY-LABEL: atomic_store_i16_release:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 3
; CSKY-NEXT:    jsri32 [.LCPI22_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI22_0:
; CSKY-NEXT:    .long __atomic_store_2
;
  store atomic i16 %b, i16* %a release, align 2
  ret void
}

define void @atomic_store_i16_seq_cst(i16 *%a, i16 %b) nounwind {
; CSKY-LABEL: atomic_store_i16_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 5
; CSKY-NEXT:    jsri32 [.LCPI23_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI23_0:
; CSKY-NEXT:    .long __atomic_store_2
;
  store atomic i16 %b, i16* %a seq_cst, align 2
  ret void
}

define void @atomic_store_i32_unordered(i32 *%a, i32 %b) nounwind {
; CSKY-LABEL: atomic_store_i32_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 0
; CSKY-NEXT:    jsri32 [.LCPI24_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI24_0:
; CSKY-NEXT:    .long __atomic_store_4
;
  store atomic i32 %b, i32* %a unordered, align 4
  ret void
}

define void @atomic_store_i32_monotonic(i32 *%a, i32 %b) nounwind {
; CSKY-LABEL: atomic_store_i32_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 0
; CSKY-NEXT:    jsri32 [.LCPI25_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI25_0:
; CSKY-NEXT:    .long __atomic_store_4
;
  store atomic i32 %b, i32* %a monotonic, align 4
  ret void
}

define void @atomic_store_i32_release(i32 *%a, i32 %b) nounwind {
; CSKY-LABEL: atomic_store_i32_release:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 3
; CSKY-NEXT:    jsri32 [.LCPI26_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI26_0:
; CSKY-NEXT:    .long __atomic_store_4
;
  store atomic i32 %b, i32* %a release, align 4
  ret void
}

define void @atomic_store_i32_seq_cst(i32 *%a, i32 %b) nounwind {
; CSKY-LABEL: atomic_store_i32_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a2, 5
; CSKY-NEXT:    jsri32 [.LCPI27_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI27_0:
; CSKY-NEXT:    .long __atomic_store_4
;
  store atomic i32 %b, i32* %a seq_cst, align 4
  ret void
}

define void @atomic_store_i64_unordered(i64 *%a, i64 %b) nounwind {
; CSKY-LABEL: atomic_store_i64_unordered:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a3, 0
; CSKY-NEXT:    jsri32 [.LCPI28_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI28_0:
; CSKY-NEXT:    .long __atomic_store_8
;
  store atomic i64 %b, i64* %a unordered, align 8
  ret void
}

define void @atomic_store_i64_monotonic(i64 *%a, i64 %b) nounwind {
; CSKY-LABEL: atomic_store_i64_monotonic:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a3, 0
; CSKY-NEXT:    jsri32 [.LCPI29_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI29_0:
; CSKY-NEXT:    .long __atomic_store_8
;
  store atomic i64 %b, i64* %a monotonic, align 8
  ret void
}

define void @atomic_store_i64_release(i64 *%a, i64 %b) nounwind {
; CSKY-LABEL: atomic_store_i64_release:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a3, 3
; CSKY-NEXT:    jsri32 [.LCPI30_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI30_0:
; CSKY-NEXT:    .long __atomic_store_8
;
  store atomic i64 %b, i64* %a release, align 8
  ret void
}

define void @atomic_store_i64_seq_cst(i64 *%a, i64 %b) nounwind {
; CSKY-LABEL: atomic_store_i64_seq_cst:
; CSKY:       # %bb.0:
; CSKY-NEXT:    subi16 sp, sp, 4
; CSKY-NEXT:    st32.w lr, (sp, 0) # 4-byte Folded Spill
; CSKY-NEXT:    movi16 a3, 5
; CSKY-NEXT:    jsri32 [.LCPI31_0]
; CSKY-NEXT:    ld32.w lr, (sp, 0) # 4-byte Folded Reload
; CSKY-NEXT:    addi16 sp, sp, 4
; CSKY-NEXT:    rts16
; CSKY-NEXT:    .p2align 1
; CSKY-NEXT:  # %bb.1:
; CSKY-NEXT:    .p2align 2
; CSKY-NEXT:  .LCPI31_0:
; CSKY-NEXT:    .long __atomic_store_8
;
  store atomic i64 %b, i64* %a seq_cst, align 8
  ret void
}
