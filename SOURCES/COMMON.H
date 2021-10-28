/*---------------- RESSOURCE (RESS_HQR) ------------------*/

#define	RESS_PAL		0
#define	RESS_FONT_GPM		1
#define	RESS_EMPTY			2
#define	RESS_GOODIES_GPC	3
#define	RESS_SHADOW_GPH		4

#define	RESS_HOLOMAP_PAL	5
#define	RESS_HOLOMAP_HMT	6
#define	RESS_HOLOMAP_HMG	7
#define	RESS_HOLOMAP_POS	8
#define	RESS_HOLO_TWINKEL	9
#define	RESS_HOLO_FLECHE	10
#define	RESS_HOLO_BODYFLECHE	11

#define	RESS_BUMPER_PCR		12
#define	RESS_BUMPER_PAL		13
#define	RESS_MENU_PCR		14

#define	RESS_TWINSUN_PCR	15
#define	RESS_TWINSUN_PAL	16
#define	RESS_INTRO_2_PCR	17
#define	RESS_INTRO_2_PAL	18
#define	RESS_INTRO_3_PCR	19
#define	RESS_INTRO_3_PAL	20

#define	RESS_GAME_OVER		21
#define	RESS_PAL_ALARM		22
#define	RESS_FLA_PCX		23
#define	RESS_PAL_MUSEE		24

#define	RESS_SENDELL_PCR	25
#define	RESS_SENDELL_PAL	26
#define	RESS_LOGO_PCR		27
#define	RESS_LOGO_PAL		28

#define	RESS_HOLO_CONE		29
#define RESS_HOLOMAP_TRAJ	30

#define	RESS_HOLO_VEHICULE	31
// vehicule de 31 à 48

#define	RESS_BUMPER2_PCR	49
#define	RESS_BUMPER2_PAL	50

#define	RESS_INIT_PLASMA	51

#define	RESS_BUMPER_EA_PCR	52
#define	RESS_BUMPER_EA_PAL	53

/*----------------- CUBE ----------------------*/


#define	SIZE_CUBE_X	64
#define	SIZE_CUBE_Y	25
#define	SIZE_CUBE_Z	64

#define	SIZE_BRICK_XZ	512
#define	SIZE_BRICK_Y	256
#define	DEMI_BRICK_XZ	256
#define	DEMI_BRICK_Y	128

#define	VIEW_X0		-50
#define	VIEW_Y0		-30
#define	VIEW_X1		680
#define	VIEW_Y1		580

/*---------------- FLAG_GAME ------------------*/

#define	FLAG_HOLOMAP		0
#define	FLAG_BALLE_MAGIQUE	1
#define	FLAG_SABRE_MAGIQUE	2
#define	FLAG_TROMPE		3
#define	FLAG_TUNIQUE		4
#define	FLAG_LIVRE_BU		5
#define	FLAG_MEDAILLON		6
#define	FLAG_FLACON_EAU_CLAIRE	7

#define	FLAG_MECA_PINGOUIN	14

#define	FLAG_CARBURANT		15
#define	FLAG_CLOVER		27

#define	FLAG_CONSIGNE		70

/*---------------- SAMPLES ------------------*/

#define	MAX_SAMPLES	300

/*---------------- OBJECTS ------------------*/

#define	MAX_OBJETS		100

#define	MAX_EXTRAS		50

#define	SIZE_NAME		19

#define	MAX_ANIMS		400
#define	MAX_BODYS		200

#define	MAX_FLAGS		255

#define	MAX_ZONES		255
/*#define	MAX_CODES		255	*/
#define	MAX_TRACKS		255

#define	MAX_FLAGS_CUBE		80
#define	MAX_FLAGS_GAME		255

#define	MAX_INVENTORY		28

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


/* work flags */

#define	WAIT_HIT_FRAME		1
#define	OK_HIT			2
#define	ANIM_END		4
#define	NEW_FRAME		8

#define	WAS_DRAWN		16

#define	OBJ_DEAD		32
#define	AUTO_STOP_DOOR		64

#define	ANIM_MASTER_ROT		128

#define	FALLING			256

/* Flags */

#define	CHECK_OBJ_COL		1	// test des collisions et hit obj
#define	CHECK_BRICK_COL		2	// test des collisions decors
#define	CHECK_ZONE		4	// test des zones scenariques
#define	SPRITE_CLIP		8	// (portes) zone de clip fixe
#define	PUSHABLE		16	// poussable
#define	COL_BASSE		32	// 1 = pas test des collisions hautes TWINSEN

#define	CHECK_CODE_JEU		64	// test la noyade

