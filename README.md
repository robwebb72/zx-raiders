# zx-raiders

A simple turn based tactical game on the ZX Spectrum, using Boriel's ZX Basic

## Instructions (WIP)

## BACKGROUND

As Earth tightens it's grip on the Martian economy many Earth corporations take
control of Martian companies, the most notable being Mars Securities.

With Mars Securities cracking down on the basic rights of Martian civilians an
uprising was certain.  This was lead by the charismatic leader Nye Lassan.  
MarSec moves swiftly to quell the uprising and Nye Lassan is arrested.

Two of Lassan's friends, Kaiser Krenon and Venus Starfire gather what remains of Lassan's supporters and plan to free Lassan.

The first task is to capture outpost CI-89, an old geological research station
owned by MarSec.  The outpost should be poorly defended and more importantly has
an old network hardpoint that the Raiders can use to find where Lassan is being 
held.

## THE GAME

// TODO

### THE TROOPS

// TODO

#### ACTION POINTS (APs)

Every unit has a number of action points.  
// TODO

#### HIT POINTS (HPs)

Each unit has a number of hit points.  This indicates how much damage they can
take before the unit is incapacitated.  When a unit takes damage it's HP count
is reduced.  When the HP count reaches 0 the unit is out of action.

### VICTORY

Victory is achieved when either side kills all the opposing faction's troops.

### MOVE MODE

// TODO

#### move mode - key commands

Q - move up and left
W - move up
E - move up and right
A - move left
D - move right
Z - move down and left
X - move down
C - move down and right

F - fire mode
N - select next unit
0 - end turn

### FIRE MODE

If there are no visible enemies in range of the current unit's weapon a message
will appear and fire mode will be cancelled.

If the current unit doesn't have enough AP to fire their weapon, a message will
appear and fire mode will be cancelled.

#### fire mode - key commands

N - cycle through all available targets
1 - fire at highlighted target
K - cancel fire mode
