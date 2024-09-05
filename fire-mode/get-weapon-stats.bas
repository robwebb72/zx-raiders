DIM weaponId AS UBYTE

FUNCTION ChanceToHit(target as UBYTE) AS UBYTE
    DIM modifier AS UBYTE
    DIM result AS BYTE

    IF rangeLevel(target)=1 THEN modifier = weaponStat(weaponId,WPN_ACC_MOD_SHORT)
    IF rangeLevel(target)=2 THEN modifier = weaponStat(weaponId,WPN_ACC_MOD_MID)
    IF rangeLevel(target)=3 THEN modifier = weaponStat(weaponId,WPN_ACC_MOD_LONG)   
    result = unitStat(currentUnit,UN_ACCURACY) + modifier

    if result<5 THEN RETURN 5
    if result>95 THEN RETURN 95
    RETURN result
END FUNCTION

FUNCTION GetMinDamage(target as UBYTE) AS UBYTE
    IF rangeLevel(target)=1 THEN RETURN weaponStat(weaponId,WPN_DAMAGE_MIN_SHORT)
    IF rangeLevel(target)=2 THEN RETURN weaponStat(weaponId,WPN_DAMAGE_MIN_MID)   
    RETURN weaponStat(weaponId,WPN_DAMAGE_MIN)
END FUNCTION

FUNCTION GetMaxDamage(target as UBYTE) AS UBYTE
    IF rangeLevel(target)=1 THEN RETURN weaponStat(weaponId,WPN_DAMAGE_MAX_SHORT)
    IF rangeLevel(target)=2 THEN RETURN weaponStat(weaponId,WPN_DAMAGE_MAX_MID)   
    RETURN weaponStat(weaponId,WPN_DAMAGE_MAX)
END FUNCTION


