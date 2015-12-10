;Таблицы команд. После ED
P586
VERSION T310

include globals.asi

CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel, DS:nothing

;ED_0...ED_3F - пустышки (NOP)(дальше тоже)

nED_0:			;NOP
 tact 8
endc

nED_40:			;IN B,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov [bp.rB],bl
 mov ah,bh
 tact 12
 endc

nED_41:			;OUT (C),B
 mov cx,[bp.rBC]
 mov bl,ch
 call StoreBL_portCX
 tact 12
 endc

nED_42:			;SBC HL,BC
 mov bx,[bp.rBC]
 sahf
 sbb [bp.rHL],bx
 tact 15
 lahf
 jo nED_421
 and ah,251
 or ah,28h
 jmp DoNewCommand
nED_421:
 or ah,2Eh
 endc

nED_43:			;LD (address),BC
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cx,[bp.rBC]
 test bh,192
 jz n43_1
 mov [bx],cl
n43_1:
 inc bx
 test bh,192
 jz n43_2
 mov [bx],ch
n43_2:
 tact 20
 endc

nED_44:			;NEG
 neg al
 tact 8
 lahf
 jo nED_441
 and ah,251
 or ah,28h
 endc
nED_441:
 or ah,2Eh
 endc

nED_45:			;RETN
;? mov bl,[bp.fINT_]
 mov cl,[di]
 mov ch,[di+1]
; mov [bp.fINT],bl	;Восстанавливаю прежнее INT
 add di,2
 mov si,cx
 tact 4+10
 endc

nED_46:			;IM 0
 mov [bp.fIM],0
 tact 8			;4 такта - префикс ED + 4 такта - команда
 endc

nED_47:			;LD I,A
 mov dh,al
 tact 9
 endc

nED_48:			;IN C,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov [bp.rC],bl
 tact 12
 endc

nED_49:			;OUT (C),C
 mov cx,[bp.rBC]
 mov bl,cl
 call StoreBL_portCX
 tact 12
 endc

nED_4A:			;ADC HL,BC
 mov bx,[bp.rBC]
 sahf
 adc [bp.rHL],bx
 tact 15
 lahf
 jo nED_4a1
 and ah,249
 endc
nED_4a1:
 or ah,2Ch
 and ah,253
 endc

nED_4B:                  ;LD BC,(address)
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov [bp.rBC],cx
 tact 20
 endc

nED_4D:                  ;RETI
;?
 mov bl,[di]
 mov bh,[di+1]
 add di,2
 tact 14
 mov si,bx
 endc

nED_4F:                  ;LD R,A
;!
 mov dl,al
 tact 9
 endc

nED_50:                  ;IN D,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov [bp.rD],bl
 tact 12
 endc

nED_51:                  ;OUT (C),D
 mov cx,[bp.rBC]
 mov bl,[bp.rD]
 call StoreBL_portCX
 tact 12
 endc

nED_52:                  ;SBC HL,DE
 mov cx,[bp.rDE]
 sahf
 sbb [bp.rHL],cx
 tact 15
 lahf
 jo nED_521
 and ah,251
 or ah,28h
 endc
nED_521:
 or ah,2Eh
 endc

nED_53:                  ;LD (address),DE
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cx,[bp.rDE]
 test bh,192
 jz n53_1
 mov [bx],cl
n53_1:
 inc bx
 test bh,192
 jz n53_2
 mov [bx],ch
n53_2:
 tact 20
 endc

nED_56:                  ;IM 1
 mov [bp.fIM],1
 tact 8
 endc

nED_57:                  ;LD A,I
 mov al,dh
 mov ch,ah
 test al,al
 lahf
 and ch,m fC
 mov cl,[bp.fINT]
 shl cl,2
 or ch,cl
 and ah,not (m fH or m fPV or m fN or m fC)
 add ah,ch

;? mov al,dh
; sahf
; inc al
; dec al
; lahf
; and ah,0C1h
; and al,028h
; or ah,al
; mov al,[bp.fINT]
; shl al,2		;?Может сразу писать в INT 4-ку
; or ah,al
; mov al,dh
tact 9
endc nED_57,'7'

nED_58:                  ;IN E,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov [bp.rE],bl
 tact 12
 endc

nED_59:                  ;OUT (C),E
 mov cx,[bp.rBC]
 mov bl,[bp.rE]
 call StoreBL_portCX
 tact 12
 endc

