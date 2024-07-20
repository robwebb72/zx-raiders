DIM visibilityFlag(16) AS UBYTE


FUNCTION LoSBresenhamQ1(x as UBYTE, y as UBYTE, dx as BYTE, dy as BYTE) AS UBYTE
    RETURN 1

END FUNCTION
FUNCTION LoSBresenhamQ2(x as UBYTE, y as UBYTE, dx as BYTE, dy as BYTE) AS UBYTE
    RETURN 1

END FUNCTION


FUNCTION HasLineOfSight(x1 AS UBYTE, y1 AS UBYTE, x2 AS UBYTE, y2 as UBYTE) AS UBYTE
    ' TODO: Perform Line of Sight Test
    DIM t AS UBYTE
    DIM dx, dy AS BYTE
    
    IF(x2<x1) THEN
        t = x2 : x2 = x1 : x1 = t
        t = y2 : y2 = y1 : y1 = t
    ENDIF
    
    dx = x2 - x1
    dy = y2 - y1
    
    IF(dy>dx) THEN RETURN LoSBresenhamQ1(x1, y1, dx, dy)
    RETURN LoSBresenhamQ2(x1, y1, dx, dy)
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
        visibilityFlag(i) = IsVisible(currentUnit, i)
    NEXT i
END SUB

