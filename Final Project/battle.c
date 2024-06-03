#include <stdlib.h>
#include <stdio.h>
#include "print.h"
#include "battle.h"
#include <string.h>
#include "sound.h"
#include "damagesfx.h"
#include "fanfaresfx.h"
#include "menuhighsfx.h"
#include "menulowsfx.h"

// Take the character and subtract CHAR_START. -1 is invalid
const int text_tile_lkup[] = {TILE_EXCLAMATION,TILE_QUOTE,TILE_POUND,TILE_CURRENCY,
TILE_PERCENT,TILE_AMPERSAND,TILE_APOSTROPHE,TILE_LPARANTHESIS,TILE_RPARANTHESIS,
TILE_ASTERISK,TILE_PLUS,TILE_COMMA,TILE_MINUS,TILE_PERIOD,TILE_FSLASH,TILE_0,TILE_1,
TILE_2,TILE_3,TILE_4,TILE_5,TILE_6,TILE_7,TILE_8,TILE_9,TILE_COLON,TILE_SEMICOLON,
TILE_LANGLED,TILE_EQUAL,TILE_RANGLED,TILE_QUESTION,TILE_AT,TILE_A,TILE_B,TILE_C,TILE_D,
TILE_E,TILE_F,TILE_G,TILE_H,TILE_I,TILE_J,TILE_K,TILE_L,TILE_M,TILE_N,TILE_O,TILE_P,
TILE_Q,TILE_R,TILE_S,TILE_T,TILE_U,TILE_V,TILE_W,TILE_X,TILE_Y,TILE_Z,TILE_LSQUARE,
TILE_BSLASH,TILE_RSQUARE,TILE_CARROT,TILE_UNDERSCORE,TILE_GRAVE};

int lettersActive; // Used internally by text functions

int battleStatus;
int turn;
int targetTeam; // Team the targeting menu is targeting
COMBATANT* fighter; // Combatant whose turn it is
int fighterIdx;
MOVE* move; // The move to be executed
int turnPoints;
int nextTurnPoints;
int nextFighterIdx;
int nextTurn;
COMBATANT* captured;
// Menu tracking
int menu;
int selOpt;
int numOpt;
int waiting;
// Player input variables
int enter;
int leave;
// Character buffers for displaying text
char topBuf[63];
char botBuf[63];
// Boss battle flag
int bossBattle;

// Sets up the battle state
void initBattle(int opponentType) {
    battleStatus = ONGOING;
    lettersActive = 0;
    goToFrontMenu();
    waiting = 0;
    enter = 0;
    leave = 0;
    topBuf[0] = '\0';
    botBuf[0] = '\0';

    turn = PLAYERTURN;
    fighter = &battleAllies[0];
    fighterIdx = 0;
    captured = NULL;
    move = NULL;
    turnPoints = 0;
    for (int i = 0; i < 4; i++) {
        if (battleAllies[i].exists && battleAllies[i].hp > 0) {
            turnPoints++;
        }
    }

    nextTurnPoints = turnPoints;
    nextFighterIdx = fighterIdx;
    nextTurn = turn;
    REG_TM2CNT = TIMER_OFF;

    bossBattle = 0;

    resetOpponents();
    // Figure out who started the fight and put them on the enemy team
    switch (opponentType)
    {
    case FISH:
        battleOpponents[0] = CBT_FISH;
        battleOpponents[1] = CBT_FISH;
        battleOpponents[2] = CBT_NONE;
        battleOpponents[3] = CBT_NONE;
        break;
    case SHARK:
        battleOpponents[0] = CBT_SHARK;
        battleOpponents[1] = CBT_SHARK;
        battleOpponents[2] = CBT_FISH;
        battleOpponents[3] = CBT_NONE;
        break;
    case ANGLER:
        battleOpponents[0] = CBT_ANGLER;
        battleOpponents[1] = CBT_SHARK;
        battleOpponents[2] = CBT_SHARK;
        battleOpponents[3] = CBT_FISH;
        break;
    case PUFFER:
        battleOpponents[0] = CBT_PUFFER;
        battleOpponents[1] = CBT_SHARK;
        battleOpponents[2] = CBT_FISH;
        battleOpponents[3] = CBT_FISH;
        break;
    case BARRACUDA:
        battleOpponents[0] = CBT_BARRACUDA;
        battleOpponents[1] = CBT_BARRACUDA;
        battleOpponents[2] = CBT_SHARK;
        battleOpponents[3] = CBT_FISH;
        break;
    case BOSS:
        bossBattle = 1; // IMPORTANT! This is a boss battle!
        battleOpponents[0] = CBT_GOD;
        battleOpponents[1] = CBT_BARRACUDA;
        battleOpponents[2] = CBT_PUFFER;
        battleOpponents[3] = CBT_SHARK;
        break;
    default:
        battleOpponents[0] = CBT_FISH;
        battleOpponents[1] = CBT_NONE;
        battleOpponents[2] = CBT_NONE;
        battleOpponents[3] = CBT_NONE;
        break;
    }
    // Then draw the teams
    drawCombatants();
}

