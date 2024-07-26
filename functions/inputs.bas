SUB WaitForKeyRelease()
    WHILE Inkey$<>"" : WEND
END SUB


SUB WaitForKeyDown()
    WHILE Inkey$="" : WEND
END SUB


SUB WaitForKeyPress()
    WaitForKeyDown()
    WaitForKeyRelease()
END SUB

