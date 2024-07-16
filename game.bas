DECLARE FUNCTION CheckKeyForMovement(key as UBYTE) AS UBYTE

#include "game_next_unit.bas"
#include "game_move_unit.bas"


SUB RunGame()
    DO
        player = 3 - player
        IF player = 1 THEN turnCounter = turnCounter + 1
        TakeTurn()
    LOOP WHILE winner=0
END SUB


SUB TakeTurn()
    DIM currentUnit AS UBYTE
    DIM moveDirection AS UBYTE
    DIM turnEnded AS UBYTE = 0
    DIM key AS String
    DIM blinker AS UBYTE
    
    currentUnit = (8 * player) - 1
    currentUnit = GetNextUnit(player, currentUnit)
    PrintInfoBar(MOVE_MODE)
    ResetUnitAps(player)
    DO
        WaitForKeyRelease()
        DO
            blinker = BlinkerState()
            IF blinker=0 THEN
                DrawUnit(currentUnit,DRAW_REMOVE)
            ELSE
                DrawUnit(currentUnit, DRAW_NORMAL)
            ENDIF
            key = INKEY
        LOOP WHILE key=""

        moveDirection = CheckKeyForMovement(Code(key(0)))

        IF moveDirection<>DIR_NONE THEN
            MoveUnit(moveDirection, currentUnit)
        ELSEIF key="n" or key="N" THEN
            DrawUnit(currentUnit, DRAW_NORMAL)
            currentUnit = GetNextUnit(player, currentUnit)
        ELSEIF key="1" THEN 
            KillAllUnits(player)
        ELSEIF key="0" THEN 
            turnEnded = 1
        ENDIF
        
        ' check for victory condition
        
        
    LOOP WHILE turnEnded = 0
END SUB

SUB ResetUnitAps(player as UBYTE)
    DIM i, j AS UBYTE

    i = (player - 1) * 8
    FOR j = i TO i+7
        unitStat(j, UN_AP) = unitStat(j, UN_TOTAL_AP)
    NEXT j
END SUB

SUB KillAllUnits(player as UBYTE)
    DIM i, j AS UBYTE

    i = (player - 1) * 8
    FOR j = i TO i+7
        unitStat(j, UN_STATUS) = DEAD
    NEXT j
END SUB
