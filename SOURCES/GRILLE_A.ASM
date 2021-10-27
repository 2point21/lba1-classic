;----------------------------------------------------------------------------
;				 Grille_A.ASM 386
;			      (c) Adeline 1993
;----------------------------------------------------------------------------
				.386P
				.model SMALL, SYSCALL
;----------------------------------------------------------------------------
				.data
;----------------------------------------------------------------------------
			extrn	NoLanguage	XMap	:DWORD
			extrn	NoLanguage	YMap	:DWORD
			extrn	NoLanguage	ZMap	:DWORD
			extrn	NoLanguage	XScreen	:DWORD
			extrn	NoLanguage	YScreen	:DWORD

			include	\projet\lib386\lib_svga\svga.ash

			public	NoLanguage	CodeJeu

CodeJeu		db	0

comment	@
UBYTE	*BufCube		;
UBYTE	*BufMap			;
UBYTE	*TabBlock		;
UBYTE	*BufferBrick		;
	@

	extrn	NoLanguage	BufCube:DWORD
	extrn	NoLanguage	BufMap:DWORD
	extrn	NoLanguage	TabBlock:DWORD
	extrn	NoLanguage	BufferBrick:DWORD

HEADER_BLOCK	equ	3

SIZE_CUBE_X	equ	64
SIZE_CUBE_Y	equ	25
SIZE_CUBE_Z	equ	64

SIZE_BRICK_XZ	equ	512
SIZE_BRICK_Y	equ	256
DEMI_BRICK_XZ	equ	256
DEMI_BRICK_Y	equ	128

;----------------------------------------------------------------------------
				.code

			public	NoLanguage	DecompColonne
			public	NoLanguage	Map2Screen
			public	NoLanguage	MixteColonne
			public	NoLanguage	GetAdrBlock
;			public	NoLanguage	GetColBrick
			public	NoLanguage	WorldColBrick
			public	NoLanguage	WorldColBrickFull
			public	NoLanguage	WorldCodeBrick

;----------------------------------------------------------------------------
;*--------------------------------------------------------------------------*

GetAdrBlock	proc	,\
		numblock:DWORD

		mov	ecx, numblock

		mov	eax, [TabBlock]		; pto = (ULONG*)TabBlock
		add	eax, [ eax + ecx*4 ]	; TabBlock + pto[numbloc]

		ret

GetAdrBlock	endp

;*--------------------------------------------------------------------------*

WorldColBrickFull 	proc	xw:DWORD, yw:DWORD, zw:DWORD, ymax:DWORD

	;' ptc = BufCube

		mov	ecx, [BufCube]

	;' + (xm*SIZE_CUBE_Y*2)

		mov	eax, xw

	;' xm = (xw+DEMI_BRICK_XZ)/SIZE_BRICK_XZ

		add	eax, DEMI_BRICK_XZ	; +256
		shr	eax, 9			; /512

		mov	[XMap], eax

	;' + ym*2

		mov	eax, yw

	;' ym = yw/SIZE_BRICK_Y

		sar	eax, 8			; /256
		mov	[YMap], eax

	;' + zm*3200 (SIZE_CUBE_X*SIZE_CUBE_Y*2)

		mov	eax, zw

	;' zm = (zw+DEMI_BRICK_XZ)/SIZE_BRICK_XZ

		add	eax, DEMI_BRICK_XZ	; +256
		shr	eax, 9			; /512

		mov	[ZMap], eax

		mov	eax, [XMap]
		or	eax, eax		; bound
		jl	ovfw
		cmp	eax, 64
		jge	ovfw

		lea	eax, [eax*2]		; *2
		mov	edx, eax		; =
		lea	eax, [eax*8]		; *16
		add	edx, eax		; 2  + 16 = 18
		lea	edx, [edx+eax*2]	; 18 + 32 = 50

		add	ecx, edx

		mov	eax, [YMap]

		cmp	eax, -1
		jle	col_1

		lea	ecx, [ecx+eax*2]

		mov	eax, [ZMap]

		or	eax, eax		; check bound
		jl	ovfw
		cmp	eax, 64
		jge	ovfw

		shl	eax, 7			; *128
		mov	edx, eax		; = 128
		lea	eax, [eax*8]		; *1024
		add	edx, eax		; 128  + 1024 = 1152
		lea	edx, [edx+eax*2]	; 1152 + 2048 = 3200

		add	ecx, edx

		xor	eax, eax
		mov	al, [ecx]

		or	al, al
		jz	nocol

	;'	if( *ptc != 0 )
	;'	{
	;'		block = (*ptc++) - 1 ;
	;'		adr = GetAdrBlock( block )	;
	;'		adr += HEADER_BLOCK		;
	;'		adr += (*ptc)<<2 		;/* 4 Bytes to Jump	*/
	;'		return *adr ;
	;'	}

		mov	edx, [TabBlock]			; pto = (ULONG*)TabBlock
		add	edx, [ edx + eax*4 - 4]		; TabBlock + pto[numblock]

		add	edx, HEADER_BLOCK

		mov	al, byte ptr[ecx+1]
		lea	edx, [edx + eax*4 ]

		mov	al, [edx]

		; check full height
		mov	edx, ymax
		add	edx, 255
		shr	edx, 8				; / 256 hauteur brick

		push	ebx
		mov	ebx, [YMap]

