SUB Menu()
    DIM i AS UBYTE
    DIM a AS STRING
    
    BORDER 1: PAPER 0: INK 4 : CLS
    WaitForKeyRelease()
    PRINT AT 10,10;"MARS RAIDERS"; AT 11,10;"by Rob Webb"; AT 14,5;"Press any key to start"
    PRINT AT 10,1; INK 5;"\A\B\C"
    PRINT AT 10,28; INK 2;"\F\E\D"
    DO
        i = BlinkerState()
        IF i=1 THEN 
            PRINT AT 14,5;"Press any key to start"
        ELSE 
            PRINT AT 14,5;"                      "
        ENDIF
        a = INKEY
    LOOP WHILE a = ""
    WaitForKeyRelease()
    BEEP 0.1,1
END SUB