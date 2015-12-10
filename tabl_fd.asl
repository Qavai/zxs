;Таблицы команд. После FD (регистр IY)
P586
VERSION T310

include globals.asi

CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel, DS:nothing

nFD_9:          ;ADD IY,BC
 mov bx,[bp.rBC]
 add [bp.rIY],bx
 jc ndd91
 and ah,252
 endc
ndd91:
 and ah,252
 inc ah
 endc

nFD_19:          ;ADD IY,DE
 mov bx,[bp.rDE]
 add [bp.rIY],bx
 jc ndd91
 and ah,252
 endc

nFD_21:          ;LD IY,word
 mov cl,[si]
 mov ch,[si+1]
 add si,2
 mov [bp.rIY],cx
 endc ndd21,'1'

nFD_22:          ;LD (address),IY
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 test bh,192
 jz n22_1
 mov [bx],cl
n22_1:
 inc bx
 test bh,192
 jz DoNewCommand
 mov [bx],ch
 endc ndd22,'2'

nFD_23:          ;INC IY
 inc [bp.rIY]
 endc ndd23,'3'

nFD_24:           ;INC YH ;старший байт IY.
 sahf
 inc [bp.rYH]
 lahf
 jo ndd241
 and ah,249
 jmp DoNewCommand
ndd241:
 or ah,4
 and ah,253
 endc ndd24,'4'

nFD_25:           ;DEC YH
 sahf
 dec [bp.rYH]
 lahf
 jo ndd251
 and ah,251
 jmp DoNewCommand
ndd251:
 or ah,6
 endc ndd25,'5'

nFD_26:           ;LD YH,0
;? ld YH,byte
 mov [bp.rYH],0
 endc ndd26,'6'

nFD_29:          ;ADD IY,IY
 add [bp.rIY],cx
 jc ndd291
 and ah,252
 endc ndd29,'9'
ndd291:
 and ah,252
 inc ah
 endc ndd28,'8'

nFD_2A:          ;LD IY,(address)
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov [bp.rIY],cx
 endc ndd2a,'A'

nFD_2B:          ;DEC IY
 dec [bp.rIY]
 endc ndd2b,'B'

nFD_2C:           ;INC YL
 sahf
 inc [bp.rYL]
 lahf
 jo ndd2c1
 and ah,249
 jmp DoNewCommand
ndd2c1:
 or ah,4
 and ah,253
 endc ndd2c,'C'

nFD_2D:           ;DEC YL
 sahf
 dec [bp.rYL]
 lahf
 jo ndd2d1
 and ah,251
 jmp DoNewCommand
ndd2d1:
 or ah,6
 endc ndd2d,'D'

nFD_2E:           ;LD YL,0
;? ld YL,byte
 mov [bp.rYL],0
 endc ndd2e,'E'

nFD_34:          ;INC (IY+byte)
 getadr_i
 sahf
 mov cl,[bx]
 inc cl
 lahf
 jo ndd343
 and ah,249
 test bh,192
 jz DoNewCommand
 mov [bx],cl
 endc
ndd343:
 or ah,4
 and ah,253
 test bh,192
 jz DoNewCommand
 mov [bx],cl
 endc

nFD_35:          ;DEC (IY+byte)
 getadr_i
 mov cl,[bx]
 sahf
 dec cl
 lahf
 jo n351
 and ah,251
 test bh,192
 jz DoNewCommand
 mov [bx],cl
 endc
n351:
 or ah,6
 test bh,192
 jz DoNewCommand
 mov [bx],cl
 endc

nFD_36:          ;LD (IY+byte),byte
 getadr_i
 mov cl,[si]
 inc si
 test bh,192
 jz DoNewCommand
 mov [bx],cl
 endc

nFD_39:          ;ADD IY,SP
 add [bp.rIY],di
 jc ndd391
 and ah,252
 endc
ndd391:
 and ah,252
 inc ah
 endc

nFD_44:          ;LD B,YH
 mov [bp.rB],ch
 endc ndd44,'4'

nFD_45:          ;LD B,YL
 mov [bp.rB],cl
 endc nFD_45,'5'

nFD_46:          ;LD B,(IY+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rB],cl
 endc nFD_46,'6'

nFD_4C:          ;LD C,YH
 mov [bp.rC],ch
 endc nFD_4c,'C'

nFD_4D:          ;LD C,YL
 mov [bp.rC],cl
 endc nFD_4d,'D'

nFD_4E:          ;LD C,(IY+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rC],cl
 endc nFD_4e,'E'

nFD_54:          ;LD D,YH
 mov [bp.rD],ch
 endc nFD_54,'4'

nFD_55:          ;LD D,YL
 mov [bp.rD],cl
 endc nFD_55,'5'

nFD_56:          ;LD D,(IY+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rD],cl
 endc nFD_56,'6'

nFD_5C:          ;LD E,YH
 mov [bp.rE],ch
 endc nFD_5c,'C'

