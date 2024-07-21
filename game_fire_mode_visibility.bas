DIM visibilityFlag(16) AS UBYTE


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
        IF map(y,x)<>0 THEN RETURN 0
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
        IF map(y,x)<>0 THEN RETURN 0
    NEXT c

    RETURN 1
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


FUNCTION IsVisible(currentUnit AS UBYTE, target AS UBYTE) AS UBYTE

    DIM dx, dy as BYTE
    DIM range, rangeSquare, dSquare as UBYTE
    DIM xu, xt, yu, yt as UBYTE
    
    DIM weaponId AS UBYTE
    
    weaponId = unitStat(currentUnit, UN_WEAPON)
    range = weaponStat(weaponId,WPN_RANGE)
    
    xu = unitStat(currentUnit,UN_X)
    xt = unitStat(target,UN_X)    
    dx = xt - xu
    IF dx<0 THEN dx=-dx    
    IF dx>range THEN return 0 
    
    yu = unitStat(currentUnit,UN_Y)
    yt = unitStat(target,UN_Y)
    dy = yt - yu
    IF dy<0 THEN dy=-dy
    IF dy>range THEN return 0 
    
    rangeSquare = range * range
    dSquare = dx * dx + dy * dy
    IF dSquare >  rangeSquare THEN RETURN 0
    
    RETURN HasLineOfSight(xu, yu, xt, yt)   
END FUNCTION


SUB CalculateEnemyVisibility(currentUnit AS UBYTE)
    DIM startUnit, enemyPlayer as UBYTE   
    enemyPlayer = 2 - player    
    startUnit = enemyPlayer * 8
        
    FOR i = startUnit TO startUnit+7
        IF unitStat(i,UN_STATUS)=ALIVE THEN visibilityFlag(i) = IsVisible(currentUnit, i)
    NEXT i
END SUB


FUNCTION AnyEnemiesVisible() AS UBYTE
    DIM startUnit, enemyPlayer as UBYTE   
    enemyPlayer = 2 - player    
    startUnit = enemyPlayer * 8
        
    FOR i = startUnit TO startUnit+7
        IF visibilityFlag(i) = TRUE THEN RETURN TRUE
    NEXT i
    RETURN FALSE
END FUNCTION
