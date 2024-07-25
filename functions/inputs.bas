SUB WaitForKeyRelease()
    WHILE Inkey$<>"" : WEND
END SUB

SUB WaitForKeyDown()
    WHILE Inkey$="" : WEND
END SUB

FUNCTION GetKeyPress() AS STRING
    DIM key AS STRING
    
    DO 
        key = Inkey()
    LOOP UNTIL key<>""
    WaitForKeyRelease()
    RETURN key
END FUNCTION


SUB WaitForKeyPress()
    WaitForKeyDown()
    WaitForKeyRelease()
END SUB