nFD_5D:          ;LD E,YL
 mov [bp.rE],cl
 endc nFD_5d,'D'

nFD_5E:          ;LD E,(IY+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rE],cl
 endc nFD_5e,'E'

nFD_60:          ;LD YH,B
 mov ch,[bp.rB]
 mov [bp.rYH],ch
 endc nFD_60,'0'

nFD_61:          ;LD YH,C
 mov ch,[bp.rC]
 mov [bp.rYH],ch
 endc nFD_61,'1'

nFD_62:          ;LD YH,D
 mov ch,[bp.rD]
 mov [bp.rYH],ch
 endc nFD_62,'2'

nFD_63:          ;LD YH,E
 mov ch,[bp.rE]
 mov [bp.rYH],ch
 endc nFD_63,'3'

nFD_64:          ;LD YH,YH
 endc nFD_64,'4'

nFD_65:          ;LD YH,YL
 mov ch,[bp.rYL]
 mov [bp.rYH],ch
 endc nFD_65,'5'

nFD_66:          ;LD H,(IY+byte)
 getadr_i
 mov ch,[bx]
 mov [bp.rH],ch
 endc nFD_66,'6'

nFD_67:          ;LD YH,A
 mov [bp.rYH],al
 endc nFD_67,'7'

nFD_68:          ;LD YL,B
 mov cl,[bp.rB]
 mov [bp.rYL],cl
 endc nFD_68,'8'

nFD_69:          ;LD YL,C
 mov cl,[bp.rC]
 mov [bp.rYL],cl
 endc nFD_69,'9'

nFD_6A:          ;LD YL,D
 mov cl,[bp.rD]
 mov [bp.rYL],cl
 endc nFD_6a,'A'

nFD_6B:          ;LD YL,E
 mov cl,[bp.rE]
 mov [bp.rYL],cl
 endc nFD_6b,'B'

nFD_6C:          ;LD YL,YH
 mov cl,[bp.rYH]
 mov [bp.rYL],cl
 endc nFD_6c,'C'

nFD_6D:          ;LD YL,YL
 endc nFD_6d,'D'

nFD_6E:          ;LD L,(IY+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rL],cl
 endc nFD_6e,'E'

nFD_6F:          ;LD YL,A
 mov [bp.rYL],al
 endc nFD_6f,'F'

nFD_70:          ;LD (IY+byte),B
 getadr_i
 test bh,192
 mov cl,[bp.rB]
 jz DoNewCommand
 mov [bx],cl
 endc

nFD_71:          ;LD (IY+byte),C
 getadr_i
 test bh,192
 mov cl,[bp.rC]
 jz DoNewCommand
 mov [bx],cl
 endc nFD_71,'1'

nFD_72:          ;LD (IY+byte),D
 getadr_i
 test bh,192
 mov cl,[bp.rD]
 jz DoNewCommand
 mov [bx],cl
 endc nFD_72,'2'

nFD_73:          ;LD (IY+byte),E
 getadr_i
 test bh,192
 mov cl,[bp.rE]
 jz DoNewCommand
 mov [bx],cl
 endc nFD_73,'3'

nFD_74:          ;LD (IY+byte),H
 getadr_i
 test bh,192
 mov cl,[bp.rH]
 jz DoNewCommand
 mov [bx],cl
 endc nFD_74,'4'

nFD_75:          ;LD (IY+byte),L
 getadr_i
 test bh,192
 mov cl,[bp.rL]
 jz DoNewCommand
 mov [bx],cl
 endc nFD_75,'5'

nFD_77:          ;LD (IY+byte),A
 getadr_i
 test bh,192
 jz DoNewCommand
 mov [bx],al
 endc nFD_77,'7'

nFD_7C:          ;LD A,YH
 mov al,ch
 endc nFD_7c,'C'

nFD_7D:          ;LD A,YL
 mov al,cl
 endc nFD_7d,'D'

nFD_7E:          ;LD A,(IY+byte)
 getadr_i
 mov al,[bx]
 endc nFD_7E,'E'

nFD_84:          ;ADD A,YH
 add al,ch
 lahf
 jo nFD_861
 and ah,249
 endc
nFD_861:
 or ah,4
 and ah,253
 endc

nFD_85:          ;ADD A,YL
 add al,cl
 lahf
 jo nFD_861
 and ah,249
 endc nFD_85,'5'

nFD_86:		;ADD A,(IY+byte)
 getadr_i	;bx=adr=(IY+byte)
 add al,[bx]
 lahf
 jo nFD_861
 and ah,249
 endc nFD_86,'6'

nFD_8C:          ;ADC A,YH
 sahf
 adc al,ch
 lahf
 jo nFD_8e1
 and ah,249
 jmp DoNewCommand
nFD_8e1:
 or ah,4
 and ah,253
 endc nFD_8c,'C'

nFD_8D:          ;ADC A,YL
 sahf
 adc al,cl
 lahf
 jo nFD_8e1
 and ah,249
 endc nFD_8d,'D'

