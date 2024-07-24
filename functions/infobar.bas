DIM _ib_blankLine AS STRING

_ib_blankLine = "                                "

SUB ClearInfoBar()
    PAPER 1: INK 6
    PRINT AT 20,0;_ib_blankLine
END SUB

SUB PrintInfoBar(mode as UBYTE)
    ClearInfoBar()
    IF player=0 THEN
        PRINT AT 20,0;"Raiders"
    ELSE
        PRINT AT 20,0;"Marsec"
    END IF
    
    IF mode = FIRE_MODE THEN PRINT AT 20,10;"FIRE mode"
    IF mode = MOVE_MODE THEN PRINT AT 20,10;"MOVE mode"
    PRINT AT 20,23;"Turn: ";turnCounter
    PAPER 0
END SUB


SUB PrintInfoBarWarning(warning as STRING)
    DIM offset AS BYTE
    ClearInfoBar()
    
    offset = (32-Len(warning))/2
    IF offset<0 THEN offset = 0
    PRINT AT 20,offset;FLASH 1;warning
    
    WHILE Inkey<>"" : WEND
    WHILE Inkey="" : WEND

END SUB 