nED_5A:                  ;ADC HL,DE
 mov cx,[bp.rDE]
 sahf
 adc [bp.rHL],cx
 tact 15
 lahf
 jo nED_5a1
 and ah,249
 jmp DoNewCommand
nED_5a1:
 or ah,2Ch
 and ah,253
 endc

nED_5B:                  ;LD DE,(address)
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov [bp.rDE],cx
 tact 20
endc nED_5b,'B'

nED_5E:                  ;IM 2
 mov [bp.fIM],2
 tact 8
 endc

nED_5F:                  ;LD A,R
;! r_x
 mov al,dl
 mov ch,ah
 test al,al
 lahf
 and ch,m fC
 mov cl,[bp.fINT]
 shl cl,2
 or ch,cl
 and ah,not (m fH or m fPV or m fN or m fC)
 add ah,ch
tact 9
 endc

nED_60:                  ;IN H,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov [bp.rH],bl
 tact 12
 endc

nED_61:                  ;OUT (C),H
 mov cx,[bp.rBC]
 mov bl,[bp.rH]
 call StoreBL_portCX
 tact 12
 endc

nED_62:                  ;SBC HL,HL
 mov cx,[bp.rHL]
 sahf
 sbb [bp.rHL],cx
 tact 15
 lahf
 jo nED_621
 and ah,251
 jmp DoNewCommand
nED_621:
 or ah,6
endc nED_62,'2'

nED_63:                  ;LD (address),HL *
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cx,[bp.rHL]
 test bh,192
 jz n63_1
 mov [bx],cl
n63_1:
 inc bx
 test bh,192
 jz n63_2
 mov [bx],ch
n63_2:
 tact 20
 endc

nED_67:                  ;RRD
 mov bx,[bp.rHL]
 mov cl,[bx]
 mov ch,al
 mov bl,cl
 and bl,0Fh
 and al,0F0h
 or al,bl
 shl cx,4
 sahf
 inc al
 dec al
 lahf
 mov bl,[bp.rL]
 and ah,0EDh
 test bh,192
 jz ned67_0
 mov [bx],ch
ned67_0:
 tact 18
endc

nED_68:                  ;IN L,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov [bp.rL],bl
 tact 12
 endc

nED_69:                  ;OUT (C),L
 mov cx,[bp.rBC]
 mov bl,[bp.rL]
 call StoreBL_portCX
 tact 12
 endc

nED_6A:                  ;ADC HL,HL
 mov cx,[bp.rHL]
 sahf
 adc [bp.rHL],cx
 tact 15
 lahf
 jo nED_6a1
 and ah,249
 jmp DoNewCommand
nED_6a1:
 or ah,4
 and ah,253
endc nED_6a,'A'

nED_6B:                  ;LD HL,(address) *
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov [bp.rHL],cx
 tact 20
endc nED_6b,'B'

nED_6F:                  ;RLD
 mov bx,[bp.rHL]
 mov cl,[bx]
 sub ch,ch
 shl cx,4
 mov bl,al
 and bl,0Fh
 or cl,bl
 and al,0F0h
 or al,ch
 sahf
 inc al
 dec al
 lahf
 mov bl,[bp.rL]
 and ah,0EDh
 test bh,192
 jz ned6f_0
 mov [bx],cl
ned6f_0:
 tact 18
endc

nED_70:			;IN (C) Меняет флаги, но никуда не заносит
 mov cx,[bp.rBC]	;	считанное значение
 call LdBL_portCX
 mov ah,bh
 tact 12
 endc

nED_71:                  ;OUT (C),0
 mov cx,[bp.rBC]
 xor bl,bl
 call StoreBL_portCX
 tact 12
 endc

nED_72:                  ;SBC HL,SP
 sahf
 sbb [bp.rHL],di
 tact 15
 lahf
 jo nED_721
 and ah,251
 jmp DoNewCommand
nED_721:
 or ah,6
endc nED_72,'2'

nED_73:                  ;LD (address),SP
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cx,di
 test bh,192
 jz n73_1
 mov [bx],cl
n73_1:
 inc bx
 test bh,192
 jz n73_2
 mov [bx],ch
n73_2:
 tact 20
endc nED_73,'3'

nED_78:                  ;IN A,(C)
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ax,bx
 tact 12
 endc

