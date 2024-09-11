#include "visibility.bas"
#include "next_target.bas"
#include "draw_shot.bas"
#include "get_weapon_stats.bas"
#include "take_shot.bas"


SUB PrintChanceToHit(target as UBYTE)
    INK 5: PAPER 0 
    PRINT AT 22,25;"hit ";ChanceToHit(target);"%";
END SUB


SUB PrintDamageRange(target as UBYTE)
    DIM minDmg, maxDmg as UBYTE

    minDmg = GetMinDamage(target)
    maxDmg = GetMaxDamage(target)
    INK 5: PAPER 0
    
    PRINT at 22,17;minDmg;"-";maxDmg;"dmg";
END SUB


FUNCTION HasAPToFire() AS UBYTE
    IF unitStat(currentUnit,UN_AP) < weaponStat(weaponId, WPN_AP) THEN RETURN FALSE
    RETURN TRUE
END FUNCTION


SUB PrintInfoPaneFireMode(target as UBYTE)
    PrintFireInfo(target)
    PrintChanceToHit(target)
    PrintDamageRange(target)
    
    IF rangeLevel(target) = 1 THEN PRINT AT 23,25;"SHORT"
    IF rangeLevel(target) = 2 THEN PRINT AT 23,25;"MEDIUM"
    IF rangeLevel(target) = 3 THEN PRINT AT 23,25;"LONG"  
END SUB


SUB FireMode()   
    DIM endFireMode AS UBYTE = FALSE
    DIM key AS String
    DIM target AS UBYTE

    weaponId = unitStat(currentUnit, UN_WEAPON)

    IF HasAPToFire() = FALSE THEN
        PrintInfoBarWarning("Not enough AP to fire")
        PrintInfoBar(MOVE_MODE)
        RETURN
    ENDIF
   
    CalculateEnemyVisibility()
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
            
            TakeShot(target)
            
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