void goToFrontMenu() {
    menu = FRONTMENU;
    numOpt = 4;
    selOpt = 0;
}

void goToAttackMenu() {
    menu = ATTACKMENU;
    numOpt = fighter->numMoves;
    selOpt = 0;
}

void goToTargetMenu() {
    menu = TARGETMENU;
    numOpt = 4;
    if (targetTeam == ENEMYTEAM) {
        for (int i = 0; i < 4; i++) {
            if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                selOpt = i;
                break;
            }
        }
    } else {
        for (int i = 0; i < 4; i++) {
            if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                selOpt = i;
                break;
            }
        }
    }
    
}

void goToInspectMenu() {
    menu = INSPECTMENU;
    numOpt = 4;
    for (int i = 0; i < 4; i++) {
        if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
            selOpt = i;
            break;
        }
    }
    targetTeam = ENEMYTEAM;
}

void goToCaptureMenu() {
    menu = CAPTUREMENU;
    numOpt = 4;
    for (int i = 0; i < 4; i++) {
        if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
            selOpt = i;
            break;
        }
    }
    targetTeam = ENEMYTEAM;
}

void goToReplaceMenu() {
    menu = REPLACEMENU;
    numOpt = 3;
    selOpt = 0;
    targetTeam = PLAYERTEAM;
}

void replaceMenu() {
    int realOpt = selOpt + 1;
    sprintf(topBuf, "YOU CAPTURED A\n%s! SELECT\nAN ALLY TO REPLACE.", captured->name);
    shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * realOpt) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
    shadowOAM[TARGETING_ARROW].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
    shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
    sprintf(botBuf, "%s:%d/%d", battleAllies[realOpt].name, battleAllies[realOpt].hp, battleAllies[realOpt].maxHp);
    if (leave) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        sprintf(topBuf, "YOU RELEASED\n%s.", captured->name);
        captured->exists = 0;
        finishTurn();
    } else if (enter) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        botBuf[0] = '\0';
        sprintf(topBuf, "%s REPLACED\n%s.", captured->name, battleAllies[realOpt].name);
        battleAllies[realOpt] = *captured; // Copy captured into battleAllies
        captured->exists = 0; // disable the original captured
        // Heal up the new teammate a little to make things fair
        if (battleAllies[realOpt].hp < battleAllies[realOpt].maxHp / 2) battleAllies[realOpt].hp = battleAllies[realOpt].maxHp / 2;
        finishTurn();
    }
}

void captureMenu() {
    strncpy(topBuf, "CHOOSE AN OPPONENT\nTO CAPTURE.", 61);
    shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * selOpt) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
    shadowOAM[TARGETING_ARROW].attr1 = (192 & COLMASK) | ATTR1_TINY;
    shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
    sprintf(botBuf, "%s:%d/%d", battleOpponents[selOpt].name, battleOpponents[selOpt].hp, battleOpponents[selOpt].maxHp);

    if (leave) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        goToFrontMenu();
    } else if (enter) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        botBuf[0] = '\0';
        if (bossBattle) {
            sprintf(topBuf, "YOU CANNOT\nCAPTURE SUCH A\nFIERCE OPPONENT!");
            finishTurn();
        } else {
            // The chance of our success is the percent of missing health
            int r = rand() % (battleOpponents[selOpt].maxHp);
            if (battleOpponents[selOpt].hp < r) {
                captured = &battleOpponents[selOpt];
                goToReplaceMenu();
            } else {
                sprintf(topBuf, "YOU FAILED TO\nCAPTURE %s.", battleOpponents[selOpt].name);
                finishTurn();
            }
        }
    }
}

void inspectMenu() {
    strncpy(topBuf, "CHOOSE A COMBATANT\nTO INSPECT.", 61);
    if (targetTeam == ENEMYTEAM) {
        shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * selOpt) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
        shadowOAM[TARGETING_ARROW].attr1 = (192 & COLMASK) | ATTR1_TINY;
        shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
        sprintf(botBuf, "%s:%d/%d", battleOpponents[selOpt].name, battleOpponents[selOpt].hp, battleOpponents[selOpt].maxHp);
    } else {
        shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * selOpt) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
        shadowOAM[TARGETING_ARROW].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
        shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
        sprintf(botBuf, "%s:%d/%d", battleAllies[selOpt].name, battleAllies[selOpt].hp, battleAllies[selOpt].maxHp);
    }

    if (leave) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        goToFrontMenu();
    }
}

void frontMenu() {
    strncpy(topBuf, "WHAT WILL YOU DO?", 61);
    sprintf(botBuf, "%cATTACK   %cCAPTURE\n%cPASS\n%cINSPECT", tsel(selOpt == 0), tsel(selOpt == 3), tsel(selOpt == 1), tsel(selOpt == 2));
    if (enter) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        switch (selOpt)
        {
        case 0:
            goToAttackMenu();
            break;
        case 1:
            sprintf(topBuf, "%s PASSED.", fighter->name);
            botBuf[0] = '\0';
            finishTurn();
            break;
        case 2:
            goToInspectMenu();
            break;
        case 3:
            goToCaptureMenu();
            break;
        }
    }
}