nED_79:                  ;OUT (C),A
 mov cx,[bp.rBC]
 mov bl,al
 call StoreBL_portCX
 tact 12
 endc

nED_7A:                  ;ADC HL,SP
 sahf
 adc [bp.rHL],di
 tact 15
 lahf
 jo nED_7a1
 and ah,249
 jmp DoNewCommand
nED_7a1:
 or ah,4
 and ah,253
 endc

nED_7B:                  ;LD SP,(address)
 mov bl,[si]
 mov bh,[si+1]
 add si,2
 mov cl,[bx]
 mov ch,[bx+1]
 mov di,cx
 tact 20
endc nED_7b,'B'

nED_A0:			;LDI	byte(DE)=(HL),BC--,HL++,DE++;
 mov bx,[bp.rHL]
 mov ch,[bx]
 inc [bp.rHL]
 mov bx,[bp.rDE]
 test bh,0C0h
 jz neda0_0
 mov [bx],ch
neda0_0:
 inc [bp.rDE]
 and ah,0E9h
 tact 16
 dec [bp.rBC]
 jz DoNewCommand
 or ah,4
 endc

nED_A1:			;CPI
 mov bx,[bp.rHL]
 mov cl,ah
 cmp al,[bx]
 lahf
 and cl,1
 and ah,not 1
 or ah,cl
 inc [bp.rHL]
 or ah,6
 tact 16
 dec [bp.rBC]
 jz nED__9F0
 endc
nED__9F0:
 and ah,not 4
 endc

nED_A2:			;INI
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov cl,bl
 mov bx,[bp.rHL]
 test bh,0C0h
 jz neda2_0
 mov [bx],cl
neda2_0:
 inc [bp.rHL]
 tact 16
 or ah,42h
 dec [bp.rB]
 jz DoNewCommand
 and ah,0BFh
 endc

nED_A3:			;OUTI
 mov bx,[bp.rHL]
 mov cx,[bp.rBC]
 mov bl,[bx]
 call StoreBL_portCX
 inc [bp.rHL]
 tact 16
 or ah,42h
 dec [bp.rB]
 jz DoNewCommand
 and ah,0BFh
 endc

nED_A8:			;LDD
 mov bx,[bp.rHL]
 mov ch,[bx]
 dec [bp.rHL]
 mov bx,[bp.rDE]
 test bh,0C0h
 jz neda8_0
 mov [bx],ch
neda8_0:
 dec [bp.rDE]
 and ah,not 16h
 tact 16
 dec [bp.rBC]
 jz DoNewCommand
 or ah,4
 endc

nED_A9:			;CPD
 mov bx,[bp.rHL]
 mov cl,ah
 cmp al,[bx]
 lahf
 and cl,1
 and ah,not 1
 or ah,cl
 dec [bp.rHL]
 tact 16
 or ah,6
 dec [bp.rBC]
 jz nED__A70
 endc
nED__A70:
 and ah,not 4
 endc

nED_AA:			;IND
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov cl,bl
 mov bx,[bp.rHL]
 test bh,0C0h
 jz nedaa_0
 mov [bx],cl
nedaa_0:
 dec [bp.rHL]
 tact 16
 or ah,42h
 dec [bp.rB]
 jz DoNewCommand
 and ah,0BFh
 endc

nED_AB:			;OUTD
 mov bx,[bp.rHL]
 mov cx,[bp.rBC]
 mov bl,[bx]
 call StoreBL_portCX
 dec [bp.rHL]
 tact 16
 or ah,42h
 dec [bp.rB]
 jz DoNewCommand
 and ah,0BFh
 endc

nED_B0:			;LDIR
;Ускоренный вариант
 mov [bp.rA],al
 mov bx,[bp.rDE]
 mov cx,[bp.rHL]
ned1:
 mov al,[ecx]
 test bh,0C0h
 jz ned2
 mov [bx],al
ned2:
 inc cx
 inc bx
 dec [bp.rBC]
 jnz ned1
 mov [bp.rDE],bx
 mov [bp.rHL],cx
 and ah,not (m fH or m fPV or m fN)
 tact 16
 mov al,[bp.rA]
 endc

if 0
;Стандартный вариант
 mov bx,[bp.rHL]
 mov ch,[bx]
 inc [bp.rHL]
 mov bx,[bp.rDE]
 test bh,0C0h
 jz nedb0_0
 mov [bx],ch
