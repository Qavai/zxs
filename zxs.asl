;������ �������-48. ������ �������,8.8.1998 <<SUPER>> @
VERSION T310
SMART
locals

include globals.asi

if TypeCpu EQ 3
P386
elseif TypeCpu EQ 4
P486
else
P586
endif

GROUP DataGroup DataStart, DataOfs, DataWork, StackStart
GROUP CodeGroup	CodeStart, CodeInterrupt

MODEL FARSTACK use16 DOS SMALL,NORMAL PASCAL
CodeStart segment byte public 'ZxsCodeStart' use16
Assume CS:CodeGroup,DS:DataGroup,SS:DataWork
start:				;=1a
 cld

 sub eax,eax
 mov ebx,eax
 mov ecx,eax
 mov edx,eax
 mov esi,eax
 mov edi,eax
 mov ebp,eax

 push DataGroup
 pop es
 mov di,ofs DataGroup:StartBss
 mov cx,LenBss/2
if (LenBss MOD 2) EQ 0
 rep stosw
else
 rep stosw
 stosb
endif

 mov ax,StackStart
 sub ax,DataOfs
 shl ax,4
 add ax,LenStack

 mov bx,ss
 mov cx,DataOfs
 mov bp,ofs DataOfs:DataCPU
 mov ss,cx
 mov sp,ax

 mov [bp+SegPSP],ds
 mov ax,ds
 push es
 pop ds
 mov es,ax

 sub bx,ax
 add bx,LenStack/16
 mov ah,4Ah
 int 33
 jc ErrMemory

 mov ax,3D00h		;���뢠� ZXS.DAT
 lea dx,NameDatFile
 int 33
 jc ErrDatFile
 mov [bp.hFileDat],ax

 mov ax,3D00h		;���뢠� Tap-䠩�
 lea dx,NameTapFile+dat
 int 33
 jc ErrTapFile
 mov [bp.hFileTap],ax

 mov ah,48h
 mov bx,65536/16
 int 33
 jc ErrMemory
 mov [bp.SegZX],ax

 push ds
 mov ds,ax
 mov ah,3Fh		;����㧪� ��� 16�� � �࠭ 6912 ���� (���⠢��)
 mov cx,16384+6912
 mov bx,[bp.hFileDat]
 sub dx,dx
 int 33
 pop ds
 jc ErrDatFile
 cmp ax,16384+6912
 jnz ErrDatFile

 mov ah,15
 int 16
 mov [bp.OldScrMode],al

 mov ax,3509h
 int 33
 mov [bp.OldInt9Ofs],bx
 mov [bp.OldInt9Seg],es

 mov ax,13h
 int 16

 push ds
 pop es
 mov ax,1012h
 sub bx,bx
 mov cx,17
 lea dx,TablePalVga
 int 16

 cli
 in al,21h
 mov [bp.OldPort21h],al
 in al,61h
 mov [bp.OldPort61h],al

 mov dx,3daH		;���� �࠭���
 in al,dx
 jmp $+2
 mov dl,0c0h
 mov al,11h+32
 out dx,al
 jmp $+2
 mov al,16
 out dx,al

 mov al,11111101b	;���쪮 ��������� ࠡ�⠥�
 out 21h,al

 mov al,[bp.OldPort61h]	;������ �ࠢ����� ��㪮� �१ 1 ���
 and al,not 3		;������ 1 ���
 out 61h,al

 mov ax,2509h
 lea dx,Int9Entry
 push cs
 pop ds
 int 33

 push 0A000h
 pop es

 push eax
 mov eax,10101010h
 xor di,di		;�����⠢����� ������� ��� �뢮�� �࠭��� (BORDER)
 mov cx,(4*320+32)/4
 rep stosd
 mov di,4*320+32
 mov bx,192
m101a:
 add di,256
 mov cx,(32+32)/4
 rep stosd
 dec bx
 jnz m101a
 mov cx,(4*320)/4
 rep stosd
 pop eax

 mov ds,[bp.SegZX]
 call ResetCPU
 xor cx,cx
 sti
 jmp far ptr DoNewCommand

ExitDos:
 cli
 mov ax,2509h
 lds dx,[bp.OldInt9]
 int 33

 push DataGroup
 pop ds

 mov al,[bp.OldPort21h]
 out 21h,al
 mov al,[bp.OldPort61h]
 out 61h,al
 sti

 movzx ax,[bp.OldScrMode]
 int 16
Dos:
 mov bx,[bp.hFileDat]
 or bx,bx
 jz Dos0
 mov ah,3Eh
 int 33
