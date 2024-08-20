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


DIM unitStat(NUMBER_OF_UNITS-1,12) AS UBYTE = { _
    { 0,2,2,12,16,60,  2, 3,1,0,0,0,0 }, _
    { 0,1,0,12,16,40,  1, 2,1,0,0,0,0 }, _
    { 0,1,0, 8,12,40,  1, 3,1,0,0,0,0 }, _
    { 0,0,2, 8,12,30,  1, 4,1,0,0,0,0 }, _
    { 0,2,1, 6,12,50,  1,17,1,0,0,0,0 }, _
    { 0,1,0, 5,12,40,  2,16,1,0,0,0,0 }, _
    { 0,0,2, 5,10,30,  2,15,1,0,0,0,0 }, _
    { 0,0,2, 5,10,50,  1,16,1,0,0,0,0 }, _
    { 1,5,1,10,12,60,  28, 3,1,0,0,0,0 }, _
    { 1,4,0, 8,12,40,  29, 4,1,0,0,0,0 }, _
    { 1,4,0, 8,10,40,  28, 5,1,0,0,0,0 }, _
    { 1,5,1, 8,10,50,  13,16,1,0,0,0,0 }, _
    { 1,3,2, 8,12,30,  10,16,1,0,0,0,0 }, _ 
    { 1,3,2, 4,12,30,  21,15,1,0,0,0,0 }, _
    { 1,4,0, 4,12,30,  20,16,1,0,0,0,0 }, _
    { 1,4,0, 4,12,30,  22,17,1,0,0,0,0 } }


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