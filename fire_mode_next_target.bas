FUNCTION FindNextTarget(player as UBYTE, currentTarget as UBYTE) AS UBYTE
    DIM counter AS UBYTE
    DIM originalTarget AS UBYTE
    DIM found as UBYTE = 0
    DIM playerOffset AS UBYTE = 0
    
    IF player=2 THEN playerOffset = 8
    
    originalTarget = currentTarget - playerOffset
    counter = originalTarget    
    
    DO
        counter = counter + 1
        IF counter > 7 THEN counter = 0


        IF counter = originalTarget THEN
            found = 1
         ELSEIF visibleFlag(counter) = TRUE
            found = 1
         ENDIF
    LOOP WHILE found=0
    
    RETURN counter + playerOffset
END FUNCTION