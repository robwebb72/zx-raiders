#define __ZXB_DISABLE_BOLD
#define __ZXB_DISABLE_ITALIC
#define __ZXB_DISABLE_SCROLL

'= DEFINES ====================================================================
#include "global_defines.bas"

'= DATA =======================================================================
#include "data/units.bas"
#include "data/weapons.bas"
#include "data/map.bas"

'= GRAPHICS ===================================================================
#include "udgs/raiders.udg.bas"
POKE (uinteger 23675, @raiders)

'= FUNCTIONS ==================================================================
#include "functions/timing.bas"
#include "functions/inputs.bas"
#include "functions/random.bas"

'= MODULES ====================================================================
#include "game.bas"

'= MAIN =======================================================================

DO
    StartScreen()
    Randomize
    RunGame()
    WaitForKeyRelease()
LOOP


SUB StartScreen()
    DIM key AS STRING
    
    BORDER 1: PAPER 0: INK 4 : CLS
    WaitForKeyRelease()

    PRINT AT 10,10;"MARS RAIDERS"; AT 11,10;"by Rob Webb"
    PRINT AT 10,1; INK 5;"\A\B\C"
    PRINT AT 10,28; INK 2;"\F\E\D"
    DO
        IF BlinkerState()=1 THEN 
            PRINT AT 14,5;"Press any key to start"
        ELSE 
            PRINT AT 14,5;"                      "
        ENDIF
        key = INKEY
    LOOP WHILE key = ""
    WaitForKeyRelease()
    BEEP 0.1,1
END SUB