th0:		cmp	ebx, 24
		jae	notesth

		add	ecx, 2
		inc	ebx

		cmp	word ptr[ecx], 0
		jnz	hcol
		dec	edx
		jnz	th0

notesth:	pop	ebx

		ret

nocol:	;' return *(ptc+1)

		mov	al, byte ptr[ecx+1]	; eventuelle col transparente

		; check full height
		mov	edx, ymax
		add	edx, 255
		shr	edx, 8			; / 256 hauteur brick

		push	ebx
		mov	ebx, [YMap]

th1:		cmp	ebx, 24
		jae	notsth

		add	ecx, 2
		inc	ebx
		cmp	word ptr[ecx], 0
		jnz	hcol
		dec	edx
		jnz	th1

notsth:		pop	ebx

		ret

col_1:		; mov	[YMap], 0		; test y-1
hcol:		mov	al, 1
		ret

ovfw:		mov	al, 0
		ret

WorldColBrickFull	endp

;*--------------------------------------------------------------------------*

WorldColBrick 	proc	xw:DWORD, yw:DWORD, zw:DWORD

	;' ptc = BufCube
		mov	ecx, [BufCube]

	;' + (xm*SIZE_CUBE_Y*2)
		mov	eax, xw

	;' xm = (xw+DEMI_BRICK_XZ)/SIZE_BRICK_XZ

		add	eax, DEMI_BRICK_XZ	; +256
		shr	eax, 9			; /512
		mov	[XMap], eax

	;' + ym*2
		mov	eax, yw
	;' ym = yw/SIZE_BRICK_Y

		sar	eax, 8			; /256
		mov	[YMap], eax

	;' + zm*3200 (SIZE_CUBE_X*SIZE_CUBE_Y*2)

		mov	eax, zw

	;' zm = (zw+DEMI_BRICK_XZ)/SIZE_BRICK_XZ

		add	eax, DEMI_BRICK_XZ	; +256
		shr	eax, 9			; /512
		mov	[ZMap], eax



		mov	eax, [XMap]

		or	eax, eax		; bound
		jl	ovfw
		cmp	eax, 64
		jge	ovfw

		lea	eax, [eax*2]		; *2
		mov	edx, eax		; =
		lea	eax, [eax*8]		; *16
		add	edx, eax		; 2  + 16 = 18
		lea	edx, [edx+eax*2]	; 18 + 32 = 50

		add	ecx, edx

		mov	eax, [YMap]

		cmp	eax, -1
		jle	col_1

		or	eax, eax		; check bound
		jl	ovfw
		cmp	eax, 24
		jg	ovfw

		lea	ecx, [ecx+eax*2]

		mov	eax, [ZMap]

		or	eax, eax		; check bound
		jl	ovfw
		cmp	eax, 64
		jge	ovfw

		shl	eax, 7			; *128
		mov	edx, eax		; = 128
		lea	eax, [eax*8]		; *1024
		add	edx, eax		; 128  + 1024 = 1152
		lea	edx, [edx+eax*2]	; 1152 + 2048 = 3200

		add	ecx, edx

		xor	eax, eax
		mov	al, [ecx]

		or	al, al
		jz	nocol

	;'	if( *ptc != 0 )
	;'	{
	;'		block = (*ptc++) - 1 ;
	;'		adr = GetAdrBlock( block )	;
	;'		adr += HEADER_BLOCK		;
	;'		adr += (*ptc)<<2 		;/* 4 Bytes to Jump	*/
	;'		return *adr ;
	;'	}

		mov	edx, [TabBlock]			; pto = (ULONG*)TabBlock
		add	edx, [ edx + eax*4 - 4]		; TabBlock + pto[numblock]

		add	edx, HEADER_BLOCK