void attackMenu() {
    strncpy(topBuf, "CHOOSE AN ATTACK.", 61);
    sprintf(botBuf, "%c%-9s%c%-9s%c%-9s%c%-9s%c%-9s%c%-9s", 
            tsel(selOpt == 0), fighter->moves[0]->text, tsel(selOpt == 3), fighter->moves[3]->text,
            tsel(selOpt == 1), fighter->moves[1]->text, tsel(selOpt == 4), fighter->moves[4]->text,
            tsel(selOpt == 2), fighter->moves[2]->text, tsel(selOpt == 5), fighter->moves[5]->text);
    if (leave) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        goToFrontMenu();
    } else if (enter) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        move = fighter->moves[selOpt];
        targetTeam = move->targeting == OPPONENT ? ENEMYTEAM : PLAYERTEAM;
        goToTargetMenu();
    }
}

void targetMenu() {
    strncpy(topBuf, "CHOOSE A TARGET.", 61);
    // These four special moves only target self, so we need to override selOpt
    if (move == &MOVE_REGEN || move == &MOVE_RESOLVE || move == &MOVE_DASH || move == &MOVE_TRANSCEND) {
        selOpt = fighterIdx; // set to the current actor. hit all should already be false
    }
    if (targetTeam == ENEMYTEAM) {
        if (move->hitAll) {
            if (battleOpponents[0].exists && battleOpponents[0].hp > 0) {
                shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * 0) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW].attr1 = (192 & COLMASK) | ATTR1_TINY;
                shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
            }
            if (battleOpponents[1].exists && battleOpponents[1].hp > 0) {
                shadowOAM[TARGETING_ARROW + 1].attr0 = ((15 + 40 * 1) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW + 1].attr1 = (192 & COLMASK) | ATTR1_TINY;
                shadowOAM[TARGETING_ARROW + 1].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW + 1].attr0 = ATTR0_HIDE;
            }
            if (battleOpponents[2].exists && battleOpponents[2].hp > 0) {
                shadowOAM[TARGETING_ARROW + 2].attr0 = ((15 + 40 * 2) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW + 2].attr1 = (192 & COLMASK) | ATTR1_TINY;
                shadowOAM[TARGETING_ARROW + 2].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW + 2].attr0 = ATTR0_HIDE;
            }
            if (battleOpponents[3].exists && battleOpponents[3].hp > 0) {
                shadowOAM[TARGETING_ARROW + 3].attr0 = ((15 + 40 * 3) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW + 3].attr1 = (192 & COLMASK) | ATTR1_TINY;
                shadowOAM[TARGETING_ARROW + 3].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW + 3].attr0 = ATTR0_HIDE;
            }
            sprintf(botBuf, "%s WILL AFFECT\nALL ENEMIES", move->text);
        } else {
            shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * selOpt) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
            shadowOAM[TARGETING_ARROW].attr1 = (192 & COLMASK) | ATTR1_TINY;
            shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
            sprintf(botBuf, "%s:%d/%d", battleOpponents[selOpt].name, battleOpponents[selOpt].hp, battleOpponents[selOpt].maxHp);
        }
    } else {
        if (move->hitAll) {
            if (battleAllies[0].exists && battleAllies[0].hp > 0) {
                shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * 0) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
                shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
            }
            if (battleAllies[1].exists && battleAllies[1].hp > 0) {
                shadowOAM[TARGETING_ARROW + 1].attr0 = ((15 + 40 * 1) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW + 1].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
                shadowOAM[TARGETING_ARROW + 1].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW + 1].attr0 = ATTR0_HIDE;
            }
            if (battleAllies[2].exists && battleAllies[2].hp > 0) {
                shadowOAM[TARGETING_ARROW + 2].attr0 = ((15 + 40 * 2) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW + 2].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
                shadowOAM[TARGETING_ARROW + 2].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW + 2].attr0 = ATTR0_HIDE;
            }
            if (battleAllies[3].exists && battleAllies[3].hp > 0) {
                shadowOAM[TARGETING_ARROW + 3].attr0 = ((15 + 40 * 3) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
                shadowOAM[TARGETING_ARROW + 3].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
                shadowOAM[TARGETING_ARROW + 3].attr2 = ATTR2_TILEID64(0, 26);
            } else {
                shadowOAM[TARGETING_ARROW + 3].attr0 = ATTR0_HIDE;
            }
            sprintf(botBuf, "%s WILL\nAFFECT ALL ALLIES", move->text);
        } else {
            shadowOAM[TARGETING_ARROW].attr0 = ((15 + 40 * selOpt) & ROWMASK) | ATTR0_REGULAR | ATTR0_TALL | ATTR0_8BPP;
            shadowOAM[TARGETING_ARROW].attr1 = (40 & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
            shadowOAM[TARGETING_ARROW].attr2 = ATTR2_TILEID64(0, 26);
            sprintf(botBuf, "%s:%d/%d", battleAllies[selOpt].name, battleAllies[selOpt].hp, battleAllies[selOpt].maxHp);
        }
    }

    if (leave) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        shadowOAM[TARGETING_ARROW + 1].attr0 = ATTR0_HIDE;
        shadowOAM[TARGETING_ARROW + 2].attr0 = ATTR0_HIDE;
        shadowOAM[TARGETING_ARROW + 3].attr0 = ATTR0_HIDE;
        goToAttackMenu();
    } else if (enter) {
        playSoundB(menuhighsfx_data, menuhighsfx_length, 0);
        shadowOAM[TARGETING_ARROW].attr0 = ATTR0_HIDE;
        shadowOAM[TARGETING_ARROW + 1].attr0 = ATTR0_HIDE;
        shadowOAM[TARGETING_ARROW + 2].attr0 = ATTR0_HIDE;
        shadowOAM[TARGETING_ARROW + 3].attr0 = ATTR0_HIDE;
        if (targetTeam == ENEMYTEAM) {
            executeMove(move, &battleOpponents[selOpt]);
        } else {
            executeMove(move, &battleAllies[selOpt]);
        }
    }
}

