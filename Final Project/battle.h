#ifndef BATTLE_H
#define BATTLE_H
// Battle state stuff

#include "mode0.h"
#include "game.h"

// Letter sprites
#define TILE_EXCLAMATION    ATTR2_TILEID64(0, 0)
#define TILE_QUOTE          ATTR2_TILEID64(1, 0)
#define TILE_POUND          ATTR2_TILEID64(2, 0)
#define TILE_CURRENCY       ATTR2_TILEID64(3, 0) // custom icon for in game currency
#define TILE_PERCENT        ATTR2_TILEID64(4, 0)
#define TILE_AMPERSAND      ATTR2_TILEID64(5, 0)
#define TILE_APOSTROPHE     ATTR2_TILEID64(6, 0)
#define TILE_LPARANTHESIS   ATTR2_TILEID64(7, 0)

#define TILE_RPARANTHESIS   ATTR2_TILEID64(0, 1)
#define TILE_ASTERISK       ATTR2_TILEID64(1, 1) // custom icon for a little selection icon
#define TILE_PLUS           ATTR2_TILEID64(2, 1)
#define TILE_COMMA          ATTR2_TILEID64(3, 1)
#define TILE_MINUS          ATTR2_TILEID64(4, 1)
#define TILE_PERIOD         ATTR2_TILEID64(5, 1)
#define TILE_FSLASH         ATTR2_TILEID64(6, 1)
#define TILE_0              ATTR2_TILEID64(7, 1)

#define TILE_1              ATTR2_TILEID64(0, 2)
#define TILE_2              ATTR2_TILEID64(1, 2)
#define TILE_3              ATTR2_TILEID64(2, 2)
#define TILE_4              ATTR2_TILEID64(3, 2)
#define TILE_5              ATTR2_TILEID64(4, 2)
#define TILE_6              ATTR2_TILEID64(5, 2)
#define TILE_7              ATTR2_TILEID64(6, 2)
#define TILE_8              ATTR2_TILEID64(7, 2)

#define TILE_9              ATTR2_TILEID64(0, 3)
#define TILE_COLON          ATTR2_TILEID64(1, 3)
#define TILE_SEMICOLON      ATTR2_TILEID64(2, 3)
#define TILE_LANGLED        ATTR2_TILEID64(3, 3)
#define TILE_EQUAL          ATTR2_TILEID64(4, 3)
#define TILE_RANGLED        ATTR2_TILEID64(5, 3)
#define TILE_QUESTION       ATTR2_TILEID64(6, 3)
#define TILE_AT             ATTR2_TILEID64(7, 3)

#define TILE_A              ATTR2_TILEID64(0, 4)
#define TILE_B              ATTR2_TILEID64(1, 4)
#define TILE_C              ATTR2_TILEID64(2, 4)
#define TILE_D              ATTR2_TILEID64(3, 4)
#define TILE_E              ATTR2_TILEID64(4, 4)
#define TILE_F              ATTR2_TILEID64(5, 4)
#define TILE_G              ATTR2_TILEID64(6, 4)
#define TILE_H              ATTR2_TILEID64(7, 4)

#define TILE_I              ATTR2_TILEID64(0, 5)
#define TILE_J              ATTR2_TILEID64(1, 5)
#define TILE_K              ATTR2_TILEID64(2, 5)
#define TILE_L              ATTR2_TILEID64(3, 5)
#define TILE_M              ATTR2_TILEID64(4, 5)
#define TILE_N              ATTR2_TILEID64(5, 5)
#define TILE_O              ATTR2_TILEID64(6, 5)
#define TILE_P              ATTR2_TILEID64(7, 5)

#define TILE_Q              ATTR2_TILEID64(0, 6)
#define TILE_R              ATTR2_TILEID64(1, 6)
#define TILE_S              ATTR2_TILEID64(2, 6)
#define TILE_T              ATTR2_TILEID64(3, 6)
#define TILE_U              ATTR2_TILEID64(4, 6)
#define TILE_V              ATTR2_TILEID64(5, 6)
#define TILE_W              ATTR2_TILEID64(6, 6)
#define TILE_X              ATTR2_TILEID64(7, 6)