;	essai	mov	al, byte ptr[edx+1]		; code jeu
;		mov	[CodeJeu], al


		mov	al, byte ptr[ecx+1]
		lea	edx, [edx + eax*4 ]

		mov	al, [edx]

		ret

nocol:	;' return *(ptc+1)

		mov	al, byte ptr[ecx+1]			; eventuelle col transparente
		ret

col_1:		; mov	[YMap], 0		; test col-1
		mov	al, 1
		ret

ovfw:		mov	al, 0
		ret

WorldColBrick	endp

;*--------------------------------------------------------------------------*

WorldCodeBrick 	proc	xw:DWORD, yw:DWORD, zw:DWORD

	;' ptc = BufCube

		mov	ecx, [BufCube]

	;' + (xm*SIZE_CUBE_Y*2)

		mov	eax, xw

	;' xm = (xw+DEMI_BRICK_XZ)/SIZE_BRICK_XZ

		add	eax, DEMI_BRICK_XZ	; +256
		shr	eax, 9			; /512

		mov	[XMap], eax

		lea	eax, [eax*2]		; *2
		mov	edx, eax		; =
		lea	eax, [eax*8]		; *16
		add	edx, eax		; 2  + 16 = 18
		lea	edx, [edx+eax*2]	; 18 + 32 = 50

		add	ecx, edx

	;' + ym*2

		mov	eax, yw

		cmp	eax, -1
		jle	nocode

	;' ym = yw/SIZE_BRICK_Y

		shr	eax, 8			; /256

		mov	[YMap], eax
		lea	ecx, [ecx+eax*2]

	;' + zm*3200 (SIZE_CUBE_X*SIZE_CUBE_Y*2)

		mov	eax, zw

	;' zm = (zw+DEMI_BRICK_XZ)/SIZE_BRICK_XZ

		add	eax, DEMI_BRICK_XZ	; +256
		shr	eax, 9			; /512

		mov	[ZMap], eax

		shl	eax, 7			; *128
		mov	edx, eax		; = 128
		lea	eax, [eax*8]		; *1024
		add	edx, eax		; 128  + 1024 = 1152
		lea	edx, [edx+eax*2]	; 1152 + 2048 = 3200

		add	ecx, edx

		xor	eax, eax
		mov	al, [ecx]

		or	al, al
		jz	nocode

	;'	if( *ptc != 0 )
	;'	{
	;'		block = (*ptc++) - 1 ;
	;'		adr = GetAdrBlock( block )	;
	;'		adr += HEADER_BLOCK		;
	;'		adr += (*ptc)<<2 		;/* 4 Bytes to Jump	*/
	;'		return *adr ;
	;'	}

		mov	edx, [TabBlock]			; pto = (ULONG*)TabBlock
		add	edx, [ edx + eax*4 - 4]		; TabBlock + pto[numblock]

		add	edx, HEADER_BLOCK

		mov	al, byte ptr[edx+1]
		ret

