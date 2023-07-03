; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=mips-mti-linux-gnu -mcpu=mips32r2 < %s -asm-show-inst | FileCheck %s --check-prefix=MIPS32
; RUN: llc -mtriple=mips-mti-linux-gnu -mcpu=mips32r2 -mattr=+micromips < %s -asm-show-inst | FileCheck %s --check-prefix=MMR3
; RUN: llc -mtriple=mips-img-linux-gnu -mcpu=mips32r6 < %s -asm-show-inst | FileCheck %s --check-prefix=MIPS32R6
; RUN: llc -mtriple=mips-img-linux-gnu -mcpu=mips32r6 -mattr=+micromips < %s -asm-show-inst | FileCheck %s --check-prefix=MMR6
; RUN: llc -mtriple=mips64-mti-linux-gnu -mcpu=mips4 < %s -asm-show-inst | FileCheck %s --check-prefix=MIPS4
; RUN: llc -mtriple=mips64-img-linux-gnu -mcpu=mips64r6 < %s -asm-show-inst | FileCheck %s --check-prefix=MIPS64R6
; RUN: llc -mtriple=mips-mti-linux-gnu -mcpu=mips32r2 -mattr=+micromips,+fp64 < %s -asm-show-inst | FileCheck %s --check-prefix=MMR5FP64
; RUN: llc -mtriple=mips-mti-linux-gnu -mcpu=mips32r5 -mattr=+fp64 < %s -asm-show-inst | FileCheck %s --check-prefix=MIPS32R5FP643

; Test subword and word stores. We use -asm-show-inst to test that the produced
; instructions match the expected ISA.

; NOTE: As the -asm-show-inst shows the internal numbering of instructions
;       and registers, these numbers have been replaced with wildcard regexes.

@a = common global i8 0, align 4
@b = common global i16 0, align 4
@c = common global i32 0, align 4
@d = common global i64 0, align 8
@e = common global float 0.0, align 4
@f = common global double 0.0, align 8

define void @f1(i8 %a) {
; MIPS32-LABEL: f1:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    lui $1, %hi(a) # <MCInst #{{[0-9]+}} LUi
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MIPS32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(a))>>
;
; MMR3-LABEL: f1:
; MMR3:       # %bb.0:
; MMR3-NEXT:    lui $1, %hi(a) # <MCInst #{{[0-9]+}} LUi_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MMR3-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR3-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(a))>>
;
; MIPS32R6-LABEL: f1:
; MIPS32R6:       # %bb.0:
; MIPS32R6-NEXT:    lui $1, %hi(a) # <MCInst #{{[0-9]+}} LUi
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MIPS32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R6-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(a))>>
;
; MMR6-LABEL: f1:
; MMR6:       # %bb.0:
; MMR6-NEXT:    lui $1, %hi(a) # <MCInst #{{[0-9]+}} LUi_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MMR6-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(a))>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS4-LABEL: f1:
; MIPS4:       # %bb.0:
; MIPS4-NEXT:    lui $1, %highest(a) # <MCInst #{{[0-9]+}} LUi64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%highest(a))>>
; MIPS4-NEXT:    daddiu $1, $1, %higher(a) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%higher(a))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    daddiu $1, $1, %hi(a) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS4-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%lo(a))>>
;
; MIPS64R6-LABEL: f1:
; MIPS64R6:       # %bb.0:
; MIPS64R6-NEXT:    lui $1, %highest(a) # <MCInst #{{[0-9]+}} LUi64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%highest(a))>>
; MIPS64R6-NEXT:    daddiu $1, $1, %higher(a) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%higher(a))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    daddiu $1, $1, %hi(a) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS64R6-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%lo(a))>>
;
; MMR5FP64-LABEL: f1:
; MMR5FP64:       # %bb.0:
; MMR5FP64-NEXT:    lui $1, %hi(a) # <MCInst #{{[0-9]+}} LUi_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MMR5FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR5FP64-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(a))>>
;
; MIPS32R5FP643-LABEL: f1:
; MIPS32R5FP643:       # %bb.0:
; MIPS32R5FP643-NEXT:    lui $1, %hi(a) # <MCInst #{{[0-9]+}} LUi
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%hi(a))>>
; MIPS32R5FP643-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R5FP643-NEXT:    sb $4, %lo(a)($1) # <MCInst #{{[0-9]+}} SB
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(a))>>
  store i8 %a, ptr @a
  ret void
}