#define TILE_Y              ATTR2_TILEID64(0, 7)
#define TILE_Z              ATTR2_TILEID64(1, 7)
#define TILE_LSQUARE        ATTR2_TILEID64(2, 7)
#define TILE_BSLASH         ATTR2_TILEID64(3, 7)
#define TILE_RSQUARE        ATTR2_TILEID64(4, 7)
#define TILE_CARROT         ATTR2_TILEID64(5, 7)
#define TILE_UNDERSCORE     ATTR2_TILEID64(6, 7)
#define TILE_GRAVE          ATTR2_TILEID64(7, 7) // custom icon for a little star in the top left

// Character to sprite TILE lookup stuff
// Take the character and subtract CHAR_START
#define CHAR_START '!'
extern const int text_tile_lkup[];

// Sprite ID table
enum { TURNINDICATOR = 0, ALLY1_B, ALLY2_B, ALLY3_B, ALLY4_B, ENEMY1_B, ENEMY2_B, ENEMY3_B, ENEMY4_B, HB1, HB2, HB3,
 HB4, HB5, HB6, HB7, HB8, TARGETING_ARROW, TARGETING_ARROW2, TARGETING_ARROW3, TARGETING_ARROW4, 
 TURNICON1, TURNICON2, TURNICON3, TURNICON4, TURNICON5, TURNICON6, TURNICON7, TURNICON8,
 TEXT_IDX };

// Some constants
// At 7 width text looks good. At 6 it looks kinda compressed with QWM#$& but it gives us 20 characters
// At 6 width and 3 lines we have 60 letters per box (120 sprites) which is definitely extreme
// Definitely try to keep text short
#define CHAR_WIDTH 6 // while text sprites are 8 wide, the rightmost column of pixels is always empty
#define CHAR_HEIGHT 8 
#define TEXTBOX_WIDTH (121) // that's 17 characters
#define TEXTBOX_HEIGHT (3 * CHAR_HEIGHT) // that's 3 lines of text
#define TEXT_TOP_X 59
#define TEXT_TOP_Y 11
#define TEXT_BOTTOM_X 59
#define TEXT_BOTTOM_Y 123

// Textbox functions
extern int lettersActive;
void eraseAllText();
void drawText(char* str, int textboxX, int textboxY, int textboxWidth, int textboxHeight);
void setTopText(char* str);
void setBottomText(char* str);
char tsel(int cond);

// Battle status used by main to figure out how the battle is going
enum { LOST = -1, ONGOING = 0, WON = 1 };
extern int battleStatus;
extern int bossBattle;
extern int waiting;
extern int turnPoints;
extern int nextTurnPoints;
extern int fighterIdx;
extern int nextFighterIdx;

// Turn tracking
enum { PLAYERTURN, ENEMYTURN };
extern int turn;
extern int nextTurn;

// Menu tracking
enum { FRONTMENU, ATTACKMENU, TARGETMENU, INSPECTMENU, CAPTUREMENU, REPLACEMENU };

// Team tracking
enum { PLAYERTEAM, ENEMYTEAM };

// Init functions
void initBattle(int opponentType);
void resetOpponents();

// Update functions
void updateBattle();
void drawCombatants();
void checkBattleStatus();

// Menuing
void goToFrontMenu();
void goToAttackMenu();
void goToTargetMenu();
void goToInspectMenu();
void goToCaptureMenu();
void goToReplaceMenu();
void frontMenu();
void attackMenu();
void targetMenu();
void inspectMenu();
void captureMenu();
void replaceMenu();
void executeMove(MOVE* m, COMBATANT* t);
void finishTurn();

// I want the sprites to be bigger on the battle screen
// Either we can have more sprites on the sprite sheet for this which might be ok
// but if we can't we could use smaller sprites and use the affine matrix

#endif