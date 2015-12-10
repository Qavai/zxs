;Таблицы команд. Обычная (главная)
P586
VERSION T310

include	globals.asi

CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel, DS:nothing
n0:			;NOP
 tact 4
 endc

n1:			;LD BC,word
 mov cl,[si]
 mov ch,[si+1]
 add si,2
 mov [bp.rBC],cx
 tact 10
 endc

n2:			;LD (BC),A
 tact 7
 mov bx,[bp.rBC]
 test bh,0C0h
 jz DoNewCommand
 mov [bx],al
 endc n2,'2'

n3:			;INC BC
 tact 6
 inc [bp.rBC]
 endc n3,'3'

n4:			;INC B
 tact 4
 sahf
 inc [bp.rB]
 lahf
 jo n4_1
 and ah,249
 jmp DoNewCommand
n4_1:
 and ah,253
 or ah,2Ch
 endc n4,'4'

n5:			;DEC B
 tact 4
 sahf
 dec [bp.rB]
 lahf
 jo n5_1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n5_1:
 or ah,2Eh
 endc n5,'5'

n6:			;LD B,byte
 mov cl,[si]
 inc si
 mov [bp.rB],cl
 tact 7
 endc n6,'6'

n7:			;RLCA
 sahf
 rol al,1
 lahf
 tact 4
;? and ah,237
 endc

n8:			;EX AF,AF'
 mov cx,[bp.rAF_]
 mov [bp.rAF_],ax
 mov ax,cx
 tact 4
 endc n8,'8'

n9:			;ADD HL,BC
 mov cx,[bp.rBC]
 and ah,not (m f5 or m fH or m f3 or m fN or m fC)
 add [bp.rHL],cx
 adc ah,0
 tact 11
 endc

nA:			;LD A,(BC)
 tact 7
 mov bx,[bp.rBC]
 mov al,[bx]
 endc na,'A'

nB:			;DEC BC
 tact 6
 dec [bp.rBC]
 endc nB,'B'

nC:			;INC C
 tact 4
 sahf
 inc [bp.rC]
 lahf
 jo nc_1
 and ah,249
 jmp DoNewCommand
nc_1:
 and ah,253
 or ah,2Ch
 endc nc,'C'

nD:			;DEC C
 tact 4
 sahf
 dec [bp.rC]
 lahf
 jo nd_1
 and ah,251
 or ah,28h
 jmp DoNewCommand
nd_1:
 or ah,2Eh
 endc nd,'D'

nE_:			;LD C,byte
 mov cl,[si]
 inc si
 mov [bp.rC],cl
 tact 7
 endc

nF:			;RRCA
 sahf
 ror al,1
 lahf
 tact 4
;? and ah,237
 endc nF,'F'

n10:			;DJNZ dis
 dec [bp.rB]
 jz n101
 movsx cx,bptr [si]
 add si,cx
 tact 13
 inc si
 endc
n101:
 inc si
 tact 8
 endc

n11:			;LD DE,word
 mov cl,[si]
 mov ch,[si+1]
 add si,2
 mov [bp.rDE],cx
 tact 10
 endc

n12:			;LD (DE),A
 tact 7
 mov bx,[bp.rDE]
 test bh,192
 jz DoNewCommand
 mov [bx],al
 endc n12,'2'

n13:			;INC DE
 inc [bp.rDE]
 tact 6
 endc n13,'3'

n14:           ;INC D
 tact 4
 sahf
 inc [bp.rD]
 lahf
 jo n141
 and ah,249
 jmp DoNewCommand
n141:
 and ah,253
 or ah,2Ch
 endc n14,'4'

n15:           ;DEC D
 tact 4
 sahf
 dec [bp.rD]
 lahf
 jo n151
 and ah,251
 or ah,28h
 jmp DoNewCommand
n151:
 or ah,2Eh
 endc n15,'5'

n16:           ;LD D,byte
 mov cl,[si]
 inc si
 mov [bp.rD],cl
 tact 7
 endc n16,'6'

n17:           ;RLA
 sahf
 rcl al,1
 lahf
 tact 4
;? and ah,237
 endc n17,'7'

n18:           ;JR dis
 movsx bx,bptr [si]
 inc si
 tact 12
 add si,bx
 endc n18,'8'

n19:           ;ADD HL,DE
 mov cx,[bp.rDE]
 and ah,not (m f5 or m fH or m f3 or m fN or m fC)
 add [bp.rHL],cx
 adc ah,0
 tact 11
 endc

n1A:           ;LD A,(DE)
 mov bx,[bp.rDE]
 tact 7
 mov al,[bx]
 endc n1a,'A'

n1B:           ;DEC DE
 dec [bp.rDE]
 tact 6
 endc n1b,'B'

n1C:           ;INC E
 tact 4
 sahf
 inc [bp.rE]
 lahf
 jo n1c1
 and ah,249
 jmp DoNewCommand
n1c1:
 and ah,253
 or ah,2Ch
 endc n1c,'C'

n1D:           ;DEC E
 tact 4
 sahf
 dec [bp.rE]
 lahf
 jo n1d1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n1d1:
 or ah,2Eh
 endc n1d,'D'

n1E:           ;LD E,byte
 mov cl,[si]
 inc si
 mov [bp.rE],cl
 tact 7
 endc n1e,'E'

n1F:           ;RRA
 sahf
 rcr al,1
 lahf
 tact 4
;? and ah,237
 endc n1f,'F'

n20:			;JR NZ,dis
 sahf
 jnz n18
 inc si
 tact 7
 endc n20,'0'

