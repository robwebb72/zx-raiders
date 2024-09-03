#DEFINE WPN_AP 0
#DEFINE WPN_RANGE_MAX 1
#DEFINE WPN_DAMAGE_MIN 2
#DEFINE WPN_DAMAGE_MAX 3
#DEFINE WPN_RANGE_SHORT 4
#DEFINE WPN_RANGE_MID 5

DIM weaponStat(2,5) AS UBYTE = { _
    { 3, 6,2,3,    3, 6    }, _
    { 6, 9,4,6,    3, 6    }, _
    { 8,12,4,8,    4, 8    } }

DIM weaponName(2) AS STRING

weaponName(0) = "pistol"
weaponName(1) = "minigun"
weaponName(2) = "rifle"

' MODS Pistol  10%, -10%, -10%,   3-4, 1-2, 0-0
'      Minigun  5%, 0%, -20%      5-9, 3-6, 2-4
'      Rifle   -5%, 10%, 10%      5-7, 5-7, 4-6
'
'
'  pistol,  3,   3, 110, 3, 4,   6, 90, 1, 2,   6,  0, 0, 0
'  minigun, 6,   3, 105, 6, 8,   6,100, 3, 6,   9, 80, 2, 4
'  rifle,   8,   4,  90, 5, 7,   6,120, 5, 7,   8,110, 3, 6
'
