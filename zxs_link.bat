@echo off
c:\win\command\attrib -h *.obj >nul
echo ������
e:\asm\bin\tasm.exe zxs.as* /m5/ml/t >_errors.obj
if errorlevel 1 goto lita
echo ���������� ZXS.EXE
rem e:\asm\wlink.exe FILE zxs,tabl0,tabl_cb,tabl_dd,tabl_fd,tabl_ddc,tabl_fdc,tabl_ed FORMAT dos NAME zxs.exe OPTION quiet,stack=528 >>_errors.obj
e:\asm\bin\tlink.exe zxs.obj,tabl0.obj,tabl_cb.obj,tabl_dd.obj,tabl_fd.obj,tabl_ddc.obj,tabl_fdc.obj,tabl_ed.obj, zxs.exe
if errorlevel 1 goto lita1_0
c:\win\command\attrib +h *.obj >nul
c:\win\command\attrib -h _errors.obj
cls
goto exit
:lita
echo �訡�� ������
goto exit1
:lita1_0
echo �訡�� ���������� ZXS.EXE
:exit1
d:\progs\dos\qview\qview.exe _errors.obj
:exit
