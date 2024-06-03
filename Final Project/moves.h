#ifndef MOVES_H
#define MOVES_H
// Contains the MOVE items contained in all COMBATANTs

// Targeting mode enum
enum { OPPONENT, ALLY };

typedef struct tag_move {
    char text[10]; // 9 letters + \0
    char flavorText[61]; // 60 letters + \0
    int damage;
    int hitAll;
    int targeting;
    int healing;
} MOVE;

extern MOVE MOVE_SLASH;
extern MOVE MOVE_BLAST;
extern MOVE MOVE_HEAL;

/* Move ideas
 * FISH - nibble (weak ss), flail (v weak hit all), regen (minor self heal)
 * SHARK - strike (strong ss), heal (minor target heal)
 * ANGLER - bite (med ss), heal (strong target heal), heal (weak all heal)
 * BARRACUDA - bite (med ss), dash (+1 turn)
 * PUFFER - nibble (weak ss), puff up (weak hit all), burst (minor heal all)
 * TUNA GOD - bite (med ss), slash (strong ss), regen (strong self heal), heal (med heal all), tidalwave (med hit all)
 * 
 * SUBMARINE - torpedo (med ss), shield (minor target heal), blast (weak hit all)
 * SUBMARINE could level up moves for strong torpedo, med shield, and med blast
 */
// single
extern MOVE MOVE_NIBBLE; // weak
extern MOVE MOVE_BITE;   // med
extern MOVE MOVE_STRIKE; // strong
extern MOVE MOVE_SLASH; // strong
// multi
extern MOVE MOVE_FLAIL;  // weak
extern MOVE MOVE_PUFFUP; // med
extern MOVE MOVE_WAVE;   // med
// heal
extern MOVE MOVE_REGEN;      // weak
extern MOVE MOVE_RESOLVE;    // med
extern MOVE MOVE_SHEAL;      // weak
extern MOVE MOVE_LHEAL;      // med
extern MOVE MOVE_SHEALBURST; // weak
extern MOVE MOVE_LHEALBURST; // med
// special
extern MOVE MOVE_DASH; // free turn
extern MOVE MOVE_TRANSCEND;  // full heal
// player
extern MOVE MOVE_TORPEDO1; // med
extern MOVE MOVE_TORPEDO2; // strong
extern MOVE MOVE_SHIELD1;  // weak
extern MOVE MOVE_SHIELD2;  // med
extern MOVE MOVE_BLAST1;   // weak
extern MOVE MOVE_BLAST2;   // med
extern MOVE MOVE_DEATHRAY; // OMEGA
extern MOVE MOVE_BRUH; // OMEGA
// default
extern MOVE MOVE_NONE;

#endif