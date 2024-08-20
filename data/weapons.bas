#DEFINE WPN_AP 0
#DEFINE WPN_RANGE 1
#DEFINE WPN_DAMAGE_MIN 2
#DEFINE WPN_DAMAGE_MAX 3

DIM weaponStat(2,3) AS UBYTE = { _
    { 3,5,2,3 }, _
    { 6,8,4,6 }, _
    { 8,10,4,8 } }

DIM weaponName(2) AS STRING

weaponName(0) = "pistol"
weaponName(1) = "minigun"
weaponName(2) = "rifle"