define void @f2(i16 %a) {
; MIPS32-LABEL: f2:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    lui $1, %hi(b) # <MCInst #{{[0-9]+}} LUi
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MIPS32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(b))>>
;
; MMR3-LABEL: f2:
; MMR3:       # %bb.0:
; MMR3-NEXT:    lui $1, %hi(b) # <MCInst #{{[0-9]+}} LUi_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MMR3-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR3-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(b))>>
;
; MIPS32R6-LABEL: f2:
; MIPS32R6:       # %bb.0:
; MIPS32R6-NEXT:    lui $1, %hi(b) # <MCInst #{{[0-9]+}} LUi
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MIPS32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R6-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(b))>>
;
; MMR6-LABEL: f2:
; MMR6:       # %bb.0:
; MMR6-NEXT:    lui $1, %hi(b) # <MCInst #{{[0-9]+}} LUi_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MMR6-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(b))>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS4-LABEL: f2:
; MIPS4:       # %bb.0:
; MIPS4-NEXT:    lui $1, %highest(b) # <MCInst #{{[0-9]+}} LUi64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%highest(b))>>
; MIPS4-NEXT:    daddiu $1, $1, %higher(b) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%higher(b))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    daddiu $1, $1, %hi(b) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS4-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%lo(b))>>
;
; MIPS64R6-LABEL: f2:
; MIPS64R6:       # %bb.0:
; MIPS64R6-NEXT:    lui $1, %highest(b) # <MCInst #{{[0-9]+}} LUi64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%highest(b))>>
; MIPS64R6-NEXT:    daddiu $1, $1, %higher(b) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%higher(b))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    daddiu $1, $1, %hi(b) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS64R6-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%lo(b))>>
;
; MMR5FP64-LABEL: f2:
; MMR5FP64:       # %bb.0:
; MMR5FP64-NEXT:    lui $1, %hi(b) # <MCInst #{{[0-9]+}} LUi_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MMR5FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR5FP64-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(b))>>
;
; MIPS32R5FP643-LABEL: f2:
; MIPS32R5FP643:       # %bb.0:
; MIPS32R5FP643-NEXT:    lui $1, %hi(b) # <MCInst #{{[0-9]+}} LUi
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%hi(b))>>
; MIPS32R5FP643-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R5FP643-NEXT:    sh $4, %lo(b)($1) # <MCInst #{{[0-9]+}} SH
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(b))>>
  store i16 %a, ptr @b
  ret void
}

