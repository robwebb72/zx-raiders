DECLARE FUNCTION FindNextUnit(player as UBYTE, currentUnit as UBYTE) AS UBYTE

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