n21:           ;LD HL,word
 mov cl,[si]
 mov ch,[si+1]
 add si,2
 mov [bp.rHL],cx
 tact 10
 endc n21,'1'
     
n22:           ;LD (address),HL
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cx,[bp.rHL]
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

n23:           ;INC HL
 inc [bp.rHL]
 tact 6
 endc n23,'3'

n24:           ;INC H
 tact 4
 sahf
 inc [bp.rH]
 lahf
 jo n241
 and ah,249
 jmp DoNewCommand
n241:
 and ah,253
 or ah,2Ch
 endc n24,'4'

n25:           ;DEC H
 tact 4
 sahf
 dec [bp.rH]
 lahf
 jo n251
 and ah,251
 or ah,28h
 jmp DoNewCommand
n251:
 or ah,2Eh
 endc n25,'5'

n26:           ;LD H,byte
 mov ch,[si]
 inc si
 mov [bp.rH],ch
 tact 7
 endc n26,'6'

n27:           ;DAA
 tact 4
 test ah,2
 jnz n27_0
 sahf
 daa
 lahf
;? and ah,253
 endc
n27_0:
 sahf
 das
 lahf
;? or ah,10	;? 2
 endc

n28:           ;JR Z,dis
 sahf
 jz n18
 inc si
 tact 7
 endc n28,'8'

n29:           ;ADD HL,HL
 mov cx,[bp.rHL]
 and ah,not (m f5 or m fH or m f3 or m fN or m fC)
 add [bp.rHL],cx
 adc ah,0
 tact 11
 endc

n2A:           ;LD HL,(address)
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov [bp.rHL],cx
 tact 16
 endc n2a,'A'

n2B:           ;DEC HL
 dec [bp.rHL]
 tact 6
 endc n2b,'B'

n2C:           ;INC L
 tact 4
 sahf
 inc [bp.rL]
 lahf
 jo n2c1
 and ah,249
 jmp DoNewCommand
n2c1:
 and ah,253
 or ah,2Ch
 endc n2c,'C'

n2D:           ;DEC L
 tact 4
 sahf
 dec [bp.rL]
 lahf
 jo n2d1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n2d1:
 or ah,2Eh
 endc n2d,'D'

n2E:           ;LD L,byte
 mov cl,[si]
 inc si
 mov [bp.rL],cl
 tact 7
 endc n2e,'E'

n2F:           ;CPL
 not al
 or ah,12h
 tact 4
 endc n2f,'F'

n30:           ;JR NC,dis
 sahf
 jnc n18
 inc si
 tact 7
 endc n30,'0'

n31:           ;LD SP,word
 mov bl,[si]
 mov bh,[si+1]
 tact 10
 add si,2
 mov di,bx
 endc

n32:           ;LD (address),A
 mov bl,[si]
 mov bh,[si+1]
 tact 13
 add si,2
 test bh,192
 jz DoNewCommand
 mov [bx],al
 endc n32,'2'

n33:           ;INC SP
 inc di
 tact 6
 jmp DoNewCommand

n34:           ;INC (HL)
 mov bx,[bp.rHL]
 mov cl,[bx]
 sahf
 inc cl
 lahf
 jo n341
 and ah,249
 test bh,192
 jz n34_2
 mov [bx],cl
n34_2:
 tact 11
 endc
n341:
 or ah,2Ch
 and ah,253
 test bh,192
 jz n34_3
 mov [bx],cl
n34_3:
 tact 11
 endc

n35:           ;DEC (HL)
 mov bx,[bp.rHL]
 mov cl,[bx]
 sahf
 dec cl
 lahf
 jo n351
 and ah,251
 or ah,28h
 test bh,192
 jz n35_2
 mov [bx],cl
n35_2:
 tact 11
 endc
n351:
 or ah,2Eh
 test bh,192
 jz n35_3
 mov [bx],cl
n35_3:
 tact 11
 endc

n36:           ;LD (HL),byte
 mov cl,[si]
 inc si
 mov bx,[bp.rHL]
 test bh,192
 jz n36_0
 mov [bx],cl
n36_0:
 tact 10
 endc n36,'6'

n37:           ;SCF
;? and ah,0ECh
 tact 4
;? inc ah
or ah,m fC
 jmp DoNewCommand

n38:           ;JR C,dis
 sahf
 jc n18
 inc si
 tact 7
 endc n38,'8'

n39:           ;ADD HL,SP
 and ah,not (m f5 or m fH or m f3 or m fN or m fC)
 add [bp.rHL],di
 adc ah,0
 tact 11
 endc

n3A:           ;LD A,(address)
 mov bl,[si]
 mov bh,[si+1]
 tact 13
 add si,2
 mov al,[bx]
 endc n3a,'A'

n3B:           ;DEC SP
 dec di
 tact 6
 endc n3b,'B'

n3C:           ;INC A
 tact 4
 sahf
 inc al
 lahf
 jo n3c1
 and ah,249
 jmp DoNewCommand
n3c1:
 and ah,253
 or ah,2Ch
 endc n3c,'C'

n3D:           ;DEC A
 tact 4
 sahf
 dec al
 lahf
 jo n3d1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n3d1:
 or ah,2Eh
 endc n3d,'D'

n3E:           ;LD A,byte
 tact 7
 lodsb
 endc n3e,'E'

n3F:           ;CCF
 xor ah,1
 tact 4
;? and ah,0EDh
 endc n3f,'F'

n40:           ;LD B,B
 tact 4
 endc

