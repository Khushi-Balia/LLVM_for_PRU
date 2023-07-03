; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s

define amdgpu_ps void @flat_atomic_fadd_f64_no_rtn_intrinsic(ptr %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: flat_atomic_fadd_f64_no_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY3]], %subreg.sub0, [[COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   FLAT_ATOMIC_ADD_F64 killed [[COPY4]], killed [[COPY5]], 0, 0, implicit $exec, implicit $flat_scr :: (volatile dereferenceable load store (s64) on %ir.ptr)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = call double @llvm.amdgcn.flat.atomic.fadd.f64.p1.f64(ptr %ptr, double %data)
  ret void
}

define amdgpu_ps double @flat_atomic_fadd_f64_rtn_intrinsic(ptr %ptr, double %data) {
  ; GFX90A_GFX940-LABEL: name: flat_atomic_fadd_f64_rtn_intrinsic
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY3]], %subreg.sub0, [[COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[FLAT_ATOMIC_ADD_F64_RTN:%[0-9]+]]:vreg_64_align2 = FLAT_ATOMIC_ADD_F64_RTN killed [[COPY4]], killed [[COPY5]], 0, 1, implicit $exec, implicit $flat_scr :: (volatile dereferenceable load store (s64) on %ir.ptr)
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY [[FLAT_ATOMIC_ADD_F64_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[FLAT_ATOMIC_ADD_F64_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = COPY [[COPY6]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = COPY [[COPY7]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = call double @llvm.amdgcn.flat.atomic.fadd.f64.p1.f64(ptr %ptr, double %data)
  ret double %ret
}

define amdgpu_ps void @flat_atomic_fadd_f64_no_rtn_atomicrmw(ptr %ptr, double %data) #0 {
  ; GFX90A_GFX940-LABEL: name: flat_atomic_fadd_f64_no_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY3]], %subreg.sub0, [[COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   FLAT_ATOMIC_ADD_F64 killed [[COPY4]], killed [[COPY5]], 0, 0, implicit $exec, implicit $flat_scr :: (load store syncscope("wavefront") monotonic (s64) on %ir.ptr)
  ; GFX90A_GFX940-NEXT:   S_ENDPGM 0
  %ret = atomicrmw fadd ptr %ptr, double %data syncscope("wavefront") monotonic
  ret void
}

define amdgpu_ps double @flat_atomic_fadd_f64_rtn_atomicrmw(ptr %ptr, double %data) #0 {
  ; GFX90A_GFX940-LABEL: name: flat_atomic_fadd_f64_rtn_atomicrmw
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64 = REG_SEQUENCE [[COPY3]], %subreg.sub0, [[COPY2]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE1]]
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vreg_64_align2 = COPY [[REG_SEQUENCE]]
  ; GFX90A_GFX940-NEXT:   [[FLAT_ATOMIC_ADD_F64_RTN:%[0-9]+]]:vreg_64_align2 = FLAT_ATOMIC_ADD_F64_RTN killed [[COPY4]], killed [[COPY5]], 0, 1, implicit $exec, implicit $flat_scr :: (load store syncscope("wavefront") monotonic (s64) on %ir.ptr)
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY [[FLAT_ATOMIC_ADD_F64_RTN]].sub0
  ; GFX90A_GFX940-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[FLAT_ATOMIC_ADD_F64_RTN]].sub1
  ; GFX90A_GFX940-NEXT:   $sgpr0 = COPY [[COPY6]]
  ; GFX90A_GFX940-NEXT:   $sgpr1 = COPY [[COPY7]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $sgpr0, $sgpr1
  %ret = atomicrmw fadd ptr %ptr, double %data syncscope("wavefront") monotonic
  ret double %ret
}

declare double @llvm.amdgcn.flat.atomic.fadd.f64.p1.f64(ptr, double)

attributes #0 = {"amdgpu-unsafe-fp-atomics"="true" }