nFD_8E:          ;ADC A,(IY+byte)
 getadr_i
 sahf
 adc al,[bx]
 lahf
 jo nFD_8e1
 and ah,249
 endc nFD_8e,'E'

nFD_94:           ;SUB YH
 sub al,ch
 lahf
 jo nFD_961
 and ah,251
 jmp DoNewCommand
nFD_961:
 or ah,6
 endc nFD_94,'4'

nFD_95:           ;SUB YL
 sub al,cl
 lahf
 jo nFD_961
 and ah,251
 endc nFD_95,'5'

nFD_96:           ;SUB (IY+byte)
 getadr_i
 sub al,[bx]
 lahf
 jo nFD_962
 and ah,251
 jmp DoNewCommand
nFD_962:
 or ah,6
 endc nFD_96,'6'

nFD_9C:           ;SBC A,YH
 sahf
 sbb al,ch
 lahf
 jo nFD_9e1
 and ah,251
 jmp DoNewCommand
nFD_9e1:
 or ah,6
 endc nFD_9c,'C'

nFD_9D:           ;SBC A,YL
 sahf
 sbb al,cl
 lahf
 jo nFD_9e1
 and ah,251
 endc nFD_9d,'D'

nFD_9E:           ;SBC A,(IY+byte)
 getadr_i
 sahf
 sbb al,[bx]
 lahf
 jo nFD_9e2
 and ah,251
 jmp DoNewCommand
nFD_9e2:
 or ah,6
 endc nFD_9e,'E'

nFD_A4:               ;AND YH
 and al,ch
 lahf
 mov cl,al
 and ah,0FDh
 and cl,28h
 or ah,10h
 or ah,cl
 endc nFD_a4,'4'

nFD_A5:               ;AND YL
 and al,cl
 lahf
 mov cl,al
 and ah,0FDh
 and cl,28h
 or ah,10h
 or ah,cl
 endc nFD_a5,'5'

nFD_A6:               ;AND (IY+byte)
 getadr_i
 and al,[bx]
 lahf
 mov cl,al
 and ah,0FDh
 and cl,28h
 or ah,10h
 or ah,cl
 endc nFD_a6,'6'

nFD_AC:               ;XOR YH
 xor al,ch
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nFD_ac,'C'

nFD_AD:               ;XOR YL
 xor al,cl
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nFD_ad,'D'

nFD_AE:               ;XOR (IY+byte)
 getadr_i
 xor al,[bx]
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nFD_ae,'E'

nFD_B4:               ;OR YH
 or al,ch
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nFD_b4,'4'

nFD_B5:               ;OR YL
 or al,cl
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nFD_b5,'5'

nFD_B6:               ;OR (IY+byte)
 getadr_i
 or al,[bx]
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nFD_b6,'6'

nFD_BC:		;CP YH	;?
 cmp al,ch
 lahf
 jo nFD_bc1
 and ah,251
 jmp DoNewCommand
nFD_bc1:
 or ah,6
 endc nFD_bc,'C'

nFD_BD:		;CP YL	;?
 cmp al,cl
 lahf
 jo nFD_bd1
 and ah,251
 jmp DoNewCommand
nFD_bd1:
 or ah,6
 endc nFD_bd,'D'

nFD_BE:           ;CP (IY+byte)
 getadr_i
 cmp al,[bx]
 lahf
 jo nFD_be1
 and ah,251
 jmp DoNewCommand
nFD_be1:
 or ah,6
 endc nFD_be,'E'

nFD_CB:          ;DD CB d1 d2 , где d1-смещение(IY+d1),d2-код команды
 movsx bx,bptr [si]
 mov cl,[si+1]
 sub ch,ch
 add si,2
 add bx,[bp.rIY]
 jmp wptr [ss:ecx*2+CmdFD_CB]

nFD_DD:
;?
 dec dl
 dec si
 endc

nFD_E1:          ;POP IY
 mov cl,[di]
 mov ch,[di+1]
 add di,2
 mov [bp.rIY],cx
 endc

nFD_E3:      ;EX (SP),IY
 mov bl,[di]
 mov bh,[di+1]
 mov cx,[bp.rIY]
 mov [bp.rIY],bx
 mov bx,di
 test bh,192
 jz nFD_e31
 mov [bx],cl
nFD_e31:
 inc bx
 test bh,192
 jz DoNewCommand
 mov [bx],ch
 endc

nFD_E5:      ;PUSH IY
 dec di
 test di,0C000h
 jz ne5_0
 mov [di],ch
ne5_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],cl
 endc

nFD_E9:      ;JP (IY)
 mov si,cx
 endc

nFD_ED:
;?
 dec dl
 dec si
 endc

nFD_F9:           ;LD SP,IY
 mov di,cx
 endc

nFD_FD:           ;*nop*
;?
 dec dl
 dec si
 endc

CodeKernel Ends
End