n41:           ;LD B,C
 mov bl,[bp.rC]
 tact 4
 mov [bp.rB],bl
 endc

n42:           ;LD B,D
 mov bl,[bp.rD]
 tact 4
 mov [bp.rB],bl
 endc n42,'2'

n43:           ;LD B,E
 mov bl,[bp.rE]
 tact 4
 mov [bp.rB],bl
 endc n43,'3'

n44:           ;LD B,H
 mov bl,[bp.rH]
 tact 4
 mov [bp.rB],bl
 endc

n45:           ;LD B,L
 mov bl,[bp.rL]
 tact 4
 mov [bp.rB],bl
 endc n45,'5'

n46:           ;LD B,(HL)
 mov bx,[bp.rHL]
 mov bl,[bx]
 tact 7
 mov [bp.rB],bl
 endc n46,'6'

n47:           ;LD B,A
 mov [bp.rB],al
 tact 4
 endc

n48:           ;LD C,B
 mov bl,[bp.rB]
 tact 4
 mov [bp.rC],bl
 endc n48,'8'
 
n49:           ;LD C,C
 tact 4
 endc
 
n4A:           ;LD C,D
 mov bl,[bp.rD]
 tact 4
 mov [bp.rC],bl
 endc n4A,'A'
 
n4B:           ;LD C,E
 mov bl,[bp.rE]
 tact 4
 mov [bp.rC],bl
 endc n4B,'B'
 
n4C:           ;LD C,H
 mov bl,[bp.rH]
 tact 4
 mov [bp.rC],bl
 endc n4C,'C'
 
n4D:           ;LD C,L
 mov bl,[bp.rL]
 tact 4
 mov [bp.rC],bl
 endc n4D,'D'
 
n4E:           ;LD C,(HL)
 mov bx,[bp.rHL]
 mov bl,[bx]
 tact 7
 mov [bp.rC],bl
 endc n4E,'E'
 
n4F:           ;LD C,A
 mov [bp.rC],al
 tact 4
 endc n4F,'F'
 
n50:           ;LD D,B
 mov bl,[bp.rB]
 tact 4
 mov [bp.rD],bl
 endc n50,'0'
 
n51:           ;LD D,C
 mov bl,[bp.rC]
 tact 4
 mov [bp.rD],bl
 endc n51,'1'
 
n52:           ;LD D,D
 tact 4
 endc
 
n53:           ;LD D,E
 mov bl,[bp.rE]
 tact 4
 mov [bp.rD],bl
 endc n53,'3'
 
n54:           ;LD D,H
 mov bl,[bp.rH]
 tact 4
 mov [bp.rD],bl
 endc n54,'4'
 
n55:           ;LD D,L
 mov bl,[bp.rL]
 tact 4
 mov [bp.rD],bl
 endc
 
n56:           ;LD D,(HL)
 mov bx,[bp.rHL]
 mov bl,[bx]
 tact 7
 mov [bp.rD],bl
 endc n56,'6'
 
n57:           ;LD D,A
 mov [bp.rD],al
 tact 4
 endc n57,'7'

n58:           ;LD E,B
 mov bl,[bp.rB]
 tact 4
 mov [bp.rE],bl
 endc n58,'8'

n59:           ;LD E,C
 mov bl,[bp.rC]
 tact 4
 mov [bp.rE],bl
 endc n59,'9'

n5A:           ;LD E,D
 mov bl,[bp.rD]
 tact 4
 mov [bp.rE],bl
 endc n5A,'A'

n5B:           ;LD E,E
 tact 4
 endc n5B,'B'

n5C:           ;LD E,H
 mov bl,[bp.rH]
 tact 4
 mov [bp.rE],bl
 endc n5C,'C'

n5D:           ;LD E,L
 mov bl,[bp.rL]
 tact 4
 mov [bp.rE],bl
 endc n5D,'D'

n5E:           ;LD E,(HL)
 mov bx,[bp.rHL]
 mov bl,[bx]
 tact 7
 mov [bp.rE],bl
 endc n5E,'E'

n5F:           ;LD E,A
 mov [bp.rE],al
 tact 4
 endc n5F,'F'

n60:           ;LD H,B
 mov bl,[bp.rB]
 tact 4
 mov [bp.rH],bl
 endc n60,'0'

n61:           ;LD H,C
 mov bl,[bp.rC]
 tact 4
 mov [bp.rH],bl
 endc n61,'1'

n62:           ;LD H,D
 mov bl,[bp.rD]
 tact 4
 mov [bp.rH],bl
 endc n62,'2'

n63:           ;LD H,E
 mov bl,[bp.rE]
 tact 4
 mov [bp.rH],bl
 endc n63,'3'

n64:           ;LD H,H
 tact 4
 endc n64,'4'

n65:           ;LD H,L
 mov bl,[bp.rL]
 tact 4
 mov [bp.rH],bl
 endc n65,'5'

n66:           ;LD H,(HL)
 mov bx,[bp.rHL]
 mov bl,[bx]
 tact 7
 mov [bp.rH],bl
 endc

n67:           ;LD H,A
 mov [bp.rH],al
 tact 4
 endc n67,'7'

n68:           ;LD L,B
 mov bl,[bp.rB]
 tact 4
 mov [bp.rL],bl
 endc n68,'8'

n69:           ;LD L,C
 mov bl,[bp.rC]
 tact 4
 mov [bp.rL],bl
 endc n69,'9'

n6A:           ;LD L,D
 mov bl,[bp.rD]
 tact 4
 mov [bp.rL],bl
 endc n6a,'A'

