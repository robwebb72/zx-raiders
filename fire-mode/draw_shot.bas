DIM pointsx(32) AS UBYTE
DIM pointsy(32) AS UBYTE
DIM pointsCount AS UBYTE


SUB PopulateForQ1(x as UBYTE, y as UBYTE, dx as BYTE, dy as BYTE)   
    DIM delta, signY, x2, y2 AS BYTE
    DIM c AS UBYTE

    pointsCount= dx-1
    IF pointsCount<1 THEN RETURN

    signY = SGN(dy)
    
    dy = ABS(dy)
    x2 = dx + dx
    y2 = dy + dy
    
    delta = y2 - dx
    
    FOR c = 1 TO dx-1
        WHILE delta>0
            y = y + signY : delta = delta - x2
        WEND
        x = x + 1
        delta = delta + y2
        pointsx(c) = x
        pointsy(c) = y
    NEXT c    
END SUB

SUB PopulateForQ2(x as UBYTE, y as UBYTE, dx as BYTE, dy as BYTE)

    DIM delta, signY, x2, y2 AS BYTE
    DIM c AS UBYTE

    pointsCount=ABS(dy)-1
    IF pointsCount<1 THEN RETURN


    signY = SGN(dy)
    dy=ABS(dy)
    x2 = dx + dx
    y2 = dy + dy
    
    delta = x2 - dy
    
    FOR c = 1 TO dy-1
        WHILE delta>0
            x = x + 1
            delta = delta - y2
        WEND
        delta = delta + x2
        y = y + signY
        pointsx(c) = x
        pointsy(c) = y
    NEXT c
END SUB


SUB CreatePath(x1 as UBYTE, y1 as UBYTE, x2 as UBYTE, y2 as UBYTE)
    DIM t AS UBYTE
    DIM dx, dy AS BYTE
    
    IF(x1>x2) THEN
        t = x1: x1 = x2: x2 = t
        t = y1: y1 = y2: y2 = t
    ENDIF
    dx = x2 - x1 : dy = y2 - y1

    IF ABS(dy)>dx THEN PopulateForQ2(x1, y1, dx, dy) ELSE PopulateForQ1(x1, y1, dx, dy)
END SUB


SUB DrawShotRightToLeft()
    DIM i AS UBYTE

    FOR i= pointsCount TO 1 STEP -1
         DrawProjectile(pointsx(i),pointsy(i))
    NEXT i
END SUB


SUB DrawShotLeftToRight()
    DIM i AS UBYTE
    
    FOR i= 1 TO pointsCount 
        DrawProjectile(pointsx(i),pointsy(i))
    NEXT i
END SUB


SUB DrawProjectile(x as UBYTE, y as UBYTE)
    PRINT at y,x;INK 7;"\G";
    Wait(8)
    PRINT at y,x;" ";
END SUB


SUB DrawShot(currentUnit as UBYTE, target as UBYTE)

    DIM xt, yt, xu, yu as UBYTE
    
    xu = unitStat(currentUnit, UN_X) : yu = unitStat(currentUnit, UN_Y)
    xt = unitStat(target, UN_X) : yt = unitStat(target, UN_Y)
    
    CreatePath(xu, yu, xt, yt)
    
    IF xu > xt THEN
        DrawShotRightToLeft()
    ELSE
        DrawShotLeftToRight()
    ENDIF
END SUB