define void @f3(i32 %a) {
; MIPS32-LABEL: f3:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    lui $1, %hi(c) # <MCInst #{{[0-9]+}} LUi
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MIPS32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(c))>>
;
; MMR3-LABEL: f3:
; MMR3:       # %bb.0:
; MMR3-NEXT:    lui $1, %hi(c) # <MCInst #{{[0-9]+}} LUi_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MMR3-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR3-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(c))>>
;
; MIPS32R6-LABEL: f3:
; MIPS32R6:       # %bb.0:
; MIPS32R6-NEXT:    lui $1, %hi(c) # <MCInst #{{[0-9]+}} LUi
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MIPS32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R6-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(c))>>
;
; MMR6-LABEL: f3:
; MMR6:       # %bb.0:
; MMR6-NEXT:    lui $1, %hi(c) # <MCInst #{{[0-9]+}} LUi_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MMR6-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(c))>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS4-LABEL: f3:
; MIPS4:       # %bb.0:
; MIPS4-NEXT:    lui $1, %highest(c) # <MCInst #{{[0-9]+}} LUi64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%highest(c))>>
; MIPS4-NEXT:    daddiu $1, $1, %higher(c) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%higher(c))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    daddiu $1, $1, %hi(c) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS4-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%lo(c))>>
;
; MIPS64R6-LABEL: f3:
; MIPS64R6:       # %bb.0:
; MIPS64R6-NEXT:    lui $1, %highest(c) # <MCInst #{{[0-9]+}} LUi64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%highest(c))>>
; MIPS64R6-NEXT:    daddiu $1, $1, %higher(c) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%higher(c))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    daddiu $1, $1, %hi(c) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS64R6-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%lo(c))>>
;
; MMR5FP64-LABEL: f3:
; MMR5FP64:       # %bb.0:
; MMR5FP64-NEXT:    lui $1, %hi(c) # <MCInst #{{[0-9]+}} LUi_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MMR5FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR5FP64-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(c))>>
;
; MIPS32R5FP643-LABEL: f3:
; MIPS32R5FP643:       # %bb.0:
; MIPS32R5FP643-NEXT:    lui $1, %hi(c) # <MCInst #{{[0-9]+}} LUi
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%hi(c))>>
; MIPS32R5FP643-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R5FP643-NEXT:    sw $4, %lo(c)($1) # <MCInst #{{[0-9]+}} SW
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(c))>>
  store i32 %a, ptr @c
  ret void
}

define void @f4(i64 %a) {
; MIPS32-LABEL: f4:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    lui $1, %hi(d) # <MCInst #{{[0-9]+}} LUi
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MIPS32-NEXT:    sw $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SW
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MIPS32-NEXT:    addiu $1, $1, %lo(d) # <MCInst #{{[0-9]+}} ADDiu
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MIPS32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32-NEXT:    sw $5, 4($1) # <MCInst #{{[0-9]+}} SW
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Imm:4>>
;
; MMR3-LABEL: f4:
; MMR3:       # %bb.0:
; MMR3-NEXT:    lui $1, %hi(d) # <MCInst #{{[0-9]+}} LUi_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MMR3-NEXT:    sw $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SW_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MMR3-NEXT:    addiu $2, $1, %lo(d) # <MCInst #{{[0-9]+}} ADDiu_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MMR3-NEXT:    sw16 $5, 4($2) # <MCInst #{{[0-9]+}} SW16_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Imm:4>>
; MMR3-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS32R6-LABEL: f4:
; MIPS32R6:       # %bb.0:
; MIPS32R6-NEXT:    lui $1, %hi(d) # <MCInst #{{[0-9]+}} LUi
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MIPS32R6-NEXT:    sw $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SW
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MIPS32R6-NEXT:    addiu $1, $1, %lo(d) # <MCInst #{{[0-9]+}} ADDiu
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MIPS32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R6-NEXT:    sw $5, 4($1) # <MCInst #{{[0-9]+}} SW
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Imm:4>>
;
; MMR6-LABEL: f4:
; MMR6:       # %bb.0:
; MMR6-NEXT:    lui $1, %hi(d) # <MCInst #{{[0-9]+}} LUi_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MMR6-NEXT:    sw $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SW_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MMR6-NEXT:    addiu $2, $1, %lo(d) # <MCInst #{{[0-9]+}} ADDiu_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MMR6-NEXT:    sw16 $5, 4($2) # <MCInst #{{[0-9]+}} SW16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Imm:4>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS4-LABEL: f4:
; MIPS4:       # %bb.0:
; MIPS4-NEXT:    lui $1, %highest(d) # <MCInst #{{[0-9]+}} LUi64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%highest(d))>>
; MIPS4-NEXT:    daddiu $1, $1, %higher(d) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%higher(d))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    daddiu $1, $1, %hi(d) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS4-NEXT:    sd $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SD
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%lo(d))>>
;
; MIPS64R6-LABEL: f4:
; MIPS64R6:       # %bb.0:
; MIPS64R6-NEXT:    lui $1, %highest(d) # <MCInst #{{[0-9]+}} LUi64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%highest(d))>>
; MIPS64R6-NEXT:    daddiu $1, $1, %higher(d) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%higher(d))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    daddiu $1, $1, %hi(d) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS64R6-NEXT:    sd $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SD
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%lo(d))>>
;
; MMR5FP64-LABEL: f4:
; MMR5FP64:       # %bb.0:
; MMR5FP64-NEXT:    lui $1, %hi(d) # <MCInst #{{[0-9]+}} LUi_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MMR5FP64-NEXT:    sw $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SW_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MMR5FP64-NEXT:    addiu $2, $1, %lo(d) # <MCInst #{{[0-9]+}} ADDiu_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MMR5FP64-NEXT:    sw16 $5, 4($2) # <MCInst #{{[0-9]+}} SW16_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Imm:4>>
; MMR5FP64-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS32R5FP643-LABEL: f4:
; MIPS32R5FP643:       # %bb.0:
; MIPS32R5FP643-NEXT:    lui $1, %hi(d) # <MCInst #{{[0-9]+}} LUi
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%hi(d))>>
; MIPS32R5FP643-NEXT:    sw $4, %lo(d)($1) # <MCInst #{{[0-9]+}} SW
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MIPS32R5FP643-NEXT:    addiu $1, $1, %lo(d) # <MCInst #{{[0-9]+}} ADDiu
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(d))>>
; MIPS32R5FP643-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R5FP643-NEXT:    sw $5, 4($1) # <MCInst #{{[0-9]+}} SW
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Imm:4>>
  store i64 %a, ptr @d
  ret void
}

