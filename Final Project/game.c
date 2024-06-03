#include <stdlib.h>
#include "mode0.h"
#include "print.h"
#include "game.h"
#include <string.h>

int submarineMaxHp;
int submarineHp;
int gameVictory;

COMBATANT CBT_FISH = { "FISH", 1, 10, 10, 3, { &MOVE_NIBBLE, &MOVE_FLAIL, &MOVE_REGEN, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(0, 18) };
COMBATANT CBT_SHARK = { "SHARK", 1, 16, 16, 2, { &MOVE_STRIKE, &MOVE_SHEAL, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(0, 22) };
COMBATANT CBT_ANGLER = { "ANGLER", 1, 24, 24, 3, { &MOVE_BITE, &MOVE_LHEAL, &MOVE_LHEALBURST, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(4, 20) };
COMBATANT CBT_PUFFER = { "PUFFER", 1, 28, 28, 3, { &MOVE_NIBBLE, &MOVE_PUFFUP, &MOVE_SHEALBURST, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(4, 22) };
COMBATANT CBT_BARRACUDA = { "BARRACUDA", 1, 14, 14, 2, { &MOVE_BITE, &MOVE_DASH, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(0, 20) };
COMBATANT CBT_GOD = { "TUNA GOD", 1, 60, 60, 6, { &MOVE_BITE, &MOVE_SLASH, &MOVE_RESOLVE, &MOVE_LHEALBURST, &MOVE_WAVE, &MOVE_TRANSCEND }, ATTR2_TILEID64(8, 26) };
COMBATANT CBT_SUBMARINE = { "SUBMARINE", 1, 20, 20, 3, { &MOVE_TORPEDO1, &MOVE_SHIELD1, &MOVE_BLAST1, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(0, 16) };
COMBATANT CBT_NONE = { "NONE", 0, 0, 0, 0, { &MOVE_NONE, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE, &MOVE_NONE }, ATTR2_TILEID64(0, 16) }; 

COMBATANT battleAllies[4];
COMBATANT battleOpponents[4];

int cheater = 0;

// Initialize the game
void initGame() {
    cheater = 0;
    submarineMaxHp = 100;
    submarineHp = submarineMaxHp;
    gameVictory = 0;
    initParty();
}

// Set up the default player party
void initParty() {
    battleAllies[0] = CBT_SUBMARINE;
    battleAllies[0].hp = battleAllies[0].maxHp;
    battleAllies[1] = CBT_FISH;
    battleAllies[1].hp = battleAllies[1].maxHp;
    strncpy(battleAllies[1].name, "BUDDY", NAME_LEN); // Give the starting ally a fun name
    battleAllies[2] = CBT_NONE;
    battleAllies[3] = CBT_NONE;
}

// Returns the number of tiles to be red in a section of the healthbar
int tilesRed(int tile1, int hp, int maxHp, int segments) {
    if (hp > (((tile1) * maxHp) / segments)) {
        if (hp > (((tile1+1) * maxHp) / segments)) {
            if (hp > (((tile1+2) * maxHp) / segments)) {
                if (hp > (((tile1+3) * maxHp) / segments)) {
                    return 4;
                } else {
                    return 3;
                }
            } else {
                return 2;
            }
        } else {
            return 1;
        }
    } else {
        return 0;
    }
}
