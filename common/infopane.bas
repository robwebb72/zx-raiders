
DIM _ip_blankLine AS STRING

_ip_blankLine = "                                "


FUNCTION PadNumericString(value as UBYTE) AS STRING
    IF value<10 THEN RETURN " " + STR(value)
    RETURN STR(value)
END FUNCTION


FUNCTION CreateStatString(currentValue as UBYTE, originalValue as UBYTE) AS STRING

    RETURN PadNumericString(currentValue) + "/" + PadNumericString(originalValue)
END FUNCTION


SUB InfoPaneStartTurn()

    INK 6 : PAPER 1
    ClearInfoBar()
    ClearInfoPane()
    IF player=0 THEN
        PRINT AT 21,12;"RAIDERS"
        BEEP 0.5, 3
    ELSE
        PRINT AT 21,12;"MARSEC"
        BEEP 0.5, 1
    ENDIF
    PRINT AT 22,12;"TURN: " + Str(turnCounter)
    PAPER 0
    InfoBarWait()
    ClearInfoPane()
END SUB

SUB PrintWeaponInfo()
    DIM weaponId AS UBYTE
    weaponId = unitStat(currentUnit, UN_WEAPON)
    PRINT AT 21,17;weaponName(weaponId);" (";weaponStat(weaponId,WPN_AP);" AP)";   
END SUB


SUB PrintUnitInfo()
    INK 6 : PAPER 0 : ClearInfoPane()
    
    PRINT AT 21,0;unitName(currentUnit);  
    PrintWeaponInfo()
    PrintAP()
    PrintHP()
END SUB


SUB PrintAP()
    INK 6 : PAPER 0
    PRINT AT 22,0;"AP:";CreateStatString(unitStat(currentUnit,UN_AP),unitStat(currentUnit,UN_TOTAL_AP))
END SUB


SUB PrintHP()
    INK 6 : PAPER 0
    PRINT AT 22,17;"HP:";CreateStatString(unitStat(currentUnit,UN_HP),unitStat(currentUnit,UN_TOTAL_HP))
END SUB


SUB ClearInfoPane()
    PRINT AT 21,0;_ip_blankLine;
    PRINT AT 22,0;_ip_blankLine;
    PRINT AT 23,0;_ip_blankLine;
END SUB


SUB PrintFireInfo(target as UBYTE)
    INK 6 : PAPER 0 : ClearInfoPane()
    
    PRINT AT 21,0;unitName(currentUnit);
    PrintWeaponInfo()
    PrintAP()
    INK 5
    PRINT AT 23,0;unitName(target);
    PRINT AT 23,17;"HP:";unitStat(target,UN_HP);" ";

END SUB