void executeMove(MOVE* m, COMBATANT* t) {
    mgba_printf("Executing move! Enemy turn: %d, Fighter %s, Target: %s", turn, fighter->name, t->name);
    if (m->healing) { // healing sfx
        playSoundB(fanfaresfx_data, fanfaresfx_length, 0);
    } else {  // hurt sfx
        playSoundB(damagesfx_data, damagesfx_length, 0);
    }
    if (m->hitAll) {
        if (targetTeam == ENEMYTEAM) {
            for (int i = 0; i < 4; i++) {
                // If boss battle, allow reviving of opponenets. The Tuna God is a god after all, he can use necromancy if he wants
                if (battleOpponents[i].exists && (battleOpponents[i].hp > 0 || bossBattle)) {
                    battleOpponents[i].hp -= m->damage;
                    battleOpponents[i].hp += m->healing;
                    if (battleOpponents[i].hp > battleOpponents[i].maxHp) {
                        battleOpponents[i].hp = battleOpponents[i].maxHp;
                    }
                }
            }
        } else {
            for (int i = 0; i < 4; i++) {
                if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                    battleAllies[i].hp -= m->damage;
                    battleAllies[i].hp += m->healing;
                    if (battleAllies[i].hp > battleAllies[i].maxHp) {
                        battleAllies[i].hp = battleAllies[i].maxHp;
                    }
                }
            }
        }
    } else {
        t->hp -= m->damage;
        t->hp += m->healing;
        if (t->hp > t->maxHp) {
            t->hp = t->maxHp;
        }
    }
    if (m == &MOVE_DASH) {
        turnPoints += 2;
        if (turnPoints > 9) turnPoints = 9; // we subtract 1 after this which will make it 8, which is the max
    }
    if (m == &MOVE_TRANSCEND) {
        fighter->hp = fighter->maxHp;
    }
    // We don't want opponents going into negative health. It interferes with the Tuna God's necromantic abilities
    for (int i = 0; i < 4; i++) {
        if (battleOpponents[i].exists && battleOpponents[i].hp < 0) {
            battleOpponents[i].hp = 0;
        }
    }
    
    sprintf(topBuf, m->flavorText, fighter->name, t->name);
    botBuf[0] = '\0';
    // Remove dead allies from the team. Important to do this after printing the names.
    // Ignore the submarine
    for (int i = 1; i < 4; i++) {
        // Permanently kill this ally
        if (battleAllies[i].exists && battleAllies[i].hp <= 0) {
            battleAllies[i] = CBT_NONE;
        }
    }
    
    finishTurn();
}

