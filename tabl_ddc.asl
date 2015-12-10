;Таблицы команд. После DD CB
P586
VERSION T310

include globals.asi

CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel, DS:nothing

;Набор после DD CB
;В BX находится вычисленный адрес (IX+смещение)

nDD_CB_0:	;RLC (IX+byte),B
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb00
 mov [bx],cl
nddcb00:
 and ah,0EDh
 mov [bp.rB],cl
 jmp DoNewCommand

nDD_CB_1:           ;RLC (IX+byte),C
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb01
 mov [bx],cl
nddcb01:
 and ah,0EDh
 mov [bp.rC],cl
 jmp DoNewCommand

nDD_CB_2:           ;RLC (IX+byte),D
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb02
 mov [bx],cl
nddcb02:
 and ah,0EDh
 mov [bp.rD],cl
 jmp DoNewCommand

nDD_CB_3:           ;RLC (IX+byte),E
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb03
 mov [bx],cl
nddcb03:
 and ah,0EDh
 mov [bp.rE],cl
 jmp DoNewCommand

nDD_CB_4:           ;RLC (IX+byte),H
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb04
 mov [bx],cl
nddcb04:
 and ah,0EDh
 mov [bp.rH],cl
 jmp DoNewCommand

nDD_CB_5:           ;RLC (IX+byte),L
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb05
 mov [bx],cl
nddcb05:
 and ah,0EDh
 mov [bp.rL],cl
 jmp DoNewCommand

nDD_CB_6:           ;RLC (IX+byte)
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb06
 mov [bx],cl
nddcb06:
 and ah,0EDh
 jmp DoNewCommand

nDD_CB_7:           ;RLC (IX+byte),A
 mov cl,[bx]
 rol cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb07
 mov [bx],cl
nddcb07:
 and ah,0EDh
 mov al,cl
 jmp DoNewCommand

nDD_CB_8:           ;RRC (IX+byte),B
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb08
 mov [bx],cl
nddcb08:
 and ah,0EDh
 mov [bp.rB],cl
 jmp DoNewCommand

nDD_CB_9:           ;RRC (IX+byte),C
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb09
 mov [bx],cl
nddcb09:
 and ah,0EDh
 mov [bp.rC],cl
 jmp DoNewCommand

nDD_CB_A:           ;RRC (IX+byte),D
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb0A
 mov [bx],cl
nddcb0A:
 and ah,0EDh
 mov [bp.rD],cl
 jmp DoNewCommand

nDD_CB_B:           ;RRC (IX+byte),E
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb0B
 mov [bx],cl
nddcb0B:
 and ah,0EDh
 mov [bp.rE],cl
 jmp DoNewCommand

nDD_CB_C:           ;RRC (IX+byte),H
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb0C
 mov [bx],cl
nddcb0C:
 and ah,0EDh
 mov [bp.rH],cl
 jmp DoNewCommand

nDD_CB_D:           ;RRC (IX+byte),L
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb0D
 mov [bx],cl
nddcb0D:
 and ah,0EDh
 mov [bp.rL],cl
 jmp DoNewCommand

nDD_CB_E:           ;RRC (IX+byte)
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb0E
 mov [bx],cl
nddcb0E:
 and ah,0EDh
 jmp DoNewCommand

nDD_CB_F:           ;RRC (IX+byte),A
 mov cl,[bx]
 ror cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb0f
 mov [bx],cl
nddcb0f:
 and ah,0EDh
 mov al,cl
 jmp DoNewCommand

nDD_CB_10:          ;RL (IX+byte),B
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb100
 mov [bx],cl
nddcb100:
 and ah,237
 mov [bp.rB],cl
 jmp DoNewCommand

nDD_CB_11:          ;RL (IX+byte),C
 mov cl,[bx]
 sahf                
 rcl cl,1            
 inc cl              
 dec cl              
 lahf                
 test bh,192         
 jz nddcb101         
 mov [bx],cl         
