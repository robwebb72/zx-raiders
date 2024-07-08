#define __ZXB_DISABLE_BOLD
#define __ZXB_DISABLE_ITALIC
#define __ZXB_DISABLE_SCROLL

'= DEFINES ====================================================================
#include "global_defines.bas"

'= DATA =======================================================================
#include "data/units.bas"
#include "data/weapons.bas"
#include "data/map.bas"

'= GLOBALS ====================================================================
DIM winner AS UBYTE
DIM turnCounter AS UBYTE
DIM player AS UBYTE

'= GRAPHICS ===================================================================
#include "udgs/raiders.udg.bas"
POKE (uinteger 23675, @raiders)

'= FUNCTIONS ==================================================================
#include "functions/infopane.bas"
#include "functions/infobar.bas"
#include "functions/draw_unit.bas"
#include "functions/blinker.bas"
#include "functions/inputs.bas"
#include "functions/random.bas"

'= MODULES ====================================================================
#include "menu.bas"
#include "game_initialise.bas"

DECLARE FUNCTION GetNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE
DECLARE FUNCTION FindNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE

DO
    Menu()
    InitialiseGame()
    RunGame()
    WaitForKeyRelease()
    PAUSE 200
    PAUSE 0
LOOP


SUB RunGame()
    DO
        player = 3 - player
        IF player = 1 THEN turnCounter = turnCounter + 1
        TakeTurn()
    LOOP WHILE winner=0
END SUB


SUB TakeTurn()
    DIM currentUnit AS UBYTE
    DIM turnEnded AS UBYTE = 0
    DIM key AS String
    
    currentUnit = (8 * player) - 1
    currentUnit = GetNextUnit(player, currentUnit)
    PrintInfoBar(MOVE_MODE)
    ResetUnitAps()
    WaitForKeyRelease()
    DO
        key = inkey
        IF key="0" then turnEnded = 1        
        
    LOOP WHILE turnEnded = 0
END SUB


FUNCTION GetNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE
    DrawUnit(currentUnit, DRAW_NORMAL)
    currentUnit = FindNextUnit(player, currentUnit)
    PrintUnitInfo(currentUnit)    
    RETURN currentUnit
END FUNCTION

FUNCTION FindNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE
    DIM counter AS UBYTE = currentUnit
    DIM found as UBYTE = 0
    
    DO
        counter = counter + 1
        IF player=1 AND counter>7 THEN counter = 0
        IF player=2 AND counter>15 THEN counter = 8
        IF counter = currentUnit THEN
            found = 1
         ELSEIF unitStat(counter, UN_STATUS) = ALIVE
            found = 1
         ENDIF
    LOOP WHILE found=0
    
    RETURN counter
END FUNCTION






SUB ResetUnitAps()
    DIM i AS UBYTE
    DIM j AS UBYTE
    i = 0
    IF player = 2 then i=8
    FOR j = i TO i+7
        unitStat(j, UN_AP) = unitStat(j, UN_TOTAL_AP)
    NEXT j
END SUB