Dos0:
 mov bx,[bp.hFileTap]
 or bx,bx
 jz Dos01
 mov ah,3Eh
 int 33
Dos01:
 mov ax,[bp.SegZX]
 or ax,ax
 jz Dos1
 mov es,ax
 mov ah,49h
 int 33
Dos1:
 lea dx,dhelp
 call ConString
 lea dx,hallo
 call ConString

 EXITCODE 0

ErrMemory:
 lea dx,strErrMemory
 jmp Vika

ErrTapFile:
 lea dx,strErrTapFile
 jmp Vika

ErrDatFile:
 lea dx,strErrDatFile
Vika:
 call ConString
 jmp Dos

;----------------------
; �뢮��� ����� � CON
; IN -> DX-����;
proc ConString
 mov ah,9
 int 33
ret
endp
;----------------------

CodeStart Ends
;----------------------------------------------------------------------------
CodeKernel segment para public 'ZxsCodeKernel' use16
Assume CS:CodeKernel,DS:nothing,SS:DataWork
proc DoNewCommand
shl cx, 3	;!
 sub [bp.Tacts],cx	;? cx
 jns @@m1
 cmp [bp.LastKey],40h+128	;F6 - ॠ��� ०��
 jz @@m1
;=====================================================================
 add [bp.Tacts],360*8	;�뢮�� ��।��� ����� (8 ��ப)
 pushad
 mov di,[bp.NextAdrIn]
 push di

 mov si,[bp+di]		;���� �祪
 mov bx,[bp+di+2]	;���� ��ਡ�⮢
 mov di,[bp+di+4]

 mov cx,32
@@z0:
 push cx
 mov dl,[bx]		;DL=��ਡ��� ��� 8 �祪: .7-FLASH,.6-BRIGHT
			;.0...2-INK(GRB),.3...5-PAPER(GRB)
 or dl,dl
 jns @@v2
 test [bp.fl0],m FlashOn
 jz @@v2

 mov cl,dl		;����� INK � PAPER
 shr cl,3
 and cl,0Fh		;CL=PAPER
 and dl,7
 mov ch,cl
 and ch,8
 or ch,dl		;CH=INK
 jmp @@v3

@@v2:
 mov ch,dl
 shr ch,3
 and ch,0Fh		;CH=PAPER
 and dl,7
 mov cl,ch
 and cl,8
 or cl,dl		;CL=INK

 include zxs_con.asi

 inc si
 pop cx
 inc bx
 dec cx
 jnz @@z0

 pop ax			;DI
 add ax,6
 cmp ax,tAdrsInEnd
 jnz @@v1

 mov [bp.NextAdrIn],tAdrsIn
 popad
 dec [bp.fSecond]
 jnz @@q3
 mov [bp.fSecond],25
 xor [bp.fl0],m FlashOn
@@q3:
 cmp [bp.fHALT],0
 jz @@q4
 mov [bp.fHALT],0
 inc si
@@q4:
 cmp [bp.fINT],0
 jz @@m1
 mov [bp.fINT],0
;? or [bp.fl0],m IntGo

;? 3 ⨯� ���뢠��� ������ (IM)
 dec di
 mov cx,si
 test di,0C000h
 mov si,38h
 jz @@q1
 mov [di],ch
@@q1:
 dec di
 test di,0C000h
 jz DoNext
 mov [di],cl
 jmp DoNext

@@v1:
 mov [bp.NextAdrIn],ax
 popad
;=====================================================================
@@m1:
 push ax
 mov al,[bp.LastKey]
 cmp al,3Fh+128		;F5 ��� ������
 jnz m302a
 mov [bp.LastKey],0
 pop ax
 call ResetCPU
 jmp DoNext

m302a:
 cmp al,1+128		;Esc ��室 � ��
 jz ExitImitation
 cmp al,44h+128		;F10 ��㧠 ����樨
 jnz m312a
 pop ax
 jmp DoNewCommand

m312a:
 cmp al,3Dh+128		;F3 ����㧪� Z80-䠩��
 jz LoadZ80
 pop ax

DoNext:
 cmp si,556h		;�஢�ઠ,����-�� ���뢠��� � ������䮭�
 jz LdBytes

DoContinue:
 inc dl
 js m152a
 mov bl,[si]
 sub bh,bh
 inc si
			Assume SS:DataOfs
 jmp wptr [ss:ebx*2+Cmd0]

