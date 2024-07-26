DIM _ib_blankLine AS STRING

_ib_blankLine = "                                "

FUNCTION TextCentre(text as STRING) AS UBYTE
    DIM offset AS BYTE

    offset = (32-Len(text))/2
    IF offset<0 THEN offset = 0

    RETURN offset    
END FUNCTION

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

SUB InfoBarWait()
    Wait(10)
    WaitOrKeyPress(250)
    WaitForKeyRelease()
END SUB

SUB PrintInfoBarWarning(warning as STRING)
    ClearInfoBar()
    PRINT AT 20,TextCentre(warning);FLASH 1;warning
    InfoBarWait()
END SUB 

SUB PrintInfoBarInform(info as STRING)
    ClearInfoBar()
    PRINT AT 20,TextCentre(info);INK 6;info
    InfoBarWait()
END SUB 
