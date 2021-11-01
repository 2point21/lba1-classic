# Little Big Adventure Content Description

## Main Sources
Gameplay Source Files

* ADFLI_A - FLA movies chunk routines
* AMBIANCE - Surroundings (Palette fades, scene sample)
* BALANCE - Rule of Three
* BUBSORT - Bubble Sort Algorithm
* CPYMASK - Screen Clip Regions
* DISKFUNC - Load Scenes
* EXTRA - Bonus objects
* FICHE - Animation Actions
* FIRE - Main Menu Fire/Plasma Effect
* FLIPBOX - Screen Clip Regions
* FUNC - Helper functions
* GAMEMENU - Main Menu
* GERELIFE - Life Script (scripting routines)
* GERETRAK - Move Script (scripting routines)
* GLOBAL - Global Constants and Variables
* GRAPH_A - Draw Sprites
* GRILLE - Isometric scenes
* GRILLE_A - Isometric scenes optimisations
* HOLOMAP - Holomap routines
* INCRUST - Overlay objects on screen (eg. used holomap, grabbed keys, ...)
* MALLOC - Memory Allocation
* MASK_A - Screen Clip Regions
* MCGA - Screen routines
* MESSAGE - Text and Voice routines
* MIXER - Audio Samples
* OBJECT - Actor routines (colisions, animations)
* PERSO -  Main Game Loop
* PLAYFLA - FLA movie player
* VERSION - Game version macros

## Libraries

### LIB_3D
Software Rendering Library

* P_ANIM - 3D Models Animations
* P_FUNC - 3D Helper Functions
* P_OB_ISO - Rendering 3D Static Models (e.g. holomap)
* P_OBJ_3D - Rendering 3D Models
* P_OBJET - Other Rendering (for example text dialog polygon arrow)
* P_SINTAB - Sine Table
* P_TRIGO - Trigonometry Helper Functions

### LIB_CD
CD-ROM Auxiliar Library

* CDROM - CD-ROM Helper Functions

### LIB_MENU
User Interface Library

* MENU - Main User Interface Routines
* MENUFUNC - User Interface Components
* SELECTOR - File System related routines

### LIB_MIDI
Musical Instrument Digital Interface Library (XMIDI)

* MIDI - Play Midi Music Routines

### LIB_MIX
Audio Mixer Library

* MIXER_A - Audio Mixer - Interops with the various Sound Drivers

### LIB_SAMP
Audio Sampler Library

* BALANCE - Rule of Three
* DMA_CODE - Direct Memory Access Controller
* GUS - Advanced Gravis Ultra Sound Setup
* WAVE_A - Interop with various Sound Drivers
* WAVE - Init Sound Drivers

### LIB_SVGA
Graphics Library

* CPYMASK - Screen Clip Regions
* DLL - Graphics Drivers Interop
* DLL_I - Graphics Initialisation
* FONT_A - Display Font Routines
* GIF - Load GIF (Graphics Interchange Format)
* GRAPH_A - Draw Sprites
* INITMODE - Init different Graphic Cards
* INITSVGA - Super Video Graphics Array Initialisation
* LBM - Load Interchange File Format (IFF)
* MASK_A - Screen Clip Regions
* PCX - Load PCX (Picture Exchange) files
* RECT - Create a Retangle
* SAVEPCX - Save PCX (Picture Exchange) files
* S_BLOCK - Blit to Screen
* S_BOX - Draw Rectangule (menu items, dialogues)
* S_DLL - Load Drivers
* S_FILLV - Rendering Routines
* S_FIND - Detect Graphic Devices
* S_LINE - Draw Lines
* S_MODE - Set Graphics Mode
* S_MOUSE - Mouse Input
* S_PAL - Palette Routines
* S_PHYS - Graphics Helpers
* S_POLY - Polygons Software Rendering
* S_SCREEN - Clear Screen
* S_STRING - Draw Text
* S_TEXT - Convert string to different types
* TEXTURE - Render Textured Polygons (Holomap)
* VESA - Graphics Helpers
* ZOOM - Screen Scale

### LIB_SYS

Game System Library

* ADELINE - Base System Initialisation
* BUFFER_A - Memory routines
* DLLLOAD - 32-bit DLL Driver Loader 
* EXPAND - LZSS Decryption
* FILES - File System Routines
* FILES_A - Touch file
* HQ_RESS - Load High Quality Resources (HQR Asset files)
* HQ_MEM - HQR Memory Allocation Routines
* HQR - Assembly optimisations to check if resource index exist
* KEYBOARD - Keyboard Input System
* LOADMALL - Load file with special memory allocation routines
* LOADSAVE - Load and Save files
* MALLOC - Memory Allocation Routines
* TIMER_A - System Timer
