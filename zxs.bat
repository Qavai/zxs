@echo off
set tasm=e:\asm\bin\tasm.exe
c:\win\command\attrib -h *.obj
echo Основная таблица
 %tasm% tabl0.as* /m5/ml/t >_errors.obj
 if errorlevel 1 goto lita
echo После CB
 %tasm% tabl_cb.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita1
echo После ED
 %tasm% tabl_ed.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita5
echo После DD
 %tasm% tabl_dd.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita2
echo После DD CB
 %tasm% tabl_ddc.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita6
echo После FD
 %tasm% tabl_fd.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita2_0
echo После FD CB
 %tasm% tabl_fdc.as* /m5/ml/t >>_errors.obj
 if errorlevel 1 goto lita6_0
echo Имитатор
 %tasm% zxs.as* /m5/ml/t >>_errors.obj
if errorlevel 1 goto lita3
echo Компоновка ZXS.EXE
e:\asm\bin\tlink.exe /3 zxs.obj tabl0.obj tabl_cb.obj tabl_dd.obj tabl_fd.obj tabl_ddc.obj tabl_fdc.obj tabl_ed.obj, zxs.exe
rem e:\asm\wlink.exe FILE zxs,tabl0,tabl_cb,tabl_dd,tabl_fd,tabl_ddc,tabl_fdc,tabl_ed FORMAT dos NAME zxs.exe OPTION quiet,stack=528 >>_errors.obj
if errorlevel 1 goto lita4_0
c:\win\command\attrib +h *.obj
c:\win\command\attrib -h _errors.obj
cls
goto exit
:lita
echo Ошибка Основная таблица
goto exit1
:lita1
echo Ошибка CB
goto exit1
:lita2
echo Ошибка DD
goto exit1
:lita2_0
echo Ошибка FD
goto exit1
:lita3
echo Ошибка Имитатор
goto exit1
:lita4_0
echo Ошибка Компоновка ZXS.EXE
goto exit1
:lita5
echo Ошибка ED
goto exit1
:lita6_0
echo Ошибка FD CB
goto exit1
:lita6
echo Ошибка DD CB
:exit1
d:\progs\dos\qview\qview.exe _errors.obj
:exit
