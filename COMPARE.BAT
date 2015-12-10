@echo off
s:\win\command\fc d:\tabl0.asl s:\DAYS.PRO\ZXS\tabl0.asl /a >d:_errors.asm
s:\win\command\fc d:\tabl_cb.asl s:\DAYS.PRO\ZXS\tabl_cb.asl /a >>d:\_errors.asm
s:\win\command\fc d:\tabl_ed.asl s:\DAYS.PRO\ZXS\tabl_ed.asl /a >>d:\_errors.asm
s:\win\command\fc d:\tabl_dd.asl s:\DAYS.PRO\ZXS\tabl_dd.asl /a >>d:\_errors.asm
s:\win\command\fc d:\tabl_ddc.asl s:\DAYS.PRO\ZXS\tabl_ddc.asl /a >>d:\_errors.asm
s:\win\command\fc d:\tabl_fd.asl s:\DAYS.PRO\ZXS\tabl_fd.asl /a >>d:\_errors.asm
s:\win\command\fc d:\tabl_fdc.asl s:\DAYS.PRO\ZXS\tabl_fdc.asl /a >>d:\_errors.asm
s:\win\command\fc d:\zxs.asl s:\DAYS.PRO\ZXS\zxs.asl /a >>d:\_errors.asm
s:\win\command\fc d:\globals.asi s:\DAYS.PRO\ZXS\globals.asi /a >>d:\_errors.asm
echo Сравнение прошло. Смотрите файл d:\_errors.asm
