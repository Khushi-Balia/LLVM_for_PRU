//  Declarations that describe the PRU register file

// General register definition
class PRUReg<string name, list<string> altNames = []> : Register<name, altNames> {
    let Namespace = "PRU";
}

// Subregister indices
def sub_8_0 : SubRegIndex<8>;
def sub_8_8 : SubRegIndex<8, 8>;
def sub_16_0 : SubRegIndex<16>;
def sub_16_16 : SubRegIndex<16, 16>;

def sub_8_16 : ComposedSubRegIndex<sub_16_16, sub_8_0>;
def sub_8_24 : ComposedSubRegIndex<sub_16_16, sub_8_8>;

// Special purpose registers
def SP : PRUReg<2, "r2">;
def FP : PRUReg<4, "r4">;

// General purpose registers
foreach reg = 0-31 in {
    
    //for the r0,r1.. form
    def r # reg : PRUReg<"r" # reg>{
        let SubRegs = [!cast<PRUReg>("r" # reg # "_w0"),
                       !cast<PRUReg>("r" # reg # "_w2")];
        let SubRegIndices = [sub_16_0, sub_16_16];
        let CoveredBySubRegs = 1;
    }

    //for the r0.b1, r1.b3.. form
    foreach byte = 0-3 in {
        def r # reg # _b # byte : PRUReg<"r" # reg # ".b" # byte>;
    }

    //for the r0.w0, r1.w1.. form
    foreach word = [0, 2] in {
        def r # reg # _w # word : PRUReg<"r" # reg # ".w" # word> {
            // !cast -> bang operator
            let SubRegs = [!cast<PRUReg>("r" # reg # "_b" # word),
                           !cast<PRUReg>("r" # reg # "_b" # !add(word, 1))];
                           //!add -> adds and produces sum
            let SubRegIndices = [sub_8_0, sub_8_8];
            let CoveredBySubRegs = 1;
        }
    }
    
    //two-byte word: w1 spans bytes 1 and 2
    def r # reg # _w1 : PRUReg<"r" # reg # ".w1"> {
        let Aliases = [!cast<PRUReg>("r" # reg # "_w0"),
                       !cast<PRUReg>("r" # reg # "_w2")];
        let SubRegs = [!cast<PRUReg>("r" # reg # "_b1"),
                       !cast<PRUReg>("r" # reg # "_b2")];
        let SubRegIndices = [sub_8_0, sub_8_8];
        let CoveredBySubRegs = 1;
    }
}

//Byte-field
foreach n = 0-3 in {
    def b # n : PRUReg<"b" # n> {
        let SubRegs = [!cast<PRUReg>("r0_b" # n)];
        let SubRegIndices = [sub_8_8];
        let CoveredBySubRegs = 1;
    }
}

// Register Classes
// The order of registers represents the preferred allocation sequence.
// Registers are listed in the order caller-save, callee-save, specials

def breg : RegisterClass<"PRU", [i8], 8, (sequence "b%u", 0, 3)>;

def reg8 : RegisterClass<"PRU", [i8], 8, (add
    (sequence "r%u_b0", 0, 31),
    (sequence "r%u_b1", 0, 31),
    (sequence "r%u_b2", 0, 31),
    (sequence "r%u_b3", 0, 31)
)>;

def reg16 : RegisterClass<"PRU", [i16], 8, (add
    (sequence "r%u_w0", 0, 31),
    (sequence "r%u_w1", 0, 31),
    (sequence "r%u_w2", 0, 31)
)>;

def reg32 : RegisterClass<"PRU", [i32], 8, (sequence "r%u", 0, 31)>;