include "PRUInstrFormats.td"

// PRU Operand Definitions

def i8imm_31 : ImmLeaf<i8, [{return (uint8_t) Imm <= 31;}]>;
def i16imm_31 : ImmLeaf<i16, [{return (uint16_t) Imm <= 31;}]>;
def i32imm_31 : ImmLeaf<i32, [{return (uint32_t) Imm <= 31;}]>;

def i8imm_255 : ImmLeaf<i8, [{return (uint8_t) Imm <= 255;}]>;
def i16imm_255 : ImmLeaf<i16, [{return (uint16_t) Imm <= 255;}]>;
def i32imm_255 : ImmLeaf<i32, [{return (uint32_t) Imm <= 255;}]>;

def i16imm_65535 : ImmLeaf<i16, [{return (uint16_t) Imm <= 65535;}]>;
def i32imm_65535 : ImmLeaf<i32, [{return (uint32_t) Imm <= 65535;}]>;

//jump targets have OtherVT type
def jump_target : Operand<OtherVT> { let OperandType = "OPERAND_PCREL"; }

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
