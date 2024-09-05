#DEFINE WPN_AP 0
#DEFINE WPN_RANGE_MAX 1
#DEFINE WPN_DAMAGE_MIN 2
#DEFINE WPN_DAMAGE_MAX 3
#DEFINE WPN_RANGE_SHORT 4
#DEFINE WPN_RANGE_MID 5
#DEFINE WPN_ACC_MOD_SHORT 6
#DEFINE WPN_ACC_MOD_MID 7
#DEFINE WPN_ACC_MOD_LONG 8

#DEFINE WPN_DAMAGE_MIN_SHORT 9
#DEFINE WPN_DAMAGE_MAX_SHORT 10

#DEFINE WPN_DAMAGE_MIN_MID 11
#DEFINE WPN_DAMAGE_MAX_MID 12


DIM weaponStat(2,12) AS BYTE = { _
    { 3, 6,0,0,    3, 6,  10, -10, -10,    3,4,     1,2  }, _
    { 6, 9,2,4,    3, 6,  10,   0, -20,    5,9,     3,6  }, _
    { 8,12,5,7,    4, 8,  -5,  10,  10,    5,7,     4,6  } }

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