define void @f5(float %e) {
; MIPS32-LABEL: f5:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    lui $1, %hi(e) # <MCInst #{{[0-9]+}} LUi
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MIPS32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(e))>>
;
; MMR3-LABEL: f5:
; MMR3:       # %bb.0:
; MMR3-NEXT:    lui $1, %hi(e) # <MCInst #{{[0-9]+}} LUi_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MMR3-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR3-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(e))>>
;
; MIPS32R6-LABEL: f5:
; MIPS32R6:       # %bb.0:
; MIPS32R6-NEXT:    lui $1, %hi(e) # <MCInst #{{[0-9]+}} LUi
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MIPS32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R6-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(e))>>
;
; MMR6-LABEL: f5:
; MMR6:       # %bb.0:
; MMR6-NEXT:    lui $1, %hi(e) # <MCInst #{{[0-9]+}} LUi_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MMR6-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(e))>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS4-LABEL: f5:
; MIPS4:       # %bb.0:
; MIPS4-NEXT:    lui $1, %highest(e) # <MCInst #{{[0-9]+}} LUi64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%highest(e))>>
; MIPS4-NEXT:    daddiu $1, $1, %higher(e) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%higher(e))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    daddiu $1, $1, %hi(e) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS4-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%lo(e))>>
;
; MIPS64R6-LABEL: f5:
; MIPS64R6:       # %bb.0:
; MIPS64R6-NEXT:    lui $1, %highest(e) # <MCInst #{{[0-9]+}} LUi64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%highest(e))>>
; MIPS64R6-NEXT:    daddiu $1, $1, %higher(e) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%higher(e))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    daddiu $1, $1, %hi(e) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS64R6-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%lo(e))>>
;
; MMR5FP64-LABEL: f5:
; MMR5FP64:       # %bb.0:
; MMR5FP64-NEXT:    lui $1, %hi(e) # <MCInst #{{[0-9]+}} LUi_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MMR5FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR5FP64-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(e))>>
;
; MIPS32R5FP643-LABEL: f5:
; MIPS32R5FP643:       # %bb.0:
; MIPS32R5FP643-NEXT:    lui $1, %hi(e) # <MCInst #{{[0-9]+}} LUi
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%hi(e))>>
; MIPS32R5FP643-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R5FP643-NEXT:    swc1 $f12, %lo(e)($1) # <MCInst #{{[0-9]+}} SWC1
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(e))>>
  store float %e, ptr @e
  ret void
}

