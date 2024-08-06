
DIM _ip_blankLine AS STRING

_ip_blankLine = "                                "


FUNCTION PadNumericString(value as UBYTE) AS STRING
    IF value<10 THEN RETURN " " + STR(value)
    RETURN STR(value)
END FUNCTION


FUNCTION CreateStatString(name as STRING, currentValue as UBYTE, originalValue as UBYTE) AS STRING
    DIM output, current, original AS STRING
    
    current = PadNumericString(currentValue)
    original = PadNumericString(originalValue)
    output = name + current + "/" + original
    RETURN output  
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


SUB PrintUnitInfo()
    DIM weaponId AS UBYTE
    
    INK 6 : PAPER 0 : ClearInfoPane()
    
    PRINT AT 21,0;unitName(currentUnit);  
    PrintAP()
    PrintHP()

    weaponId = unitStat(currentUnit, UN_WEAPON)
    PRINT AT 21,20;weaponName(weaponId);
    PRINT AT 22,20;weaponStat(weaponId,WPN_AP);" AP to fire";   
END SUB


SUB PrintAP()
    INK 6 : PAPER 0
    PRINT AT 22,0;CreateStatString("AP:",unitStat(currentUnit,UN_AP),unitStat(currentUnit,UN_TOTAL_AP))
END SUB


SUB PrintHP()
    INK 6 : PAPER 0
    PRINT AT 23,0;CreateStatString("HP:",unitStat(currentUnit,UN_HP),unitStat(currentUnit,UN_TOTAL_HP))
END SUB


SUB ClearInfoPane()
    PRINT AT 21,0;_ip_blankLine;
    PRINT AT 22,0;_ip_blankLine;
    PRINT AT 23,0;_ip_blankLine;
END SUB