m152a:
 mov bl,[si]
 sub bh,bh
 inc si
 xor dl,dl
 jmp wptr [ss:ebx*2+Cmd0]

ExitImitation:
 pop ax
 jmp far ptr ExitDos
endp

;------------------------------
; ���ᯥ稢��� ����㧪� � �����
proc LdBytes
 pusha
 push ds es ds
 pop es

 mov [bp.rAF],ax
 mov ah,48h		;�뤥��� ������ �६���� ��� ����㧪� 䠩��
 mov bx,65536/16
 int 33
 jc @@ErrMem
 mov [bp.SegBufTap],ax
 mov ds,ax

 mov ah,3Fh		;Tap-䠩� 㦥 �����, ����㦠� ���� 3 ����
 mov bx,[bp.hFileTap]
 mov cx,3
 xor dx,dx
 int 33
 jc @@ErrTap
 cmp ax,3
 jnz @@ErrTap

 xor si,si		;�஢�ઠ ����� � ⨯�
 lodsw
 mov cx,ax
 cmp ax,3
 jc @@ErrTap
 dec ax
 dec ax
 mov [bp.LenBlock],ax
 cmp ax,[bp.rDE]
 jnz @@ErrTap
 lodsb
 cmp al,[bp.rA]
 jnz @@ErrTap
 mov [bp.TypeBlock],al

 mov ax,cx		;����㦠� ����� � ���� ��⭮��
 dec cx
 mov ah,3Fh
 xor dx,dx
 push cx		;?
 int 33
 pop cx
 jc @@ErrTap
 cmp ax,cx
 jnz @@ErrTap

 xor si,si		;�஢�ઠ �� ��⭮���
 mov al,[bp.TypeBlock]
@@m1:
 xor al,[si]
 inc si
 dec cx
 jnz @@m1
 or al,al
 jnz @@ErrTap

 mov bx,[bp.rIX]
 xor si,si
 mov cx,[bp.LenBlock]
 test [bp.rF],1		;LOAD ��� VERIFY
 jz @@Verify

@@m2:			;LOAD - ��९��뢠� � ������
 lodsb
 test bh,0C0h
 jz @@m3
 mov [es:bx],al
@@m3:
 inc bx
 dec cx
 jnz @@m2
 jmp @@OkTap

@@Verify:
 lodsb
 cmp al,[es:bx]
 jnz @@ErrTap
 inc bx
 dec cx
 jnz @@Verify
@@OkTap:
 mov ah,49h
 mov es,[bp.SegBufTap]
 int 33
 or [bp.rF],1		;?
 jmp @@ExitLdBytes

@@ErrTap:
 mov ah,49h
 mov es,[bp.SegBufTap]
 int 33
@@ErrMem:
 and [bp.rF],not 1	;?
 or [bp.rF],40h
@@ExitLdBytes:
 pop es ds
 popa

 mov ah,[bp.rF]
 mov si,53Fh
 jmp DoContinue
endp
;
;? ������� �⪠� �� 3 ����, �᫨ �訡��
;? ��������, ������ DE,IX,A
;------------------------------
proc LoadZ80
 pop ax




 jmp DoNext

endp
;----------------------------------
; �����頥� � BL ���祭�� ���� CX
; IN -> CX-����
; OUT-> BL-���祭�� ����
;	BH-������� 䫠��
;
;  ! -> CX ���������
proc LdBL_portCX
 mov bl,255		;���⮢ ���
 rcr cl,1
 jc @@NoFE

 mov bl,1Fh		;������ ����������
 shr ch,1
 jc @@m1
 and bl,[bp.Array8KeyLine]
@@m1:
 shr ch,1
 jc @@m2
 and bl,[bp.Array8KeyLine+1]
@@m2:
 shr ch,1
 jc @@m3
 and bl,[bp.Array8KeyLine+2]
@@m3:
 shr ch,1
 jc @@m4
 and bl,[bp.Array8KeyLine+3]
@@m4:
 shr ch,1
 jc @@m5
 and bl,[bp.Array8KeyLine+4]
@@m5:
 shr ch,1
 jc @@m6
 and bl,[bp.Array8KeyLine+5]
@@m6:
 shr ch,1
 jc @@m7
 and bl,[bp.Array8KeyLine+6]
@@m7:
 shr ch,1
 jc @@m8
 and bl,[bp.Array8KeyLine+7]
@@m8:

@@NoFE:
;? sahf
; mov bh,ah
; mov cl,ah
; and bh,m fC
; and bl,bl
; lahf
; and ah,not(m fH or m fN or m fC)
; or bh,ah
; mov ah,cl
 mov ch,ah
 test bl,bl
 ror ah,1
 lahf
 mov bh,ah
 mov ah,ch
