		.386p

		.model SMALL, SYSCALL

		include	f:\projet\lib386\lib_svga\svga.ash

;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*
;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*
		.data
;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*

		extrn	NoLanguage TabOffLine:DWORD
		extrn	NoLanguage Screen:DWORD

IndexCoul0	db	4*16
PalRed		db	0
PalGreen	db	0
PalBlue		db	0
PalXor		db	0

;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*
		.code
;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*
;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

		public	NoLanguage	SimpleInitMcga
		public	NoLanguage	CopyBlockMCGA
		public	NoLanguage	ShadeBox
		public	NoLanguage	SmallSort
;		public	NoLanguage	SpeedRam
;		public	NoLanguage	TimerPalFx
		public	NoLanguage	GetHDFreeSize
		public	NoLanguage	ComputeTime

;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

;SpeedRam	proc				; pas remarquable
;
;		mov	al, 200
;		out	41, al
;		ret
;
;SpeedRam	endp

;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

comment	#

TimerPalFx	proc	uses eax edx ecx

		xor	byte ptr[PalXor], 1
		jnz	tpf1

		add	byte ptr[PalBlue], 4

		mov	al, [IndexCoul0]
		mov	dx, 03c8h
		out	dx, al			; al=Num Color

		mov	ah, [PalBlue]

		mov	cx, 16

tpf0:		mov	dx, 03c9h
		mov	al, [PalRed]
		out	dx, al			; Red
		mov	al, [PalGreen]
		out	dx, al			; Green
		mov	al, ah
		out	dx, al			; Blue

		add	ah, 8
		dec	cx
		jnz	tpf0

tpf1:		ret

TimerPalFx	endp

	#

;----------------------------------------------------------------------------
ComputeTime			proc
			local	cpttime:DWORD
			local	cptdate:DWORD

                        mov	[cpttime], 0
			mov	[cptdate], 0

			mov	ah, 2ch
			int	21h
			mov	byte ptr [cpttime], ch	;'Heure
			shl	cpttime, 6
			or	byte ptr [cpttime], cl	;'Minutes
			shl	cpttime, 5
			shr	dh, 1
			or	byte ptr [cpttime], dh	;'Secondes/2

			mov	ah, 2ah
			int	21h
			sub	cx, 1980
			mov	byte ptr [cptdate], cl	;' Annees
			shl	cptdate, 4
			or	byte ptr [cptdate], dh	;' Mois
			shl	cptdate, 5
			or	byte ptr [cptdate], dl	;' Jour

			mov	eax, cpttime
			add	eax, cptdate
			ret
ComputeTime			endp
;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*/

SmallSort	proc	uses esi edi ebx ebp,\
		objetlist:DWORD, nbobjets:DWORD, structsize:DWORD

		mov	esi, objetlist
		mov	ecx, nbobjets
		dec	ecx
		jle	fintri

		mov	edx, structsize

		; ecx nb entite - 1
		; esi start list sizeof structsize bytes
	EVEN
tt0:            mov	ebp, ecx
		mov	eax, [esi]		; lit Z

		mov	edi, esi
		add	edi, edx
		xor	ebx, ebx

tt1:		cmp	[edi], ax
		jl	plusgrand
cont:		add	edi, edx
		loop	tt1

		or	ebx, ebx
		jz	short noexchg

;		mov	eax, [ebx]
;		xchg	[esi], eax		; permutte
;		mov	[ebx], eax

		mov	edi, esi
		push	edx
		shr	edx, 2
	EVEN
permute:    	mov	eax, [ebx]
		xchg	[edi], eax		; permutte
		mov	[ebx], eax
		add	ebx, 4
		add	edi, 4
		dec	dx
		jnz	permute

		pop	edx

noexchg:	add	esi, edx
		mov	ecx, ebp
		loop	tt0

fintri:		ret

plusgrand:    	mov	ebx, edi
		mov	eax, [edi]
		jmp	short cont

SmallSort	endp

;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*
;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*

SimpleInitMcga	proc	uses esi edi ebp ebx

		mov	ax, 13h
		int	10h
		ret

SimpleInitMcga	endp

;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*

CopyBlockMCGA		proc	uses esi edi ebx ebp,\
			x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, src:DWORD,\
			xd:DWORD, yd:DWORD, dst:DWORD

			mov	ebx, y0
			mov	esi, TabOffLine[ebx*4]	; y0
			add	esi, src
			add	esi, x0			; SI Offset Src

