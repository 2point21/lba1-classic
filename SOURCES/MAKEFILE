# name the compiler
!ifdef %HOME
!ifeq WATCOM9 yes
CC = c:\compil\watcom\bin\wcc386p
CL = c:\compil\watcom\binb\Wcl386
WL = c:\compil\watcom\binb\wlib
!else
CC = c:\compil\watcom10\binb\wcc386
CL = c:\compil\watcom10\binb\Wcl386
WL = c:\compil\watcom10\binb\wlib
!endif
!else
!ifeq WATCOM9 yes
CC = f:\compil\watcom\bin\wcc386p
CL = f:\compil\watcom\binb\Wcl386
WL = f:\compil\watcom\binb\wlib
!else
CC = f:\compil\watcom10\binb\wcc386
CL = f:\compil\watcom10\binb\Wcl386
WL = f:\compil\watcom10\binb\wlib
!endif
!endif

ASM = ml

!ifeq WATCOM9 yes
CFLAGS = /oeaxt /zp2 /4s /zq /v /s /DWATCOM9
# /d2
# /DTRACE
!else
CFLAGS = /oeaxt /zp2 /5s /zq /s
!endif
AFLAGS = /Cx /Zm /c /W0 /Sa /DNoLanguage=SYSCALL /Djumps=;
LFLAGS = /l=dos4g /x /zq /4s /k7000
# /d2
# /"OPTION SYMFILE=LBA.SYM OPTION MAP=LBA.MAP"

.SILENT

OBJETS1  = version.obj perso.obj object.obj global.obj
OBJETS2  = flipbox.obj diskfunc.obj fiche.obj extra.obj incrust.obj
OBJETS3  = grille.obj grille_a.obj func.obj cpymask.obj
OBJETS4  = Message.obj ambiance.obj Balance.obj gamemenu.obj fire.obj
OBJETS5  = geretrak.obj gerelife.obj
OBJETS6  = HoloMap.obj playfla.obj adfli_a.obj mcga.obj

EXE      = LBA0

$(EXE).exe: $(OBJETS1) $(OBJETS2) $(OBJETS3) $(OBJETS4) $(OBJETS5) $(OBJETS6)
	if exist tempo.obs del tempo.obs
	if exist tempo.obj del tempo.obj
	copy    /B *.obj tempo.obs
	ren     tempo.obs tempo.obj
	$(CL) $(LFLAGS) /fe=$(EXE).exe tempo.obj
	del     tempo.obj
	prntitre M "$(EXE) OK"
#       wstrip $(EXE)
	copy $(EXE).exe \projet\lba\game

.c.obj :
	PRNTITRE M "$*.C"
	$(CC) $^& $(CFLAGS)

.asm.obj :
	PRNTITRE M "$*.ASM"
	$(ASM) $(AFLAGS) $^&.ASM
