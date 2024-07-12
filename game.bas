DECLARE FUNCTION GetNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE
DECLARE FUNCTION FindNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE

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
    DIM blinker AS UBYTE
    
    currentUnit = (8 * player) - 1
    currentUnit = GetNextUnit(player, currentUnit)
    PrintInfoBar(MOVE_MODE)
    ResetUnitAps(player)
    DO
        DO
            blinker = BlinkerState()
            IF blinker=0 THEN
                DrawUnit(currentUnit,DRAW_REMOVE)
            ELSE
                DrawUnit(currentUnit, DRAW_NORMAL)
            ENDIF
            key = iNKEY
        LOOP WHILE key=""
        IF key="n" or key="N" THEN
            DrawUnit(currentUnit, DRAW_NORMAL)
            currentUnit = GetNextUnit(player, currentUnit)
        ENDIF
        IF key="1" THEN KillAllUnits(player)
        IF key="0" THEN turnEnded = 1        
        WaitForKeyRelease()
        
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