#define	INVISIBLE		512	// not drawn but all computed

#define	SPRITE_3D		1024	// un sprite pas un 3DO

#define	OBJ_FALLABLE		2048	// peut tomber
#define	NO_SHADOW		4096	// pas d'ombre auto
#define	OBJ_BACKGROUND		8192	// s'incruste dans le decor la 1er fois

#define	OBJ_CARRIER		16384	// peut porter et deplacer un obj

#define	MINI_ZV			32768	// zv carre sur plus petit cote (si 3DO)

/* Option Flags */

#define	EXTRA_MASK	(16+32+64+128+256)

#define	EXTRA_GIVE_NOTHING	1

#define	EXTRA_GIVE_MONEY	16
#define	EXTRA_GIVE_LIFE		32
#define	EXTRA_GIVE_MAGIC	64
#define	EXTRA_GIVE_KEY		128
#define	EXTRA_GIVE_CLOVER	256

/* FlagAnim */

#define	ANIM_REPEAT	0
#define	ANIM_THEN	1
#define	ANIM_ALL_THEN	2
#define	ANIM_INSERT	3
#define	ANIM_SET	4

/*──────────────────────────────────────────────────────────────────────────*/
/*──────────────────────────────────────────────────────────────────────────*/


#define	EXTRA_TIME_OUT		1
#define	EXTRA_FLY		2
#define	EXTRA_END_OBJ		4
#define	EXTRA_END_COL		8
#define	EXTRA_STOP_COL		16
#define	EXTRA_TAKABLE		32
#define	EXTRA_FLASH		64
#define	EXTRA_SEARCH_OBJ	128
#define	EXTRA_IMPACT		256
#define	EXTRA_SEARCH_KEY	512
#define	EXTRA_TIME_IN		1024
#define	EXTRA_ONE_FRAME		2048
#define	EXTRA_EXPLO		4096
#define	EXTRA_WAIT_NO_COL	8192
#define	EXTRA_WAIT_SOME_TIME	16384


typedef	struct
{
	WORD	Sprite ;		/* num sprite */

	WORD	PosX ;
	WORD 	PosY ;
	WORD	PosZ ;

	WORD	OrgX ;
	WORD 	OrgY ;
	WORD	OrgZ ;

	WORD	Vx ;
	WORD 	Vy ;
	WORD	Vz ;

	WORD	Flags ;

	WORD	Poids ;

	ULONG	Timer ;			/* memo timer 50hz */

	WORD	TimeOut ;		/* life time */

	WORD	HitForce ;		/* si !=0 force de frappe */

	WORD	Divers ;		/* nombre pour zone giver */

}	T_EXTRA ;

/*──────────────────────────────────────────────────────────────────────────*/

typedef	struct
{
	WORD	X0 ;
	WORD	Y0 ;
	WORD	Z0 ;
	WORD	X1 ;
	WORD	Y1 ;
	WORD	Z1 ;
	WORD	Type ;
	WORD	Num ;
	WORD	Info0 ;
	WORD	Info1 ;
	WORD	Info2 ;
	WORD	Info3 ;			}	T_ZONE ;

typedef struct
{
	WORD	Z ;
	WORD	NumObj ;

	WORD	Xw ;
	WORD	Yw ;

	WORD	Zw ;
	WORD	Num ;


/*	WORD	Xmin ;
	WORD	Ymin ;
	WORD	Zmin ;
	WORD	Xmax ;
	WORD	Ymax ;
	WORD	Zmax ;	*/

				}	T_SORT ;

/*---------------- holomap -----------------*/

/*
#define	MAX_HOLO_OBJ	50

typedef	struct	{	WORD	Alpha ;
			WORD	Beta ;
			WORD	Size ;

			WORD	Obj ;
			WORD	Flag ;
			WORD	Info ;	} T_HOLO_OBJ ;
*/
#define	MAX_HOLO_POS	150

typedef	struct	{	WORD	Alpha ;
			WORD	Beta ;
			WORD	Size ;

//			WORD	XIsland ;
//			WORD	ZIsland ;

//			UBYTE	Type ;

			WORD	Mess ;
//			WORD	Fleche ;
						} T_HOLO_POS ;

/*---------------- incrust display ---------*/

#define	MAX_INCRUST_DISP	10

#define	INCRUST_SPRITE		0
#define	INCRUST_NUM		1
#define	INCRUST_CMPT		2
#define	INCRUST_OBJ		3
#define	INCRUST_TEXT		4

typedef struct	{	WORD	Num ;
			WORD	X ;
			WORD	Y ;
			WORD	Type ;
			WORD	Info ;
			WORD	Move ;
			ULONG	TimerEnd ;	}	T_INCRUST_DISP ;