// Called at the end of every turn
void finishTurn() {
    goToFrontMenu();
    mgba_printf("Ending turn...");
    turnPoints--;
    // Check the interrupt handler for an explanation for what nextTurnPoints is
    nextTurnPoints = turnPoints;
    // Always set these values to something valid otherwise weird things can happen
    nextFighterIdx = fighterIdx;
    nextTurn = turn;

    if (turnPoints == 0) {  // Swap turns
        if (turn == PLAYERTURN) {
            nextTurn = ENEMYTURN;
            for (int i = 0; i < 4; i++) {
                if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                    nextTurnPoints++;
                }
            }
            if (bossBattle) {
                nextTurnPoints += 1; // Bosses get an extra turn
            }
            for (int i = 0; i < 4; i++) {
                if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                    nextFighterIdx = i;
                    fighter = &battleOpponents[i];
                    break;
                }
            }
        } else {
            nextTurn = PLAYERTURN;
            for (int i = 0; i < 4; i++) {
                if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                    nextTurnPoints++;
                }
            }
            for (int i = 0; i < 4; i++) {
                if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                    nextFighterIdx = i;
                    fighter = &battleAllies[i];
                    break;
                }
            }
        }
    } else {  // Move to next fighter in list
        if (turn == PLAYERTURN) {
            for (int i = 1; i < 5; i++) {
                if (battleAllies[(fighterIdx + i) % 4].exists && battleAllies[(fighterIdx + i) % 4].hp > 0) {
                    nextFighterIdx = (fighterIdx + i) % 4;
                    fighter = &battleAllies[nextFighterIdx];
                    break;
                }
            }
        } else {
            for (int i = 1; i < 5; i++) {
                if (battleOpponents[(fighterIdx + i) % 4].exists && battleOpponents[(fighterIdx + i) % 4].hp > 0) {
                    nextFighterIdx = (fighterIdx + i) % 4;
                    fighter = &battleOpponents[nextFighterIdx];
                    break;
                }
            }
        }
    }
    
    waiting = 1;
    REG_TM2CNT = 0;
    REG_TM2D = 0 - (16384 * 2); // wait two seconds
    REG_TM2CNT = TIMER_ON | TM_FREQ_1024 | TM_IRQ;
}

// Checks for victory or failure
void checkBattleStatus() {
    int winTest = 1;
    for (int i = 0; i < 4; i++) {
        if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
            winTest = 0;
            break;
        }
    }
    if (winTest) {
        battleStatus = WON;
        if (bossBattle) {
            gameVictory = 1;
        }
    }
    int loseTest = 1;
    for (int i = 0; i < 4; i++) {
        if (battleAllies[i].exists && battleAllies[i].hp > 0) {
            loseTest = 0;
            break;
        }
    }
    if (loseTest) {
        battleStatus = LOST;
    }
}

// Runs battle
void updateBattle() {
    if (waiting) {
        return;
    }
    checkBattleStatus();
    if (battleStatus != ONGOING) { return; }
    enter = 0;
    leave = 0;
    if (turn == PLAYERTURN) {
        // Get input. Some menus have different logic for this
        if (menu == REPLACEMENU) {
            if (BUTTON_PRESSED(BUTTON_DOWN)) {
                if (selOpt < numOpt - 1) {
                    selOpt += 1;
                    playSoundB(menulowsfx_data, menulowsfx_length, 0);
                }
            } else if (BUTTON_PRESSED(BUTTON_UP)) {
                if (selOpt != 0) {
                    selOpt -= 1;
                    playSoundB(menulowsfx_data, menulowsfx_length, 0);
                }
            }
        } else if (menu == TARGETMENU || menu == INSPECTMENU || menu == CAPTUREMENU) {
            if (BUTTON_PRESSED(BUTTON_DOWN)) {
                if (targetTeam == ENEMYTEAM) {
                    for (int i = selOpt + 1; i < 4; i++) {
                        if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                            selOpt = i;
                            playSoundB(menulowsfx_data, menulowsfx_length, 0);
                            break;
                        }
                    }
                } else {
                    for (int i = selOpt + 1; i < 4; i++) {
                        if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                            selOpt = i;
                            playSoundB(menulowsfx_data, menulowsfx_length, 0);
                            break;
                        }
                    }
                }
            } else if (BUTTON_PRESSED(BUTTON_UP)) {
                if (targetTeam == ENEMYTEAM) {
                    for (int i = selOpt - 1; i >= 0; i--) {
                        if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                            selOpt = i;
                            playSoundB(menulowsfx_data, menulowsfx_length, 0);
                            break;
                        }
                    }
                } else {
                    for (int i = selOpt - 1; i >= 0; i--) {
                        if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                            selOpt = i;
                            playSoundB(menulowsfx_data, menulowsfx_length, 0);
                            break;
                        }
                    }
                }
            }
            if (menu == INSPECTMENU) {
                if (BUTTON_PRESSED(BUTTON_RIGHT) && targetTeam == PLAYERTEAM) {
                    targetTeam = ENEMYTEAM;
                    for (int i = 0; i < 4; i++) {
                        if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                            selOpt = i;
                            playSoundB(menulowsfx_data, menulowsfx_length, 0);
                            break;
                        }
                    }
                } else if (BUTTON_PRESSED(BUTTON_LEFT) && targetTeam == ENEMYTEAM) {
                    targetTeam = PLAYERTEAM;
                    for (int i = 0; i < 4; i++) {
                        if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                            selOpt = i;
                            playSoundB(menulowsfx_data, menulowsfx_length, 0);
                            break;
                        }
                    }
                }
            }
        } else {
            if (BUTTON_PRESSED(BUTTON_DOWN)) {
                if (selOpt < numOpt - 1) {
                    if (selOpt != 2 && selOpt != 5) {
                        selOpt += 1;
                        playSoundB(menulowsfx_data, menulowsfx_length, 0);
                    }
                }
            } else if (BUTTON_PRESSED(BUTTON_UP)) {
                if (selOpt != 0 && selOpt != 3) {
                    selOpt -= 1;
                    playSoundB(menulowsfx_data, menulowsfx_length, 0);
                }
            }
            if (BUTTON_PRESSED(BUTTON_RIGHT)) {
                if (selOpt < numOpt - 3) {
                    if (selOpt < 3) {
                        selOpt += 3;
                        playSoundB(menulowsfx_data, menulowsfx_length, 0);
                    }
                } 
            } else if (BUTTON_PRESSED(BUTTON_LEFT)) {
                if (selOpt > 2) {
                    selOpt -= 3;
                    playSoundB(menulowsfx_data, menulowsfx_length, 0);
                }
            }
        }

        if (BUTTON_PRESSED(BUTTON_A)) {
            enter = 1;
        }
        if (BUTTON_PRESSED(BUTTON_B)) {
            leave = 1;
        }

        // Do stuff
        // Big ol' menu state machine
        switch (menu)
        {
        case FRONTMENU:
            frontMenu();
            break;
        case ATTACKMENU:
            attackMenu();
            break;
        case TARGETMENU:
            targetMenu();
            break;
        case INSPECTMENU:
            inspectMenu();
            break;
        case CAPTUREMENU:
            captureMenu();
            break;
        case REPLACEMENU:
            replaceMenu();
            break;
        }
    } else { // Enemy turn
        int skip = rand() % 7;
        if (skip == 6) {
            sprintf(topBuf, "%s PASSED", fighter->name);
            finishTurn();
        } else {
            int nm = fighter->numMoves;
            if (bossBattle && fighterIdx == 0) {
                nm -= 1;
            }
            int mi = rand() % nm;
            if (bossBattle && fighterIdx == 0 && fighter->hp < 10) {
                mi = 5; // index of transcend
            }
            if (fighter->moves[mi]->targeting == OPPONENT) {
                targetTeam = PLAYERTEAM;
                int numopps = 0;
                for (int i = 0; i < 4; i++) {
                    if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                        numopps++;
                    }
                }
                int ta = rand() % numopps;
                for (int i = 0; i < 4; i++) {
                    if (battleAllies[i].exists && battleAllies[i].hp > 0) {
                        if (ta == 0) {
                            executeMove(fighter->moves[mi], &battleAllies[i]);
                            break;
                        } else {
                            ta--;
                        }
                    }
                }
            } else {
                targetTeam = ENEMYTEAM;
                int numfriends = 0;
                for (int i = 0; i < 4; i++) {
                    if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                        numfriends++;
                    }
                }
                int ta = rand() % numfriends;
                for (int i = 0; i < 4; i++) {
                    if (battleOpponents[i].exists && battleOpponents[i].hp > 0) {
                        if (ta == 0) {
                            executeMove(fighter->moves[mi], &battleOpponents[i]);
                            break;
                        } else {
                            ta--;
                        }
                    }
                }
            }
        }
    }

    eraseAllText();
    setTopText(topBuf);
    setBottomText(botBuf);
    drawCombatants();
}

