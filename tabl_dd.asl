;Таблицы команд. После DD (регистр IX)
P586
VERSION T310

include globals.asi

CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel, DS:nothing

;DD_0...DD_8 - как основной набор (дальше писать это не буду)

nDD_9:          ;ADD IX,BC
 mov bx,[bp.rBC]
 tact 11
 add [bp.rIX],bx
 jc ndd91
 and ah,252
 endc
ndd91:
 and ah,252
 inc ah
 endc

nDD_19:          ;ADD IX,DE
 mov bx,[bp.rDE]
 tact 11
 add [bp.rIX],bx
 jc ndd91
 and ah,252
 endc

nDD_21:          ;LD IX,word
 mov bl,[si]
 mov bh,[si+1]
 tact 10
 add si,2
 mov [bp.rIX],bx
 endc ndd21,'1'

nDD_22:          ;LD (address),IX
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 test bh,192
 jz n22_1
 mov [bx],cl
n22_1:
 inc bx
 test bh,192
 jz n22_2
 mov [bx],ch
n22_2:
 tact 16
 endc

nDD_23:          ;INC IX
 inc [bp.rIX]
 tact 6
 endc

nDD_24:           ;INC XH ;старший байт IX.
 sahf
 inc [bp.rXH]
 tact 4
 lahf
 jo ndd241
 and ah,249
 jmp DoNewCommand
ndd241:
 or ah,4
 and ah,253
 endc ndd24,'4'

nDD_25:           ;DEC XH
 sahf
 dec [bp.rXH]
 lahf
 jo ndd251
 and ah,251
 jmp DoNewCommand
ndd251:
 or ah,6
 endc ndd25,'5'

nDD_26:           ;LD XH,0
;? ld xh,byte
 mov [bp.rXH],0
 endc ndd26,'6'

nDD_29:          ;ADD IX,IX
 add [bp.rIX],cx
 jc ndd291
 and ah,252
 endc ndd29,'9'
ndd291:
 and ah,252
 inc ah
 endc ndd28,'8'

nDD_2A:          ;LD IX,(address)
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov [bp.rIX],cx
 endc ndd2a,'A'

nDD_2B:          ;DEC IX
 dec [bp.rIX]
 endc ndd2b,'B'

nDD_2C:           ;INC XL
 sahf
 inc [bp.rXL]
 lahf
 jo ndd2c1
 and ah,249
 jmp DoNewCommand
ndd2c1:
 or ah,4
 and ah,253
 endc ndd2c,'C'

nDD_2D:           ;DEC XL
 sahf
 dec [bp.rXL]
 lahf
 jo ndd2d1
 and ah,251
 jmp DoNewCommand
ndd2d1:
 or ah,6
 endc ndd2d,'D'

nDD_2E:           ;LD XL,0
;? ld xl,byte
 mov [bp.rXL],0
 endc ndd2e,'E'

nDD_34:          ;INC (IX+byte)
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

nDD_35:          ;DEC (IX+byte)
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

nDD_36:          ;LD (IX+byte),byte
 getadr_i
 mov cl,[si]
 inc si
 test bh,192
 jz DoNewCommand
 mov [bx],cl
 endc

nDD_39:          ;ADD IX,SP
 add [bp.rIX],di
 jc ndd391
 and ah,252
 endc
ndd391:
 and ah,252
 inc ah
 endc

nDD_44:          ;LD B,XH
 mov [bp.rB],ch
 endc ndd44,'4'

nDD_45:          ;LD B,XL
 mov [bp.rB],cl
 endc nDD_45,'5'

nDD_46:          ;LD B,(IX+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rB],cl
 endc nDD_46,'6'

nDD_4C:          ;LD C,XH
 mov [bp.rC],ch
 endc nDD_4c,'C'

nDD_4D:          ;LD C,XL
 mov [bp.rC],cl
 endc nDD_4d,'D'

nDD_4E:          ;LD C,(IX+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rC],cl
 endc nDD_4e,'E'

nDD_54:          ;LD D,XH
 mov [bp.rD],ch
 endc nDD_54,'4'

nDD_55:          ;LD D,XL
 mov [bp.rD],cl
 endc nDD_55,'5'

nDD_56:          ;LD D,(IX+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rD],cl
 endc nDD_56,'6'

nDD_5C:          ;LD E,XH
 mov [bp.rE],ch
 endc nDD_5c,'C'

nDD_5D:          ;LD E,XL
 mov [bp.rE],cl
 endc nDD_5d,'D'

nDD_5E:          ;LD E,(IX+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rE],cl
 endc nDD_5e,'E'

nDD_60:          ;LD XH,B
 mov ch,[bp.rB]
 mov [bp.rXH],ch
 endc nDD_60,'0'

