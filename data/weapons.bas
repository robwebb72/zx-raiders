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
'      Minigun  5%, 0%, -20%      6-8, 3-6, 3-6
'      Rifle   -5%, 10%, 10%      5-7, 5-7, 4-7
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