nddcb101:            
 and ah,237          
 mov [bp.rC],cl
 jmp DoNewCommand

nDD_CB_12:          ;RL (IX+byte),D
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb102
 mov [bx],cl
nddcb102:
 and ah,237
 mov [bp.rD],cl
 jmp DoNewCommand

nDD_CB_13:          ;RL (IX+byte),E
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb103
 mov [bx],cl
nddcb103:
 and ah,237
 mov [bp.rE],cl
 jmp DoNewCommand

nDD_CB_14:          ;RL (IX+byte),H
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb104
 mov [bx],cl
nddcb104:
 and ah,237
 mov [bp.rH],cl
 jmp DoNewCommand

nDD_CB_15:          ;RL (IX+byte),L
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb105
 mov [bx],cl
nddcb105:
 and ah,237
 mov [bp.rL],cl
 jmp DoNewCommand

nDD_CB_16:          ;RL (IX+byte)
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb106
 mov [bx],cl
nddcb106:
 and ah,237
 jmp DoNewCommand

nDD_CB_17:          ;RL (IX+byte),A
 mov cl,[bx]
 sahf
 rcl cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb107
 mov [bx],cl
nddcb107:
 and ah,237
 mov al,cl
 jmp DoNewCommand

nDD_CB_18:          ;RR (IX+byte),B
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb108
 mov [bx],cl
nddcb108:
 and ah,237
 mov [bp.rB],cl
 jmp DoNewCommand

nDD_CB_19:          ;RR (IX+byte),C
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb109
 mov [bx],cl
nddcb109:
 and ah,237
 mov [bp.rC],cl
 jmp DoNewCommand

nDD_CB_1A:          ;RR (IX+byte),D
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb10A
 mov [bx],cl
nddcb10A:
 and ah,237
 mov [bp.rD],cl
 jmp DoNewCommand

nDD_CB_1B:          ;RR (IX+byte),E
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb10B
 mov [bx],cl
nddcb10B:
 and ah,237
 mov [bp.rE],cl
 jmp DoNewCommand

nDD_CB_1C:          ;RR (IX+byte),H
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb10C
 mov [bx],cl
nddcb10C:
 and ah,237
 mov [bp.rH],cl
 jmp DoNewCommand

nDD_CB_1D:          ;RR (IX+byte),L
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb10D
 mov [bx],cl
nddcb10D:
 and ah,237
 mov [bp.rL],cl
 jmp DoNewCommand

nDD_CB_1E:          ;RR (IX+byte)
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb10E
 mov [bx],cl
nddcb10E:
 and ah,237
 jmp DoNewCommand

nDD_CB_1F:          ;RR (IX+byte),A
 mov cl,[bx]
 sahf
 rcr cl,1
 inc cl
 dec cl
 lahf
 test bh,192
 jz nddcb10f
 mov [bx],cl
nddcb10f:
 and ah,237
 mov al,cl
 jmp DoNewCommand

nDD_CB_20:          ;SLA (IX+byte),B
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb20
 mov [bx],ch
nddcb20:
 and ah,237
 mov [bp.rB],ch
 jmp DoNewCommand

nDD_CB_21:          ;SLA (IX+byte),C
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb21
 mov [bx],ch
nddcb21:
 and ah,237
 mov [bp.rC],ch
 jmp DoNewCommand

nDD_CB_22:          ;SLA (IX+byte),D
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb22
 mov [bx],ch
nddcb22:
 and ah,237
 mov [bp.rD],ch
 jmp DoNewCommand

nDD_CB_23:          ;SLA (IX+byte),E
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb23
 mov [bx],ch
nddcb23:
 and ah,237
 mov [bp.rE],ch
 jmp DoNewCommand

nDD_CB_24:          ;SLA (IX+byte),H
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb24
 mov [bx],ch
nddcb24:
 and ah,237
 mov [bp.rH],ch
 jmp DoNewCommand

nDD_CB_25:          ;SLA (IX+byte),L
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb25
 mov [bx],ch
