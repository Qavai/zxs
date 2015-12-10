;Таблицы команд. После CB
P586
VERSION T310

include globals.asi

CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel, DS:nothing

nCB_0:		;RLC B
 mov cl,[bp.rB]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rB],cl
 tact 8
 endc

nCB_1:		;RLC C
 mov cl,[bp.rC]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rC],cl
 tact 8
 endc

nCB_2:		;RLC D
 mov cl,[bp.rD]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rD],cl
 tact 8
 endc nCB_2,'2'

nCB_3:		;RLC E
 mov cl,[bp.rE]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rE],cl
 tact 8
 endc nCB_3,'3'

nCB_4:		;RLC H
 mov cl,[bp.rH]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rH],cl
 tact 8
 endc nCB_4,'4'

nCB_5:		;RLC L
 mov cl,[bp.rL]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rL],cl
 tact 8
 endc nCB_5,'5'

nCB_6:		;RLC (HL)
 mov bx,[bp.rHL]
 mov cl,[bx]
 sahf
 rol cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 test bh,192
 jz nCB_6_1
 mov [bx],cl
nCB_6_1:
 tact 15
 endc

nCB_7:		;RLC A
 sahf
 rol al,1
 lahf
 test al,al
 ror ah,1
 lahf
 tact 8
 endc

nCB_8:		;RRC B
 mov cl,[bp.rB]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rB],cl
 tact 8
 endc nCB_8,'8'

nCB_9:		;RRC C
 mov cl,[bp.rC]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rC],cl
 tact 8
 endc nCB_9,'9'

nCB_A:		;RRC D
 mov cl,[bp.rD]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rD],cl
 tact 8
 endc nCB_a,'A'

nCB_B:		;RRC E
 mov cl,[bp.rE]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rE],cl
 tact 8
 endc nCB_b,'B'

nCB_C:		;RRC H
 mov cl,[bp.rH]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rH],cl
 tact 8
 endc nCB_c,'C'

nCB_D:		;RRC L
 mov cl,[bp.rL]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 mov [bp.rL],cl
 tact 8
 endc nCB_d,'D'

nCB_E:		;RRC (HL)
 mov bx,[bp.rHL]
 mov cl,[bx]
 sahf
 ror cl,1
 lahf
 test cl,cl
 ror ah,1
 lahf
 test bh,192
 jz nCB_e1
 mov [bx],cl
nCB_e1:
 tact 15
 endc nCB_e,'E'

nCB_F:		;RRC A
 sahf
 ror al,1
 lahf
 test al,al
 ror ah,1
 lahf
 tact 8
 endc nCB_f,'F'

nCB_10:		;RL B
 mov cl,[bp.rB]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rB],cl
 and ah,0EDh
 tact 8
 endc nCB_10,'0'

nCB_11:		;RL C
 mov cl,[bp.rC]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rC],cl
 and ah,0EDh
 tact 8
 endc nCB_11,'1'

nCB_12:		;RL D
 mov cl,[bp.rD]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rD],cl
 and ah,0EDh
 tact 8
 endc nCB_12,'2'

nCB_13:		;RL E
 mov cl,[bp.rE]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rE],cl
 and ah,0EDh
 tact 8
 endc nCB_13,'3'

nCB_14:		;RL H
 mov cl,[bp.rH]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rH],cl
 and ah,0EDh
 tact 8
 endc nCB_14,'4'

nCB_15:		;RL L
 mov cl,[bp.rL]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rL],cl
 and ah,0EDh
 tact 8
 endc nCB_15,'5'

nCB_16:		;RL (HL)
 mov bx,[bp.rHL]
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nCB_161
 mov [bx],cl
nCB_161:
 and ah,0EDh
 tact 15
 endc nCB_16,'6'

nCB_17:		;RL A
 sahf
 rcl al,1
 inc al
 dec al
 lahf
 tact 8
 and ah,0EDh
 endc nCB_17,'7'

nCB_18:		;RR B
 mov cl,[bp.rB]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rB],cl
 and ah,0EDh
 tact 8
 endc nCB_18,'8'

nCB_19:		;RR C
 mov cl,[bp.rC]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rC],cl
 and ah,0EDh
 tact 8
 endc nCB_19,'9'

nCB_1A:		;RR D
 mov cl,[bp.rD]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rD],cl
 and ah,0EDh
 tact 8
 endc nCB_1a,'A'

nCB_1B:		;RR E
 mov cl,[bp.rE]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rE],cl
 and ah,0EDh
 tact 8
 endc nCB_1b,'B'

nCB_1C:		;RR H
 mov cl,[bp.rH]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rH],cl
 and ah,0EDh
 tact 8
 endc nCB_1c,'C'

nCB_1D:		;RR L
 mov cl,[bp.rL]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 mov [bp.rL],cl
 and ah,0EDh
 tact 8
 endc nCB_1d,'D'

