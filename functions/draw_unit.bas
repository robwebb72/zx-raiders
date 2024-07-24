#DEFINE DRAW_NORMAL 0
#DEFINE DRAW_FIRE_NOT_VISIBLE 1
#DEFINE DRAW_FIRE_VISIBLE 2
#DEFINE DRAW_FIRE_TARGETED 3
#DEFINE DRAW_RED 4
#DEFINE DRAW_YELLOW 5
#DEFINE DRAW_REMOVE 6

SUB DrawUnit(unit AS UBYTE, mode AS UBYTE)

    IF mode = DRAW_REMOVE THEN 
        PAPER 0
        PRINT AT unitStat(unit,UN_Y),unitStat(unit,UN_X);" "
        RETURN
    END IF
    IF unitStat(unit,UN_STATUS) = DEAD THEN RETURN  ' if unit is dead, don't draw it
    IF mode = DRAW_NORMAL AND unitStat(unit, UN_FACTION) = 0 THEN INK 4
    IF mode = DRAW_NORMAL AND unitStat(unit, UN_FACTION) = 1 THEN INK 2
    IF mode = DRAW_FIRE_NOT_VISIBLE THEN INK 1
    IF mode = DRAW_FIRE_VISIBLE THEN INK 5

    PRINT AT unitStat(unit,UN_Y),unitStat(unit,UN_X);CHR$(144 + unitStat(unit, UN_ICON))
END SUB