nddcb25:
 and ah,237
 mov [bp.rL],ch
 jmp DoNewCommand

nDD_CB_26:          ;SLA (IX+byte)
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb26
 mov [bx],ch
nddcb26:
 and ah,237
 jmp DoNewCommand

nDD_CB_27:          ;SLA (IX+byte),A
 mov ch,[bx]
 shl ch,1
 inc ch
 dec ch
 lahf
 test bh,192
 jz nddcb27
 mov [bx],ch
nddcb27:
 and ah,237
 mov al,ch
 jmp DoNewCommand

nDD_CB_28:         ;SRA (IX+byte),B
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb28
 mov [bx],ch
nddcb28:
 and ah,237
 mov [bp.rB],ch
 jmp DoNewCommand

nDD_CB_29:         ;SRA (IX+byte),C
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb29
 mov [bx],ch
nddcb29:
 and ah,237
 mov [bp.rC],ch
 jmp DoNewCommand

nDD_CB_2A:         ;SRA (IX+byte),D
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb2A
 mov [bx],ch
nddcb2A:
 and ah,237
 mov [bp.rD],ch
 jmp DoNewCommand

nDD_CB_2B:         ;SRA (IX+byte),E
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb2B
 mov [bx],ch
nddcb2B:
 and ah,237
 mov [bp.rE],ch
 jmp DoNewCommand

nDD_CB_2C:         ;SRA (IX+byte),H
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb2C
 mov [bx],ch
nddcb2C:
 and ah,237
 mov [bp.rH],ch
 jmp DoNewCommand

nDD_CB_2D:         ;SRA (IX+byte),L
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb2D
 mov [bx],ch
nddcb2D:
 and ah,237
 mov [bp.rL],ch
 jmp DoNewCommand

nDD_CB_2E:         ;SRA (IX+byte)
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb2E
 mov [bx],ch
nddcb2E:
 and ah,237
 jmp DoNewCommand

nDD_CB_2F:         ;SRA (IX+byte),A
 mov ch,[bx]
 sar ch,1
 lahf
 test bh,192
 jz nddcb2F
 mov [bx],ch
nddcb2F:
 and ah,237
 mov al,ch
 jmp DoNewCommand

nDD_CB_30:          ;SLL (IX+byte),B
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb30
 mov [bx],ch
nddcb30:
 and ah,237
 mov [bp.rB],ch
 jmp DoNewCommand

nDD_CB_31:          ;SLL (IX+byte),C
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb31
 mov [bx],ch
nddcb31:
 and ah,237
 mov [bp.rC],ch
 jmp DoNewCommand

nDD_CB_32:          ;SLL (IX+byte),D
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb32
 mov [bx],ch
nddcb32:
 and ah,237
 mov [bp.rD],ch
 jmp DoNewCommand

nDD_CB_33:          ;SLL (IX+byte),E
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb33
 mov [bx],ch
nddcb33:
 and ah,237
 mov [bp.rE],ch
 jmp DoNewCommand

nDD_CB_34:          ;SLL (IX+byte),H
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb34
 mov [bx],ch
nddcb34:
 and ah,237
 mov [bp.rH],ch
 jmp DoNewCommand

nDD_CB_35:          ;SLL (IX+byte),L
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb35
 mov [bx],ch
nddcb35:
 and ah,237
 mov [bp.rL],ch
 jmp DoNewCommand

nDD_CB_36:          ;SLL (IX+byte)
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb36
 mov [bx],ch
nddcb36:
 and ah,237
 jmp DoNewCommand

nDD_CB_37:          ;SLL (IX+byte),A
 mov ch,[bx]
 stc
 rcl ch,1
 lahf
 test bh,192
 jz nddcb37
 mov [bx],ch
nddcb37:
 and ah,237
 mov al,ch
 jmp DoNewCommand

nDD_CB_38:         ;SRL (IX+byte),B
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb38
 mov [bx],ch
