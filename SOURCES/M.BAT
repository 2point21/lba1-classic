copy f:\projet\lba\tools\perso\common.h
copy f:\projet\lba\tools\perso\grille.h
copy f:\projet\lba\tools\perso\message.c
copy f:\compil\watcom10\lib386\qsort.obj
rem copy f:\compil\watcom10\lib386\hrder386.obj
del version.obj

call watcom9
wmake WATCOM9=yes
call watcom10