/*---------------- divers ------------------*/

#define	START_FILE_ISLAND	3

#define	Rnd(n)	(rand()%n)

#define	NUM_PERSO	0

#define	C_NORMAL	0
#define	C_SPORTIF	1
#define	C_AGRESSIF	2
#define	C_DISCRET	3
#define C_PROTOPACK	4

#define	ACTIVE_LIFE	0
#define	ACTIVE_TRACK	1

#define	MAX_TYPES_ZONE	7

#define	POS_MIDDLE	1
#define	POS_LEFT	2
#define	POS_RIGHT	4
#define	POS_UP		8
#define	POS_DOWN	16

/*---------------- Script: defines ------------------*/

#define	NO_MOVE			0
#define	MOVE_MANUAL		1
#define	MOVE_FOLLOW		2
#define	MOVE_TRACK		3
#define	MOVE_FOLLOW_2		4
#define	MOVE_TRACK_ATTACK	5
#define	MOVE_SAME_XZ		6
#define	MOVE_RANDOM		7

#define	NB_MOVES	8


/*---------------- Track: macros ------------------*/

#define	TM_END			0
#define	TM_NOP			1
#define	TM_BODY			2
#define	TM_ANIM			3
#define	TM_GOTO_POINT		4
#define	TM_WAIT_ANIM		5
#define	TM_LOOP			6
#define TM_ANGLE		7
#define	TM_POS_POINT		8
#define	TM_LABEL		9
#define	TM_GOTO			10
#define	TM_STOP			11
#define	TM_GOTO_SYM_POINT	12
#define	TM_WAIT_NB_ANIM		13
#define	TM_SAMPLE		14
#define	TM_GOTO_POINT_3D	15
#define	TM_SPEED		16
#define	TM_BACKGROUND		17
#define	TM_WAIT_NB_SECOND	18
#define	TM_NO_BODY		19
#define	TM_BETA			20
#define	TM_OPEN_LEFT		21
#define	TM_OPEN_RIGHT		22
#define	TM_OPEN_UP		23
#define	TM_OPEN_DOWN		24
#define	TM_CLOSE		25
#define	TM_WAIT_DOOR		26
#define	TM_SAMPLE_RND		27
#define	TM_SAMPLE_ALWAYS	28
#define	TM_SAMPLE_STOP		29
#define	TM_PLAY_FLA		30
#define	TM_REPEAT_SAMPLE	31
#define	TM_SIMPLE_SAMPLE	32
#define	TM_FACE_TWINKEL		33
#define	TM_ANGLE_RND		34

#define	NB_MACROS_TRACK		35

/*---------------- Life: macro ------------------*/

/*---*/
#define	LM_END			0
#define	LM_NOP			1
#define	LM_SNIF			2
#define	LM_OFFSET		3
#define	LM_NEVERIF		4