nddcb38:
 and ah,237
 mov [bp.rB],ch
 jmp DoNewCommand

nDD_CB_39:         ;SRL (IX+byte),C
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb39
 mov [bx],ch
nddcb39:
 and ah,237
 mov [bp.rC],ch
 jmp DoNewCommand

nDD_CB_3A:         ;SRL (IX+byte),D
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb3A
 mov [bx],ch
nddcb3A:
 and ah,237
 mov [bp.rD],ch
 jmp DoNewCommand

nDD_CB_3B:         ;SRL (IX+byte),E
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb3B
 mov [bx],ch
nddcb3B:
 and ah,237
 mov [bp.rE],ch
 jmp DoNewCommand

nDD_CB_3C:         ;SRL (IX+byte),H
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb3C
 mov [bx],ch
nddcb3C:
 and ah,237
 mov [bp.rH],ch
 jmp DoNewCommand

nDD_CB_3D:         ;SRL (IX+byte),L
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb3D
 mov [bx],ch
nddcb3D:
 and ah,237
 mov [bp.rL],ch
 jmp DoNewCommand

nDD_CB_3E:         ;SRL (IX+byte)
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb3E
 mov [bx],ch
nddcb3E:
 and ah,237
 jmp DoNewCommand

nDD_CB_3F:         ;SRL (IX+byte),A
 mov ch,[bx]
 shr ch,1
 lahf
 test bh,192
 jz nddcb3F
 mov [bx],ch
nddcb3F:
 and ah,237
 mov al,ch
 jmp DoNewCommand

nDD_CB_40:
 bit_i  0
nDD_CB_41:
 bit_i  0
nDD_CB_42:
 bit_i  0
nDD_CB_43:
 bit_i  0
nDD_CB_44:
 bit_i  0
nDD_CB_45:
 bit_i  0
nDD_CB_46:
 bit_i  0
nDD_CB_47:
 bit_i  0

nDD_CB_48:
 bit_i  1
nDD_CB_49:
 bit_i  1
nDD_CB_4A:
 bit_i  1
nDD_CB_4B:
 bit_i  1
nDD_CB_4C:
 bit_i  1
nDD_CB_4D:
 bit_i  1
nDD_CB_4E:
 bit_i  1
nDD_CB_4F:
 bit_i  1

nDD_CB_50:
 bit_i  2
nDD_CB_51:
 bit_i  2
nDD_CB_52:
 bit_i  2
nDD_CB_53:
 bit_i  2
nDD_CB_54:
 bit_i  2
nDD_CB_55:
 bit_i  2
nDD_CB_56:
 bit_i  2
nDD_CB_57:
 bit_i  2

nDD_CB_58:
 bit_i  3
nDD_CB_59:
 bit_i  3
nDD_CB_5A:
 bit_i  3
nDD_CB_5B:
 bit_i  3
nDD_CB_5C:
 bit_i  3
nDD_CB_5D:
 bit_i  3
nDD_CB_5E:
 bit_i  3
nDD_CB_5F:
 bit_i  3

nDD_CB_60:
 bit_i  4
nDD_CB_61:
 bit_i  4
nDD_CB_62:
 bit_i  4
nDD_CB_63:
 bit_i  4
nDD_CB_64:
 bit_i  4
nDD_CB_65:
 bit_i  4
nDD_CB_66:
 bit_i  4
nDD_CB_67:
 bit_i  4

nDD_CB_68:
 bit_i  5
nDD_CB_69:
 bit_i  5
nDD_CB_6A:
 bit_i  5
nDD_CB_6B:
 bit_i  5
nDD_CB_6C:
 bit_i  5
nDD_CB_6D:
 bit_i  5
nDD_CB_6E:
 bit_i  5
nDD_CB_6F:
 bit_i  5

nDD_CB_70:
 bit_i  6
nDD_CB_71:
 bit_i  6
nDD_CB_72:
 bit_i  6
nDD_CB_73:
 bit_i  6
