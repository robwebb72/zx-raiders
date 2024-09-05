FUNCTION CalculateDamage(target as UBYTE) as UBYTE
    RETURN Random(GetMinDamage(target), GetMaxDamage(target))
END FUNCTION


SUB TakeShot(target as UBYTE)
    DIM message AS STRING
    DIM diceRoll, damage AS UBYTE
    DIM targetHP AS BYTE
    
    ' draw current unit in case it was blanked out by the blinker
    DrawUnit(currentUnit, DRAW_NORMAL)  

    unitStat(currentUnit, UN_AP) = unitStat(currentUnit, UN_AP) - weaponStat(weaponId, WPN_AP)
    PrintAP()

    DrawShot(currentUnit, target)
    diceRoll = Random(1,100)
    IF diceRoll>ChanceToHit(target) THEN
        message = unitName(currentUnit) + " misses"
        PrintInfoBarInform(message)
        PrintInfoBar(FIRE_MODE)
        RETURN
    ENDIF

    damage = CalculateDamage(target)
    ShowDamage(target, damage)
    
    IF damage >= unitStat(target, UN_HP) THEN
        KillUnit(target)
        PrintInfoBarInform(unitName(target) + " is out of action")
    ELSE
        unitStat(target, UN_HP) = unitStat(target, UN_HP) - damage
        PrintInfoBarInform(unitName(currentUnit) + " hits for " + Str(damage) + " HP")
        PrintInfoPaneFireMode(target)
    ENDIF
    PrintInfoBar(FIRE_MODE)
END SUB


SUB ShowDamage(target as UBYTE, damage as UBYTE)
    DIM i AS UBYTE
    
    FOR i=0 TO damage
        DrawUnit(target, DRAW_YELLOW)
        BEEP 0.15,-4
        DrawUnit(target, DRAW_RED)
        BEEP 0.15,-6
    NEXT i    
    DrawUnit(target, DRAW_FIRE_TARGET)
END SUB


SUB KillUnit(target as UBYTE)
    unitStat(target, UN_HP) = 0
    unitStat(target, UN_STATUS) = DEAD
    DrawUnit(target, DRAW_REMOVE)
    rangeLevel(target) = 0
    map(unitStat(target, UN_Y),unitStat(target, UN_X)) = 0
END SUB