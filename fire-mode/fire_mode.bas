#include "visibility.bas"
#include "next_target.bas"
#include "draw_shot.bas"

FUNCTION ChanceToHit(target as UBYTE) AS UBYTE
    DIM modifier AS UBYTE = 100
    DIM result AS BYTE
    DIM weaponId AS UBYTE
    weaponId = unitStat(currentUnit, UN_WEAPON)

    result = unitStat(currentUnit,UN_ACCURACY)
    IF rangeLevel(target) = 1 THEN modifier = weaponStat(weaponId,WPN_ACC_MOD_SHORT)
    IF rangeLevel(target) = 2 THEN modifier = weaponStat(weaponId,WPN_ACC_MOD_MID)
    IF rangeLevel(target) = 3 THEN modifier = weaponStat(weaponId,WPN_ACC_MOD_LONG)
    
    result = result + modifier
    if result < 5 THEN result = 5
    if result >95 THEN result = 95
    RETURN result
END FUNCTION

SUB PrintChanceToHit(target as UBYTE)
    INK 5: PAPER 0 
    PRINT AT 22,25;"hit ";ChanceToHit(target);"%";
END SUB
    
SUB PrintDamageRange()
    DIM minDmg, maxDmg as UBYTE
    DIM weaponId AS UBYTE
    weaponId = unitStat(currentUnit, UN_WEAPON)

    minDmg = weaponStat(weaponId,WPN_DAMAGE_MIN)
    maxDmg = weaponStat(weaponId,WPN_DAMAGE_MAX)
    INK 5: PAPER 0
    
    PRINT at 22,17;minDmg;"-";maxDmg;"dmg";
END SUB

FUNCTION HasAPToFire() AS UBYTE
    DIM weaponId AS UBYTE
    
    weaponId = unitStat(currentUnit, UN_WEAPON)
    IF unitStat(currentUnit,UN_AP) < weaponStat(weaponId, WPN_AP) THEN RETURN FALSE
    RETURN TRUE

END FUNCTION


SUB PrintInfoPaneFireMode(target as UBYTE)
    PrintFireInfo(target)
    PrintChanceToHit(target)
    PrintDamageRange()
END SUB

SUB FireMode(currentUnit AS UBYTE)   
    DIM endFireMode AS UBYTE = FALSE
    DIM key AS String
    DIM target AS UBYTE

    IF HasAPToFire() = FALSE THEN
        PrintInfoBarWarning("Not enough AP to fire")
        PrintInfoBar(MOVE_MODE)
        RETURN
    ENDIF
   
    CalculateEnemyVisibility(currentUnit)
    IF AnyEnemiesVisible() = FALSE THEN
        PrintInfoBarWarning("No visible enemies in range")
        PrintInfoBar(MOVE_MODE)
        RETURN
    ENDIF

    PrintInfoBar(FIRE_MODE)
    DrawEnemyUnitsForFireMode()
    target = GetFirstTarget(player)
    DrawUnit(target, DRAW_FIRE_TARGET)
    PrintInfoPaneFireMode(target)

    DO   
        IF HasAPToFire() = FALSE THEN
            PrintInfoBarWarning("Not enough AP to fire")
            EXIT DO
        ENDIF
    
        WaitForKeyRelease()
        DO
            DrawUnit(currentUnit, DRAW_CURRENT_UNIT)
            key = INKEY
        LOOP WHILE key=""

        IF key="k" or key="K" THEN
            endFireMode = 1
        ELSEIF key="n" or key="N" THEN
            DrawUnit(target, DRAW_FIRE_VISIBLE)
            target = GetNextTarget(player, target)
            DrawUnit(target, DRAW_FIRE_TARGET)
            PrintInfoPaneFireMode(target)

        ELSEIF key="1" THEN
            
            TakeShot(currentUnit, target)
            
            IF AnyEnemiesVisible() = FALSE THEN
                PrintInfoBarWarning("No visible enemies in range")
                endFireMode = TRUE
            ELSEIF unitStat(target, UN_STATUS) = DEAD THEN
                target = GetNextTarget(player, target)
                DrawUnit(target, DRAW_FIRE_TARGET)
                PrintInfoPaneFireMode(target)
            ENDIF
        ENDIF
        
    LOOP WHILE endFireMode = FALSE

    PrintInfoBar(MOVE_MODE)
    DrawEnemyUnitsForMoveMode()
    PrintUnitInfo()    ' Draw Move Mode Info Pane

END SUB


SUB DrawEnemyUnitsForMoveMode()
    DIM unit as UBYTE   
        
    FOR unit = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(unit,UN_FACTION) = player THEN CONTINUE FOR
        IF unitStat(unit,UN_STATUS) = DEAD THEN CONTINUE FOR
        DrawUnit(unit, DRAW_NORMAL)
    NEXT unit       
END SUB


SUB DrawEnemyUnitsForFireMode()
    DIM unit as UBYTE   
        
    FOR unit = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(unit,UN_FACTION) = player THEN CONTINUE FOR
        IF unitStat(unit,UN_STATUS) = DEAD THEN CONTINUE FOR
        IF rangeLevel(unit)>0 THEN 
            DrawUnit(unit, DRAW_FIRE_VISIBLE)       
        ELSE
            DrawUnit(unit, DRAW_FIRE_NOT_VISIBLE)
        ENDIF
    NEXT unit       
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

SUB TakeShot(currentUnit as UBYTE, target as UBYTE)
    DIM weaponId AS UBYTE
    DIM diceRoll AS UBYTE
    DIM message AS STRING
    DIM damage AS UBYTE
    DIM targetHP AS BYTE
       
    DrawUnit(currentUnit, DRAW_NORMAL)  ' draw current unit in case it was blanked out by the blinker
    
    weaponId = unitStat(currentUnit, UN_WEAPON)
    message = unitName(currentUnit) + " "

    unitStat(currentUnit, UN_AP) = unitStat(currentUnit, UN_AP) - weaponStat(weaponId, WPN_AP)
    PrintAP()

    DrawShot(currentUnit, target)
    diceRoll = Random(1,100)
    diceRoll = 52
    IF diceRoll>ChanceToHit(target) THEN
        message = message + "misses"
        PrintInfoBarInform(message)
        PrintInfoBar(FIRE_MODE)
        RETURN
    ENDIF

    damage = Random(weaponStat(weaponId, WPN_DAMAGE_MIN), weaponStat(weaponId, WPN_DAMAGE_MAX))
    targetHP = unitStat(target, UN_HP) - damage
    ShowDamage(target, damage)
           
    
    IF targetHP<=0 THEN                     ' if target is dead
        unitStat(target, UN_HP) = 0
        unitStat(target, UN_STATUS) = DEAD
        DrawUnit(target, DRAW_REMOVE)
        rangeLevel(target) = 0
        map(unitStat(target, UN_Y),unitStat(target, UN_X)) = 0
        message = unitName(target) + " is out of action"
        PrintInfoBarInform(message)
    ELSE
        message = message + "hits for " + Str(damage) + " HP"
        PrintInfoBarInform(message)
        unitStat(target, UN_HP) = targetHP
        PrintInfoPaneFireMode(target)
    ENDIF
    PrintInfoBar(FIRE_MODE)

END SUB