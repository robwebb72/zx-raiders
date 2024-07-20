#DEFINE DIR_NONE 0
#DEFINE DIR_W 1
#DEFINE DIR_E 2
#DEFINE DIR_N 4
#DEFINE DIR_S 8
#DEFINE DIR_NW 5
#DEFINE DIR_NE 6
#DEFINE DIR_SW 9
#DEFINE DIR_SE 10

#DEFINE ASCII_Q 81
#DEFINE ASCII_W 87
#DEFINE ASCII_E 69
#DEFINE ASCII_A 65
#DEFINE ASCII_D 68
#DEFINE ASCII_Z 90
#DEFINE ASCII_X 88
#DEFINE ASCII_C 67


FUNCTION CheckKeyForMovement(key as UBYTE) AS UBYTE

    IF key>96 THEN key=key-32
    IF key=ASCII_Q THEN RETURN DIR_NE
    IF key=ASCII_W THEN RETURN DIR_N
    IF key=ASCII_E THEN RETURN DIR_NW
    IF key=ASCII_A THEN RETURN DIR_E
    IF key=ASCII_D THEN RETURN DIR_W
    IF key=ASCII_Z THEN RETURN DIR_SE
    IF key=ASCII_X THEN RETURN DIR_S
    IF key=ASCII_C THEN RETURN DIR_SW

    RETURN DIR_NONE
END FUNCTION

FUNCTION GetDx(dir as UBYTE) AS BYTE
    IF (dir bAND DIR_E)>0 THEN RETURN -1
    IF (dir bAND DIR_W)>0 THEN RETURN 1
    RETURN 0
END FUNCTION

FUNCTION GetDy(dir as UBYTE) AS BYTE
    IF (dir bAND DIR_N)>0 THEN RETURN -1
    IF (dir bAND DIR_S)>0 THEN RETURN 1
    RETURN 0
END FUNCTION

FUNCTION CheckMapBounds(dx as BYTE, dy as BYTE, currentUnit as UBYTE) AS UBYTE
    IF dx=-1 and unitStat(currentUnit,UN_X)=0 RETURN 0
    IF dy=-1 and unitStat(currentUnit,UN_Y)=0 RETURN 0
    IF dx=1 and unitStat(currentUnit,UN_X)=31 RETURN 0
    IF dy=1 and unitStat(currentUnit,UN_Y)=19 RETURN 0
    RETURN 1
END FUNCTION

SUB MoveUnit(direction as UBYTE, currentUnit as UBYTE)

    DIM dx, dy AS BYTE
    DIM nx, ny AS UBYTE
    DIM onMap AS UBYTE
    DIM apCost AS UBYTE = 2
    
    dx = GetDx(direction)
    dy = GetDy(direction)

    IF dx=0 and dy=0 THEN RETURN
    IF (dx*dy)<>0 THEN apCost = 3

    IF(apCost>unitStat(currentUnit, UN_AP)) THEN RETURN    

    onMap = CheckMapBounds(dx, dy, currentUnit)
    IF onMap = 0 THEN
        BEEP 0.1,1
        RETURN
    ENDIF
            
    nx = unitStat(currentUnit,UN_X) + dx
    ny = unitStat(currentUnit,UN_Y) + dy
    IF map(ny,nx)<>0 THEN
        BEEP 0.1,1
        RETURN
    ENDIF
    
    map(unitStat(currentUnit,UN_Y), unitStat(currentUnit,UN_X)) = 0
    
    DrawUnit(currentUnit, DRAW_REMOVE)
    unitStat(currentUnit,UN_X) = nx
    unitStat(currentUnit,UN_Y) = ny
    DrawUnit(currentUnit, DRAW_NORMAL)
    map(unitStat(currentUnit,UN_Y), unitStat(currentUnit,UN_X)) = currentUnit+1

    unitStat(currentUnit, UN_AP) = unitStat(currentUnit, UN_AP) - apCost
    PrintAP(currentUnit)
END SUB