n6B:           ;LD L,E
 mov bl,[bp.rE]
 tact 4
 mov [bp.rL],bl
 endc n6b,'B'

n6C:           ;LD L,H
 mov bl,[bp.rH]
 tact 4
 mov [bp.rL],bl
 endc n6c,'C'

n6D:           ;LD L,L
 tact 4
 endc n6d,'D'

n6E:		;LD L,(HL)
 mov bx,[bp.rHL]
 mov bl,[bx]
 tact 7
 mov [bp.rL],bl
 endc n6e,'E'

n6F:           ;LD L,A
 mov [bp.rL],al
 tact 4
 endc n6f,'F'

n70:           ;LD (HL),B
 mov bx,[bp.rHL]
 mov ch,[bp.rB]
 test bh,192
 jz n70_0
 mov [bx],ch
n70_0:
 tact 7
 endc

n71:           ;LD (HL),C
 mov bx,[bp.rHL]
 mov ch,[bp.rC]
 test bh,192
 jz n71_0
 mov [bx],ch
n71_0:
 tact 7
 endc n71,'1'

n72:           ;LD (HL),D
 mov bx,[bp.rHL]
 mov ch,[bp.rD]
 test bh,192
 jz n72_0
 mov [bx],ch
n72_0:
 tact 7
 endc n72,'2'

n73:           ;LD (HL),E
 mov bx,[bp.rHL]
 mov ch,[bp.rE]
 test bh,192
 jz n73_0
 mov [bx],ch
n73_0:
 tact 7
 endc n73,'3'

n74:           ;LD (HL),H
 mov bx,[bp.rHL]
 tact 7
 test bh,192
 jz DoNewCommand
 mov [bx],bh
 endc n74,'4'

n75:           ;LD (HL),L
 mov bx,[bp.rHL]
 tact 7
 test bh,192
 jz DoNewCommand
 mov [bx],bl
 endc n75,'5'

n76:           ;HALT
 tact 4
 mov [bp.fHALT],1
 dec si
 endc

n77:           ;LD (HL),A
 tact 7
 mov bx,[bp.rHL]
 test bh,192
 jz DoNewCommand
 mov [bx],al
 endc

n78:           ;LD A,B
 mov al,[bp.rB]
 tact 4
 endc n78,'8'
 
n79:           ;LD A,C
 mov al,[bp.rC]
 tact 4
 endc n79,'9'
 
n7A:           ;LD A,D
 mov al,[bp.rD]
 tact 4
 endc n7a,'A'
 
n7B:           ;LD A,E
 mov al,[bp.rE]
 tact 4
 endc n7b,'B'
 
n7C:           ;LD A,H
 mov al,[bp.rH]
 tact 4
 endc n7c,'C'
 
n7D:           ;LD A,L
 mov al,[bp.rL]
 tact 4
 endc n7d,'D'
 
n7E:           ;LD A,(HL)
 mov bx,[bp.rHL]
 tact 7
 mov al,[bx]
 endc n7e,'E'
 
n7F:           ;LD A,A
 tact 4
 endc n7f,'F'
 
n80:           ;ADD A,B
 tact 4
 add al,[bp.rB]
 lahf
 jo n801
 and ah,249
 jmp DoNewCommand
n801:
 or ah,2Ch
 and ah,253
 endc

n81:           ;ADD A,C
 tact 4
 add al,[bp.rC]
 lahf
 jo n811
 and ah,249
 jmp DoNewCommand
n811:
 or ah,2Ch
 and ah,253
 endc

n82:           ;ADD A,D
 tact 4
 add al,[bp.rD]
 lahf
 jo n821
 and ah,249
 jmp DoNewCommand
n821:
 or ah,2Ch
 and ah,253
 endc n82_,'2'

n83:           ;ADD A,E
 tact 4
 add al,[bp.rE]
 lahf
 jo n831
 and ah,249
 jmp DoNewCommand
n831:
 or ah,2Ch
 and ah,253
 endc n83_,'3'

n84:           ;ADD A,H
 tact 4
 add al,[bp.rH]
 lahf
 jo n841
 and ah,249
 jmp DoNewCommand
n841:
 or ah,2Ch
 and ah,253
 endc n84_,'4'

n85:           ;ADD A,L
 tact 4
 add al,[bp.rL]
 lahf
 jo n851
 and ah,249
 jmp DoNewCommand
n851:
 or ah,2Ch
 and ah,253
 endc n85_,'5'

n86:           ;ADD A,(HL)
 mov bx,[bp.rHL]
 tact 7
 add al,[bx]
 lahf
 jo n861
 and ah,249
 jmp DoNewCommand
n861:
 or ah,2Ch
 and ah,253
 endc n86_,'6'

n87:           ;ADD A,A
 tact 4
 add al,al
 lahf
 jo n871
 and ah,249
 jmp DoNewCommand
n871:
 or ah,2Ch
 and ah,253
 endc n87_,'7'

n88:           ;ADC A,B
 tact 4
 sahf
 adc al,[bp.rB]
 lahf
 jo n881
 and ah,249
 jmp DoNewCommand
n881:
 or ah,2Ch
 and ah,253
 endc n88_,'8'

n89:           ;ADC A,C
 tact 4
 sahf
 adc al,[bp.rC]
 lahf
 jo n891
 and ah,249
 jmp DoNewCommand
n891:
 or ah,2Ch
 and ah,253
 endc n89_,'9'

n8A:           ;ADC A,D
 tact 4
 sahf
 adc al,[bp.rD]
 lahf
 jo n8a1
 and ah,249
 jmp DoNewCommand