// sets all the opponents to not exist
void resetOpponents() {
    for (int i = 0; i < 4; i++) {
        battleOpponents[i].exists = 0;
    }
}

// Returns an asterisk if cond is true and a space otherwise
// Useful for showing where the player's cursor is
char tsel(int cond) {
    return cond ? '*' : ' ';
}

// Draws a healthbar for a combatant
void drawHealthbar(int x, int y, COMBATANT* c, int spriteIdx, int barId) {
    // These healthbars are way more precise than the overworld one
    shadowOAM[spriteIdx].attr0 = ((y) & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[spriteIdx].attr1 = ((x) & COLMASK) | ATTR1_SMALL;
    // All of the healthbar sprites are linearly aligned in memory. Select the right one
    shadowOAM[spriteIdx].attr2 = ATTR2_TILEID64(0, 14) + (barId * 8);
    // 30 pixels of color to work with, how many are green?
    int gCol = ((c->hp * 30) / (c->maxHp));
    // That's the address of the first healthbar offset by the first 2 rows since they're 
    // useless to use, offset further to select the same tiles the sprite is using
    unsigned volatile short *vb = (unsigned short *)0x06013800 + 8 + (barId * 128);
    // l is the color of the left pixel, r is the color of the right pixel
    char l = 8;
    char r = 8;
    // For each tile, appropriately set the pixels color
    for (int i = 0; i < 4; i++) {
        r = 1 <= gCol ? 8 : 2;
        vb[0 + (i * 4)] = 11 | (r << 8);
        l = 2 <= gCol ? 8 : 2;
        r = 3 <= gCol ? 8 : 2;
        vb[1 + (i * 4)] = l | (r << 8);
        l = 4 <= gCol ? 8 : 2;
        r = 5 <= gCol ? 8 : 2;
        vb[2 + (i * 4)] = l | (r << 8);
        l = 6 <= gCol ? 8 : 2;
        r = 7 <= gCol ? 8 : 2;
        vb[3 + (i * 4)] = l | (r << 8);
    }
    vb = (vb + 32);
    for (int i = 0; i < 4; i++) {
        l = 8 <= gCol ? 8 : 2;
        r = 9 <= gCol ? 8 : 2;
        vb[0 + (i * 4)] = l | (r << 8);
        l = 10 <= gCol ? 8 : 2;
        r = 11 <= gCol ? 8 : 2;
        vb[1 + (i * 4)] = l | (r << 8);
        l = 12 <= gCol ? 8 : 2;
        r = 13 <= gCol ? 8 : 2;
        vb[2 + (i * 4)] = l | (r << 8);
        l = 14 <= gCol ? 8 : 2;
        r = 15 <= gCol ? 8 : 2;
        vb[3 + (i * 4)] = l | (r << 8);
    }
    vb = (vb + 32);
    for (int i = 0; i < 4; i++) {
        l = 16 <= gCol ? 8 : 2;
        r = 17 <= gCol ? 8 : 2;
        vb[0 + (i * 4)] = l | (r << 8);
        l = 18 <= gCol ? 8 : 2;
        r = 19 <= gCol ? 8 : 2;
        vb[1 + (i * 4)] = l | (r << 8);
        l = 20 <= gCol ? 8 : 2;
        r = 21 <= gCol ? 8 : 2;
        vb[2 + (i * 4)] = l | (r << 8);
        l = 22 <= gCol ? 8 : 2;
        r = 23 <= gCol ? 8 : 2;
        vb[3 + (i * 4)] = l | (r << 8);
    }
    vb = (vb + 32);
    for (int i = 0; i < 4; i++) {
        l = 24 <= gCol ? 8 : 2;
        r = 25 <= gCol ? 8 : 2;
        vb[0 + (i * 4)] = l | (r << 8);
        l = 26 <= gCol ? 8 : 2;
        r = 27 <= gCol ? 8 : 2;
        vb[1 + (i * 4)] = l | (r << 8);
        l = 28 <= gCol ? 8 : 2;
        r = 29 <= gCol ? 8 : 2;
        vb[2 + (i * 4)] = l | (r << 8);
        l = 30 <= gCol ? 8 : 2;
        vb[3 + (i * 4)] = l | (11 << 8);
    }
}

// Draws all of the combatants
void drawCombatants() {
    // TODO use affine matrix to make these sprites big
    shadowOAM[TURNICON1].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON2].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON3].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON4].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON5].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON6].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON7].attr0 = ATTR0_HIDE;
    shadowOAM[TURNICON8].attr0 = ATTR0_HIDE;
    for (int i = turnPoints - 1; i >= 0; i--) {
        shadowOAM[TURNICON8 - i].attr0 = (41 & ROWMASK) | ATTR0_REGULAR | ATTR0_SQUARE | ATTR0_8BPP;
        shadowOAM[TURNICON8 - i].attr1 = ((57 + 9 * i) & COLMASK) | ATTR1_TINY;
        shadowOAM[TURNICON8 - i].attr2 = ATTR2_TILEID64(1, 26);
    }

    shadowOAM[TURNINDICATOR].attr0 = ((15 + (40 * fighterIdx)) & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    if (turn == PLAYERTURN) {
        shadowOAM[TURNINDICATOR].attr1 = (8 & COLMASK) | ATTR1_MEDIUM;
    } else {
        shadowOAM[TURNINDICATOR].attr1 = (200 & COLMASK) | ATTR1_MEDIUM;
    }
    shadowOAM[TURNINDICATOR].attr2 = ATTR2_TILEID64(4, 16);

    if (battleAllies[0].exists && battleAllies[0].hp > 0) {
        shadowOAM[ALLY1_B].attr0 = (15 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ALLY1_B].attr1 = (8 & COLMASK) | ATTR1_MEDIUM;
        shadowOAM[ALLY1_B].attr2 = battleAllies[0].tileid;
        drawHealthbar(8, 15 - 8, &battleAllies[0], HB1, 0);
    } else {
        shadowOAM[ALLY1_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB1].attr0 = ATTR0_HIDE;
    }
    if (battleAllies[1].exists && battleAllies[1].hp > 0) {
        shadowOAM[ALLY2_B].attr0 = (55 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ALLY2_B].attr1 = (8 & COLMASK) | ATTR1_MEDIUM;
        shadowOAM[ALLY2_B].attr2 = battleAllies[1].tileid;
        drawHealthbar(8, 55 - 8, &battleAllies[1], HB2, 1);
    } else {
        shadowOAM[ALLY2_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB2].attr0 = ATTR0_HIDE;
    }
    if (battleAllies[2].exists && battleAllies[2].hp > 0) {
        shadowOAM[ALLY3_B].attr0 = (95 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ALLY3_B].attr1 = (8 & COLMASK) | ATTR1_MEDIUM;
        shadowOAM[ALLY3_B].attr2 = battleAllies[2].tileid;
        drawHealthbar(8, 95 - 8, &battleAllies[2], HB3, 2);
    } else {
        shadowOAM[ALLY3_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB3].attr0 = ATTR0_HIDE;
    }
    if (battleAllies[3].exists && battleAllies[3].hp > 0) {
        shadowOAM[ALLY4_B].attr0 = (135 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ALLY4_B].attr1 = (8 & COLMASK) | ATTR1_MEDIUM;
        shadowOAM[ALLY4_B].attr2 = battleAllies[3].tileid;
        drawHealthbar(8, 135 - 8, &battleAllies[3], HB4, 3);
    } else {
        shadowOAM[ALLY4_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB4].attr0 = ATTR0_HIDE;
    }

    
    if (battleOpponents[0].exists && battleOpponents[0].hp > 0) {
        shadowOAM[ENEMY1_B].attr0 = (15 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ENEMY1_B].attr1 = (200 & COLMASK) | ATTR1_MEDIUM | ATTR1_HFLIP;
        shadowOAM[ENEMY1_B].attr2 = battleOpponents[0].tileid;
        drawHealthbar(200, 15 - 8, &battleOpponents[0], HB5, 4);
    } else {
        shadowOAM[ENEMY1_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB5].attr0 = ATTR0_HIDE;
    }
    if (battleOpponents[1].exists && battleOpponents[1].hp > 0) {
        shadowOAM[ENEMY2_B].attr0 = (55 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ENEMY2_B].attr1 = (200 & COLMASK) | ATTR1_MEDIUM | ATTR1_HFLIP;
        shadowOAM[ENEMY2_B].attr2 = battleOpponents[1].tileid;
        drawHealthbar(200, 55 - 8, &battleOpponents[1], HB6, 5);
    } else {
        shadowOAM[ENEMY2_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB6].attr0 = ATTR0_HIDE;
    }
    if (battleOpponents[2].exists && battleOpponents[2].hp > 0) {
        shadowOAM[ENEMY3_B].attr0 = (95 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ENEMY3_B].attr1 = (200 & COLMASK) | ATTR1_MEDIUM | ATTR1_HFLIP;
        shadowOAM[ENEMY3_B].attr2 = battleOpponents[2].tileid;
        drawHealthbar(200, 95 - 8, &battleOpponents[2], HB7, 6);
    } else {
        shadowOAM[ENEMY3_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB7].attr0 = ATTR0_HIDE;
    }
    if (battleOpponents[3].exists && battleOpponents[3].hp > 0) {
        shadowOAM[ENEMY4_B].attr0 = (135 & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
        shadowOAM[ENEMY4_B].attr1 = (200 & COLMASK) | ATTR1_MEDIUM | ATTR1_HFLIP;
        shadowOAM[ENEMY4_B].attr2 = battleOpponents[3].tileid;
        drawHealthbar(200, 135 - 8, &battleOpponents[3], HB8, 7);
    } else {
        shadowOAM[ENEMY4_B].attr0 = ATTR0_HIDE;
        shadowOAM[HB8].attr0 = ATTR0_HIDE;
    }
}

// Erases all text on the screen
void eraseAllText() {
    for (int i = TEXT_IDX; i < 128; i++) {
        shadowOAM[i].attr0 = ATTR0_HIDE;
    }
    lettersActive = 0;
}

// Draws text on the screen
void drawText(char* str, int textboxX, int textboxY, int textboxWidth, int textboxHeight) {
    // go until we hit that null
    int rightLimit = textboxX + textboxWidth;
    int bottomLimit = textboxY + textboxHeight;
    int cursorx = textboxX;
    int cursory = textboxY;
    while(*str != '\0') {
        // Move cursor down a line if there's a newline character
        if (*str == '\n') {
            cursory += CHAR_HEIGHT; // Move down a row
            cursorx = textboxX; // carriage return
        } else {
            // Only allocate a sprite if its a visible character
            if (*str != ' ') {
                int idx = TEXT_IDX + lettersActive;
                // Return early if we don't have a free sprite
                if (idx >= 128) {
                    return;
                }
                shadowOAM[idx].attr0 = (cursory & ROWMASK) | ATTR0_REGULAR | ATTR0_8BPP;
                shadowOAM[idx].attr1 = (cursorx & COLMASK) | ATTR1_TINY;
                shadowOAM[idx].attr2 = text_tile_lkup[*str - CHAR_START];
                lettersActive++;
            }
            // Move the cursor
            cursorx += CHAR_WIDTH;
            if (cursorx + CHAR_WIDTH >= rightLimit) {
                cursory += CHAR_HEIGHT; // Move down a row
                cursorx = textboxX; // carriage return
            }
        }
        // Return early if we ran out of vertical space
        if (cursory >= bottomLimit) {
            return;
        }
        // Increment the character pointer
        str++;
    }
}

// Set top textbox text
void setTopText(char* str) {
    drawText(str, TEXT_TOP_X, TEXT_TOP_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
}

// Set bottom textbox text
void setBottomText(char* str) {
    drawText(str, TEXT_BOTTOM_X, TEXT_BOTTOM_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
}