nCB_1E:		;RR (HL)
 mov bx,[bp.rHL]
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nCB_1e1
 mov [bx],cl
nCB_1e1:
 and ah,0EDh
 tact 15
 endc nCB_1e,'E'

nCB_1F:		;RR A
 sahf
 rcr al,1
 inc al
 dec al
 lahf
 tact 8
 and ah,0EDh
 endc nCB_1f,'F'

nCB_20:		;SLA B
 shl [bp.rB],1
 lahf
 tact 8
 and ah,237
 endc nCB_20,'0'

nCB_21:         ;SLA C
 shl [bp.rC],1
 lahf
 tact 8
 and ah,237
 endc nCB_21,'1'

nCB_22:         ;SLA D
 shl [bp.rD],1
 lahf
 tact 8
 and ah,237
 endc nCB_22,'2'

nCB_23:         ;SLA E
 shl [bp.rE],1
 lahf
 tact 8
 and ah,237
 endc nCB_23,'3'

nCB_24:         ;SLA H
 shl [bp.rH],1
 lahf
 tact 8
 and ah,237
 endc nCB_24,'4'

nCB_25:         ;SLA L
 shl [bp.rL],1
 lahf
 tact 8
 and ah,237
 endc nCB_25,'5'

nCB_26:         ;SLA (HL)
 mov bx,[bp.rHL]
 mov ch,[bx]
 shl ch,1
 lahf
 test bh,192
 jz nCB_261
 mov [bx],ch
nCB_261:
 and ah,237
 tact 15
 endc nCB_26,'6'

nCB_27:         ;SLA A
 shl al,1
 lahf
 tact 8
 and ah,237
 endc nCB_27,'7'

nCB_28:         ;SRA B
 sar [bp.rB],1
 lahf
 tact 8
 and ah,237
 endc nCB_28,'8'

nCB_29:         ;SRA C
 sar [bp.rC],1
 lahf
 tact 8
 and ah,237
 endc nCB_29,'9'

nCB_2A:         ;SRA D
 sar [bp.rD],1
 lahf
 tact 8
 and ah,237
 endc nCB_2a,'A'

nCB_2B:         ;SRA E
 sar [bp.rE],1
 lahf
 tact 8
 and ah,237
 endc nCB_2b,'B'

nCB_2C:         ;SRA H
 sar [bp.rH],1
 lahf
 tact 8
 and ah,237
 endc nCB_2c,'C'

nCB_2D:         ;SRA L
 sar [bp.rL],1
 lahf
 tact 8
 and ah,237
 endc nCB_2d,'D'

nCB_2E:         ;SRA (HL)
 mov bx,[bp.rHL]
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nCB_2e1
 mov [bx],ch
nCB_2e1:
 and ah,237
 tact 15
 endc nCB_2e,'E'

nCB_2F:         ;SRA A
 sar al,1
 lahf
 tact 8
 and ah,237
 endc nCB_2f,'F'

nCB_30:		;SLL B
 stc
 rcl [bp.rB],1
 lahf
 tact 8
 and ah,237
 endc nCB_30,'0'

nCB_31:         ;SLL C
 stc
 rcl [bp.rC],1
 lahf
 tact 8
 and ah,237
 endc nCB_31,'1'

nCB_32:         ;SLL D
 stc
 rcl [bp.rD],1
 lahf
 tact 8
 and ah,237
 endc nCB_32,'2'

nCB_33:         ;SLL E
 stc
 rcl [bp.rE],1
 lahf
 tact 8
 and ah,237
 endc nCB_33,'3'

nCB_34:         ;SLL H
 stc
 rcl [bp.rH],1
 lahf
 tact 8
 and ah,237
 endc nCB_34,'4'

nCB_35:         ;SLL L
 stc
 rcl [bp.rL],1
 lahf
 tact 8
 and ah,237
 endc nCB_35,'5'

nCB_36:         ;SLL (HL)
 mov bx,[bp.rHL]
 stc
 mov ch,[bx]
 rcl ch,1
 lahf
 test bh,192
 jz nCB_361
 mov [bx],ch
nCB_361:
 and ah,237
 tact 15
 endc nCB_36,'6'

nCB_37:         ;SLL A
 stc
 rcl al,1
 lahf
 tact 8
 and ah,237
 endc nCB_37,'7'

nCB_38:         ;SRL B
 shr [bp.rB],1
 lahf
 tact 8
 and ah,237
 endc nCB_38,'8'

nCB_39:         ;SRL C
 shr [bp.rC],1
 lahf
 tact 8
 and ah,237
 endc nCB_39,'9'

nCB_3A:         ;SRL D
 shr [bp.rD],1
 lahf
 tact 8
 and ah,237
 endc nCB_3a,'A'

