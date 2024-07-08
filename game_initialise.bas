SUB InitialiseGame()
    CLS
    winner = 0
    turnCounter = 0
    player = 2
 
    ResetMap()
    ResetUnits()
    DrawMap()
    DrawUnits()
END SUB


SUB ResetMap()
    DIM j, i AS UBYTE
    
    FOR j=0 TO 19
        FOR i=0 TO 31
            IF map(j,i)<100 THEN map(j,i) = 0
        NEXT i
    NEXT j
END SUB


SUB ResetUnits()
    DIM i AS UBYTE

    FOR i = 0 TO 15
        unitStat(i,UN_X) = unitStat(i,UN_X_START)
        unitStat(i,UN_Y) = unitStat(i,UN_Y_START)
        unitStat(i,UN_AP) = unitStat(i,UN_TOTAL_AP)
        unitStat(i,UN_HP) = unitStat(i,UN_TOTAL_HP)
        unitStat(i,UN_STATUS) = ALIVE
        map(unitStat(i,UN_Y_START),unitStat(i,UN_X_START)) = i
    NEXT i
END SUB

SUB DrawMap()
    DIM y, x AS UBYTE
    
    PAPER 7: INK 2
    FOR y=0 TO 19
        FOR x=0 TO 31
            IF map(y,x)>100 THEN PRINT AT y,x;"\G"
        NEXT x
    NEXT y
    PAPER 0
END SUB

SUB DrawUnits()
    DIM i AS UBYTE
    
    FOR i=0 TO 15
        DrawUnit(i,DRAW_NORMAL)
    NEXT i
END SUB