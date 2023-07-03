include "PRUInstrFormats.td"

//===----------------------------------------------------------------------===//
// PRU Type Profiles
//===----------------------------------------------------------------------===//

def SDT_PRUCallSeqStart : SDCallSeqStart<[SDTCisVT<0, i32>]>;
def SDT_PRUCallSeqEnd : SDCallSeqEnd<[SDTCisVT<0, i32>, SDTCisVT<1, i32>]>;
def SDT_PRUJmpLink : SDTypeProfile<0, 1, [SDTCisVT<0, iPTR>]>;
def SDT_PRUCall : SDTypeProfile<0, -1, [SSDTCisVT<0, iPTR>]>;
def SDT_PRUSelectCC : SDTypeProfile<1, 3, [SDTCisSameAs<0, 1>, SDTCisSameAs<1, 2>, SDTCisVT<3, i32>]>;

//===----------------------------------------------------------------------===//
// PRU Specific Node Definitions
//===----------------------------------------------------------------------===//

def PRUCall: SDNode<"PRUISD::CALL", SDT_PRUCall,
                  [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue, SDNPVariadic]>;
def PRURet: SDNode<"PRUISD::RET_FLAG", SDTNone,
                     [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;                  
def PRUJmpLink : SDNode<"PRUISD::JmpLink", SDT_PRUJmpLink,
                         [SDNPHasChain, SDNPOutGlue, SDNPOptInGlue,
                          SDNPVariadic]>;
def callseq_start : SDNode<"ISD::CALLSEQ_START", SDT_Cpu0CallSeqStart,
                           [SDNPHasChain, SDNPSideEffect, SDNPOutGlue]>;
def callseq_end : SDNode<"ISD::CALLSEQ_END", SDT_Cpu0CallSeqEnd,
                         [SDNPHasChain, SDNPOptInGlue,
                          SDNPSideEffect, SDNPOutGlue]>;
def PRUselectcc : SDNode<"PRUISD::SELECT_CC", SDT_PRUSelectCC, [SDNPInGlue]>;

//===----------------------------------------------------------------------===//
// Pattern fragments.
//===----------------------------------------------------------------------===//

def i8imm_31 : ImmLeaf<i8, [{return (uint8_t) Imm <= 31;}]>;
def i16imm_31 : ImmLeaf<i16, [{return (uint16_t) Imm <= 31;}]>;
def i32imm_31 : ImmLeaf<i32, [{return (uint32_t) Imm <= 31;}]>;

def i8imm_255 : ImmLeaf<i8, [{return (uint8_t) Imm <= 255;}]>;
def i16imm_255 : ImmLeaf<i16, [{return (uint16_t) Imm <= 255;}]>;
def i32imm_255 : ImmLeaf<i32, [{return (uint32_t) Imm <= 255;}]>;

def i16imm_65535 : ImmLeaf<i16, [{return (uint16_t) Imm <= 65535;}]>;
def i32imm_65535 : ImmLeaf<i32, [{return (uint32_t) Imm <= 65535;}]>;

//===----------------------------------------------------------------------===//
// PRU Operand Definitions
//===----------------------------------------------------------------------===//

//jump targets have OtherVT type
def jump_target : Operand<OtherVT> 
{ let OperandType = "OPERAND_PCREL"; }

def gaddr : Operand<iPTR>;

// PRU Complex Pattern Definitions.

def addr : Operand<iPTR>, ComplexPattern<iPTR, 2, "SelectAddress"> {
    let MIOperandInfo = (ops reg32: $base, i32imm: $offset);
    let PrintMethod = "print_addr";
}

def regaddr : Operand<iPTR>, ComplexPattern<iPTR, 2, "SelectAddressReg"> {
    let MIOperandInfo = (ops reg32: $base, reg32: $offset);
    let PrintMethod = "print_addr";
}

// Instructions specific format

// Arithmetic and logical instructions with 3 register operands
class ArithLogicR<bits<8> opcode, string opstr, SDNode opNode, bit isComm = 0>
  : ALU_Inst_RR<opcode, (outs GPRRegs:$ra), (ins GPRRegs:$rb, GPRRegs:$rc),
       !strconcat(opstr, "\t$ri, $rj, $rk"),
       [(set GPRRegs:$ri, (GPRegs:$rj, GPRegs:$rk))]> {
  let isCommutable = isComm;
  let isReMaterializable = 1;
}

// Arithmetic and logical instructions with 2 register operands
class ArithLogicI<bits<8> opcode, string  opstr, SDNode opNode>
  : class ALU_Inst_RI<opcode, (outs GPRegs:$ri), (ins GPRegs:$rj, i16imm_255:$const),
       !strconcat(opstr, "\t$ri, $rj, $const"),
       [(set GPRegs:$ri, (opNode GPRegs:$rj, i16imm_255:$const))]> {
  let isReMaterializable = 1;
}

//Load and store
class LDI<bits<8> opcode, string opstr, SDNode opNode, Operand od>
  : LS_Inst<opcode, (outs GPRegs:$ri), (ins od:$addr),
         !strconcat(opstr, "\t$ri, $addr"),
       [(set GPRegs:$ri, (opNode addr:$addr))], IILoad> {
}