nCB_3B:         ;SRL E
 shr [bp.rE],1
 lahf
 tact 8
 and ah,237
 endc nCB_3b,'B'

nCB_3C:         ;SRL H
 shr [bp.rH],1
 lahf
 tact 8
 and ah,237
 endc nCB_3c,'C'

nCB_3D:         ;SRL L
 shr [bp.rL],1
 lahf
 tact 8
 and ah,237
 endc nCB_3d,'D'

nCB_3E:         ;SRL (HL)
 mov bx,[bp.rHL]
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nCB_3e1
 mov [bx],ch
nCB_3e1:
 and ah,237
 tact 15
 endc nCB_3e,'E'

nCB_3F:         ;SRL A
 shr al,1
 lahf
 tact 8
 and ah,237
 endc nCB_3f,'F'

nCB_40:
 bit_reg 0,rB
nCB_41:
 bit_reg 0,rC
nCB_42:
 bit_reg 0,rD
nCB_43:
 bit_reg 0,rE
nCB_44:
 bit_reg 0,rH
nCB_45:
 bit_reg 0,rL
nCB_46:
 bit_hl  0
nCB_47:
 bit_a   0

nCB_48:
 bit_reg 1,rB
nCB_49:
 bit_reg 1,rC
nCB_4A:
 bit_reg 1,rD
nCB_4B:
 bit_reg 1,rE
nCB_4C:
 bit_reg 1,rH
nCB_4D:
 bit_reg 1,rL
nCB_4E:
 bit_hl  1
nCB_4F:
 bit_a   1

nCB_50:
 bit_reg 2,rB
nCB_51:
 bit_reg 2,rC
nCB_52:
 bit_reg 2,rD
nCB_53:
 bit_reg 2,rE
nCB_54:
 bit_reg 2,rH
nCB_55:
 bit_reg 2,rL
nCB_56:
 bit_hl  2
nCB_57:
 bit_a   2

nCB_58:
 bit_reg 3,rB
nCB_59:
 bit_reg 3,rC
nCB_5A:
 bit_reg 3,rD
nCB_5B:
 bit_reg 3,rE
nCB_5C:
 bit_reg 3,rH
nCB_5D:
 bit_reg 3,rL
nCB_5E:
 bit_hl  3
nCB_5F:
 bit_a   3

nCB_60:
 bit_reg 4,rB
nCB_61:
 bit_reg 4,rC
nCB_62:
 bit_reg 4,rD
nCB_63:
 bit_reg 4,rE
nCB_64:
 bit_reg 4,rH
nCB_65:
 bit_reg 4,rL
nCB_66:
 bit_hl  4
nCB_67:
 bit_a   4

nCB_68:
 bit_reg 5,rB
nCB_69:
 bit_reg 5,rC
nCB_6A:
 bit_reg 5,rD
nCB_6B:
 bit_reg 5,rE
nCB_6C:
 bit_reg 5,rH
nCB_6D:
 bit_reg 5,rL
nCB_6E:
 bit_hl  5
nCB_6F:
 bit_a   5

nCB_70:
 bit_reg 6,rB
nCB_71:
 bit_reg 6,rC
nCB_72:
 bit_reg 6,rD
nCB_73:
 bit_reg 6,rE
nCB_74:
 bit_reg 6,rH
nCB_75:
 bit_reg 6,rL
nCB_76:
 bit_hl  6
nCB_77:
 bit_a   6

nCB_78:
 bit_reg 7,rB
nCB_79:
 bit_reg 7,rC
nCB_7A:
 bit_reg 7,rD
nCB_7B:
 bit_reg 7,rE
nCB_7C:
 bit_reg 7,rH
nCB_7D:
 bit_reg 7,rL
nCB_7E:
 bit_hl  7
nCB_7F:
 bit_a   7

nCB_80:
 res_reg 0,rB
nCB_81:
 res_reg 0,rC
nCB_82:
 res_reg 0,rD
nCB_83:
 res_reg 0,rE
nCB_84:
 res_reg 0,rH
nCB_85:
 res_reg 0,rL
nCB_86:
 res_hl  0
nCB_87:
 res_a	 0

nCB_88:
 res_reg 1,rB
nCB_89:
 res_reg 1,rC
nCB_8A:
 res_reg 1,rD
nCB_8B:
 res_reg 1,rE
nCB_8C:
 res_reg 1,rH
nCB_8D:
 res_reg 1,rL
nCB_8E:
 res_hl  1
nCB_8F:
 res_a	 1

nCB_90:
 res_reg 2,rB
nCB_91:
 res_reg 2,rC
nCB_92:
 res_reg 2,rD
nCB_93:
 res_reg 2,rE
nCB_94:
 res_reg 2,rH
nCB_95:
 res_reg 2,rL
nCB_96:
 res_hl  2
nCB_97:
 res_a	 2

