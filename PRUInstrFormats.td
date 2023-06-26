// Generic PRU Format
class InstPRU<dag outs, dag ins, string asmstr, list<dag> pattern>
    : Instruction {
  field bits<32> Inst;

  let Namespace = "PRU";
  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString   = asmstr;
  let Pattern = pattern;
  let Size = 4;

  bits<8> Opcode = 0;
  let Inst{31-24} = Opcode;

  let DecoderNamespace = "PRU";
  field bits<32> SoftFail = 0;
  }

// PRU Pseudo Instructions Format
// Pseudo instructions are not real PRU instructions.
class PRUPseudoInst<dag outs, dag ins, string asmstr, list<dag> pattern>
    : InstPRU<outs, ins, asmstr, pattern> {
  let isPseudo = 1;
  let isCodeGenOnly = 1;
}

// ALU Instructions

// ALU register-register instruction
class ALU_Inst_RR<bits<8> opcode, dag outs, dag ins, string asmstr,
                  list<dag> pattern>
    : InstPRU<outs, ins, asmstr, pattern> {

  bits<5> ri; // destination register
  bits<5> rj; // source 1 register
  bits<5> rk; // source 2 register

  let Opcode = opcode;
  let Inst{23-18} = ri;
  let Inst{17-13} = rj;
  let Inst{12-8} = rk;
  let Inst{7-0} = 0;
}

// ALU register-immediate instruction
class ALU_Inst_RI<bits<8> opcode, dag outs, dag ins, string asmstr,
                  list<dag> pattern>
    : InstPRU<outs, ins, asmstr, pattern> {

  bits<5> ri; // destination register
  bits<5> rj; // source 1 register
  bits<14> const; // constant/immediate value

  let Opcode = opcode;
  let Inst{23-18} = ri;
  let Inst{17-13} = rj;
  let Inst{12-0} = const;
}

// Flow Control Instructions

class FC_Inst<bits<8> opcode, dag outs, dag ins, string asmstr,
                list<dag> pattern>
    : InstPRU<outs, ins, asmstr, pattern> {

  bits<5> ri;
  bits<5> ri;
  bits<4> condition;
  bits<10> addr;

  let Opcode = opcode;
  let Inst{23-19} = ri; 
  let Inst{18-14} = rj; 
  let Inst{13-10} = condition; 
  let Inst{9-0} = addr; 
}

// Load/Store Instructions
class LS_Inst<bits<8> opcode, dag outs, dag ins, string asmstr,
                list<dag> pattern>
    : InstPRU<outs, ins, asmstr, pattern> {

  bits<5> ri;
  bits<20> addr;

  let Opcode = opcode;
  let Inst{23-19} = ri;
  let Inst{19-0} = addr;
}