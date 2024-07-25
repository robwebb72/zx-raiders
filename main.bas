#define __ZXB_DISABLE_BOLD
#define __ZXB_DISABLE_ITALIC
#define __ZXB_DISABLE_SCROLL

'= DEFINES ====================================================================
#include "global_defines.bas"

'= DATA =======================================================================
#include "data/units.bas"
#include "data/weapons.bas"
#include "data/map.bas"

'= GLOBALS ====================================================================
DIM winner AS UBYTE
DIM turnCounter AS UBYTE
DIM player AS UBYTE

'= GRAPHICS ===================================================================
#include "udgs/raiders.udg.bas"
POKE (uinteger 23675, @raiders)

'= FUNCTIONS ==================================================================
#include "functions/infopane.bas"
#include "functions/infobar.bas"
#include "functions/draw_unit.bas"
#include "functions/blinker.bas"
#include "functions/inputs.bas"
#include "functions/random.bas"

'= MODULES ====================================================================
#include "menu.bas"
#include "game_initialise.bas"
#include "game.bas"

DO
    Menu()
    InitialiseGame()
    RunGame()
    WaitForKeyRelease()

LOOP