nocode:	;' return *(ptc+1)

		mov	al, 0F0h
		ret

WorldCodeBrick	endp

;----------------------------------------------------------------------------
;----------------------------------------------------------------------------

Map2Screen		proc	,\
			xm:DWORD, ym:DWORD, zm:DWORD

			mov	eax, xm
			sub	eax, zm
			mov	edx, eax
			sal	eax, 4		;	*16
			lea	eax, [eax + edx*8 + 320-8  -23-1]; *24 + XCentre proj
			mov	XScreen, eax

			mov	eax, xm
			add	eax, zm
			mov	edx, eax
			lea	eax, [eax*8]	; *8
			lea	eax, [eax+edx*4]; *12
			mov	edx, ym
			shl	edx, 4		; *16
			sub	edx, ym		; *15
			sub	eax, edx
			add	eax, 240  -25	; YCentre proj
			mov	YScreen, eax
			ret
Map2Screen		endp
;----------------------------------------------------------------------------

DecompColonne		proc	uses esi edi ebx,\
			pts:DWORD, ptd:DWORD

			mov	esi, pts
			mov	edi, ptd
			xor	ecx, ecx
;----------------------------------------------- Get Nb Entity
			mov	bl, [esi]	; BL = NbEntity
			inc	esi
;----------------------------------------------- For Every Entity
NewEntity:		lodsb			; OpCode
			mov	cl, al          ; CL = AL
			and	cl, 00111111b	; CL = Repeat
			inc	cl		; One More ( 1 -> 64 )
			test	al, 11000000b	; Incrust ?
			je	JumpZero	; Yes, go...
			test	al, 01000000b	; Diff Brick ?
			jne	WriteDiffBrick	; Yes, go...
;----------------------------------------------- Write Same Brick
			lodsw			; Get NumBlock & PosBlock
			rep	stosw		; Fill Brick
			dec	bl		; Entity--
			jne	NewEntity	; Again
			ret			; End
;----------------------------------------------- Incrust ( Full off Nothing )
JumpZero:		xor	ax, ax          ; NumBlock & PosBlock = 0
			rep	stosw		; Fill
			dec	bl		; Entity--
			jne	NewEntity	; Again
			ret			; End
;----------------------------------------------- Write Diff Brick
WriteDiffBrick:		rep	movsw		; Copy NumBlock & PosBlock
			dec	bl		; Entity--
			jne	NewEntity	; Again
			ret			; end
DecompColonne		endp
;----------------------------------------------------------------------------
MixteColonne		proc	uses esi edi ebx,\
			pts:DWORD, ptd:DWORD

			mov	esi, pts
			mov	edi, ptd
			xor	ecx, ecx
;----------------------------------------------- Get Nb Entity
			mov	bl, [esi]	; BL = NbEntity
			inc	esi
;----------------------------------------------- For Every Entity
NewEntity:		lodsb			; OpCode
			mov	cl, al          ; CL = AL
			and	cl, 00111111b	; CL = Repeat
			inc	cl		; One More ( 1 -> 64 )
			test	al, 11000000b	; Incrust ?
			je	JumpZero	; Yes, go...
			test	al, 01000000b	; Diff Brick ?
			jne	WriteDiffBrick	; Yes, go...
;----------------------------------------------- Write Same Brick
			lodsw			; Get NumBlock & PosBlock
			rep	stosw		; Fill Brick
			dec	bl		; Entity--
			jne	NewEntity	; Again
			ret			; End
;----------------------------------------------- Incrust ( Full off Nothing )
JumpZero:		lea	edi, [edi+ecx*2]; must add ecx WORD!
			dec	bl		; Entity--
			jne	NewEntity	; Again
			ret			; End
;----------------------------------------------- Write Diff Brick
WriteDiffBrick:		rep	movsw		; Copy NumBlock & PosBlock
			dec	bl		; Entity--
			jne	NewEntity	; Again
			ret			; end
MixteColonne		endp
;----------------------------------------------------------------------------
;				The
				End




