define void @f6(double %f) {
; MIPS32-LABEL: f6:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    lui $1, %hi(f) # <MCInst #{{[0-9]+}} LUi
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MIPS32-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC1
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32-NEXT:    # <MCOperand Expr:(%lo(f))>>
;
; MMR3-LABEL: f6:
; MMR3:       # %bb.0:
; MMR3-NEXT:    lui $1, %hi(f) # <MCInst #{{[0-9]+}} LUi_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MMR3-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR3-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC1_MM_D32
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR3-NEXT:    # <MCOperand Expr:(%lo(f))>>
;
; MIPS32R6-LABEL: f6:
; MIPS32R6:       # %bb.0:
; MIPS32R6-NEXT:    lui $1, %hi(f) # <MCInst #{{[0-9]+}} LUi
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MIPS32R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R6-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC164
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R6-NEXT:    # <MCOperand Expr:(%lo(f))>>
;
; MMR6-LABEL: f6:
; MMR6:       # %bb.0:
; MMR6-NEXT:    lui $1, %hi(f) # <MCInst #{{[0-9]+}} LUi_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MMR6-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC1_D64_MMR6
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR6-NEXT:    # <MCOperand Expr:(%lo(f))>>
; MMR6-NEXT:    jrc $ra # <MCInst #{{[0-9]+}} JRC16_MM
; MMR6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
;
; MIPS4-LABEL: f6:
; MIPS4:       # %bb.0:
; MIPS4-NEXT:    lui $1, %highest(f) # <MCInst #{{[0-9]+}} LUi64
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%highest(f))>>
; MIPS4-NEXT:    daddiu $1, $1, %higher(f) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%higher(f))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    daddiu $1, $1, %hi(f) # <MCInst #{{[0-9]+}} DADDiu
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MIPS4-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Imm:16>>
; MIPS4-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS4-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC164
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS4-NEXT:    # <MCOperand Expr:(%lo(f))>>
;
; MIPS64R6-LABEL: f6:
; MIPS64R6:       # %bb.0:
; MIPS64R6-NEXT:    lui $1, %highest(f) # <MCInst #{{[0-9]+}} LUi64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%highest(f))>>
; MIPS64R6-NEXT:    daddiu $1, $1, %higher(f) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%higher(f))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    daddiu $1, $1, %hi(f) # <MCInst #{{[0-9]+}} DADDiu
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MIPS64R6-NEXT:    dsll $1, $1, 16 # <MCInst #{{[0-9]+}} DSLL
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Imm:16>>
; MIPS64R6-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JALR64
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS64R6-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC164
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS64R6-NEXT:    # <MCOperand Expr:(%lo(f))>>
;
; MMR5FP64-LABEL: f6:
; MMR5FP64:       # %bb.0:
; MMR5FP64-NEXT:    lui $1, %hi(f) # <MCInst #{{[0-9]+}} LUi_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MMR5FP64-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR_MM
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MMR5FP64-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC1_MM_D64
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MMR5FP64-NEXT:    # <MCOperand Expr:(%lo(f))>>
;
; MIPS32R5FP643-LABEL: f6:
; MIPS32R5FP643:       # %bb.0:
; MIPS32R5FP643-NEXT:    lui $1, %hi(f) # <MCInst #{{[0-9]+}} LUi
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%hi(f))>>
; MIPS32R5FP643-NEXT:    jr $ra # <MCInst #{{[0-9]+}} JR
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>>
; MIPS32R5FP643-NEXT:    sdc1 $f12, %lo(f)($1) # <MCInst #{{[0-9]+}} SDC164
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Reg:{{[0-9]+}}>
; MIPS32R5FP643-NEXT:    # <MCOperand Expr:(%lo(f))>>
  store double %f, ptr @f
  ret void
}