n8a1:
 or ah,2Ch
 and ah,253
 endc n8a_,'A'

n8B:           ;ADC A,E
 tact 4
 sahf
 adc al,[bp.rE]
 lahf
 jo n8b1
 and ah,249
 jmp DoNewCommand
n8b1:
 or ah,2Ch
 and ah,253
 endc n8b_,'B'

n8C:           ;ADC A,H
 tact 4
 sahf
 adc al,[bp.rH]
 lahf
 jo n8c1
 and ah,249
 jmp DoNewCommand
n8c1:
 or ah,2Ch
 and ah,253
 endc n8c_,'C'

n8D:           ;ADC A,L
 tact 4
 sahf
 adc al,[bp.rL]
 lahf
 jo n8d1
 and ah,249
 jmp DoNewCommand
n8d1:
 or ah,2Ch
 and ah,253
 endc n8d_,'D'

n8E:           ;ADC A,(HL)
 mov bx,[bp.rHL]
 tact 7
 sahf
 adc al,[bx]
 lahf
 jo n8e1
 and ah,249
 jmp DoNewCommand
n8e1:
 or ah,2Ch
 and ah,253
 endc n8e_,'E'

n8F:           ;ADC A,A
 sahf
 tact 4
 adc al,al
 lahf
 jo n8f1
 and ah,249
 jmp DoNewCommand
n8f1:
 or ah,2Ch
 and ah,253
 endc n8f_,'F'

n90:           ;SUB B
 tact 4
 sub al,[bp.rB]
 lahf
 jo n901
 and ah,251
 or ah,28h
 jmp DoNewCommand
n901:
 or ah,2Eh
 endc n90,'0'

n91:           ;SUB C
 tact 4
 sub al,[bp.rC]
 lahf
 jo n911
 and ah,251
 or ah,28h
 jmp DoNewCommand
n911:
 or ah,2Eh
 endc n91_,'1'

n92:           ;SUB D
 tact 4
 sub al,[bp.rD]
 lahf
 jo n921
 and ah,251
 or ah,28h
 jmp DoNewCommand
n921:
 or ah,2Eh
 endc n92,'2'

n93:           ;SUB E
 tact 4
 sub al,[bp.rE]
 lahf
 jo n931
 and ah,251
 or ah,28h
 jmp DoNewCommand
n931:
 or ah,2Eh
 endc n93,'3'

n94:           ;SUB H
 tact 4
 sub al,[bp.rH]
 lahf
 jo n941
 and ah,251
 or ah,28h
 jmp DoNewCommand
n941:
 or ah,2Eh
 endc n94,'4'

n95:           ;SUB L
 tact 4
 sub al,[bp.rL]
 lahf
 jo n951
 and ah,251
 or ah,28h
 jmp DoNewCommand
n951:
 or ah,2Eh
 endc n95,'5'

n96:           ;SUB (HL)
 mov bx,[bp.rHL]
 tact 7
 sub al,[bx]
 lahf
 jo n961
 and ah,251
 or ah,28h
 jmp DoNewCommand
n961:
 or ah,2Eh
 endc n96,'6'

n97:           ;SUB A
; sub al,al
; lahf
; jo n971
; and ah,251
; or ah,28h
; jmp DoNewCommand
;n971:
; or ah,2Eh
 tact 4
 mov ax,4200h
 endc n97,'7'

n98:           ;SBC B
 tact 4
 sahf
 sbb al,[bp.rB]
 lahf
 jo n981
 and ah,251
 or ah,28h
 jmp DoNewCommand
n981:
 or ah,2Eh
 endc n98,'8'

n99:           ;SBC C
 tact 4
 sahf
 sbb al,[bp.rC]
 lahf
 jo n991
 and ah,251
 or ah,28h
 jmp DoNewCommand
n991:
 or ah,2Eh
 endc n99_,'9'

n9A:           ;SBC D
 tact 4
 sahf
 sbb al,[bp.rD]
 lahf
 jo n9a1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n9a1:
 or ah,2Eh
 endc n9a,'A'

n9B:           ;SBC E
 tact 4
 sahf
 sbb al,[bp.rE]
 lahf
 jo n9b1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n9b1:
 or ah,2Eh
 endc n9b,'B'

n9C:           ;SBC H
 tact 4
 sahf
 sbb al,[bp.rH]
 lahf
 jo n9c1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n9c1:
 or ah,2Eh
 endc n9c,'C'

n9D:           ;SBC L
 tact 4
 sahf
 sbb al,[bp.rL]
 lahf
 jo n9d1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n9d1:
 or ah,2Eh
 endc n9d,'D'

n9E:           ;SBC (HL)
 mov bx,[bp.rHL]
 tact 7
 sahf
 sbb al,[bx]
 lahf
 jo n9e1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n9e1:
 or ah,2Eh
 endc n9e,'E'

n9F:           ;SBC A
 sahf
 tact 4
 sbb al,al
 lahf
 jo n9f1
 and ah,251
 or ah,28h
 jmp DoNewCommand
n9f1:
 or ah,2Eh
 endc n9f,'F'

nA0:               ;AND B
 and al,[bp.rB]
 lahf
xor ah,12h
;? mov cl,al
; and ah,0FDh
; and cl,28h
; or ah,10h
; or ah,cl
 tact 4
 endc

nA1:               ;AND C
 and al,[bp.rC]
 lahf
 xor ah,12h
 tact 4
 endc

nA2:               ;AND D
 and al,[bp.rD]
 lahf
 xor ah,12h
 tact 4
 endc nA2,'2'

