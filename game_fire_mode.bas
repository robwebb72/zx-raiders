#include "game_fire_mode_visibility.bas"

    
SUB FireMode(currentUnit AS UBYTE)
    
    DIM endFireMode AS UBYTE = 0
    DIM key AS String
    DIM blinker AS UBYTE

    CalculateEnemyVisibility(currentUnit)
    IF AnyEnemiesVisible() = FALSE THEN
        PrintInfoBarWarning("No visible enemies in range")
        RETURN
    ENDIF

    PrintInfoBar(FIRE_MODE)
    DrawEnemyUnitsForFireMode()

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
        ENDIF
        
        
        
    LOOP WHILE endFireMode = 0

    PrintInfoBar(MOVE_MODE)
    DrawEnemyUnitsForMoveMode()

END SUB


SUB DrawEnemyUnitsForMoveMode()

    DIM startUnit, enemyPlayer as UBYTE   
    enemyPlayer = 2 - player    
    startUnit = enemyPlayer * 8
        
    FOR i = startUnit TO startUnit+7
        IF unitStat(i,UN_STATUS)=DEAD THEN CONTINUE FOR
        DrawUnit(i, DRAW_NORMAL)
    NEXT i        
END SUB


SUB DrawEnemyUnitsForFireMode()

    DIM startUnit, enemyPlayer as UBYTE   
    enemyPlayer = 2 - player    
    startUnit = enemyPlayer * 8
        
    FOR i = startUnit TO startUnit+7
        IF unitStat(i,UN_STATUS)=DEAD THEN CONTINUE FOR
        IF visibilityFlag(i)=1 THEN 
'        IF (i bAnd 1)=1 THEN 
            DrawUnit(i, DRAW_FIRE_VISIBLE)       
        ELSE
            DrawUnit(i, DRAW_FIRE_NOT_VISIBLE)
        ENDIF
    NEXT i        
END SUB
