DECLARE FUNCTION CheckKeyForMovement(key as UBYTE) AS UBYTE

'= GAME GLOBALS ===============================================================
DIM winner AS UBYTE
DIM turnCounter AS UBYTE
DIM player AS UBYTE

'= MODULES ====================================================================
#include "functions/infopane.bas"
#include "functions/infobar.bas"
#include "functions/draw_unit.bas"
#include "game_initialise.bas"
#include "game_find_unit.bas"
#include "game_move_unit.bas"
#include "fire_mode.bas"
#include "find_winner.bas"


SUB PrintVictoryScreen(winner as UBYTE)

    INK 4: PAPER 0: CLS
    IF winner = 0 THEN PRINT AT 10,10;FLASH 1;"RAIDERS WIN!"
    IF winner = 1 THEN PRINT AT 10,10;FLASH 1;"MARSEC WIN!"
    IF winner = 2 THEN PRINT AT 10,8;"There are no winners"
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
        InfoPaneStartTurn(player, turnCounter)        
        TakeTurn()
    LOOP WHILE winner=255
    
    PrintVictoryScreen(winner)
END SUB


SUB TakeTurn()
    DIM currentUnit AS UBYTE
    DIM moveDirection AS UBYTE
    DIM turnEnded AS UBYTE = 0
    DIM key AS String
    DIM blinker AS UBYTE

    currentUnit = GetFirstValidUnit()
    PrintInfoBar(MOVE_MODE)
    PrintUnitInfo(currentUnit)

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
            currentUnit = GetNextUnit(currentUnit)
        ELSEIF key="1" THEN 		' DEBUGGING CODE: Should be removed
            KillAllEnemies()	'                 also debugging!
        ELSEIF key="0" THEN 
            turnEnded = 1
		ELSEIF key="f" or key="F" THEN
			FireMode(currentUnit)			
        ENDIF
        
        winner = FindWinner()
        IF winner <3 THEN turnEnded = 1
        
    LOOP WHILE turnEnded = 0
    DrawUnit(currentUnit, DRAW_NORMAL)
END SUB


SUB ResetUnitAps()
    DIM unit AS UBYTE= 0
    
    FOR unit = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(unit, UN_FACTION) = player AND unitStat(unit, UN_STATUS) = ALIVE THEN unitStat(unit, UN_AP) = unitStat(unit, UN_TOTAL_AP) 
    NEXT unit
END SUB


SUB KillAllEnemies()
    DIM unit AS UBYTE
    DIM enemyFaction AS UBYTE
    
    enemyFaction = 1 - player
    
    FOR unit = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(unit, UN_FACTION) = enemyFaction THEN unitStat(unit, UN_STATUS) = DEAD
    NEXT unit
END SUB
