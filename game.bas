'= GAME GLOBALS ===============================================================
#DEFINE WINNER_RAIDERS 2
#DEFINE WINNER_NONE 0 
#DEFINE WINNER_MARSEC 1
#DEFINE WINNER_DRAW 3

DIM winner AS UBYTE
DIM turnCounter AS UBYTE
DIM player AS UBYTE
DIM currentUnit as UBYTE

'= MODULES ====================================================================
#include "common/infopane.bas"
#include "common/infobar.bas"
#include "common/draw_unit.bas"
#include "game_initialise.bas"
#include "unit_select.bas"
#include "unit_move.bas"
#include "fire-mode/fire_mode.bas"
#include "find_winner.bas"


SUB PrintVictoryScreen()

    INK 4: PAPER 0: CLS
    IF winner = WINNER_RAIDERS THEN PRINT AT 10,10;FLASH 1;"RAIDERS WIN!"
    IF winner = WINNER_MARSEC THEN PRINT AT 10,10;FLASH 1;"MARSEC WIN!"
    IF winner = WINNER_DRAW THEN PRINT AT 10,8;"There are no winners"
    Wait(50)
    PRINT AT 14,3;"Press any key to continue"
    WaitForKeyPress()
END SUB


SUB RunGame()

    InitialiseGame()

    DO
        player = 1 - player
        IF player = 0 THEN turnCounter = turnCounter + 1
        ResetUnitAps()
        InfoPaneStartTurn()        
        TakeTurn()
    LOOP WHILE winner=WINNER_NONE
    
    PrintVictoryScreen()
END SUB


SUB TakeTurn()
    DIM moveDirection AS UBYTE
    DIM turnEnded AS UBYTE = FALSE
    DIM key AS String
    DIM blinker AS UBYTE

    currentUnit = GetFirstValidUnit()
    PrintInfoBar(MOVE_MODE)
    PrintUnitInfo()

    DO
        WaitForKeyRelease()
        DO
            DrawUnit(currentUnit, DRAW_CURRENT_UNIT)
            key = INKEY
        LOOP WHILE key=""

        moveDirection = CheckKeyForMovement(Code(key(0)))

        IF moveDirection<>DIR_NONE THEN
            MoveUnit(moveDirection, currentUnit)
        ELSEIF key="n" or key="N" THEN
            DrawUnit(currentUnit, DRAW_NORMAL)
            currentUnit = GetNextUnit()
        ELSEIF key="0" THEN 
            turnEnded = 1
		ELSEIF key="f" or key="F" THEN
			FireMode(currentUnit)			
        ENDIF
        
        winner = FindWinner()
        IF winner<>WINNER_NONE THEN turnEnded = TRUE
        
    LOOP WHILE turnEnded = FALSE
    DrawUnit(currentUnit, DRAW_NORMAL)
END SUB


SUB ResetUnitAps()
    DIM unit AS UBYTE= 0
    
    FOR unit = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(unit, UN_FACTION) = player AND unitStat(unit, UN_STATUS) = ALIVE THEN unitStat(unit, UN_AP) = unitStat(unit, UN_TOTAL_AP) 
    NEXT unit
END SUB
