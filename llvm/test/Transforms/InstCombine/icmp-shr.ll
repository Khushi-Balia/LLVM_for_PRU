; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

target datalayout = "e-p:64:64:64-p1:16:16:16-p2:32:32:32-p3:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

declare void @use(i8)

define i1 @lshr_eq_msb_low_last_zero(i8 %a) {
; CHECK-LABEL: @lshr_eq_msb_low_last_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i8 [[A:%.*]], 6
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 127, %a
  %cmp = icmp eq i8 %shr, 0
  ret i1 %cmp
}

define <2 x i1> @lshr_eq_msb_low_last_zero_vec(<2 x i8> %a) {
; CHECK-LABEL: @lshr_eq_msb_low_last_zero_vec(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt <2 x i8> [[A:%.*]], <i8 6, i8 6>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %shr = lshr <2 x i8> <i8 127, i8 127>, %a
  %cmp = icmp eq <2 x i8> %shr, zeroinitializer
  ret <2 x i1> %cmp
}

define i1 @ashr_eq_msb_low_second_zero(i8 %a) {
; CHECK-LABEL: @ashr_eq_msb_low_second_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i8 [[A:%.*]], 6
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 127, %a
  %cmp = icmp eq i8 %shr, 0
  ret i1 %cmp
}

define i1 @lshr_ne_msb_low_last_zero(i8 %a) {
; CHECK-LABEL: @lshr_ne_msb_low_last_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 127, %a
  %cmp = icmp ne i8 %shr, 0
  ret i1 %cmp
}

define i1 @ashr_ne_msb_low_second_zero(i8 %a) {
; CHECK-LABEL: @ashr_ne_msb_low_second_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 127, %a
  %cmp = icmp ne i8 %shr, 0
  ret i1 %cmp
}

define i1 @ashr_eq_both_equal(i8 %a) {
; CHECK-LABEL: @ashr_eq_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 128, %a
  %cmp = icmp eq i8 %shr, 128
  ret i1 %cmp
}

define i1 @ashr_ne_both_equal(i8 %a) {
; CHECK-LABEL: @ashr_ne_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 128, %a
  %cmp = icmp ne i8 %shr, 128
  ret i1 %cmp
}

define i1 @lshr_eq_both_equal(i8 %a) {
; CHECK-LABEL: @lshr_eq_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 127, %a
  %cmp = icmp eq i8 %shr, 127
  ret i1 %cmp
}

define i1 @lshr_ne_both_equal(i8 %a) {
; CHECK-LABEL: @lshr_ne_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 127, %a
  %cmp = icmp ne i8 %shr, 127
  ret i1 %cmp
}

define i1 @exact_ashr_eq_both_equal(i8 %a) {
; CHECK-LABEL: @exact_ashr_eq_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr exact i8 128, %a
  %cmp = icmp eq i8 %shr, 128
  ret i1 %cmp
}

define i1 @exact_ashr_ne_both_equal(i8 %a) {
; CHECK-LABEL: @exact_ashr_ne_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr exact i8 128, %a
  %cmp = icmp ne i8 %shr, 128
  ret i1 %cmp
}

define i1 @exact_lshr_eq_both_equal(i8 %a) {
; CHECK-LABEL: @exact_lshr_eq_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 126, %a
  %cmp = icmp eq i8 %shr, 126
  ret i1 %cmp
}

define i1 @exact_lshr_ne_both_equal(i8 %a) {
; CHECK-LABEL: @exact_lshr_ne_both_equal(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 126, %a
  %cmp = icmp ne i8 %shr, 126
  ret i1 %cmp
}

define i1 @exact_lshr_eq_opposite_msb(i8 %a) {
; CHECK-LABEL: @exact_lshr_eq_opposite_msb(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 -128, %a
  %cmp = icmp eq i8 %shr, 1
  ret i1 %cmp
}

define i1 @lshr_eq_opposite_msb(i8 %a) {
; CHECK-LABEL: @lshr_eq_opposite_msb(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 -128, %a
  %cmp = icmp eq i8 %shr, 1
  ret i1 %cmp
}

define i1 @exact_lshr_ne_opposite_msb(i8 %a) {
; CHECK-LABEL: @exact_lshr_ne_opposite_msb(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 -128, %a
  %cmp = icmp ne i8 %shr, 1
  ret i1 %cmp
}

define i1 @lshr_ne_opposite_msb(i8 %a) {
; CHECK-LABEL: @lshr_ne_opposite_msb(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 -128, %a
  %cmp = icmp ne i8 %shr, 1
  ret i1 %cmp
}

define i1 @exact_ashr_eq(i8 %a) {
; CHECK-LABEL: @exact_ashr_eq(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr exact i8 -128, %a
  %cmp = icmp eq i8 %shr, -1
  ret i1 %cmp
}

define i1 @exact_ashr_ne(i8 %a) {
; CHECK-LABEL: @exact_ashr_ne(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr exact i8 -128, %a
  %cmp = icmp ne i8 %shr, -1
  ret i1 %cmp
}

define i1 @exact_lshr_eq(i8 %a) {
; CHECK-LABEL: @exact_lshr_eq(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 2
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 4, %a
  %cmp = icmp eq i8 %shr, 1
  ret i1 %cmp
}

define i1 @exact_lshr_ne(i8 %a) {
; CHECK-LABEL: @exact_lshr_ne(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 2
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 4, %a
  %cmp = icmp ne i8 %shr, 1
  ret i1 %cmp
}

define i1 @nonexact_ashr_eq(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_eq(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 -128, %a
  %cmp = icmp eq i8 %shr, -1
  ret i1 %cmp
}

define i1 @nonexact_ashr_ne(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_ne(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 -128, %a
  %cmp = icmp ne i8 %shr, -1
  ret i1 %cmp
}

define i1 @nonexact_lshr_eq(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_eq(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 2
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 4, %a
  %cmp = icmp eq i8 %shr, 1
  ret i1 %cmp
}

define i1 @nonexact_lshr_ne(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_ne(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 2
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 4, %a
  %cmp = icmp ne i8 %shr, 1
  ret i1 %cmp
}

define i1 @exact_lshr_eq_exactdiv(i8 %a) {
; CHECK-LABEL: @exact_lshr_eq_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 80, %a
  %cmp = icmp eq i8 %shr, 5
  ret i1 %cmp
}

define i1 @exact_lshr_ne_exactdiv(i8 %a) {
; CHECK-LABEL: @exact_lshr_ne_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr exact i8 80, %a
  %cmp = icmp ne i8 %shr, 5
  ret i1 %cmp
}

define i1 @nonexact_lshr_eq_exactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_eq_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 80, %a
  %cmp = icmp eq i8 %shr, 5
  ret i1 %cmp
}

define i1 @nonexact_lshr_ne_exactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_ne_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = lshr i8 80, %a
  %cmp = icmp ne i8 %shr, 5
  ret i1 %cmp
}

define i1 @exact_ashr_eq_exactdiv(i8 %a) {
; CHECK-LABEL: @exact_ashr_eq_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr exact i8 -80, %a
  %cmp = icmp eq i8 %shr, -5
  ret i1 %cmp
}

define i1 @exact_ashr_ne_exactdiv(i8 %a) {
; CHECK-LABEL: @exact_ashr_ne_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr exact i8 -80, %a
  %cmp = icmp ne i8 %shr, -5
  ret i1 %cmp
}

define i1 @nonexact_ashr_eq_exactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_eq_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 -80, %a
  %cmp = icmp eq i8 %shr, -5
  ret i1 %cmp
}

define i1 @nonexact_ashr_ne_exactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_ne_exactdiv(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A:%.*]], 4
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i8 -80, %a
  %cmp = icmp ne i8 %shr, -5
  ret i1 %cmp
}

define i1 @exact_lshr_eq_noexactdiv(i8 %a) {
; CHECK-LABEL: @exact_lshr_eq_noexactdiv(
; CHECK-NEXT:    ret i1 false
;
  %shr = lshr exact i8 80, %a
  %cmp = icmp eq i8 %shr, 31
  ret i1 %cmp
}

define i1 @exact_lshr_ne_noexactdiv(i8 %a) {
; CHECK-LABEL: @exact_lshr_ne_noexactdiv(
; CHECK-NEXT:    ret i1 true
;
  %shr = lshr exact i8 80, %a
  %cmp = icmp ne i8 %shr, 31
  ret i1 %cmp
}

define i1 @nonexact_lshr_eq_noexactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_eq_noexactdiv(
; CHECK-NEXT:    ret i1 false
;
  %shr = lshr i8 80, %a
  %cmp = icmp eq i8 %shr, 31
  ret i1 %cmp
}

define i1 @nonexact_lshr_ne_noexactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_ne_noexactdiv(
; CHECK-NEXT:    ret i1 true
;
  %shr = lshr i8 80, %a
  %cmp = icmp ne i8 %shr, 31
  ret i1 %cmp
}

define i1 @exact_ashr_eq_noexactdiv(i8 %a) {
; CHECK-LABEL: @exact_ashr_eq_noexactdiv(
; CHECK-NEXT:    ret i1 false
;
  %shr = ashr exact i8 -80, %a
  %cmp = icmp eq i8 %shr, -31
  ret i1 %cmp
}

define i1 @exact_ashr_ne_noexactdiv(i8 %a) {
; CHECK-LABEL: @exact_ashr_ne_noexactdiv(
; CHECK-NEXT:    ret i1 true
;
  %shr = ashr exact i8 -80, %a
  %cmp = icmp ne i8 %shr, -31
  ret i1 %cmp
}

define i1 @nonexact_ashr_eq_noexactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_eq_noexactdiv(
; CHECK-NEXT:    ret i1 false
;
  %shr = ashr i8 -80, %a
  %cmp = icmp eq i8 %shr, -31
  ret i1 %cmp
}

define i1 @nonexact_ashr_ne_noexactdiv(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_ne_noexactdiv(
; CHECK-NEXT:    ret i1 true
;
  %shr = ashr i8 -80, %a
  %cmp = icmp ne i8 %shr, -31
  ret i1 %cmp
}

define i1 @nonexact_lshr_eq_noexactlog(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_eq_noexactlog(
; CHECK-NEXT:    ret i1 false
;
  %shr = lshr i8 90, %a
  %cmp = icmp eq i8 %shr, 30
  ret i1 %cmp
}

define i1 @nonexact_lshr_ne_noexactlog(i8 %a) {
; CHECK-LABEL: @nonexact_lshr_ne_noexactlog(
; CHECK-NEXT:    ret i1 true
;
  %shr = lshr i8 90, %a
  %cmp = icmp ne i8 %shr, 30
  ret i1 %cmp
}

define i1 @nonexact_ashr_eq_noexactlog(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_eq_noexactlog(
; CHECK-NEXT:    ret i1 false
;
  %shr = ashr i8 -90, %a
  %cmp = icmp eq i8 %shr, -30
  ret i1 %cmp
}

define i1 @nonexact_ashr_ne_noexactlog(i8 %a) {
; CHECK-LABEL: @nonexact_ashr_ne_noexactlog(
; CHECK-NEXT:    ret i1 true
;
  %shr = ashr i8 -90, %a
  %cmp = icmp ne i8 %shr, -30
  ret i1 %cmp
}

; Don't try to fold the entire body of function @PR20945 into a
; single `ret i1 true` statement.
; If %B is equal to 1, then this function would return false.
; As a consequence, the instruction combiner is not allowed to fold %cmp
; to 'true'. Instead, it should replace %cmp with a simpler comparison
; between %B and 1.

define i1 @PR20945(i32 %B) {
; CHECK-LABEL: @PR20945(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[B:%.*]], 1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i32 -9, %B
  %cmp = icmp ne i32 %shr, -5
  ret i1 %cmp
}

define i1 @PR21222(i32 %B) {
; CHECK-LABEL: @PR21222(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[B:%.*]], 6
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %shr = ashr i32 -93, %B
  %cmp = icmp eq i32 %shr, -2
  ret i1 %cmp
}

define i1 @PR24873(i64 %V) {
; CHECK-LABEL: @PR24873(
; CHECK-NEXT:    [[ICMP:%.*]] = icmp ugt i64 [[V:%.*]], 61
; CHECK-NEXT:    ret i1 [[ICMP]]
;
  %ashr = ashr i64 -4611686018427387904, %V
  %icmp = icmp eq i64 %ashr, -1
  ret i1 %icmp
}

declare void @foo(i32)

define i1 @exact_multiuse(i32 %x) {
; CHECK-LABEL: @exact_multiuse(
; CHECK-NEXT:    [[SH:%.*]] = lshr exact i32 [[X:%.*]], 7
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X]], 131072
; CHECK-NEXT:    call void @foo(i32 [[SH]])
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sh = lshr exact i32 %x, 7
  %cmp = icmp eq i32 %sh, 1024
  call void @foo(i32 %sh)
  ret i1 %cmp
}

; PR9343 #1
define i1 @ashr_exact_eq_0(i32 %X, i32 %Y) {
; CHECK-LABEL: @ashr_exact_eq_0(
; CHECK-NEXT:    [[B:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[B]]
;
  %A = ashr exact i32 %X, %Y
  %B = icmp eq i32 %A, 0
  ret i1 %B
}

define i1 @ashr_exact_ne_0_uses(i32 %X, i32 %Y) {
; CHECK-LABEL: @ashr_exact_ne_0_uses(
; CHECK-NEXT:    [[A:%.*]] = ashr exact i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @foo(i32 [[A]])
; CHECK-NEXT:    [[B:%.*]] = icmp ne i32 [[X]], 0
; CHECK-NEXT:    ret i1 [[B]]
;
  %A = ashr exact i32 %X, %Y
  call void @foo(i32 %A)
  %B = icmp ne i32 %A, 0
  ret i1 %B
}

define <2 x i1> @ashr_exact_eq_0_vec(<2 x i32> %X, <2 x i32> %Y) {
; CHECK-LABEL: @ashr_exact_eq_0_vec(
; CHECK-NEXT:    [[B:%.*]] = icmp eq <2 x i32> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[B]]
;
  %A = ashr exact <2 x i32> %X, %Y
  %B = icmp eq <2 x i32> %A, zeroinitializer
  ret <2 x i1> %B
}

define i1 @lshr_exact_ne_0(i32 %X, i32 %Y) {
; CHECK-LABEL: @lshr_exact_ne_0(
; CHECK-NEXT:    [[B:%.*]] = icmp ne i32 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[B]]
;
  %A = lshr exact i32 %X, %Y
  %B = icmp ne i32 %A, 0
  ret i1 %B
}

define i1 @lshr_exact_eq_0_uses(i32 %X, i32 %Y) {
; CHECK-LABEL: @lshr_exact_eq_0_uses(
; CHECK-NEXT:    [[A:%.*]] = lshr exact i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @foo(i32 [[A]])
; CHECK-NEXT:    [[B:%.*]] = icmp eq i32 [[X]], 0
; CHECK-NEXT:    ret i1 [[B]]
;
  %A = lshr exact i32 %X, %Y
  call void @foo(i32 %A)
  %B = icmp eq i32 %A, 0
  ret i1 %B
}

define <2 x i1> @lshr_exact_ne_0_vec(<2 x i32> %X, <2 x i32> %Y) {
; CHECK-LABEL: @lshr_exact_ne_0_vec(
; CHECK-NEXT:    [[B:%.*]] = icmp ne <2 x i32> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[B]]
;
  %A = lshr exact <2 x i32> %X, %Y
  %B = icmp ne <2 x i32> %A, zeroinitializer
  ret <2 x i1> %B
}

; Verify conversions of ashr+icmp to a sign-bit test.

; negative test, but different transform possible

define i1 @ashr_ugt_0(i4 %x) {
; CHECK-LABEL: @ashr_ugt_0(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i4 [[X:%.*]], 1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 0 ; 0b0000
  ret i1 %r
}

define i1 @ashr_ugt_1(i4 %x) {
; CHECK-LABEL: @ashr_ugt_1(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i4 [[X:%.*]], 3
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 1 ; 0b0001
  ret i1 %r
}

define i1 @ashr_ugt_2(i4 %x) {
; CHECK-LABEL: @ashr_ugt_2(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i4 [[X:%.*]], 5
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 2 ; 0b0010
  ret i1 %r
}

define i1 @ashr_ugt_3(i4 %x) {
; CHECK-LABEL: @ashr_ugt_3(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 3 ; 0b0011
  ret i1 %r
}

define i1 @ashr_ugt_4(i4 %x) {
; CHECK-LABEL: @ashr_ugt_4(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 4 ; 0b0100
  ret i1 %r
}

define i1 @ashr_ugt_5(i4 %x) {
; CHECK-LABEL: @ashr_ugt_5(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 5 ; 0b0101
  ret i1 %r
}

define i1 @ashr_ugt_6(i4 %x) {
; CHECK-LABEL: @ashr_ugt_6(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 6 ; 0b0110
  ret i1 %r
}

define i1 @ashr_ugt_7(i4 %x) {
; CHECK-LABEL: @ashr_ugt_7(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 7 ; 0b0111
  ret i1 %r
}

define i1 @ashr_ugt_8(i4 %x) {
; CHECK-LABEL: @ashr_ugt_8(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 8 ; 0b1000
  ret i1 %r
}

define i1 @ashr_ugt_9(i4 %x) {
; CHECK-LABEL: @ashr_ugt_9(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 9 ; 0b1001
  ret i1 %r
}

define i1 @ashr_ugt_10(i4 %x) {
; CHECK-LABEL: @ashr_ugt_10(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 10 ; 0b1010
  ret i1 %r
}

define i1 @ashr_ugt_11(i4 %x) {
; CHECK-LABEL: @ashr_ugt_11(
; CHECK-NEXT:    [[R:%.*]] = icmp slt i4 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 11 ; 0b1011
  ret i1 %r
}

define i1 @ashr_ugt_12(i4 %x) {
; CHECK-LABEL: @ashr_ugt_12(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i4 [[X:%.*]], -7
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 12 ; 0b1100
  ret i1 %r
}

define i1 @ashr_ugt_13(i4 %x) {
; CHECK-LABEL: @ashr_ugt_13(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i4 [[X:%.*]], -5
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 13 ; 0b1101
  ret i1 %r
}

; negative test, but different transform possible

define i1 @ashr_ugt_14(i4 %x) {
; CHECK-LABEL: @ashr_ugt_14(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i4 [[X:%.*]], -3
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 14 ; 0b1110
  ret i1 %r
}

; negative test, but simplifies

define i1 @ashr_ugt_15(i4 %x) {
; CHECK-LABEL: @ashr_ugt_15(
; CHECK-NEXT:    ret i1 false
;
  %s = ashr i4 %x, 1
  %r = icmp ugt i4 %s, 15 ; 0b1111
  ret i1 %r
}

; negative test, but simplifies

define i1 @ashr_ult_0(i4 %x) {
; CHECK-LABEL: @ashr_ult_0(
; CHECK-NEXT:    ret i1 false
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 0 ; 0b0000
  ret i1 %r
}

; negative test, but different transform possible

define i1 @ashr_ult_1(i4 %x) {
; CHECK-LABEL: @ashr_ult_1(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i4 [[X:%.*]], 2
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 1 ; 0b0001
  ret i1 %r
}

; negative test

define i1 @ashr_ult_2(i4 %x) {
; CHECK-LABEL: @ashr_ult_2(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i4 [[X:%.*]], 4
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 2 ; 0b0010
  ret i1 %r
}

; negative test

define i1 @ashr_ult_3(i4 %x) {
; CHECK-LABEL: @ashr_ult_3(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i4 [[X:%.*]], 6
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 3 ; 0b0011
  ret i1 %r
}

define i1 @ashr_ult_4(i4 %x) {
; CHECK-LABEL: @ashr_ult_4(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 4 ; 0b0100
  ret i1 %r
}

define i1 @ashr_ult_5(i4 %x) {
; CHECK-LABEL: @ashr_ult_5(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 5 ; 0b0101
  ret i1 %r
}

define i1 @ashr_ult_6(i4 %x) {
; CHECK-LABEL: @ashr_ult_6(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 6 ; 0b0110
  ret i1 %r
}

define i1 @ashr_ult_7(i4 %x) {
; CHECK-LABEL: @ashr_ult_7(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 7 ; 0b0111
  ret i1 %r
}

define i1 @ashr_ult_8(i4 %x) {
; CHECK-LABEL: @ashr_ult_8(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 8 ; 0b1000
  ret i1 %r
}

define i1 @ashr_ult_9(i4 %x) {
; CHECK-LABEL: @ashr_ult_9(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 9 ; 0b1001
  ret i1 %r
}

define i1 @ashr_ult_10(i4 %x) {
; CHECK-LABEL: @ashr_ult_10(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 10 ; 0b1010
  ret i1 %r
}

define i1 @ashr_ult_11(i4 %x) {
; CHECK-LABEL: @ashr_ult_11(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 11 ; 0b1011
  ret i1 %r
}

; negative test

define i1 @ashr_ult_12(i4 %x) {
; CHECK-LABEL: @ashr_ult_12(
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i4 [[X:%.*]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 12 ; 0b1100
  ret i1 %r
}

; negative test

define i1 @ashr_ult_13(i4 %x) {
; CHECK-LABEL: @ashr_ult_13(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i4 [[X:%.*]], -6
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 13 ; 0b1101
  ret i1 %r
}

; negative test

define i1 @ashr_ult_14(i4 %x) {
; CHECK-LABEL: @ashr_ult_14(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i4 [[X:%.*]], -4
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 14 ; 0b1110
  ret i1 %r
}

; negative test, but different transform possible

define i1 @ashr_ult_15(i4 %x) {
; CHECK-LABEL: @ashr_ult_15(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i4 [[X:%.*]], -2
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i4 %x, 1
  %r = icmp ult i4 %s, 15 ; 0b1111
  ret i1 %r
}

define i1 @lshr_eq_0_multiuse(i8 %x) {
; CHECK-LABEL: @lshr_eq_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp ult i8 [[X]], 4
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = lshr i8 %x, 2
  call void @use(i8 %s)
  %c = icmp eq i8 %s, 0
  ret i1 %c
}

define i1 @lshr_ne_0_multiuse(i8 %x) {
; CHECK-LABEL: @lshr_ne_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp ugt i8 [[X]], 3
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = lshr i8 %x, 2
  call void @use(i8 %s)
  %c = icmp ne i8 %s, 0
  ret i1 %c
}

define i1 @ashr_eq_0_multiuse(i8 %x) {
; CHECK-LABEL: @ashr_eq_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = ashr i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp ult i8 [[X]], 4
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = ashr i8 %x, 2
  call void @use(i8 %s)
  %c = icmp eq i8 %s, 0
  ret i1 %c
}

define i1 @ashr_ne_0_multiuse(i8 %x) {
; CHECK-LABEL: @ashr_ne_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = ashr i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp ugt i8 [[X]], 3
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = ashr i8 %x, 2
  call void @use(i8 %s)
  %c = icmp ne i8 %s, 0
  ret i1 %c
}

define i1 @lshr_exact_eq_0_multiuse(i8 %x) {
; CHECK-LABEL: @lshr_exact_eq_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = lshr exact i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp eq i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = lshr exact i8 %x, 2
  call void @use(i8 %s)
  %c = icmp eq i8 %s, 0
  ret i1 %c
}

define i1 @lshr_exact_ne_0_multiuse(i8 %x) {
; CHECK-LABEL: @lshr_exact_ne_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = lshr exact i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = lshr exact i8 %x, 2
  call void @use(i8 %s)
  %c = icmp ne i8 %s, 0
  ret i1 %c
}

define i1 @ashr_exact_eq_0_multiuse(i8 %x) {
; CHECK-LABEL: @ashr_exact_eq_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = ashr exact i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp eq i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = ashr exact i8 %x, 2
  call void @use(i8 %s)
  %c = icmp eq i8 %s, 0
  ret i1 %c
}

define i1 @ashr_exact_ne_0_multiuse(i8 %x) {
; CHECK-LABEL: @ashr_exact_ne_0_multiuse(
; CHECK-NEXT:    [[S:%.*]] = ashr exact i8 [[X:%.*]], 2
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[C:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[C]]
;
  %s = ashr exact i8 %x, 2
  call void @use(i8 %s)
  %c = icmp ne i8 %s, 0
  ret i1 %c
}

define i1 @lshr_pow2_ugt(i8 %x) {
; CHECK-LABEL: @lshr_pow2_ugt(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 2, %x
  %r = icmp ugt i8 %s, 1
  ret i1 %r
}

define i1 @lshr_pow2_ugt_use(i8 %x) {
; CHECK-LABEL: @lshr_pow2_ugt_use(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -128, [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[X]], 5
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 128, %x
  call void @use(i8 %s)
  %r = icmp ugt i8 %s, 5
  ret i1 %r
}

define <2 x i1> @lshr_pow2_ugt_vec(<2 x i8> %x) {
; CHECK-LABEL: @lshr_pow2_ugt_vec(
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %s = lshr <2 x i8> <i8 8, i8 8>, %x
  %r = icmp ugt <2 x i8> %s, <i8 6, i8 6>
  ret <2 x i1> %r
}

; negative test - need power-of-2

define i1 @lshr_not_pow2_ugt(i8 %x) {
; CHECK-LABEL: @lshr_not_pow2_ugt(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 3, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[S]], 1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 3, %x
  %r = icmp ugt i8 %s, 1
  ret i1 %r
}

define i1 @lshr_pow2_ugt1(i8 %x) {
; CHECK-LABEL: @lshr_pow2_ugt1(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[X:%.*]], 7
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 128, %x
  %r = icmp ugt i8 %s, 1
  ret i1 %r
}

; negative test - need logical shift

define i1 @ashr_pow2_ugt(i8 %x) {
; CHECK-LABEL: @ashr_pow2_ugt(
; CHECK-NEXT:    [[S:%.*]] = ashr i8 -128, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[S]], -96
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i8 128, %x
  %r = icmp ugt i8 %s, 160
  ret i1 %r
}

; negative test - need unsigned pred

define i1 @lshr_pow2_sgt(i8 %x) {
; CHECK-LABEL: @lshr_pow2_sgt(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -128, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[S]], 3
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 128, %x
  %r = icmp sgt i8 %s, 3
  ret i1 %r
}

define i1 @lshr_pow2_ult(i8 %x) {
; CHECK-LABEL: @lshr_pow2_ult(
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[X:%.*]], 1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 4, %x
  %r = icmp ult i8 %s, 2
  ret i1 %r
}

define i1 @lshr_pow2_ult_use(i8 %x) {
; CHECK-LABEL: @lshr_pow2_ult_use(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -128, [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[X]], 4
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 128, %x
  call void @use(i8 %s)
  %r = icmp ult i8 %s, 5
  ret i1 %r
}

define <2 x i1> @lshr_pow2_ult_vec(<2 x i8> %x) {
; CHECK-LABEL: @lshr_pow2_ult_vec(
; CHECK-NEXT:    [[R:%.*]] = icmp ne <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %s = lshr <2 x i8> <i8 8, i8 8>, %x
  %r = icmp ult <2 x i8> %s, <i8 6, i8 6>
  ret <2 x i1> %r
}

; negative test - need power-of-2

define i1 @lshr_not_pow2_ult(i8 %x) {
; CHECK-LABEL: @lshr_not_pow2_ult(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 3, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[S]], 2
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 3, %x
  %r = icmp ult i8 %s, 2
  ret i1 %r
}

define i1 @lshr_pow2_ult_equal_constants(i32 %x) {
; CHECK-LABEL: @lshr_pow2_ult_equal_constants(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i32 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %shr = lshr i32 16, %x
  %r = icmp ult i32 %shr, 16
  ret i1 %r
}

define i1 @lshr_pow2_ult_smin(i8 %x) {
; CHECK-LABEL: @lshr_pow2_ult_smin(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 128, %x
  %r = icmp ult i8 %s, 128
  ret i1 %r
}

; negative test - need logical shift

define i1 @ashr_pow2_ult(i8 %x) {
; CHECK-LABEL: @ashr_pow2_ult(
; CHECK-NEXT:    [[S:%.*]] = ashr i8 -128, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[S]], -96
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = ashr i8 128, %x
  %r = icmp ult i8 %s, 160
  ret i1 %r
}

; negative test - need unsigned pred

define i1 @lshr_pow2_slt(i8 %x) {
; CHECK-LABEL: @lshr_pow2_slt(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -128, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[S]], 3
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 128, %x
  %r = icmp slt i8 %s, 3
  ret i1 %r
}

; (ShiftValC >> X) >s -1 --> X != 0 with ShiftValC < 0

define i1 @lshr_neg_sgt_minus_1(i8 %x) {
; CHECK-LABEL: @lshr_neg_sgt_minus_1(
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  %r = icmp sgt i8 %s, -1
  ret i1 %r
}

define <2 x i1> @lshr_neg_sgt_minus_1_vector(<2 x i8> %x) {
; CHECK-LABEL: @lshr_neg_sgt_minus_1_vector(
; CHECK-NEXT:    [[R:%.*]] = icmp ne <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %s = lshr <2 x i8> <i8 -17, i8 -17>, %x
  %r = icmp sgt <2 x i8> %s, <i8 -1, i8 -1>
  ret <2 x i1> %r
}

define i1 @lshr_neg_sgt_minus_1_extra_use(i8 %x) {
; CHECK-LABEL: @lshr_neg_sgt_minus_1_extra_use(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -17, [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  call void @use(i8 %s)
  %r = icmp sgt i8 %s, -1
  ret i1 %r
}

; Negative tests

define i1 @lshr_neg_sgt_minus_2(i8 %x) {
; CHECK-LABEL: @lshr_neg_sgt_minus_2(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -17, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[S]], -2
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  %r = icmp sgt i8 %s, -2
  ret i1 %r
}

define i1 @lshr_neg_slt_minus_1(i8 %x) {
; CHECK-LABEL: @lshr_neg_slt_minus_1(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -17, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[S]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  %r = icmp slt i8 %s, -1
  ret i1 %r
}

; (ShiftValC >> X) <s 0 --> X == 0 with ShiftValC < 0

define i1 @lshr_neg_slt_zero(i8 %x) {
; CHECK-LABEL: @lshr_neg_slt_zero(
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X:%.*]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  %r = icmp slt i8 %s, 0
  ret i1 %r
}

define <2 x i1> @lshr_neg_slt_zero_vector(<2 x i8> %x) {
; CHECK-LABEL: @lshr_neg_slt_zero_vector(
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %s = lshr <2 x i8> <i8 -17, i8 -17>, %x
  %r = icmp slt <2 x i8> %s, <i8 0, i8 0>
  ret <2 x i1> %r
}

define i1 @lshr_neg_slt_zero_extra_use(i8 %x) {
; CHECK-LABEL: @lshr_neg_slt_zero_extra_use(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -17, [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  call void @use(i8 %s)
  %r = icmp slt i8 %s, 0
  ret i1 %r
}

; Negative tests

define i1 @lshr_neg_slt_non-zero(i8 %x) {
; CHECK-LABEL: @lshr_neg_slt_non-zero(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -17, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[S]], 2
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  %r = icmp slt i8 %s, 2
  ret i1 %r
}

define i1 @lshr_neg_sgt_zero(i8 %x) {
; CHECK-LABEL: @lshr_neg_sgt_zero(
; CHECK-NEXT:    [[S:%.*]] = lshr i8 -17, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[S]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %s = lshr i8 -17, %x
  %r = icmp sgt i8 %s, 0
  ret i1 %r
}

define i1 @exactly_one_set_signbit(i8 %x, i8 %y) {
; CHECK-LABEL: @exactly_one_set_signbit(
; CHECK-NEXT:    [[XOR_SIGNBITS:%.*]] = xor i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[XOR_SIGNBITS]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 7
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  %r = icmp eq i8 %xsign, %yposz
  ret i1 %r
}

define i1 @exactly_one_set_signbit_use1(i8 %x, i8 %y) {
; CHECK-LABEL: @exactly_one_set_signbit_use1(
; CHECK-NEXT:    [[XSIGN:%.*]] = lshr i8 [[X:%.*]], 7
; CHECK-NEXT:    call void @use(i8 [[XSIGN]])
; CHECK-NEXT:    [[XOR_SIGNBITS:%.*]] = xor i8 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[XOR_SIGNBITS]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 7
  call void @use(i8 %xsign)
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  %r = icmp eq i8 %xsign, %yposz
  ret i1 %r
}

define <2 x i1> @same_signbit(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @same_signbit(
; CHECK-NEXT:    [[XOR_SIGNBITS:%.*]] = xor <2 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt <2 x i8> [[XOR_SIGNBITS]], <i8 -1, i8 -1>
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %xsign = lshr <2 x i8> %x, <i8 7, i8 7>
  %ypos = icmp sgt <2 x i8> %y, <i8 -1, i8 -1>
  %yposz = zext <2 x i1> %ypos to <2 x i8>
  %r = icmp ne <2 x i8> %xsign, %yposz
  ret <2 x i1> %r
}

define i1 @same_signbit_use2(i8 %x, i8 %y) {
; CHECK-LABEL: @same_signbit_use2(
; CHECK-NEXT:    [[YPOS:%.*]] = icmp sgt i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[YPOSZ:%.*]] = zext i1 [[YPOS]] to i8
; CHECK-NEXT:    call void @use(i8 [[YPOSZ]])
; CHECK-NEXT:    [[XOR_SIGNBITS:%.*]] = xor i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[XOR_SIGNBITS]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 7
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  call void @use(i8 %yposz)
  %r = icmp ne i8 %xsign, %yposz
  ret i1 %r
}

; negative test

define i1 @same_signbit_use3(i8 %x, i8 %y) {
; CHECK-LABEL: @same_signbit_use3(
; CHECK-NEXT:    [[XSIGN:%.*]] = lshr i8 [[X:%.*]], 7
; CHECK-NEXT:    call void @use(i8 [[XSIGN]])
; CHECK-NEXT:    [[YPOS:%.*]] = icmp sgt i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[YPOSZ:%.*]] = zext i1 [[YPOS]] to i8
; CHECK-NEXT:    call void @use(i8 [[YPOSZ]])
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[XSIGN]], [[YPOSZ]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 7
  call void @use(i8 %xsign)
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  call void @use(i8 %yposz)
  %r = icmp ne i8 %xsign, %yposz
  ret i1 %r
}

define <2 x i1> @same_signbit_poison_elts(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @same_signbit_poison_elts(
; CHECK-NEXT:    [[XOR_SIGNBITS:%.*]] = xor <2 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sgt <2 x i8> [[XOR_SIGNBITS]], <i8 -1, i8 -1>
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %xsign = lshr <2 x i8> %x, <i8 7, i8 poison>
  %ypos = icmp sgt <2 x i8> %y, <i8 -1, i8 poison>
  %yposz = zext <2 x i1> %ypos to <2 x i8>
  %r = icmp ne <2 x i8> %xsign, %yposz
  ret <2 x i1> %r
}

; negative test

define i1 @same_signbit_wrong_type(i8 %x, i32 %y) {
; CHECK-LABEL: @same_signbit_wrong_type(
; CHECK-NEXT:    [[XSIGN:%.*]] = lshr i8 [[X:%.*]], 7
; CHECK-NEXT:    [[YPOS:%.*]] = icmp sgt i32 [[Y:%.*]], -1
; CHECK-NEXT:    [[YPOSZ:%.*]] = zext i1 [[YPOS]] to i8
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[XSIGN]], [[YPOSZ]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 7
  %ypos = icmp sgt i32 %y, -1
  %yposz = zext i1 %ypos to i8
  %r = icmp ne i8 %xsign, %yposz
  ret i1 %r
}

; negative test

define i1 @exactly_one_set_signbit_wrong_shamt(i8 %x, i8 %y) {
; CHECK-LABEL: @exactly_one_set_signbit_wrong_shamt(
; CHECK-NEXT:    [[XSIGN:%.*]] = lshr i8 [[X:%.*]], 6
; CHECK-NEXT:    [[YPOS:%.*]] = icmp sgt i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[YPOSZ:%.*]] = zext i1 [[YPOS]] to i8
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[XSIGN]], [[YPOSZ]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 6
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  %r = icmp eq i8 %xsign, %yposz
  ret i1 %r
}

; negative test
; TODO: This could reduce.

define i1 @exactly_one_set_signbit_wrong_shr(i8 %x, i8 %y) {
; CHECK-LABEL: @exactly_one_set_signbit_wrong_shr(
; CHECK-NEXT:    [[XSIGN:%.*]] = ashr i8 [[X:%.*]], 7
; CHECK-NEXT:    [[YPOS:%.*]] = icmp sgt i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[YPOSZ:%.*]] = zext i1 [[YPOS]] to i8
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[XSIGN]], [[YPOSZ]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = ashr i8 %x, 7
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  %r = icmp eq i8 %xsign, %yposz
  ret i1 %r
}

; negative test
; TODO: This could reduce.

define i1 @exactly_one_set_signbit_wrong_pred(i8 %x, i8 %y) {
; CHECK-LABEL: @exactly_one_set_signbit_wrong_pred(
; CHECK-NEXT:    [[XSIGN:%.*]] = lshr i8 [[X:%.*]], 7
; CHECK-NEXT:    [[YPOS:%.*]] = icmp sgt i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[YPOSZ:%.*]] = zext i1 [[YPOS]] to i8
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[XSIGN]], [[YPOSZ]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xsign = lshr i8 %x, 7
  %ypos = icmp sgt i8 %y, -1
  %yposz = zext i1 %ypos to i8
  %r = icmp sgt i8 %xsign, %yposz
  ret i1 %r
}