nDD_CB_74:
 bit_i  6
nDD_CB_75:
 bit_i  6
nDD_CB_76:
 bit_i  6
nDD_CB_77:
 bit_i  6

nDD_CB_78:
 bit_i  7
nDD_CB_79:
 bit_i  7
nDD_CB_7A:
 bit_i  7
nDD_CB_7B:
 bit_i  7
nDD_CB_7C:
 bit_i  7
nDD_CB_7D:
 bit_i  7
nDD_CB_7E:
 bit_i  7
nDD_CB_7F:
 bit_i  7

nDD_CB_80:
 res_i_reg  0,rB
nDD_CB_81:
 res_i_reg  0,rC
nDD_CB_82:
 res_i_reg  0,rD
nDD_CB_83:
 res_i_reg  0,rE
nDD_CB_84:
 res_i_reg  0,rH
nDD_CB_85:
 res_i_reg  0,rL
nDD_CB_86:
 res_i  0
nDD_CB_87:
 res_i_a 0

nDD_CB_88:
 res_i_reg  1,rB
nDD_CB_89:
 res_i_reg  1,rC
nDD_CB_8A:
 res_i_reg  1,rD
nDD_CB_8B:
 res_i_reg  1,rE
nDD_CB_8C:
 res_i_reg  1,rH
nDD_CB_8D:
 res_i_reg  1,rL
nDD_CB_8E:
 res_i	1
nDD_CB_8F:
 res_i_a 1

nDD_CB_90:
 res_i_reg  2,rB
nDD_CB_91:
 res_i_reg  2,rC
nDD_CB_92:
 res_i_reg  2,rD
nDD_CB_93:
 res_i_reg  2,rE
nDD_CB_94:
 res_i_reg  2,rH
nDD_CB_95:
 res_i_reg  2,rL
nDD_CB_96:
 res_i  2
nDD_CB_97:
 res_i_a  2

nDD_CB_98:
 res_i_reg  3,rB
nDD_CB_99:
 res_i_reg  3,rC
nDD_CB_9A:
 res_i_reg  3,rD
nDD_CB_9B:
 res_i_reg  3,rE
nDD_CB_9C:
 res_i_reg  3,rH
nDD_CB_9D:
 res_i_reg  3,rL
nDD_CB_9E:
 res_i  3
nDD_CB_9F:
 res_i_a  3

nDD_CB_A0:
 res_i_reg  4,rB
nDD_CB_A1:
 res_i_reg  4,rC
nDD_CB_A2:
 res_i_reg  4,rD
nDD_CB_A3:
 res_i_reg  4,rE
nDD_CB_A4:
 res_i_reg  4,rH
nDD_CB_A5:
 res_i_reg  4,rL
nDD_CB_A6:
 res_i  4
nDD_CB_A7:
 res_i_a  4

nDD_CB_A8:
 res_i_reg  5,rB
nDD_CB_A9:
 res_i_reg  5,rC
nDD_CB_AA:
 res_i_reg  5,rD
nDD_CB_AB:
 res_i_reg  5,rE
nDD_CB_AC:      
 res_i_reg  5,rH
nDD_CB_AD:
 res_i_reg  5,rL
nDD_CB_AE:
 res_i  5
nDD_CB_AF:
 res_i_a  5

nDD_CB_B0:
 res_i_reg  6,rB
nDD_CB_B1:
 res_i_reg  6,rC
nDD_CB_B2:
 res_i_reg  6,rD
nDD_CB_B3:
 res_i_reg  6,rE
nDD_CB_B4:
 res_i_reg  6,rH
nDD_CB_B5:
 res_i_reg  6,rL
nDD_CB_B6:
 res_i  6
nDD_CB_B7:
 res_i_a  6

nDD_CB_B8:
 res_i_reg  7,rB
nDD_CB_B9:
 res_i_reg  7,rC
nDD_CB_BA:
 res_i_reg  7,rD
nDD_CB_BB:
 res_i_reg  7,rE
