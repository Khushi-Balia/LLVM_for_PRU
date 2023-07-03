; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu %s -o - | FileCheck %s

@ll = dso_local local_unnamed_addr global i64 0, align 8
@x = dso_local local_unnamed_addr global i64 2651237805702985558, align 8
@s1 = dso_local local_unnamed_addr global { i8, i8 } { i8 123, i8 5 }, align 2
@s2 = dso_local local_unnamed_addr global { i8, i8 } { i8 -122, i8 3 }, align 2

define dso_local void @PR35765() {
; CHECK-LABEL: PR35765:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzbl s1(%rip), %ecx
; CHECK-NEXT:    addb $-118, %cl
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    shll %cl, %eax
; CHECK-NEXT:    movzwl x(%rip), %ecx
; CHECK-NEXT:    movzwl s2(%rip), %edx
; CHECK-NEXT:    notl %edx
; CHECK-NEXT:    orl $63488, %edx # imm = 0xF800
; CHECK-NEXT:    movzwl %dx, %edx
; CHECK-NEXT:    orl %ecx, %edx
; CHECK-NEXT:    xorl %eax, %edx
; CHECK-NEXT:    movslq %edx, %rax
; CHECK-NEXT:    movq %rax, ll(%rip)
; CHECK-NEXT:    retq
entry:
  %bf.load.i = load i16, ptr @s1, align 2
  %bf.clear.i = and i16 %bf.load.i, 2047
  %conv.i = zext i16 %bf.clear.i to i32
  %sub.i = add nsw i32 %conv.i, -1398
  %shl.i = shl i32 4, %sub.i
  %0 = load i64, ptr @x, align 8
  %bf.load1.i = load i16, ptr @s2, align 2
  %bf.clear2.i = and i16 %bf.load1.i, 2047
  %1 = xor i16 %bf.clear2.i, -1
  %neg.i = zext i16 %1 to i64
  %or.i = or i64 %0, %neg.i
  %conv5.i = trunc i64 %or.i to i32
  %conv6.i = and i32 %conv5.i, 65535
  %xor.i = xor i32 %conv6.i, %shl.i
  %conv7.i = sext i32 %xor.i to i64
  store i64 %conv7.i, ptr @ll, align 8
  ret void
}
