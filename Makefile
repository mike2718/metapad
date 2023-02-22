TARGETOS = WINNT
APPVER = 5.0
NODEBUG = 1
!include <win32.mak>

PROJ = metapad
SRCDIR = .
OUTDIR = Release

cdebug = -O2 -DNDEBUG 

all: $(OUTDIR) $(OUTDIR)\$(PROJ).exe

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

OBJS=$(OUTDIR)\metapad.obj    \
     $(OUTDIR)\cencode.obj    \
     $(OUTDIR)\cdecode.obj

ELIBS=msvcrt_winxp.obj msvcrt.lib ntstc_msvcrt.lib shell32.lib comctl32.lib

$(OUTDIR)\$(PROJ).res: $(PROJ).rc $(SRCDIR)\resource.h
    rc $(rcvars) $(rcflags) /nologo /d"NODEBUG" /fo"$(OUTDIR)\$(PROJ).res" "$(SRCDIR)\$(PROJ).rc"

.c{$(OUTDIR)}.obj:
    $(cc) $(cdebug) $(cflags) $(cvarsdll) \
    /D "_CRT_SECURE_NO_WARNINGS" /D "_SECURE_CRT_NO_DEPRECATE" /D "_WINDOWS" \
    /D "UNICODE" /D "_UNICODE" /D "USE_RICH_EDIT" /GS- \
    /Fp"$(OUTDIR)\\" /Fo"$(OUTDIR)\\" /Fd"$(OUTDIR)\\" $**

$(OUTDIR)\$(PROJ).exe: $(OBJS) $(OUTDIR)\$(PROJ).res
	$(link) $(ldebug) $(guilibsdll) $(guilflags) \
    /LIBPATH:"C:\WinDDK\7600.16385.1\lib\Crt\i386" /LIBPATH:"C:\WinDDK\7600.16385.1\lib\wxp\i386" \
    /MACHINE:X86 /INCREMENTAL:NO /NODEFAULTLIB:"MSVCRT.LIB" /OUT:"$(OUTDIR)\$(PROJ).exe" \
    $(OBJS) $(ELIBS) "$(OUTDIR)\$(PROJ).res" /PDB:"$(OUTDIR)\$(PROJ).PDB"
    if exist "$(SRCDIR)\$(PROJ).manifest" \
        mt -nologo -manifest "$(SRCDIR)\$(PROJ).manifest" -outputresource:"$@;#1"

clean:
	-del $(OUTDIR)\*.obj
    -del $(OUTDIR)\*.res

cleanall:clean
	-del $(OUTDIR)\*.exe
