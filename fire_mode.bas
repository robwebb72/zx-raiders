#include "game_fire_mode_visibility.bas"
#include "fire_mode_next_target.bas"

FUNCTION HasAPToFire(currentUnit as UBYTE) AS UBYTE
    DIM weaponId AS UBYTE
    
    weaponId = unitStat(currentUnit, UN_WEAPON)
    IF unitStat(currentUnit,UN_AP) < weaponStat(weaponId, WPN_AP) THEN RETURN FALSE
    RETURN TRUE

END FUNCTION

SUB FireMode(currentUnit AS UBYTE)   
    DIM endFireMode AS UBYTE = FALSE
    DIM key AS String
    DIM target AS UBYTE

    IF HasAPToFire(currentUnit) = FALSE THEN
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

    DO   
        IF HasAPToFire(currentUnit) = FALSE THEN
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
        ELSEIF key="1" THEN
            
            TakeShot(currentUnit, target)
            
            IF AnyEnemiesVisible() = FALSE THEN
                PrintInfoBarWarning("No visible enemies in range")
                endFireMode = TRUE
            ELSEIF unitStat(target, UN_STATUS) = DEAD THEN
                target = GetNextTarget(player, target)
                DrawUnit(target, DRAW_FIRE_TARGET)
            ENDIF
        ENDIF
        
    LOOP WHILE endFireMode = FALSE

    PrintInfoBar(MOVE_MODE)
    DrawEnemyUnitsForMoveMode()

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
        IF visibilityFlag(unit)=TRUE THEN 
            DrawUnit(unit, DRAW_FIRE_VISIBLE)       
        ELSE
            DrawUnit(unit, DRAW_FIRE_NOT_VISIBLE)
        ENDIF
    NEXT unit       
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

    ' update unit APs
    unitStat(currentUnit, UN_AP) = unitStat(currentUnit, UN_AP) - weaponStat(weaponId, WPN_AP)
    PrintAP(currentUnit)

    ' TODO: show projectile moving to target

    diceRoll = Random(1,100)
    IF diceRoll>unitStat(currentUnit, UN_ACCURACY) THEN
        message = message + "misses"
        PrintInfoBarInform(message)
        PrintInfoBar(FIRE_MODE)
        RETURN
    ENDIF

    damage = Random(weaponStat(weaponId, WPN_DAMAGE_MIN), weaponStat(weaponId, WPN_DAMAGE_MAX))
    message = message + "hits for " + Str(damage) + " HP"
    PrintInfoBarInform(message)
    
    targetHP = unitStat(target, UN_HP) - damage

    ' TODO: show damage being applied to target
        
    
    IF targetHP<=0 THEN                     ' if target is dead
        unitStat(target, UN_HP) = 0
        unitStat(target, UN_STATUS) = DEAD
        DrawUnit(target, DRAW_REMOVE)
        visibilityFlag(target) = FALSE
        map(unitStat(target, UN_Y),unitStat(target, UN_X)) = 0
        message = unitName(target) + " is out of action"
        PrintInfoBarInform(message)
    ELSE
        unitStat(target, UN_HP) = targetHP
    ENDIF
    PrintInfoBar(FIRE_MODE)

END SUB