nDD_CB_BC:
 res_i_reg  7,rH
nDD_CB_BD:
 res_i_reg  7,rL
nDD_CB_BE:
 res_i  7
nDD_CB_BF:
 res_i_a  7

nDD_CB_C0:
 set_i_reg 0,rB
nDD_CB_C1:
 set_i_reg 0,rC
nDD_CB_C2:
 set_i_reg 0,rD
nDD_CB_C3:
 set_i_reg 0,rE
nDD_CB_C4:
 set_i_reg 0,rH
nDD_CB_C5:
 set_i_reg 0,rL
nDD_CB_C6:
 set_i 0
nDD_CB_C7:
 set_i_a 0

nDD_CB_C8:
 set_i_reg 1,rB
nDD_CB_C9:
 set_i_reg 1,rC
nDD_CB_CA:
 set_i_reg 1,rD
nDD_CB_CB:
 set_i_reg 1,rE
nDD_CB_CC:
 set_i_reg 1,rH
nDD_CB_CD:
 set_i_reg 1,rL
nDD_CB_CE:
 set_i 1
nDD_CB_CF:
 set_i_a 1

nDD_CB_D0:
 set_i_reg 2,rB
nDD_CB_D1:
 set_i_reg 2,rC
nDD_CB_D2:
 set_i_reg 2,rD
nDD_CB_D3:
 set_i_reg 2,rE
nDD_CB_D4:
 set_i_reg 2,rH
nDD_CB_D5:
 set_i_reg 2,rL
nDD_CB_D6:
 set_i 2
nDD_CB_D7:
 set_i_a 2

nDD_CB_D8:
 set_i_reg 3,rB
nDD_CB_D9:
 set_i_reg 3,rC
nDD_CB_DA:
 set_i_reg 3,rD
nDD_CB_DB:
 set_i_reg 3,rE
nDD_CB_DC:
 set_i_reg 3,rH
nDD_CB_DD:
 set_i_reg 3,rL
nDD_CB_DE:
 set_i 3
nDD_CB_DF:
 set_i_a 3

nDD_CB_E0:
 set_i_reg 4,rB
nDD_CB_E1:
 set_i_reg 4,rC
nDD_CB_E2:
 set_i_reg 4,rD
nDD_CB_E3:
 set_i_reg 4,rE
nDD_CB_E4:
 set_i_reg 4,rH
nDD_CB_E5:
 set_i_reg 4,rL
nDD_CB_E6:
 set_i 4
nDD_CB_E7:
 set_i_a 4

nDD_CB_E8:
 set_i_reg 5,rB
nDD_CB_E9:
 set_i_reg 5,rC
nDD_CB_EA:
 set_i_reg 5,rD
nDD_CB_EB:
 set_i_reg 5,rE
nDD_CB_EC:
 set_i_reg 5,rH
nDD_CB_ED:
 set_i_reg 5,rL
nDD_CB_EE:
 set_i 5
nDD_CB_EF:
 set_i_a 5

nDD_CB_F0:
 set_i_reg 6,rB
nDD_CB_F1:
 set_i_reg 6,rC
nDD_CB_F2:
 set_i_reg 6,rD
nDD_CB_F3:
 set_i_reg 6,rE
nDD_CB_F4:
 set_i_reg 6,rH
nDD_CB_F5:
 set_i_reg 6,rL
nDD_CB_F6:
 set_i 6
nDD_CB_F7:
 set_i_a 6

nDD_CB_F8:
 set_i_reg 7,rB
nDD_CB_F9:
 set_i_reg 7,rC
nDD_CB_FA:
 set_i_reg 7,rD
nDD_CB_FB:
 set_i_reg 7,rE
nDD_CB_FC:
 set_i_reg 7,rH
nDD_CB_FD:
 set_i_reg 7,rL
nDD_CB_FE:
 set_i 7
nDD_CB_FF:
 set_i_a 7

CodeKernel Ends
End