ret
endp
;----------------------------------
;----------------------------------
; ���뫠�� ���祭�� BL � ���� CX
; IN -> CX-����
;	BL-���뫠���� ���祭��
; ! ->	BX �������
;	CX �������
proc StoreBL_portCX
 rcr cl,1
 jc @@notFE

 mov cl,bl
 push ax
 xor cl,[bp.pfeo]
 mov [bp.pfeo],bl
 jz @@ret
 test cl,16
 jz @@next0

 mov ch,bl		;�뢮� ��㪠
 in al,97
 and ch,10h
 shr ch,3
 and al,not 2
 or al,ch
 out 97,al

@@next0:		;�뢮� �࠭���
 test cl,7
 jz @@next1

 push dx
 mov dx,3C8h
 mov al,16
 cli
 out dx,al

 and bl,7
 sub bh,bh
 shl bl,2
 inc dx
 add bx,ofs tColorBorder
 mov al,[cs:bx]
 out dx,al
 jmp $+2
 mov al,[cs:bx+1]
 out dx,al
 jmp $+2
 mov al,[cs:bx+2]
 out dx,al
 sti
 pop dx

@@next1:		;�뢮� ������䮭�
;?
@@ret:
 pop ax
;ret
@@notFE:
ret
endp

tColorBorder label byte	;R,G,B (0...63)
 db 0,0,0,?	;����
 db 0,0,35,?	;�����
 db 50,0,0,?	;����
 db 52,0,40,?	;������,�७��� (Magenta)
 db 0,48,0,?	;�����
 db 0,48,48,?	;���㡮� (Cyan)
 db 47,47,0,?	;����
 db 45,45,45,?	;����

;----------------------------------

;---------------------
; ����뢠�� ������
proc ResetCPU far
 mov ax,1F1Fh
 mov wptr [bp.Array8KeyLine],ax
 mov wptr [bp.Array8KeyLine+2],ax
 mov wptr [bp.Array8KeyLine+4],ax
 mov wptr [bp.Array8KeyLine+6],ax
 mov [bp.Tacts],360*8
 mov [bp.NextAdrIn],tAdrsIn
 mov [bp.fSecond],25
 mov [bp.fl0],0		;?

 sub ax,ax
 mov si,ax
 mov di,ax
 mov dx,ax

 mov [bp.rBC],ax
 mov [bp.rHL],ax
 mov [bp.rDE],ax
 mov [bp.rBC_],ax
 mov [bp.rDE_],ax
 mov [bp.rHL_],ax
 mov [bp.rAF_],ax
 mov [bp.rIX],ax
 mov [bp.rIY],ax

 mov wptr [bp.fINT],ax
 mov [bp.fIM],al
 mov [bp.fHALT],al
ret
endp
;---------------------

CodeKernel Ends
;----------------------------------------------------------------------------
CodeInterrupt segment para public 'ZxsCodeStart' use16
Assume CS:CodeGroup,SS:DataWork
;------------------------
; ��ࠡ��稪 9 ���뢠���
proc Int9Entry
 push eax ds DataWork
 sub eax,eax
 pop ds
			Assume DS:DataWork
 in al,96
 mov [LastKey+dat],al
 jmp wptr [cs:eax*2+tKeysJump]

ExitInt9:
 in al,97
 mov ah,al
 or al,128
 out 97,al
 mov al,ah
 jmp $+2
 out 97,al

 mov al,32
 pop ds
 out 32,al
 pop eax
iret
endp

include zxs_keys.asi

CodeInterrupt Ends
;----------------------------------------------------------------------------
DataStart segment para public 'ZxsDataStart' use16
hallo	db 'Super Assembler - Copyright 1993-2000 <<SUPER>>'
	db ' super21@chat.ru',13,10
	db 'Software of 21 centure',13,10,36

 NameDatFile	db 'zxs.dat',0
 strErrDatFile	db '���� ZXS.DAT ��������� ��� �ᯮ�祭',13,10,36
 strErrTapFile	db '�訡�� TAP-䠩��',13,10,36
 strErrZ80File	db '�訡�� Z80-䠩��',13,10,36
 strErrMemory	db '�訡�� � ������� ��� �� ����',13,10,36
 dhelp		db 13,10,'(C) ZXS ����� 1.0 "������ ZX Spectrum-48K"'
 		db ' ������ E������ 1998-2000',13,10,36

