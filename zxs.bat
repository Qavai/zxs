@echo off
set tasm=e:\asm\bin\tasm.exe
c:\win\command\attrib -h *.obj
echo �᭮���� ⠡���
 %tasm% tabl0.as* /m5/ml/t >_errors.obj
 if errorlevel 1 goto lita
echo ��᫥ CB
 %tasm% tabl_cb.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita1
echo ��᫥ ED
 %tasm% tabl_ed.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita5
echo ��᫥ DD
 %tasm% tabl_dd.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita2
echo ��᫥ DD CB
 %tasm% tabl_ddc.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita6
echo ��᫥ FD
 %tasm% tabl_fd.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita2_0
echo ��᫥ FD CB
 %tasm% tabl_fdc.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita6_0
echo ������
 %tasm% zxs.as* /m5/ml/t >>_errors.obj
if errorlevel 1 goto lita3
echo ���������� ZXS.EXE
e:\asm\bin\tlink.exe /3 zxs.obj tabl0.obj tabl_cb.obj tabl_dd.obj tabl_fd.obj tabl_ddc.obj tabl_fdc.obj tabl_ed.obj, zxs.exe
rem e:\asm\wlink.exe FILE zxs,tabl0,tabl_cb,tabl_dd,tabl_fd,tabl_ddc,tabl_fdc,tabl_ed FORMAT dos NAME zxs.exe OPTION quiet,stack=528 >>_errors.obj
if errorlevel 1 goto lita4_0
c:\win\command\attrib +h *.obj
c:\win\command\attrib -h _errors.obj
cls
goto exit
:lita
echo �訡�� �᭮���� ⠡���
goto exit1
:lita1
echo �訡�� CB
goto exit1
:lita2
echo �訡�� DD
goto exit1
:lita2_0
echo �訡�� FD
goto exit1
:lita3
echo �訡�� ������
goto exit1
:lita4_0
echo �訡�� ���������� ZXS.EXE
goto exit1
:lita5
echo �訡�� ED
goto exit1
:lita6_0
echo �訡�� FD CB
goto exit1
:lita6
echo �訡�� DD CB
:exit1
d:\progs\dos\qview\qview.exe _errors.obj
:exit
