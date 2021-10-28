/*══════════════════════════════════════════════════════════════════════════*
		   █▀▀▀▄ █▀▀▀▀ █▀▀▀▀  █    ██▄ █ █▀▀▀▀ ██▀▀▀
		   ██  █ ██▀▀  ██▀▀   ██   ██▀██ ██▀▀  ▀▀▀▀█
		   ▀▀▀▀  ▀▀▀▀▀ ▀▀     ▀▀   ▀▀  ▀ ▀▀▀▀▀ ▀▀▀▀▀
 *══════════════════════════════════════════════════════════════════════════*/
/*──────────────────────────────────────────────────────────────────────────*/
// Cdrom Version si pas define version disk
//#define	CDROM	1

// mettre ce define pour une version travail seulement
// en cdrom pas d'importance ATTENTION à supprimer pour version disk
// #define MAGOUILLE_FLA_HD	1

/*----------------*/

// demo 3 cubes
// #define	DEMO	1

// sauvegarde ecran/acceleration/infos
//#define	DEBUG_TOOLS	1

/*----------------*/

// Brick, Gri et Bll dans .HQR
#define	BRICK_HQR	1
// samples dans .HQR
#define	SAMPLE_HQR	1
// midi music dans .HQR
#define	MIDI_HQR	1
// samples des FLAs dans .HQR
#define	SAMPLE_FLA_HQR	1

// tous fichiers dans même dir
#define	ONE_GAME_DIRECTORY	1

//path des ressources
#define	PATH_RESSOURCE		""

/*──────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────*/

#include	<stdlib.h>
#include	<string.h>
#include	<dos.h>
#include	<conio.h>
#include	<stdio.h>

#include 	"\projet\lib386\lib_sys\adeline.h"
#include 	"\projet\lib386\lib_sys\lib_sys.h"
#include 	"\projet\lib386\lib_svga\lib_svga.h"
#include 	"\projet\lib386\lib_3D\lib_3D.h"
#include 	"\projet\lib386\lib_mix\lib_mix.h"
#include 	"\projet\lib386\lib_samp\lib_wave.h"
#include 	"\projet\lib386\lib_midi\lib_midi.h"
#include 	"\projet\lib386\lib_cd\lib_cd.h"

#include 	"common.h"

/*---------------- macros ------------------*/

#ifdef	DEBUG_TOOLS

extern	ULONG	UsedHQMemory ;

#define	CHECK_MEMORY	\
	if( (Size_HQM_Memory-Size_HQM_Free) > UsedHQMemory )\
	{\
		UsedHQMemory = Size_HQM_Memory-Size_HQM_Free ;\
	}
#else

#define	CHECK_MEMORY	/* coucou */

#endif

/*---------------- CONSTANTE ------------------*/

#define	SIZE_CUBE_X	64
#define	SIZE_CUBE_Y	25
#define	SIZE_CUBE_Z	64

#define	SIZE_BRICK_XZ	512
#define	SIZE_BRICK_Y	256
#define	DEMI_BRICK_XZ	256
#define	DEMI_BRICK_Y	128

/*---------------- FENETRE ------------------*/

#define	VIEW_X0		-50
#define	VIEW_Y0		-30
#define	VIEW_X1		680
#define	VIEW_Y1		580

/*──────────────────────────────────────────────────────────────────────────*/

#define	MAX_CLOVER_BOX		10

/*──────────────────────────────────────────────────────────────────────────*/
/* type objet pour affscene */

#define	TYPE_OBJ_3D		(1024*0)
#define	TYPE_FLAG_RED		(1024*1)
#define	TYPE_FLAG_YELLOW	(1024*2)
#define	TYPE_SHADOW		(1024*3)
#define	TYPE_OBJ_SPRITE		(1024*4)
#define	TYPE_ZONE_DEC		(1024*5)
#define	TYPE_EXTRA		(1024*6)

/*──────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────*/

#define	FILE_3D_NORMAL		0
#define	FILE_3D_SPORTIF		1
#define	FILE_3D_AGRESSIF	2
#define	FILE_3D_DISCRET		3
#define	FILE_3D_PROTOPACK	4

#define	NO_BODY			255

#define	GEN_BODY_NORMAL		0
#define	GEN_BODY_TUNIQUE	1
#define	GEN_BODY_SABRE		2

#define	NO_ANIM			255