nedb0_0:
 inc [bp.rDE]
 dec [bp.rBC]
 jz nED_B00
 and ah,not (m fH or m fN)
 sub si,2
 tact 21
 or ah,m fPV
 endc
nED_B00:
 and ah,not (m fH or m fPV or m fN)
 tact 16
 endc
endif

nED_B1:			;CPIR
 mov cl,ah
 mov bx,[bp.rHL]
 and cl,m fC
 inc [bp.rHL]
 cmp al,[bx]
 jz nED_B12
 lahf
 and ah,not m fC
 or ah,m fPV or m fN
 or ah,cl
 dec [bp.rBC]
 jz nED_B13
 sub si,2
 tact 21
 endc
nED_B12:
 lahf
 and ah,not m fC
 or ah,cl
 or ah,m fPV or m fN
 dec [bp.rBC]
 jz nED_B13
 tact 16
 endc
nED_B13:
 and ah,not m fPV
 tact 16
 endc

nED_B2:			;INIR
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov cl,bl
 mov bx,[bp.rHL]
 test bh,0C0h
 jz nedb2_0
 mov [bx],cl
nedb2_0:
 inc [bp.rHL]
 or ah,42h
 dec [bp.rB]
 jz nedb2_1
 and ah,0BFh
 sub si,2
 tact 21
 endc
nedb2_1:
 tact 16
 endc

nED_B3:			;OTIR
 mov bx,[bp.rHL]
 mov cx,[bp.rBC]
 mov bl,[bx]
 call StoreBL_portCX
 inc [bp.rHL]
 or ah,42h
 dec [bp.rB]
 jz nedb31
 and ah,0BFh
 sub si,2
 tact 21
 endc
nedb31:
 tact 16
 endc

nED_B8:			;LDDR
;Ускоренный вариант
 mov [bp.rA],al
 mov bx,[bp.rDE]
 mov cx,[bp.rHL]
nedb81:
 mov al,[ecx]
 test bh,0C0h
 jz nedb82
 mov [bx],al
nedb82:
 dec cx
 dec bx
 dec [bp.rBC]
 jnz nedb81
 mov [bp.rDE],bx
 mov [bp.rHL],cx
 and ah,not (m fH or m fPV or m fN)
 tact 16
 mov al,[bp.rA]
 endc

if 0
;Стандартный вариант
 mov bx,[bp.rHL]
 mov ch,[bx]
 dec [bp.rHL]
 mov bx,[bp.rDE]
 test bh,0C0h
 jz nedb8_0
 mov [bx],ch
nedb8_0:
 dec [bp.rDE]
 dec [bp.rBC]
 jz nED_B80
 and ah,not (m fH or m fN)
 sub si,2
 tact 21
 or ah,m fPV
 endc
nED_B80:
 and ah,not (m fH or m fPV or m fN)
 tact 16
 endc
endif

nED_B9:			;CPDR
 mov cl,ah
 mov bx,[bp.rHL]
 and cl,m fC
 dec [bp.rHL]
 cmp al,[bx]
 jz nED_B92
 lahf
 and ah,not m fC
 or ah,6
 or ah,cl
 dec [bp.rBC]
 jz nED_B93
 sub si,2
 tact 21
 endc
nED_B92:
 lahf
 and ah,not m fC
 or ah,cl
 or ah,6
 dec [bp.rBC]
 jz nED_B93
 tact 16
 endc
nED_B93:
 and ah,not 4
 tact 16
 endc

nED_BA:			;INDR
 mov cx,[bp.rBC]
 call LdBL_portCX
 mov ah,bh
 mov cl,bl
 mov bx,[bp.rHL]
 test bh,0C0h
 jz nedba_0
 mov [bx],cl
nedba_0:
 dec [bp.rHL]
 or ah,42h
 dec [bp.rB]
 jz nedba_1
 and ah,0BFh
 sub si,2
 tact 21
 endc
nedba_1:
 tact 16
 endc

nED_BB:			;OTDR
 mov bx,[bp.rHL]
 mov cx,[bp.rBC]
 mov bl,[bx]
 call StoreBL_portCX
 dec [bp.rHL]
 or ah,42h
 dec [bp.rB]
 jz nedbb1
 and ah,0BFh
 sub si,2
 tact 21
 endc
nedbb1:
 tact 16
 endc

CodeKernel Ends
End
