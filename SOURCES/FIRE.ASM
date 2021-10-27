; ------------------------------ FIRE.ASM ------------------------------


		.386p

		.model SMALL, SYSCALL

		.data

		include	\projet\lib386\lib_svga\svga.ash
		include	\projet\lib386\lib_sys\lib_sys.ash

		public	NoLanguage      Imagen

		extrn	NoLanguage	BufSpeak:DWORD

;Imagen  DB 320*50 DUP (0)
;Imagen2 DB 320*50 DUP (0)

Imagen		dd	0000
Imagen2		dd	0000

loopy	dw	00

		.code

		public	NoLanguage	DoFire
		public	NoLanguage	ComputeFire

ComputeFire	proc	uses esi edi ebx edx

		mov	eax, [BufSpeak]
		mov	[Imagen], eax
		add	eax, 320*50
		mov	[Imagen2], eax

		mov	esi, [Imagen]
		add	esi, 321
		mov	edi, [Imagen2]
		add	edi, 321

;		mov	esi, 321 + offset Imagen
;		mov	edi, 321 + offset Imagen2

		MOV     CX,48*320-2

		XOR     BH,BH
@@lp:
		XOR     AX,AX
		ADD     AL,-1[eSI]
		ADC     AH,BH
		ADD     AL,-320[eSI]
		ADC     AH,BH
		ADD     AL,-319[eSI]
		ADC     AH,BH
		ADD     AL,-321[eSI]
		ADC     AH,BH
		ADD     AL,1[eSI]
		ADC     AH,BH
		ADD     AL,320[eSI]
		ADC     AH,BH
		ADD     AL,319[eSI]
		ADC     AH,BH
		ADD     AL,321[eSI]
		ADC     AH,BH
		ROR     AX,3

		TEST    AH,65h                  ; Wanna know why 60h? Me too.
		JNZ     @@nx                    ; This is pure experience.
						; ok but it's better with 65

		mov	edx, [Imagen2]
		add	edx, 46*320

		CMP    edi, edx

;		cmp edi, 46*320 + offset Imagen2
		JNC    @@dec

		OR    AL,AL                   ; My dog coded here too.
		JZ    @@nx                    ; I helped my sister with this one.
@@dec:
		DEC  AL                      ; Yeah! Cool a bit, please.
@@nx:
		inc     esi
		mov	byte ptr[edi], al

		inc	edi

		dec	cx
		jnz	@@lp                    ; New image stored in Imagen2.

		mov	esi, [Imagen2]
		add	esi, 320
		MOV     edi, [Imagen]

;		mov	esi, 320 + offset Imagen2
;		mov	edi, offset Imagen

		MOV     ecx, 160*48/2
		rep	movsd

		mov	esi, [Imagen2]
		add	esi, 320*39

;		mov	esi, offset Imagen2 + 320*39

		mov	ecx, 5*320
		mov	ah, 11
@@rcl:
		mov	al,[esi]
		cmp	al, 15
		jnc	@@rcn
		SUB   AL,AH
		NEG   AL
		MOV   [eSI],AL
@@rcn:
		INC    eSI
		dec	cx
		jnz	@@rcl

		ret

ComputeFire	endp


DoFire		proc uses esi edi ebx ebp ,\
		lig:dword, coul:dword

		call	ComputeFire

		mov	esi, [Imagen]
		add	esi, 5*320

;		mov	esi, offset Imagen + 5 * 320

		mov	edi, Log

		mov	eax, lig
		add	edi, [TabOffLine + eax*4]

		mov	ebx, Coul
		mov	bh, bl
		add	bh, 15

		mov	dx, 25

copy0:		mov	cx, 320

copy:		mov	al, [esi]
		shr	al, 1
		add	al, bl
		cmp	al, bh
		ja	adcoul
adcrt:		mov	ah, al
		mov	[edi], ax
		mov	[edi+640], ax
		inc	esi
		inc	edi
		inc	edi

		dec	cx
		jnz	copy

		add	edi, 640

		dec	dx
		jnz	copy0

		ret

adcoul:		mov	al, bh
		jmp	adcrt

DoFire		endp

	END
