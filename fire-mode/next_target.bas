FUNCTION GetNextTarget(player as UBYTE, currentTarget as UBYTE) AS UBYTE
    DIM nextTarget AS UBYTE

    nextTarget = currentTarget
    DO
        nextTarget = nextTarget + 1
        IF nextTarget >= NUMBER_OF_UNITS THEN nextTarget = 0
    
        IF unitStat(nextTarget, UN_STATUS) = DEAD THEN CONTINUE DO
        IF unitStat(nextTarget, UN_FACTION) = player THEN CONTINUE DO
        IF rangeSqValue(nextTarget)>0 THEN RETURN nextTarget
    LOOP WHILE nextTarget <> currentTarget
    
    IF unitStat(nextTarget, UN_STATUS) = ALIVE THEN RETURN nextTarget
    RETURN 255
END FUNCTION


FUNCTION GetFirstTarget(player as UBYTE) AS UBYTE
    RETURN GetNextTarget(player, NUMBER_OF_UNITS)
END FUNCTION
