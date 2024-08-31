DIM visibilityFlag(NUMBER_OF_UNITS) AS UBYTE


FUNCTION LoSBresenhamQ1(x as UBYTE, y as UBYTE, dx as BYTE, dy as BYTE) AS UBYTE
    DIM delta, signY, x2, y2 AS BYTE
    DIM c AS UBYTE

    signY = SGN(dy)
    dy = ABS(dy)
    x2 = dx + dx
    y2 = dy + dy
    
    delta = y2 - dx
    
    FOR c = 1 TO dx-1
        WHILE delta>0
            y = y + signY
            delta = delta - x2
        WEND
        x = x + 1
        delta = delta + y2
        IF map(y,x)<>0 THEN RETURN FALSE
    NEXT c

    RETURN 1
END FUNCTION


FUNCTION LoSBresenhamQ2(x as UBYTE, y as UBYTE, dx as BYTE, dy as BYTE) AS UBYTE
    DIM delta, signY, x2, y2 AS BYTE
    DIM c AS UBYTE
    
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
        y = y + signY
        IF map(y,x)<>0 THEN RETURN FALSE
    NEXT c

    RETURN TRUE
END FUNCTION


FUNCTION HasLineOfSight(x1 AS UBYTE, y1 AS UBYTE, x2 AS UBYTE, y2 as UBYTE) AS UBYTE
    DIM t AS UBYTE
    DIM dx, dy AS BYTE
    
    IF(x2<x1) THEN
        t = x2 : x2 = x1 : x1 = t
        t = y2 : y2 = y1 : y1 = t
    ENDIF
    
    dx = x2 - x1
    dy = y2 - y1
    
    IF(ABS(dy)>ABS(dx)) THEN RETURN LoSBresenhamQ2(x1, y1, dx, dy)
    RETURN LoSBresenhamQ1(x1, y1, dx, dy)
END FUNCTION


FUNCTION IsInRange(range as UBYTE, dx as BYTE, dy as BYTE) AS UBYTE  
    DIM dSquare as UBYTE
    DIM rangeSq AS UBYTE

    IF dx > range THEN RETURN FALSE
    IF dy > range THEN RETURN FALSE

    dSquare = (dx * dx) + (dy * dy)
    rangeSq = range * range
    IF dSquare > rangeSq THEN RETURN FALSE

    RETURN TRUE

END FUNCTION


FUNCTION IsVisible(currentUnit AS UBYTE, target AS UBYTE) AS UBYTE
    DIM dx, dy as BYTE
    DIM xu, xt, yu, yt as UBYTE  
    DIM weaponId, rangeSq AS UBYTE
    
    weaponId = unitStat(currentUnit, UN_WEAPON)
    rangeSq = weaponStat(weaponId,WPN_LONG_RANGE_SQ)
    
    xu = unitStat(currentUnit,UN_X)
    xt = unitStat(target,UN_X)    
    dx = xt - xu
    
    yu = unitStat(currentUnit,UN_Y)
    yt = unitStat(target,UN_Y)
    dy = yt - yu

    IF IsInRange(rangeSq, dx, dy)=FALSE THEN RETURN 0
    IF HasLineOfSight(xu, yu, xt, yt) =FALSE THEN RETURN 0
    RETURN dx*dx + dy*dy
END FUNCTION


SUB CalculateEnemyVisibility(currentUnit AS UBYTE)
    DIM i AS UBYTE = 0

    FOR i = 0 TO NUMBER_OF_UNITS-1
      
        visibilityFlag(i) = 0
        
        IF unitStat(i, UN_FACTION) = player THEN CONTINUE FOR
        IF unitStat(i, UN_STATUS) <> ALIVE THEN CONTINUE FOR
        visibilityFlag(i) = IsVisible(currentUnit, i)
    NEXT i

END SUB


FUNCTION AnyEnemiesVisible() AS UBYTE
    DIM i AS UBYTE
        
    FOR i = 0 TO NUMBER_OF_UNITS-1
        IF visibilityFlag(i)>0 THEN RETURN TRUE
    NEXT i
    RETURN FALSE
END FUNCTION
