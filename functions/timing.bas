' location 23672 is the low byte of the frame counter.  It is incremented every 20ms
' 50 * 20 ms = 1 second

FUNCTION BlinkerState() AS UBYTE
    IF (PEEK 23672) & 16 = 0 THEN RETURN 0
    RETURN 1
END FUNCTION


SUB Wait(n as INTEGER)

    DIM i, j AS UBYTE
    DIM diff AS INTEGER
    
    i = PEEK 23672
    
    WHILE n>0
        j = PEEK 23672
        diff = j - i
        IF diff<0 THEN diff = diff + 256
        n = n - diff
        i = j    
    WEND
END SUB