#define	LM_LABEL		10
#define	LM_RETURN		11
#define	LM_IF			12
#define	LM_SWIF			13
#define	LM_ONEIF		14
#define	LM_ELSE			15
#define	LM_ENDIF		16
#define	LM_BODY			17
#define	LM_BODY_OBJ		18
#define	LM_ANIM			19
#define	LM_ANIM_OBJ		20
#define	LM_SET_LIFE		21
#define	LM_SET_LIFE_OBJ		22
#define	LM_SET_TRACK		23
#define	LM_SET_TRACK_OBJ	24
#define	LM_MESSAGE		25
#define	LM_FALLABLE		26
#define	LM_SET_DIR		27
#define	LM_SET_DIR_OBJ		28
#define	LM_CAM_FOLLOW		29
#define	LM_COMPORTEMENT_HERO	30
#define	LM_SET_FLAG_CUBE	31
#define	LM_COMPORTEMENT		32
#define	LM_SET_COMPORTEMENT	33
#define LM_SET_COMPORTEMENT_OBJ	34
#define	LM_END_COMPORTEMENT	35
#define	LM_SET_FLAG_GAME	36
#define	LM_KILL_OBJ		37
#define	LM_SUICIDE		38
#define	LM_USE_ONE_LITTLE_KEY	39
#define	LM_GIVE_GOLD_PIECES	40
#define	LM_END_LIFE		41
#define	LM_STOP_L_TRACK		42
#define	LM_RESTORE_L_TRACK	43
#define	LM_MESSAGE_OBJ		44
#define	LM_INC_CHAPTER		45
#define	LM_FOUND_OBJECT		46
#define	LM_SET_DOOR_LEFT	47
#define	LM_SET_DOOR_RIGHT	48
#define	LM_SET_DOOR_UP		49
#define	LM_SET_DOOR_DOWN	50
#define	LM_GIVE_BONUS		51
#define	LM_CHANGE_CUBE		52
#define	LM_OBJ_COL		53
#define	LM_BRICK_COL		54
#define	LM_OR_IF		55
#define	LM_INVISIBLE		56
#define	LM_ZOOM			57
#define	LM_POS_POINT		58
#define	LM_SET_MAGIC_LEVEL	59
#define	LM_SUB_MAGIC_POINT	60
#define	LM_SET_LIFE_POINT_OBJ	61
#define	LM_SUB_LIFE_POINT_OBJ	62
#define	LM_HIT_OBJ		63
#define	LM_PLAY_FLA		64
#define	LM_PLAY_MIDI		65
#define	LM_INC_CLOVER_BOX	66
#define	LM_SET_USED_INVENTORY	67
#define	LM_ADD_CHOICE		68
#define	LM_ASK_CHOICE		69
#define	LM_BIG_MESSAGE		70
#define	LM_INIT_PINGOUIN	71
#define	LM_SET_HOLO_POS		72
#define	LM_CLR_HOLO_POS		73
#define	LM_ADD_FUEL		74
#define	LM_SUB_FUEL		75
#define	LM_SET_GRM		76
#define	LM_SAY_MESSAGE		77
#define	LM_SAY_MESSAGE_OBJ	78
#define	LM_FULL_POINT		79
#define	LM_BETA			80
#define	LM_GRM_OFF		81
#define LM_FADE_PAL_RED		82
#define	LM_FADE_ALARM_RED	83
#define	LM_FADE_ALARM_PAL	84
#define	LM_FADE_RED_PAL		85
#define	LM_FADE_RED_ALARM	86
#define	LM_FADE_PAL_ALARM	87
#define	LM_EXPLODE_OBJ		88
#define	LM_BULLE_ON		89
#define	LM_BULLE_OFF		90
#define	LM_ASK_CHOICE_OBJ	91
#define LM_SET_DARK_PAL		92
#define LM_SET_NORMAL_PAL	93
#define	LM_MESSAGE_SENDELL	94
#define	LM_ANIM_SET		95
#define	LM_HOLOMAP_TRAJ		96
#define	LM_GAME_OVER		97
#define	LM_THE_END		98
#define	LM_MIDI_OFF		99
#define	LM_PLAY_CD_TRACK	100
#define	LM_PROJ_ISO		101
#define	LM_PROJ_3D		102
#define	LM_TEXT			103
#define	LM_CLEAR_TEXT		104
#define	LM_BRUTAL_EXIT		105

#define	NB_MACROS_LIFE		106

/*---*/
#define	LF_COL			0
#define	LF_COL_OBJ		1
#define	LF_DISTANCE		2
#define	LF_ZONE			3
#define	LF_ZONE_OBJ		4
#define	LF_BODY			5
#define	LF_BODY_OBJ		6
#define	LF_ANIM			7
#define	LF_ANIM_OBJ		8
#define	LF_L_TRACK		9
#define	LF_L_TRACK_OBJ		10
#define	LF_FLAG_CUBE		11
#define	LF_CONE_VIEW		12
#define	LF_HIT_BY		13
#define	LF_ACTION		14
#define	LF_FLAG_GAME		15
#define	LF_LIFE_POINT		16
#define	LF_LIFE_POINT_OBJ	17
#define	LF_NB_LITTLE_KEYS	18
#define	LF_NB_GOLD_PIECES	19
#define	LF_COMPORTEMENT_HERO	20
#define	LF_CHAPTER		21
#define	LF_DISTANCE_3D		22
#define	LF_MAGIC_LEVEL		23
#define	LF_MAGIC_POINT		24
#define	LF_USE_INVENTORY	25
#define	LF_CHOICE		26
#define	LF_FUEL			27
#define	LF_CARRY_BY		28
#define	LF_CDROM		29

#define	NB_FUNCS_LIFE		30

/*---*/
#define	LT_EQUAL		0
#define	LT_SUP			1
#define	LT_LESS			2
#define	LT_SUP_EQUAL		3
#define	LT_LESS_EQUAL		4
#define	LT_DIFFERENT		5

#define	NB_TESTS_LIFE		6

/*---------------- The End: error ------------------*/

#define	ERROR_FILE_NOT_FOUND	0
#define	NOT_ENOUGH_MEM		1
#define	PROGRAM_OK		2
#define	NAME_NOT_FOUND		3
