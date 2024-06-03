#ifndef GAME_H
#define GAME_H
// Contains data relevant to both the overworld and battle states

#include "moves.h"

extern int submarineMaxHp;
extern int submarineHp; // Player health

extern int gameVictory; // Set to 1 when the game is won

// Enemy types
enum { FISH, SHARK, ANGLER, PUFFER, BARRACUDA, BOSS };

#define NAME_LEN 10

// Structs
typedef struct tag_combatant {
    char name[NAME_LEN];
    int exists;
    int maxHp;
    int hp;
    int numMoves;
    MOVE* moves[6];
    int tileid;
} COMBATANT;

// Default combatant structs
extern COMBATANT CBT_FISH;
extern COMBATANT CBT_SHARK;
extern COMBATANT CBT_ANGLER;
extern COMBATANT CBT_PUFFER;
extern COMBATANT CBT_BARRACUDA;
extern COMBATANT CBT_GOD;
extern COMBATANT CBT_SUBMARINE;
extern COMBATANT CBT_NONE;

// TODO idea
// so how about the player in combat is separate from the submarine
// like if the player dies though, the submarine takes damage
// some enemies could also have skills that directly target the submarine
// that could actually be an interesting mechanic

// ally/opponent list
// Allies need to be accessible from battle and world since we might want to modify our party in the world
// Opponents could technically only be in battle
extern COMBATANT battleAllies[4]; // player can be ally 0
extern COMBATANT battleOpponents[4];

// Cheat flag
extern int cheater;

// Initialize game
void initGame();
void initParty();

// Utility functions used in both world and battle
int tilesRed(int tile1, int hp, int maxHp, int segments);

#endif