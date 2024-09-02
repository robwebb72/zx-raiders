#DEFINE UN_FACTION 0
#DEFINE UN_ICON 1
#DEFINE UN_WEAPON 2
#DEFINE UN_TOTAL_HP 3
#DEFINE UN_TOTAL_AP 4
#DEFINE UN_ACCURACY 5
#DEFINE UN_X_START 6
#DEFINE UN_Y_START 7
#DEFINE UN_STATUS 8
#DEFINE UN_AP 9
#DEFINE UN_HP 10
#DEFINE UN_X 11
#DEFINE UN_Y 12

#DEFINE NUMBER_OF_UNITS 16
#DEFINE ALIVE 1
#DEFINE DEAD 0
#DEFINE RAIDERS 0
#DEFINE MARSEC 1

DIM unitStat(NUMBER_OF_UNITS-1,12) AS UBYTE = { _
    { RAIDERS,   2,1,     12,  16,     60,     2,  3,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   0,2,     12,  16,     40,     1,  2,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   1,0,      8,  12,     40,     1,  3,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   0,2,      8,  12,     30,     1,  4,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   2,1,      6,  12,     50,    17, 17,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   1,0,      5,  12,     40,     2, 16,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   0,2,      5,  10,     60,     2, 15,    ALIVE ,0,0,0,0 }, _
    { RAIDERS,   0,2,      5,  10,     60,     1, 16,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    5,1,     10,  12,     60,    28,  3,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    4,0,      8,  12,     40,    29,  4,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    4,0,      8,  10,     40,    28,  5,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    5,1,      8,  10,     50,    13, 16,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    3,2,      8,  12,     30,    10, 16,    ALIVE ,0,0,0,0 }, _ 
    { MARSEC,    3,2,      4,  12,     30,    21, 15,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    3,2,      4,  12,     30,    20, 16,    ALIVE ,0,0,0,0 }, _
    { MARSEC,    3,2,      4,  12,     30,    22, 17,    ALIVE ,0,0,0,0 } }


' troop types
' - private
'    - low ap (8) - can move a square and fire a rifle
'    - low hp (6-8)  - a shot from a rifle will most likely kill them
'    - rifle or pistol
'
' - captains
'    - rifle, pistol or minigun
'    - moderate ap (10-12) - can move two squares and fire a rifle
'    - moderate hp - can survive a rifle shot, but not two
'
'
' - heroes
'    - rifle or minigun
'    - high ap (12-16) - can move three or four squares and fire a rifle
'    - very high hp - can survive two rifle shots and still fight

DIM unitName(15) AS STRING

unitName(0) = "Kaiser Krenon"
unitName(1) = "Una Darkstar"
unitName(2) = "Conrad Bastaple"
unitName(3) = "Dante Smith"
unitName(4) = "Venus Starfire"
unitName(5) = "Eliza Hicks"
unitName(6) = "Joe Phoenix"
unitName(7) = "Cassie Blaze"
unitName(8) = "Agent Brown"
unitName(9) = "Agent Donohue"
unitName(10) = "Agent Wilson"
unitName(11) = "Xuili Chase"
unitName(12) = "John Kano"
unitName(13) = "Gunther"
unitName(14) = "Dave Fury"
unitName(15) = "Bobbie Blaze"