;			mov	edi, yd
;			mov	eax, edi
;			shl	edi, 2			; *4
;			add	edi, eax		; *5
;			shl	edi, 6			; *320
;			add	edi, dst
;			add	edi, xd			; DI Offset Dst

			mov	edi, dst

			mov	ebx, y1			; y0 <=> y1
			sub	ebx, y0
			inc	ebx 			; BX Delta Y

			mov	eax, x1
			sub	eax, x0
			inc	eax                     ; AX Delta X

			mov	edx, 320
			sub	edx, eax		; DX Delta Screen
			mov	ebp, 640
			sub	ebp, eax
Again:
			mov	ecx, eax
			shr	ecx, 2
			rep	movsd
			mov	ecx, eax
			and	ecx, 11b
			rep	movsb

			add	esi, ebp
			add	edi, edx
			dec	ebx
			jne	short Again

			ret
CopyBlockMCGA		endp

;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*
;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*

ShadeBox		proc	uses esi edi ebp ebx,\
			x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD,\
			deccoul:DWORD

			mov	eax, x0
			mov	ebx, y0
			mov	ecx, x1
			mov	edx, y1

;----------------------

			cmp	eax, ClipXmax
			jg	Box_End
			cmp     ecx, ClipXmin
			jl	Box_End
			cmp	ebx, ClipYmax
			jg	Box_End
			cmp	edx, ClipYmin
			jl	Box_End
TestLeft:
			cmp	eax, ClipXmin
			jge	TestRight
			mov	eax, ClipXmin
TestRight:
			cmp	ecx, ClipXmax
			jle	TestUp
			mov	ecx, ClipXmax
TestUp:
			cmp	ebx, ClipYmin
			jge	TestDown
			mov	ebx, ClipYmin
TestDown:
			cmp	edx, ClipYmax
			jle	OkNoClip
			mov	edx, ClipYmax
OkNoClip:
;----------------------
			mov	edi, ebx		; Y0
			mov	edi, TabOffLine[edi*4]
			add	edi, Log
			add	edi, eax		; EDI Offset Src
;----------------------
			sub	edx, ebx		; Init Delta Y
			mov	ebx, edx
			inc	ebx

			mov	edx, ecx		; Init Delta X
			sub	edx, eax
			inc	edx

			mov	esi, Screen_X
			sub	esi, edx		; ebp Delta Screen

			mov	ecx, deccoul

Again:			mov	ebp, edx

loopx:			mov	al, byte ptr[edi]
			mov	ah, al
;							and	ah, 0F0h
;							and	al, 00Fh
			and	ax, 0F00Fh
			sub	al, cl
			jc	lesszero

			add	al, ah

			mov	byte ptr[edi], al
			inc	edi

			dec	ebp
			jnz	loopx

			add	edi, esi
			dec	ebx
			jne	Again
Box_End:
			ret

lesszero:               mov	al, ah
			mov	byte ptr[edi], al
			inc	edi

			dec	ebp
			jnz	loopx

			add	edi, esi
			dec	ebx
			jne	Again

			ret

ShadeBox		endp


;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/

comment	#

DesintegreClip	proc	uses ebx edi esi ebp
		level:DWORD

			mov	eax, ClipXmin
			mov	ecx, ClipXmax
			mov	ebx, ClipYmin
			mov	edx, ClipYmax

;----------------------

			mov	edi, ebx		; Y0
			mov	edi, TabOffLine[edi*4]
			add	edi, eax		; EDI Offset Src
			mov	esi, edi
			add	edi, Log
			add	esi, Screen
;----------------------

			sub	edx, ebx		; Init Delta Y
			mov	ebx, edx
			inc	ebx

			mov	edx, ecx		; Init Delta X
			sub	edx, eax
			inc	edx

			mov	eax, Screen_X
			sub	eax, edx		; ebp Delta Screen
			mov	[offsety], ecx


Again:			mov	ebp, edx

loopx:

			mov	al, byte ptr[esi]

			mov	ebx, esi
			and	ebx, 7
			and	al, byte ptr[ebx]	; plus tard table


			mov	byte ptr[edi], al

			inc	edi
			inc	esi

			dec	ebp
			jnz	loopx

			add	edi, [offsety]
			dec	ebx
			jne	Again

			ret

DesintegreClip	proc

	#

;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*
GetHDFreeSize		proc	uses	ebx

			xor	eax, eax	;' Cause IMUL
			mov	ebx, eax	;' Cause IMUL
			mov	ecx, eax	;' Cause IMUL

			mov	ah, 36h
			mov	dl, 0  		;' Current Drive
			int	21h		;' Get Free Space

			imul	ebx
			imul	ecx		;' Bytes*Sectors*Clusters

			ret

GetHDFreeSize		endp
;*ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ*
;*ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
		END