nA3:               ;AND E
 and al,[bp.rE]
 lahf
 xor ah,12h
 tact 4
 endc nA3,'3'

nA4:               ;AND H
 and al,[bp.rH]
 lahf
 xor ah,12h
 tact 4
 endc nA4,'4'

nA5:               ;AND L
 and al,[bp.rL]
 lahf
 xor ah,12h
 tact 4
 endc nA5,'5'

nA6:               ;AND (HL)
 mov bx,[bp.rHL]
 and al,[bx]
 lahf
 xor ah,12h
 tact 7
 endc nA6,'6'

nA7:               ;AND A
 and al,al
 lahf
 xor ah,12h
 tact 4
 endc nA7,'7'

nA8:               ;XOR B
 xor al,[bp.rB]
 lahf
;? mov cl,al
 and ah,0EDh
; and cl,28h
; or ah,cl
 tact 4
 endc nA8,'8'

nA9:               ;XOR C
 xor al,[bp.rC]
 lahf
 and ah,0EDh
 tact 4
 endc nA9,'9'

nAA:               ;XOR D
 xor al,[bp.rD]
 lahf
 and ah,0EDh
 tact 4
 endc nAa_,'A'

nAB:               ;XOR E
 xor al,[bp.rE]
 lahf
 and ah,0EDh
 tact 4
 endc

nAC:               ;XOR H
 xor al,[bp.rH]
 lahf
 and ah,0EDh
 tact 4
 endc nAc,'C'

nAD:               ;XOR L
 xor al,[bp.rL]
 lahf
 and ah,0EDh
 tact 4
 endc nAd,'D'

nAE:               ;XOR (HL)
 mov bx,[bp.rHL]
 xor al,[bx]
 lahf
 and ah,0EDh
 tact 7
 endc nAe,'E'

nAF:               ;XOR A
 xor al,al
 lahf
 and ah,0EDh
;? mov ax,4400h
 tact 4
 endc nAf,'F'

nB0:               ;OR B
 or al,[bp.rB]
 lahf
;? mov cl,al
 and ah,0EDh
; and cl,28h
; or ah,cl
 tact 4
 endc nB0,'0'

nB1:               ;OR C
 or al,[bp.rC]
 lahf
 and ah,0EDh
 tact 4
 endc nB1,'1'

nB2:               ;OR D
 or al,[bp.rD]
 lahf
 and ah,0EDh
 tact 4
 endc nB2,'2'

nB3:               ;OR E
 or al,[bp.rE]
 lahf
 and ah,0EDh
 tact 4
 endc nB3,'3'

nB4:               ;OR H
 or al,[bp.rH]
 lahf
 and ah,0EDh
 tact 4
 endc nB4,'4'

nB5:               ;OR L
 or al,[bp.rL]
 lahf
 and ah,0EDh
 tact 4
 endc nB5,'5'

nB6:               ;OR (HL)
 mov bx,[bp.rHL]
 or al,[bx]
 lahf
 and ah,0EDh
 tact 7
 endc nB6,'6'

nB7:               ;OR A
 or al,al
 lahf
 and ah,0EDh
 tact 4
 endc nB7,'7'

nB8:           ;CP B
 tact 4
 cmp al,[bp.rB]
 lahf
 jo nB81
 and ah,251
 or ah,28h
 jmp DoNewCommand
nB81:
 or ah,2Eh
 endc nB8,'8'

nB9:           ;CP C
 tact 4
 cmp al,[bp.rC]
 lahf
 jo nB91
 and ah,251
 or ah,28h
 jmp DoNewCommand
nB91:
 or ah,2Eh
 endc nB9,'9'

nBA:           ;CP D
 tact 4
 cmp al,[bp.rD]
 lahf
 jo nBa1
 and ah,251
 or ah,28h
 jmp DoNewCommand
nBa1:
 or ah,2Eh
 endc nBa,'A'

nBB:           ;CP E
 tact 4
 cmp al,[bp.rE]
 lahf
 jo nBb1
 and ah,251
 or ah,28h
 jmp DoNewCommand
nBb1:
 or ah,2Eh
 endc nBb_,'B'

nBC:           ;CP H
 tact 4
 cmp al,[bp.rH]
 lahf
 jo nBc1
 and ah,251
 or ah,28h
 jmp DoNewCommand
nBc1:
 or ah,2Eh
 endc nBc,'C'

nBD:           ;CP L
 tact 4
 cmp al,[bp.rL]
 lahf
 jo nBd1
 and ah,251
 or ah,28h
 jmp DoNewCommand
nBd1:
 or ah,2Eh
 endc nBd,'D'

nBE:           ;CP (HL)
 mov bx,[bp.rHL]
 tact 7
 cmp al,[bx]
 lahf
 jo nBe1
 and ah,251
 or ah,28h
 jmp DoNewCommand
nBe1:
 or ah,2Eh
 endc nBe,'E'

nBF:           ;CP A
; cmp al,al
; lahf
; jo nBf1
; and ah,251
; jmp DoNewCommand
;nBf1:
; or ah,6
 and ah,20h	;?28h
 tact 4
 or ah,42h
 endc nBf,'F'

nC0:           ;RET NZ
 sahf
 jnz nC9
 tact 5
 endc nc0,'0'

nC1:           ;POP BC
 mov cl,[di]
 mov ch,[di+1]
 add di,2
 mov [bp.rBC],cx
 tact 10
 endc nc1_,'1'

