`ifndef _DECODER_SV
`define _DECODER_SV

`ifdef VERILATOR
`include "include/common.sv"
`include "include/pipes.sv"
`else
`else

`endif 

module decoder
    import common::*;
    import pipes::*;(
        input u32 raw_instr,
        output control_t ctl,
        output is_exception
    );
    wire [6:0] f7 = raw_instr[6:0];
    wire [2:0] f3 = raw_instr[14:12];
    wire [6:0] f7_r = raw_instr[31:25];
    wire [5:0] f6_i =raw_instr[31:26];
    wire [11:0] csr = raw_instr[31:20];

    always_comb begin
        ctl= '0;
        is_exception=0;
        if(raw_instr == 32'h5006b)begin
            
        end
        else begin
        unique case(f7)
            F7_ADDI:begin
                unique case(f3)
                    F3_ADDI:begin
                       ctl.op=ADDI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_ADD;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_XORI:begin
                       ctl.op=XORI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_XOR;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_ORI:begin
                       ctl.op=ORI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_OR;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_ANDI:begin
                       ctl.op=ANDI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_AND;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_SLLI:begin
                       ctl.op=SLLI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_SLLI;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_SLTIU:begin
                       ctl.op=SLTIU;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_SLTIU;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_SLTI:begin
                       ctl.op=SLTI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_SLTI;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b1;
                    end
                    F3_SRLI:begin
                        unique case(f6_i)
                            F6_I_SRLI:begin
                                ctl.op=SRLI;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRLI;
                                ctl.typ=I_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b1;
                            end
                            F6_I_SRAI:begin
                                ctl.op=SRAI;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRAI;
                                ctl.typ=I_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b1;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            F7_LUI:begin 
                ctl.op=LUI;
                ctl.regwrite=1'b1;
                ctl.alufunc=ALU_ADD;
                ctl.typ=U_TYPE;
                ctl.memwrite=1'b0;
                ctl.memread=1'b0;
                ctl.alusrc=1'b1;
            end
            F7_ADD:begin 
                unique case(f7_r)
                    F7_R_ADD:begin
                        unique case(f3)
                            F3_ADD:begin
                                ctl.op=ADD;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_ADD;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_OR:begin
                                ctl.op=OR;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_OR;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_AND:begin
                                ctl.op=AND;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_AND;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_XOR:begin
                                ctl.op=XOR;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_XOR;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SRL:begin
                                ctl.op=SRL;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRL;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SLT:begin
                                ctl.op=SLT;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SLT;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SLTU:begin
                                ctl.op=SLTU;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SLTU;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SLL:begin
                                ctl.op=SLL;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SLL;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    F7_R_SUB:begin
                        unique case(f3)
                            F3_SUB:begin
                                ctl.op=SUB;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SUB;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SRA:begin
                                ctl.op=SRA;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRA;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end

                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    F7_R_DIVU:begin
                        unique case(f3)
                            F3_DIVU:begin
                                ctl.op=DIVU;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_DIVU;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_MUL:begin
                                ctl.op=MUL;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_MUL;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_DIV:begin
                                ctl.op=DIV;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_DIV;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_REMU:begin
                                ctl.op=REMU;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_REMU;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_REM:begin
                                ctl.op=REM;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_REM;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            F7_SD:begin
                unique case(f3)
                    F3_SD:begin
                        ctl.op=SD;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=S_TYPE;
                        ctl.memwrite=1'b1;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE8;
                    end
                    F3_SW:begin
                        ctl.op=SW;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=S_TYPE;
                        ctl.memwrite=1'b1;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE4;
                    end
                    F3_SH:begin
                        ctl.op=SH;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=S_TYPE;
                        ctl.memwrite=1'b1;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE2;
                    end
                    F3_SB:begin
                        ctl.op=SB;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=S_TYPE;
                        ctl.memwrite=1'b1;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE1;
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            
            F7_LD:begin
                unique case(f3)
                    F3_LD:begin
                        ctl.op=LD;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE8;
                        ctl.mem_unsigned=1'b0;
                    end
                    F3_LW:begin
                        ctl.op=LW;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE4;
                        ctl.mem_unsigned=1'b0;
                    end
                    F3_LWU:begin
                        ctl.op=LWU;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE4;
                        ctl.mem_unsigned=1'b1;
                    end
                    F3_LHU:begin
                        ctl.op=LHU;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE2;
                        ctl.mem_unsigned=1'b1;
                    end
                    F3_LBU:begin
                        ctl.op=LBU;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE1;
                        ctl.mem_unsigned=1'b1;
                    end
                    F3_LH:begin
                        ctl.op=LH;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE2;
                        ctl.mem_unsigned=1'b0;
                    end
                    F3_LB:begin
                        ctl.op=LB;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b1;
                        ctl.alusrc=1'b1;
                        ctl.msize=MSIZE1;
                        ctl.mem_unsigned=1'b0;
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            F7_BEQ:begin
                unique case(f3)
                    F3_BEQ:begin
                        ctl.op=BEQ;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=B_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_BNE:begin
                        ctl.op=BNE;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=B_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_BGEU:begin
                        ctl.op=BGEU;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=B_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_BLTU:begin
                        ctl.op=BLTU;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=B_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_BGE:begin
                        ctl.op=BGE;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=B_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_BLT:begin
                        ctl.op=BLT;
                        ctl.regwrite=1'b0;
                        ctl.alufunc=ALU_ADD;
                        ctl.typ=B_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            F7_JAL:begin
                ctl.op=JAL;
                ctl.regwrite=1'b1;
                ctl.alufunc=ALU_ADD;
                ctl.typ=J_TYPE;
                ctl.memwrite=1'b0;
                ctl.memread=1'b0;
                ctl.alusrc=1'b1;
                ctl.branch=1'b1;
            end
            F7_JALR:begin
                ctl.op=JALR;
                ctl.regwrite=1'b1;
                ctl.alufunc=ALU_ADD;
                ctl.typ=I_TYPE;
                ctl.memwrite=1'b0;
                ctl.memread=1'b0;
                ctl.alusrc=1'b1;
                ctl.branch=1'b1;
            end
            F7_AUIPC:begin
                ctl.op=AUIPC;
                ctl.regwrite=1'b1;
                ctl.alufunc=ALU_ADD;
                ctl.typ=U_TYPE;
                ctl.memwrite=1'b0;
                ctl.memread=1'b0;
                ctl.alusrc=1'b1;
            end
            F7_ADDIW:begin
                unique case(f3)
                    F3_ADDIW:begin
                        ctl.op=ADDIW;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_ADDIW;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_SLLIW:begin
                        ctl.op=SLLIW;
                        ctl.regwrite=1'b1;
                        ctl.alufunc=ALU_SLLIW;
                        ctl.typ=I_TYPE;
                        ctl.memwrite=1'b0;
                        ctl.memread=1'b0;
                        ctl.alusrc=1'b1;
                    end
                    F3_SRLIW:begin
                        unique case(f6_i)
                            F6_I_SRLIW:begin
                                ctl.op=SRLIW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRLIW;
                                ctl.typ=I_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b1;
                            end
                            F6_I_SRAIW:begin
                                ctl.op=SRAIW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRAIW;
                                ctl.typ=I_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b1;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            F7_SLLW:begin 
                unique case(f7_r)
                    F7_R_SLLW:begin
                        unique case(f3)
                            F3_SLLW:begin
                                ctl.op=SLLW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SLLW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_ADDW:begin
                                ctl.op=ADDW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_ADDW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SRLW:begin
                                ctl.op=SRLW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRLW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    F7_R_SUBW:begin
                        unique case(f3)
                            F3_SUBW:begin
                                ctl.op=SUBW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SUBW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_SRAW:begin
                                ctl.op=SRAW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_SRAW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    F7_R_REMW:begin
                        unique case(f3)
                            F3_REMW:begin
                                ctl.op=REMW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_REMW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_REMUW:begin
                                ctl.op=REMUW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_REMUW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_MULW:begin
                                ctl.op=MULW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_MULW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_DIVW:begin
                                ctl.op=DIVW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_DIVW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            F3_DIVUW:begin
                                ctl.op=DIVUW;
                                ctl.regwrite=1'b1;
                                ctl.alufunc=ALU_DIVUW;
                                ctl.typ=R_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end
            F7_CSRRS:begin
                unique case(f3)
                    F3_CSRRS:begin
                       ctl.op=CSRRS;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_OR;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b0;
                       ctl.csr=csr;
                    end
                    F3_CSRRC:begin
                       ctl.op=CSRRC;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_CSRRC;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b0;
                       ctl.csr=csr;
                    end
                    F3_CSRRW:begin
                       ctl.op=CSRRW;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_CSRRW;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b0;
                       ctl.csr=csr;
                    end
                    F3_CSRRSI:begin
                       ctl.op=CSRRSI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_OR;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b0;
                       ctl.csr=csr;
                    end
                    F3_CSRRCI:begin
                       ctl.op=CSRRCI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_CSRRCI;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b0;
                       ctl.csr=csr;
                    end
                    F3_CSRRWI:begin
                       ctl.op=CSRRWI;
                       ctl.regwrite=1'b1;
                       ctl.alufunc=ALU_CSRRWI;
                       ctl.typ=I_TYPE;
                       ctl.memwrite=1'b0;
                       ctl.memread=1'b0;
                       ctl.alusrc=1'b0;
                       ctl.csr=csr;
                    end
                    F3_MRET:begin
                        unique case(f7_r)
                            F7_R_MRET:begin
                                ctl.op=MRET;
                                ctl.regwrite=1'b0;
                                ctl.alufunc=ALU_NONE;
                                ctl.typ=I_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                                ctl.mret=1'b1;
                            end
                            F7_R_ECALL:begin
                                ctl.op=ECALL;
                                ctl.regwrite=1'b0;
                                ctl.alufunc=ALU_NONE;
                                ctl.typ=I_TYPE;
                                ctl.memwrite=1'b0;
                                ctl.memread=1'b0;
                                ctl.alusrc=1'b0;
                                ctl.is_exception=1'b1;
                                ctl.exception=ENVIRONMENT_CALL;
                            end
                            default:begin
                                is_exception=1'b1;
                            end
                        endcase
                       
                    end
                    default:begin
                        is_exception=1'b1;
                    end
                endcase
            end 
            default:begin
                is_exception=1'b1;
            end
        endcase
        end
    end
endmodule

`endif 