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

'    IF HasAPToFire(currentUnit) = FALSE THEN
'        PrintInfoBarWarning("Not enough AP to fire")
'        PrintInfoBar(MOVE_MODE)
'        RETURN
'    ENDIF
   
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
            IF BlinkerState()=0 THEN
                DrawUnit(currentUnit, DRAW_REMOVE)
            ELSE
                DrawUnit(currentUnit, DRAW_NORMAL)
            ENDIF
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
            PrintUnitInfo(currentUnit)
            ' update visibility flags - i.e. if unit is killed, set it's flag to false
            ' check for any visible units
        ENDIF
        
        
        
    LOOP WHILE endFireMode = FALSE

    PrintInfoBar(MOVE_MODE)
    DrawEnemyUnitsForMoveMode()

END SUB


SUB DrawEnemyUnitsForMoveMode()

    DIM i as UBYTE   
        
    FOR i = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(i,UN_FACTION) = player THEN CONTINUE FOR
        IF unitStat(i,UN_STATUS)=DEAD THEN CONTINUE FOR
        DrawUnit(i, DRAW_NORMAL)
    NEXT i        
END SUB


SUB DrawEnemyUnitsForFireMode()

    DIM i as UBYTE   
        
    FOR i = 0 TO NUMBER_OF_UNITS-1
        IF unitStat(i,UN_FACTION) = player THEN CONTINUE FOR
        IF unitStat(i,UN_STATUS)=DEAD THEN CONTINUE FOR
        IF visibilityFlag(i)=1 THEN 
            DrawUnit(i, DRAW_FIRE_VISIBLE)       
        ELSE
            DrawUnit(i, DRAW_FIRE_NOT_VISIBLE)
        ENDIF
    NEXT i        
END SUB

SUB TakeShot(currentUnit as UBYTE, target as UBYTE)
    DIM weaponId AS UBYTE
    weaponId = unitStat(currentUnit, UN_WEAPON)
    unitStat(currentUnit, UN_AP) = unitStat(currentUnit, UN_AP) - weaponStat(weaponId, WPN_AP)
END SUB