nC2:           ;JP NZ,address
 sahf
 jnz nC3
 add si,2
 tact 10
 endc nc2,'2'

nC3:           ;JP address
 mov cl,[si]
 mov ch,[si+1]
 mov si,cx
 tact 10
 endc nC3,'3'

nC4:           ;CALL NZ,address
 sahf
 jnz nCD
 add si,2
 tact 10
 endc nc4,'4'

nC5:           ;PUSH BC
 dec di
 tact 11
 mov bx,[bp.rBC]
 test di,0C000h
 jz nc5_0
 mov [di],bh
nc5_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc nc5,'5'

nC6:           ;ADD A,byte
 tact 7
 add al,[si]
 lahf
 jo nc61
 inc si
 and ah,249
 jmp DoNewCommand
nc61:
 or ah,2Ch
 inc si
 and ah,253
 endc nc6,'6'

nC7:           ;RST 0
 mov bx,si
 dec di
 tact 11
 sub si,si
 test di,0C000h
 jz nc7_0
 mov [di],bh
nc7_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc nc7,'7'

nC8:           ;RET Z
 sahf
 jz nC9
 tact 5
 endc nc8,'8'

nC9:           ;RET
 mov bl,[di]
 mov bh,[di+1]
 tact 10
 add di,2
 mov si,bx
 endc nC9,'9'

nCA:           ;JP Z,address
 sahf
 jz nC3
 add si,2
 tact 10
 endc nca,'A'

nCB:           ;После CB
 inc dl
;! r
 mov bl,[si]
 sub bh,bh
 inc si
 jmp wptr [ss:ebx*2+CmdCB]

nCC:           ;CALL Z,address
 sahf
 jz nCD
 add si,2
 tact 10
 endc ncc_,'C'

nCD:           ;CALL address
 mov bl,[si]
 mov bh,[si+1]
 dec di
 lea cx,[si+2]
 test di,0C000h
 mov si,bx
 jz nCD_0
 mov [di],ch
nCD_0:
 dec di
 test di,0C000h
 jz nCD_1
 mov [di],cl
nCD_1:
 tact 17
 endc nCD,'D'

nCE:           ;ADC A,byte
 tact 7
 sahf
 adc al,[si]
 lahf
 jo nce1
 inc si
 and ah,249
 jmp DoNewCommand
nce1:
 or ah,2Ch
 inc si
 and ah,253
 endc nce,'E'

nCF:           ;RST 8
 mov bx,si
 tact 11
 dec di
 mov si,8
 test di,0C000h
 jz ncf_0
 mov [di],bh
ncf_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc ncf,'F'

nD0:           ;RET NC
 sahf
 jnc nC9
 tact 5
 endc nd0,'0'

nD1:          ;POP DE
 mov cl,[di]
 mov ch,[di+1]
 add di,2
 mov [bp.rDE],cx
 tact 10
 endc nd1_,'1'

nD2:           ;JP NC,address
 sahf
 jnc nC3
 add si,2
 tact 10
 endc nd2,'2'

nD3:           ;OUT (byte),A	AddressPort=A*256+byte
 mov cl,[si]
 mov ch,al
 inc si
 mov bl,al
 call StoreBL_portCX
 tact 11
 endc nd3,'3'

nD4:		;CALL NC,address
 sahf
 jnc nCD
 add si,2
 tact 10
 endc nd4,'4'

nD5:		;PUSH DE
 dec di
 tact 11
 mov bx,[bp.rDE]
 test di,0C000h
 jz nd5_0
 mov [di],bh
nd5_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc nd5,'5'

nD6:		;SUB byte
 tact 7
 sub al,[si]
 lahf
 jo nd61
 inc si
 and ah,251
 or ah,28h
 jmp DoNewCommand
nd61:
 inc si
 or ah,2Eh
 endc nd6,'6'

nD7:		;RST 10
 mov bx,si
 tact 11
 dec di
 mov si,10h
 test di,0C000h
 jz nd7_0
 mov [di],bh
nd7_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc nd7,'7'

nD8:		;RET C
 sahf
 jc nC9
 tact 5
 endc nd8,'8'

nD9:		;EXX
 mov cx,[bp.rBC_]
 mov bx,[bp.rBC]
 mov [bp.rBC],cx
 mov [bp.rBC_],bx

 mov cx,[bp.rDE_]
 mov bx,[bp.rDE]
 mov [bp.rDE],cx
 mov [bp.rDE_],bx

 mov cx,[bp.rHL_]
 mov bx,[bp.rHL]
 mov [bp.rHL],cx
 mov [bp.rHL_],bx
 tact 4
 endc nd9,'9'

nDA:		;JP C,address
 sahf
 jc nC3
 add si,2
 tact 10
 endc nda,'A'

nDB:		;IN A,(byte)	AddressPort=A*256+byte
 mov cl,[si]
 mov ch,al
 inc si
 call LdBL_portCX
 tact 11
 mov al,bl
 endc

nDC:		;CALL C,address
 sahf
 jc nCD
 add si,2
 tact 10
 endc ndc,'C'

nDD:           ;После DD
 inc dl
;? r
; sub wptr [bp+Tacts],4
 mov bl,[si]
 sub bh,bh
 mov cx,[bp.rIX]
 inc si
 jmp wptr [ss:ebx*2+CmdDD]

nDE:           ;SBC A,byte
 tact 7
 sahf
 sbb al,[si]
 lahf
 jo n9f1
 inc si
 and ah,251
 or ah,28h
 jmp DoNewCommand
nde1:
 inc si
 or ah,2Eh
 endc nde,'E'