#define	GEN_ANIM_RIEN		0
#define	GEN_ANIM_MARCHE		1
#define	GEN_ANIM_RECULE		2
#define	GEN_ANIM_GAUCHE		3
#define	GEN_ANIM_DROITE		4
#define	GEN_ANIM_ENCAISSE	5
#define	GEN_ANIM_CHOC		6
#define	GEN_ANIM_TOMBE		7
#define	GEN_ANIM_RECEPTION	8
#define	GEN_ANIM_RECEPTION_2	9
#define	GEN_ANIM_MORT		10
#define	GEN_ANIM_ACTION		11
#define	GEN_ANIM_MONTE		12
#define	GEN_ANIM_ECHELLE	13
#define	GEN_ANIM_SAUTE		14
#define	GEN_ANIM_LANCE		15
#define	GEN_ANIM_CACHE		16
#define	GEN_ANIM_COUP_1		17
#define	GEN_ANIM_COUP_2		18
#define	GEN_ANIM_COUP_3		19
#define	GEN_ANIM_TROUVE		20
#define	GEN_ANIM_NOYADE		21
#define	GEN_ANIM_CHOC2		22
#define	GEN_ANIM_SABRE		23
#define	GEN_ANIM_DEGAINE	24

/*──────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────*/
typedef	struct
{
	UBYTE	GenBody ;		// 0 à 254 mais je veux -1
	UBYTE	GenAnim ;
	UBYTE	NextGenAnim ;

	UBYTE	Col ;			/* brick en collision (inutile?) */

	UBYTE	*PtrAnimAction ;

	WORD	Sprite ;

	WORD	OffsetLabelTrack ;

// divers

	UBYTE	*PtrFile3D ;

// constantes

	WORD	OptionFlags ;		/* flag d'init 2 */
/* B*/	WORD	NbBonus ;		/* nb bonus to give */
/* B*/	WORD	Armure ;		/* resistance */
	WORD	CoulObj ;		/* couleur dominante de l'objet */

/* game infos */

	WORD	Body ; 			/* num body ou sprite dans la base */

	WORD	PosObjX ;		/* pos world en cours */
	WORD	PosObjY ;
	WORD	PosObjZ ;

	WORD	OldPosX ;		/* old pos world */
	WORD	OldPosY ;
	WORD	OldPosZ ;

	WORD	Xmin ;			/* ZV */
	WORD	Xmax ;
	WORD	Ymin ;
	WORD	Ymax ;
	WORD	Zmin ;
	WORD	Zmax ;

	WORD	Beta ;			/* angle en cours */

	WORD	SRot ;			/* vitesse de rotation */

	T_REAL_VALUE	RealAngle ;	/* valeur real time de rotation */
/* B*/	WORD		Move ;		/* type de deplacement */

	UBYTE		*PtrTrack ;	/* ptr track prog */
	WORD		OffsetTrack ;	/* offset dans la track */

	UBYTE		*PtrLife ;
	WORD		OffsetLife ;	/* offset dans la vie */

	WORD		Info ;		/* infos pour DoDir */
	WORD		Info1 ;
	WORD		Info2 ;
	WORD		Info3 ;

/* B*/	WORD	ObjCol ;		/* num obj en collision */
/* B*/	WORD	CarryBy ;

	WORD	ZoneSce ;		/* zone declenchement scenarique */
/* B*/	WORD	LabelTrack ;		/* dernier label de track */
/* B*/	WORD	MemoLabelTrack ;	/* memo dernier label de track */

	WORD	Flags ;			/* flags divers permanent */
	WORD	WorkFlags ;		/* flags de gestion */

/* B*/	WORD	HitBy ;			/* frappe par */

/* B*/	WORD	HitForce ;		/* si !=0 force de frappe anim */

/* B*/	WORD	LifePoint ;		/* point de vie en cours */

/* B*/	WORD	AnimStepBeta ;		/* step de rotation par anim */
	WORD	AnimStepX ;		/* step de dep par anim */
	WORD	AnimStepY ;
	WORD	AnimStepZ ;

	WORD	DoorWidth ;		// pour les DOOR peut reservir

	WORD	Anim ;			/* anim en cours */
/* B*/	WORD	Frame ;			/* frame en cours */
/* B*/	WORD	FlagAnim ;		/* type d'anim en cours (dans flags?) */

	UBYTE	CodeJeu ;		// brick spéciale sample ou action

}	T_OBJET ;

/*
typedef	struct
{
	UBYTE	Bit ;		}	T_FLAG ;
*/

typedef	struct
{
	WORD	X ;
	WORD	Y ;
	WORD	Z ;		}	T_TRACK ;

