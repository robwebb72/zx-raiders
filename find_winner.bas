FUNCTION AnyUnitAlive(faction as UBYTE) AS UBYTE
    DIM i AS UBYTE
    
    FOR i=0 TO NUMBER_OF_UNITS-1
        IF unitStat(i, UN_FACTION) = faction AND unitStat(i, UN_STATUS) = ALIVE THEN RETURN TRUE
    NEXT i
    
    RETURN FALSE
END FUNCTION


FUNCTION FindWinner() AS UBYTE
    DIM allRaidersDead AS UBYTE = TRUE
    DIM allMarsecDead AS UBYTE = TRUE
    
    IF AnyUnitAlive(0) = TRUE THEN allRaidersDead = FALSE
    IF AnyUnitAlive(1) = TRUE THEN allMarsecDead = FALSE
    
    IF allRaidersDead = FALSE and allMarsecDead = FALSE THEN RETURN 0
    IF allRaidersDead = TRUE and allMarsecDead = TRUE THEN RETURN 3
    IF allRaidersDead = TRUE THEN RETURN 2
    RETURN 1
END FUNCTION