nDF:			;RST 18
 mov bx,si
 tact 11
 dec di
 mov si,18h
 test di,0C000h
 jz ndf_0
 mov [di],bh
ndf_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc ndf,'F'

nE0:      ;RET PO
 sahf
 jnp nC9
 tact 5
 endc ne0,'0'

nE1:          ;POP HL
 mov cl,[di]
 mov ch,[di+1]
 add di,2
 mov [bp.rHL],cx
 tact 10
 endc

nE2:      ;JP PO,address
 sahf
 jnp nC3
 add si,2
 tact 10
 endc ne2,'2'
 
nE3:      ;EX (SP),HL
 mov bl,[di]
 mov bh,[di+1]
 mov cx,[bp.rHL]
 mov [bp.rHL],bx
 mov bx,di
 test bh,0C0h
 jz nE3_0
 mov [di],cl
nE3_0:
 inc bx
 test bh,0C0h
 jz nE3_1
 mov [bx],ch
nE3_1:
 tact 19
 endc ne3,'3'

nE4:      ;CALL PO,address
 sahf
 jnp nCD
 add si,2
 tact 10
 endc ne4,'4'

nE5:      ;PUSH HL
 dec di
 tact 11
 mov bx,[bp.rHL]
 test di,0C000h
 jz ne5_0
 mov [di],bh
ne5_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc ne5,'5'

nE6:		;AND byte
 and al,[si]
 lahf
 tact 7
xor ah,12h
; and ah,0FDh
 inc si
; or ah,10h
;? mov cl,al
; and cl,28h
; or ah,cl
 endc ne6,'6'

nE7:		;RST 20
 mov bx,si
 tact 11
 dec di
 mov si,20h
 test di,0C000h
 jz ne7_0
 mov [di],bh
ne7_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc ne7,'7'

nE8:		;RET PE
 sahf
 jp nC9
 tact 5
 endc ne8,'8'

nE9:		;JP (HL)
 mov si,[bp.rHL]
 tact 4
 endc ne9,'9'

nEA:		;JP PE,address
 sahf
 jp nC3
 add si,2
 tact 10
 endc nea,'A'

nEB:		;EX DE,HL
 mov cx,[bp.rHL]
 mov bx,[bp.rDE]
 mov [bp.rHL],bx
 mov [bp.rDE],cx
 tact 4
 endc neb,'B'

nEC:		;CALL PE,address
 sahf
 jp nCD
 add si,2
 tact 10
 endc nec,'C'

nED:		;После ED
 inc dl
;! r
 mov bl,[si]
 sub bh,bh
 inc si
 jmp wptr [ss:ebx*2+CmdED]

nEE:		;XOR byte
 xor al,[si]
 lahf
;? mov cl,al
 and ah,0EDh
; and cl,28h
 inc si
; or ah,cl
 tact 7
 endc nee_,'E'

nEF:      ;RST 28
 mov bx,si
 tact 11
 dec di
 mov si,28h
 test di,0C000h
 jz nef_0
 mov [di],bh
nef_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc nef,'F'

nF0:      ;RET P
 sahf
 jns nC9
 tact 5
 endc nF0,'0'

nF1:		;POP AF
 mov al,[di]
 mov ah,[di+1]
 tact 10
 add di,2
 endc nF1_,'1'

nF2:		;JP P,address
 sahf
 jns nC3
 add si,2
 tact 10
 endc nF2,'2'

nF3:		;DI
 mov [bp.fINT],0
 tact 4
 endc

nF4:      ;CALL P,address
 sahf
 jns nCD
 add si,2
 tact 10
 endc nF4,'4'

nF5:		;PUSH AF
 dec di
 tact 11
 test di,0C000h
 jz nF5_0
 mov [di],ah
nF5_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],al
 endc nF5,'5'

nF6:               ;OR byte
 or al,[si]
 lahf
;? mov cl,al
 and ah,0EDh
; and cl,28h
 inc si
; or ah,cl
 tact 7
 endc nF6,'6'

nF7:      ;RST 30
 mov bx,si
 tact 11
 dec di
 mov si,30h
 test di,0C000h
 jz nF7_0
 mov [di],bh
nF7_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc nF7,'7'

nF8:		;RET M
 sahf
 js nC9
 tact 5
 endc nF8,'8'

nF9:           ;LD SP,HL
 mov di,[bp.rHL]
 tact 6
 endc nF9_,'9'

nFA:      ;JP M,address
 sahf
 js nC3
 add si,2
 tact 10
 endc nFa,'A'

nFB:      ;EI
 mov [bp.fINT],1
 tact 4
 endc

nFC:      ;CALL M,address
 sahf
 js nCD
 add si,2
 tact 10
 endc nFc,'C'

nFD:           ;После FD
 inc dl
;? r
; sub wptr [bp.Tacts],4
 mov bl,[si]
 sub bh,bh
 mov cx,[bp.rIY]
 inc si
 jmp wptr [ss:ebx*2+CmdFD]

nFE:           ;CP byte
 tact 7
 cmp al,[si]
 lahf
 jo nFe1
 inc si
 and ah,251
 or ah,28h
 jmp DoNewCommand
nFe1:
 inc si
 or ah,2Eh
 endc

nFF:		;RST 38
 mov bx,si
 tact 11
 dec di
 mov si,38h
 test di,0C000h
 jz nFf_0
 mov [di],bh
nFf_0:
 dec di
 test di,0C000h
 jz DoNewCommand
 mov [di],bl
 endc

CodeKernel Ends
End
