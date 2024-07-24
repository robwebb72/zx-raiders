#include "game_fire_mode_visibility.bas"
#include "fire_mode_next_target.bas"
    
SUB FireMode(currentUnit AS UBYTE)
    
    DIM endFireMode AS UBYTE = 0
    DIM key AS String
    DIM blinker AS UBYTE
    DIM target AS UBYTE
    
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
        WaitForKeyRelease()
        DO
            blinker = BlinkerState()
            IF blinker=0 THEN
                DrawUnit(currentUnit,DRAW_REMOVE)
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
            
        ENDIF
        
        
        
    LOOP WHILE endFireMode = 0

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
