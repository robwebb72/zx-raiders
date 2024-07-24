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
        IF counter=NUMBER_OF_UNITS THEN counter = 0
        IF unitStat(counter, UN_FACTION)<>player THEN CONTINUE DO
        IF counter = currentUnit THEN
            found = TRUE
         ELSEIF unitStat(counter, UN_STATUS) = ALIVE
            found = TRUE
         ENDIF
    LOOP WHILE found=FALSE
    
    RETURN counter
END FUNCTION

FUNCTION GetFirstValidUnit(player as UBYTE) AS UBYTE
    DIM counter AS UBYTE
    
    WHILE counter < NUMBER_OF_UNITS
        IF unitStat(counter,UN_FACTION) = player AND unitStat(counter,UN_STATUS) =  ALIVE THEN RETURN counter
        counter = counter + 1
    WEND
    RETURN 255 
END FUNCTION