nCB_98:
 res_reg 3,rB
nCB_99:
 res_reg 3,rC
nCB_9A:
 res_reg 3,rD
nCB_9B:
 res_reg 3,rE
nCB_9C:
 res_reg 3,rH
nCB_9D:
 res_reg 3,rL
nCB_9E:
 res_hl  3
nCB_9F:
 res_a	 3

nCB_A0:
 res_reg 4,rB
nCB_A1:
 res_reg 4,rC
nCB_A2:
 res_reg 4,rD
nCB_A3:
 res_reg 4,rE
nCB_A4:
 res_reg 4,rH
nCB_A5:
 res_reg 4,rL
nCB_A6:
 res_hl  4
nCB_A7:
 res_a	 4

nCB_A8:
 res_reg 5,rB
nCB_A9:
 res_reg 5,rC
nCB_AA:
 res_reg 5,rD
nCB_AB:
 res_reg 5,rE
nCB_AC:
 res_reg 5,rH
nCB_AD:
 res_reg 5,rL
nCB_AE:
 res_hl  5
nCB_AF:
 res_a	 5

nCB_B0:
 res_reg 6,rB
nCB_B1:
 res_reg 6,rC
nCB_B2:
 res_reg 6,rD
nCB_B3:
 res_reg 6,rE
nCB_B4:
 res_reg 6,rH
nCB_B5:
 res_reg 6,rL
nCB_B6:
 res_hl  6
nCB_B7:
 res_a	 6

nCB_B8:
 res_reg 7,rB
nCB_B9:
 res_reg 7,rC
nCB_BA:
 res_reg 7,rD
nCB_BB:
 res_reg 7,rE
nCB_BC:
 res_reg 7,rH
nCB_BD:
 res_reg 7,rL
nCB_BE:
 res_hl  7
nCB_BF:
 res_a	 7

nCB_C0:
 set_reg 0,rB
nCB_C1:
 set_reg 0,rC
nCB_C2:
 set_reg 0,rD
nCB_C3:
 set_reg 0,rE
nCB_C4:
 set_reg 0,rH
nCB_C5:
 set_reg 0,rL
nCB_C6:
 set_hl	 0
nCB_C7:
 set_a	 0

nCB_C8:
 set_reg 1,rB
nCB_C9:
 set_reg 1,rC
nCB_CA:
 set_reg 1,rD
nCB_CB:
 set_reg 1,rE
nCB_CC:
 set_reg 1,rH
nCB_CD:
 set_reg 1,rL
nCB_CE:
 set_hl	 1
nCB_CF:
 set_a	 1

nCB_D0:
 set_reg 2,rB
nCB_D1:
 set_reg 2,rC
nCB_D2:
 set_reg 2,rD
nCB_D3:
 set_reg 2,rE
nCB_D4:
 set_reg 2,rH
nCB_D5:
 set_reg 2,rL
nCB_D6:
 set_hl	 2
nCB_D7:
 set_a	 2

nCB_D8:
 set_reg 3,rB
nCB_D9:
 set_reg 3,rC
nCB_DA:
 set_reg 3,rD
nCB_DB:
 set_reg 3,rE
nCB_DC:
 set_reg 3,rH
nCB_DD:
 set_reg 3,rL
nCB_DE:
 set_hl	 3
nCB_DF:
 set_a	 3

nCB_E0:
 set_reg 4,rB
nCB_E1:
 set_reg 4,rC
nCB_E2:
 set_reg 4,rD
nCB_E3:
 set_reg 4,rE
nCB_E4:
 set_reg 4,rH
nCB_E5:
 set_reg 4,rL
nCB_E6:
 set_hl	 4
nCB_E7:
 set_a	 4

nCB_E8:
 set_reg 5,rB
nCB_E9:
 set_reg 5,rC
nCB_EA:
 set_reg 5,rD
nCB_EB:
 set_reg 5,rE
nCB_EC:
 set_reg 5,rH
nCB_ED:
 set_reg 5,rL
nCB_EE:
 set_hl	 5
nCB_EF:
 set_a	 5

nCB_F0:
 set_reg 6,rB
nCB_F1:
 set_reg 6,rC
nCB_F2:
 set_reg 6,rD
nCB_F3:
 set_reg 6,rE
nCB_F4:
 set_reg 6,rH
nCB_F5:
 set_reg 6,rL
nCB_F6:
 set_hl	 6
nCB_F7:
 set_a	 6

nCB_F8:
 set_reg 7,rB
nCB_F9:
 set_reg 7,rC
nCB_FA:
 set_reg 7,rD
nCB_FB:
 set_reg 7,rE
nCB_FC:
 set_reg 7,rH
nCB_FD:
 set_reg 7,rL
nCB_FE:
 set_hl	 7
nCB_FF:
 set_a	 7

CodeKernel Ends
End