nDD_61:          ;LD XH,C
 mov ch,[bp.rC]
 mov [bp.rXH],ch
 endc nDD_61,'1'

nDD_62:          ;LD XH,D
 mov ch,[bp.rD]
 mov [bp.rXH],ch
 endc nDD_62,'2'

nDD_63:          ;LD XH,E
 mov ch,[bp.rE]
 mov [bp.rXH],ch
 endc nDD_63,'3'

nDD_64:          ;LD XH,XH
 endc nDD_64,'4'

nDD_65:          ;LD XH,XL
 mov ch,[bp.rXL]
 mov [bp.rXH],ch
 endc nDD_65,'5'

nDD_66:          ;LD H,(IX+byte)
 getadr_i
 mov ch,[bx]
 mov [bp.rH],ch
 endc nDD_66,'6'

nDD_67:          ;LD XH,A
 mov [bp.rXH],al
 endc nDD_67,'7'

nDD_68:          ;LD XL,B
 mov cl,[bp.rB]
 mov [bp.rXL],cl
 endc nDD_68,'8'

nDD_69:          ;LD XL,C
 mov cl,[bp.rC]
 mov [bp.rXL],cl
 endc nDD_69,'9'

nDD_6A:          ;LD XL,D
 mov cl,[bp.rD]
 mov [bp.rXL],cl
 endc nDD_6a,'A'

nDD_6B:          ;LD XL,E
 mov cl,[bp.rE]
 mov [bp.rXL],cl
 endc nDD_6b,'B'

nDD_6C:          ;LD XL,XH
 mov cl,[bp.rXH]
 mov [bp.rXL],cl
 endc nDD_6c,'C'

nDD_6D:          ;LD XL,XL
 endc nDD_6d,'D'

nDD_6E:          ;LD L,(IX+byte)
 getadr_i
 mov cl,[bx]
 mov [bp.rL],cl
 endc nDD_6e,'E'

nDD_6F:          ;LD XL,A
 mov [bp.rXL],al
 endc nDD_6f,'F'

nDD_70:          ;LD (IX+byte),B
 getadr_i
 test bh,192
 mov cl,[bp.rB]
 jz DoNewCommand
 mov [bx],cl
 endc

nDD_71:          ;LD (IX+byte),C
 getadr_i
 test bh,192
 mov cl,[bp.rC]
 jz DoNewCommand
 mov [bx],cl
 endc nDD_71,'1'

nDD_72:          ;LD (IX+byte),D
 getadr_i
 test bh,192
 mov cl,[bp.rD]
 jz DoNewCommand
 mov [bx],cl
 endc nDD_72,'2'

nDD_73:          ;LD (IX+byte),E
 getadr_i
 test bh,192
 mov cl,[bp.rE]
 jz DoNewCommand
 mov [bx],cl
 endc nDD_73,'3'

nDD_74:          ;LD (IX+byte),H
 getadr_i
 test bh,192
 mov cl,[bp.rH]
 jz DoNewCommand
 mov [bx],cl
 endc nDD_74,'4'

nDD_75:          ;LD (IX+byte),L
 getadr_i
 test bh,192
 mov cl,[bp.rL]
 jz DoNewCommand
 mov [bx],cl
 endc nDD_75,'5'

nDD_77:          ;LD (IX+byte),A
 getadr_i
 test bh,192
 jz DoNewCommand
 mov [bx],al
 endc nDD_77,'7'

nDD_7C:          ;LD A,XH
 mov al,ch
 endc nDD_7c,'C'

nDD_7D:          ;LD A,XL
 mov al,cl
 endc nDD_7d,'D'

nDD_7E:          ;LD A,(IX+byte)
 getadr_i
 mov al,[bx]
 endc nDD_7E,'E'

nDD_84:          ;ADD A,XH
 add al,ch
 lahf
 jo nDD_861
 and ah,249
 endc
nDD_861:
 or ah,4
 and ah,253
 endc

nDD_85:          ;ADD A,XL
 add al,cl
 lahf
 jo nDD_861
 and ah,249
 endc nDD_85,'5'

nDD_86:		;ADD A,(IX+byte)
 getadr_i	;bx=adr=(ix+byte)
 add al,[bx]
 lahf
 jo nDD_861
 and ah,249
 endc nDD_86,'6'

nDD_8C:          ;ADC A,XH
 sahf
 adc al,ch
 lahf
 jo nDD_8e1
 and ah,249
 jmp DoNewCommand
nDD_8e1:
 or ah,4
 and ah,253
 endc nDD_8c,'C'

nDD_8D:          ;ADC A,XL
 sahf
 adc al,cl
 lahf
 jo nDD_8e1
 and ah,249
 endc nDD_8d,'D'