TablePalVga	db 0,0,0	;����	(�᫨ ������, � � tColorBorder ⮦�!)
		db 0,0,35	;�����
		db 50,0,0	;����
		db 52,0,40	;������,�७��� (Magenta)
		db 0,48,0	;�����
		db 0,48,48	;���㡮� (Cyan)
		db 47,47,0	;����
		db 45,45,45	;����
		db 0,0,0
		db 0,0,43	;�ન� ��襮��ᠭ�� 梥�
		db 60,0,0
		db 63,0,55
		db 0,60,0
		db 0,63,63
		db 63,63,0
		db 63,63,63

		db 0,0,0	;�࠭��
DataStart Ends
;----------------------------------------------------------------------------
DataOfs segment para public 'ZxsDataStart' use16
StartOffsets label word

include zxs_ofs.asi

EndOffsets label word
LenOfs = $-StartOffsets
DataOfs Ends
;----------------------------------------------------------------------------
DataWork segment para public uninit 'ZxsDataStart' use16
NOWARN UNI
 tAdrsIn        = wptr ($-dat)
 include zxs_adrs.asi		;���� ��砫� ���祪 �祪 � ��ਡ�⮢
 tAdrsInEnd     = wptr ($-dat)
 NameTapFile	= bptr ($-dat)
 		db 'zxs.tap',0
 NameZ80File	= bptr ($-dat)
 		db 'zxs.z80',0
StartBss label byte
 Tacts          = wptr ($-dat)
 		dw ?		;������⢮ ⠪⮢ �� �뢮�� �����
 NextAdrIn	= wptr ($-dat)
                dw ?		;���� �뢮�� (ᬥ饭��)
 fSecond	= bptr ($-dat)
		db ?		;������� ᥪ㭤� (��� FLASH)
 Array8KeyLine	= bptr ($-dat)
 		db 8 dup(?)	;"8 ����� ���ᮢ �� ����������"
 fl0		= bptr ($-dat)
                db ?		;������
 LastKey        = bptr ($-dat)
 		db ?		;Scan-��� ��᫥���� ������

dat label unknown
WARN UNI
 DataCPU	DataVar <?>
 SegZX          = wptr ($-dat)
 		dw ?

 OldInt9	= dwptr ($-dat)
 OldInt9Ofs     = wptr ($-dat)
 		dw ?
 OldInt9Seg     = wptr ($-dat)
 		dw ?
 OldPort21h     = bptr ($-dat)
 		db ?
 OldPort61h     = bptr ($-dat)
 		db ?
 OldScrMode     = bptr ($-dat)
 		db ?
 SegPSP         = wptr ($-dat)
 		dw ?
 hFileDat       = wptr ($-dat)
 		dw ?		;����� ����⮣� 䠩�� "zxs.dat"

; KeysPress      = bptr ($-dat)
; 		db 128 dup(?)
 SegBufTap	= wptr ($-dat)
		dw ?		;������� ���� ��� ࠡ��� � TAP-䠩���
 hFileTap	= wptr ($-dat)
		dw ?
 hFileZ80	= wptr ($-dat)
		dw ?
 LenBlock	= wptr ($-dat)
 		dw ?		;����� ���뢠����� �����
 TypeBlock	= bptr ($-dat)
 		db ?		;��� ���뢠����� �����

EndBss	label byte
LenBss	= $-StartBss
DataWork Ends
;----------------------------------------------------------------------------
StackStart segment para stack 'ZxsStackStart' use16

 db LenStack dup(?)

errif LenStack MOD 16 NE 0 "������ �⥪� ���� ��⭮ 16"
StackStart Ends
;----------------------------------------------------------------------------
End start

--------------------- ���ᠭ�� �ଠ� 䠩�� "zxs.dat" --------------------
���饭��   �����   �� �ᯮ������
---------------------------------------------------------------------------
      0h   4000h   ���-48 Spectrum 
   4000h   1B00h   ���⠢�� ������
---------------------------------------------------------------------------

 fl0	IntGo	- ���� ���뢠��� INT
	FlashOn - ᬥ�� INK � PAPER

*******************************************************************************

TablePalVga	db 0,0,0
		db 0,0,40
		db 55,0,0
		db 57,0,45
		db 0,53,0
		db 0,53,53
		db 52,52,0
		db 50,50,50

		db 0,0,0
		db 0,0,43
		db 60,0,0
		db 63,0,55
		db 0,60,0
		db 0,63,63
		db 63,63,0
		db 63,63,63

