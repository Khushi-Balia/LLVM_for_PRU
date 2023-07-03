; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 --mattr=+f,-d < %s | FileCheck %s --check-prefix=LA32F
; RUN: llc --mtriple=loongarch32 --mattr=+d < %s | FileCheck %s --check-prefix=LA32D
; RUN: llc --mtriple=loongarch64 --mattr=+f,-d < %s | FileCheck %s --check-prefix=LA64F
; RUN: llc --mtriple=loongarch64 --mattr=+d < %s | FileCheck %s --check-prefix=LA64D

define float @rint_f32(float %f) nounwind {
; LA32F-LABEL: rint_f32:
; LA32F:       # %bb.0: # %entry
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(rintf)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: rint_f32:
; LA32D:       # %bb.0: # %entry
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32D-NEXT:    bl %plt(rintf)
; LA32D-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: rint_f32:
; LA64F:       # %bb.0: # %entry
; LA64F-NEXT:    frint.s $fa0, $fa0
; LA64F-NEXT:    ret
;
; LA64D-LABEL: rint_f32:
; LA64D:       # %bb.0: # %entry
; LA64D-NEXT:    frint.s $fa0, $fa0
; LA64D-NEXT:    ret
entry:
  %0 = tail call float @llvm.rint.f32(float %f)
  ret float %0
}

declare float @llvm.rint.f32(float)

define double @rint_f64(double %d) nounwind {
; LA32F-LABEL: rint_f64:
; LA32F:       # %bb.0: # %entry
; LA32F-NEXT:    addi.w $sp, $sp, -16
; LA32F-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32F-NEXT:    bl %plt(rint)
; LA32F-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32F-NEXT:    addi.w $sp, $sp, 16
; LA32F-NEXT:    ret
;
; LA32D-LABEL: rint_f64:
; LA32D:       # %bb.0: # %entry
; LA32D-NEXT:    addi.w $sp, $sp, -16
; LA32D-NEXT:    st.w $ra, $sp, 12 # 4-byte Folded Spill
; LA32D-NEXT:    bl %plt(rint)
; LA32D-NEXT:    ld.w $ra, $sp, 12 # 4-byte Folded Reload
; LA32D-NEXT:    addi.w $sp, $sp, 16
; LA32D-NEXT:    ret
;
; LA64F-LABEL: rint_f64:
; LA64F:       # %bb.0: # %entry
; LA64F-NEXT:    addi.d $sp, $sp, -16
; LA64F-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; LA64F-NEXT:    bl %plt(rint)
; LA64F-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; LA64F-NEXT:    addi.d $sp, $sp, 16
; LA64F-NEXT:    ret
;
; LA64D-LABEL: rint_f64:
; LA64D:       # %bb.0: # %entry
; LA64D-NEXT:    frint.d $fa0, $fa0
; LA64D-NEXT:    ret
entry:
  %0 = tail call double @llvm.rint.f64(double %d)
  ret double %0
}

declare double @llvm.rint.f64(double)