nDD_8E:          ;ADC A,(IX+byte)
 getadr_i
 sahf
 adc al,[bx]
 lahf
 jo nDD_8e1
 and ah,249
 endc nDD_8e,'E'

nDD_94:           ;SUB XH
 sub al,ch
 lahf
 jo nDD_961
 and ah,251
 jmp DoNewCommand
nDD_961:
 or ah,6
 endc nDD_94,'4'

nDD_95:           ;SUB XL
 sub al,cl
 lahf
 jo nDD_961
 and ah,251
 endc nDD_95,'5'

nDD_96:           ;SUB (IX+byte)
 getadr_i
 sub al,[bx]
 lahf
 jo nDD_962
 and ah,251
 jmp DoNewCommand
nDD_962:
 or ah,6
 endc nDD_96,'6'

nDD_9C:           ;SBC A,XH
 sahf
 sbb al,ch
 lahf
 jo nDD_9e1
 and ah,251
 jmp DoNewCommand
nDD_9e1:
 or ah,6
 endc nDD_9c,'C'

nDD_9D:           ;SBC A,XL
 sahf
 sbb al,cl
 lahf
 jo nDD_9e1
 and ah,251
 endc nDD_9d,'D'

nDD_9E:           ;SBC A,(IX+byte)
 getadr_i
 sahf
 sbb al,[bx]
 lahf
 jo nDD_9e2
 and ah,251
 jmp DoNewCommand
nDD_9e2:
 or ah,6
 endc nDD_9e,'E'

nDD_A4:               ;AND XH
 and al,ch
 lahf
 mov cl,al
 and ah,0FDh
 and cl,28h
 or ah,10h
 or ah,cl
 endc nDD_a4,'4'

nDD_A5:               ;AND XL
 and al,cl
 lahf
 mov cl,al
 and ah,0FDh
 and cl,28h
 or ah,10h
 or ah,cl
 endc nDD_a5,'5'

nDD_A6:               ;AND (IX+byte)
 getadr_i
 and al,[bx]
 lahf
 mov cl,al
 and ah,0FDh
 and cl,28h
 or ah,10h
 or ah,cl
 endc nDD_a6,'6'

nDD_AC:               ;XOR XH
 xor al,ch
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nDD_ac,'C'

nDD_AD:               ;XOR XL
 xor al,cl
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nDD_ad,'D'

nDD_AE:               ;XOR (IX+byte)
 getadr_i
 xor al,[bx]
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nDD_ae,'E'

nDD_B4:               ;OR XH
 or al,ch
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nDD_b4,'4'

nDD_B5:               ;OR XL
 or al,cl
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nDD_b5,'5'

nDD_B6:               ;OR (IX+byte)
 getadr_i
 or al,[bx]
 lahf
 mov cl,al
 and ah,0EDh
 and cl,28h
 or ah,cl
 endc nDD_b6,'6'

nDD_BC:		;CP XH	;?
 cmp al,ch
 lahf
 jo nDD_bc1
 and ah,251
 jmp DoNewCommand
nDD_bc1:
 or ah,6
 endc nDD_bc,'C'

nDD_BD:		;CP XL	;?
 cmp al,cl
 lahf
 jo nDD_bd1
 and ah,251
 jmp DoNewCommand
nDD_bd1:
 or ah,6
 endc nDD_bd,'D'

nDD_BE:           ;CP (IX+byte)
 getadr_i
 cmp al,[bx]
 lahf
 jo nDD_be1
 and ah,251
 jmp DoNewCommand
nDD_be1:
 or ah,6
 endc nDD_be,'E'

nDD_CB:          ;DD CB d1 d2 , где d1-смещение(IX+d1),d2-код команды
 movsx bx,bptr [si]
 mov cl,[si+1]
 sub ch,ch
 add si,2
 add bx,[bp.rIX]
 jmp wptr [ss:ecx*2+CmdDD_CB]

nDD_DD:
;?
 dec dl
 dec si
 endc

nDD_E1:          ;POP IX
 mov cl,[di]
 mov ch,[di+1]
 add di,2
 mov [bp.rIX],cx
 endc

nDD_E3:      ;EX (SP),IX
 mov bl,[di]
 mov bh,[di+1]
 mov cx,[bp.rIX]
 mov [bp.rIX],bx
 mov bx,di
 test bh,192
 jz nDD_e31
 mov [bx],cl
nDD_e31:
 inc bx
 test bh,192
 jz DoNewCommand
 mov [bx],ch
 endc

nDD_E5:      ;PUSH IX
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

nDD_E9:      ;JP (IX)
 mov si,cx
 endc

nDD_ED:
;?
 dec dl
 dec si
 endc

nDD_F9:           ;LD SP,IX
 mov di,cx
 endc

nDD_FD:           ;*nop*
;?
 dec dl
 dec si
 endc

CodeKernel Ends
End
