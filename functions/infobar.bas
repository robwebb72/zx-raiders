DIM _ib_blankLine AS STRING

_ib_blankLine = "                                "

SUB PrintInfoBar(mode as UBYTE)
    PAPER 1: INK 6
    PRINT AT 20,0;_ib_blankLine
    IF player=1 THEN
        PRINT AT 20,0;"Raiders"
    ELSE
        PRINT AT 20,0;"Marsec"
    END IF
    
    IF mode = FIRE_MODE THEN PRINT AT 20,10;"FIRE mode"
    IF mode = MOVE_MODE THEN PRINT AT 20,10;"MOVE mode"
    PRINT AT 20,23;"Turn: ";turnCounter
    PAPER 0
END SUB