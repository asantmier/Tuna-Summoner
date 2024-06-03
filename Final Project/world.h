#ifndef WORLD_H
#define WORLD_H
// Overworld state stuff

#include "game.h"

// Sprite ID table
enum {
    PLAYER_IDX = 0, BULLET1, BULLET2, BULLET3, BULLET4, BULLET5, ENEMY1, ENEMY2, ENEMY3, ENEMY4, ENEMY5, ENEMY6,
    ENEMY7, ENEMY8, ENEMY9, ENEMY10, HEALTHBAR1, HEALTHBAR2, HEALTHBAR3, HEALTHBAR4, HEALTHBAR5, HEALTHBAR6, 
    HEALTHBAR7, HEALTHBAR8, MINE1, MINE2, MINE3, MINE4, MINE5, MINE6, MINE7, MINE8, MINE9, MINE10, MINE11, MINE12,
    MINE13, MINE14, MINE15, MINE16, MINE17, MINE18, MINE19, MINE20, PICKUP1, PICKUP2, PICKUP3, PICKUP4, PICKUP5
};

// Fixed point encoding
typedef int fp64;
#define ENCODE26_6(n) ((n) << 6)
#define DECODE26_6(n) ((n) >> 6)

// Constants
// Camera stuff
#define GAMEWIDTH 1024
#define GAMEHEIGHT 1024
#define CAM_BOUND_L 79
#define CAM_BOUND_R 159
#define CAM_BOUND_T 52
#define CAM_BOUND_B 105
// Movement stuff
#define PLAYER_MAX_V 48
#define PLAYER_MAX_A 20
#define PLAYER_DRAG  1
#define BULLET_MAX_V 96
// Pooling stuff
#define NUM_BULLETS 5
#define NUM_ENEMIES 60 // there needs to be an entry for every enemy in the level
#define NUM_MINES 60
#define NUM_PICKUP 10
#define NUM_LEVELS 1
// Sprite priorities
#define ENEMY_PRIORITY 2
#define PLAYER_PRIORITY 2
#define BULLET_PRIORITY 2
#define MINE_PRIORITY 2
#define PICKUP_PRIORITY 2
#define HUD_PRIORITY 1
// Sprite counts
#define NUM_ENEMY_SPRITES 10
#define NUM_MINE_SPRITES 20
#define NUM_PICKUP_SPRITES 5
// Settings
#define HEALTHBAR_VOFF 2

// Facing directions
enum { LEFT, RIGHT };
// AI types
enum { PASSIVE, NEUTRAL, HOSTILE };
// Pickup effects
enum { UPGRADE_TORP, UPGRADE_BLAST, UPGRADE_SHIELD, RESTORE_HP };

// Structs
typedef struct tag_player {
    fp64 int_x, int_y; // internal x and y
    int x, y; // screen space x and y
    fp64 dx, dy; // internal velocity
    int width, height;
    int facing;
} PLAYER;

typedef struct tag_bullet {
    fp64 int_x, int_y; // internal x and y
    int x, y; // screen space x and y
    fp64 dx, dy; // internal velocity
    int width, height;
    int active;
    int spriteIdx;
} BULLET;

typedef struct tag_enemy {
    fp64 int_x, int_y; // internal x and y
    int x, y; // screen space x and y
    fp64 dx, dy; // internal velocity
    int width, height;
    int active;
    int ai;
    int type;
} ENEMY;

typedef struct tag_mine {
    fp64 int_x, int_y; // internal x and y
    int x, y; // screen space x and y
    fp64 dx, dy; // internal velocity
    int width, height;
    int active;
    int damage;
} MINE;

typedef struct tag_pickup {
    fp64 int_x, int_y; // internal x and y
    int x, y; // screen space x and y
    int width, height;
    int active;
    int effect;
} PICKUP;

typedef struct tag_level {
    // pointers for the foreground, background, collision maps, etc
    ENEMY enemyList[NUM_ENEMIES];
    MINE mineList[NUM_MINES];
    PICKUP pickupList[NUM_PICKUP];
} LEVEL;

// Level data
LEVEL levels[NUM_LEVELS];

// Variables
extern PLAYER player;
extern BULLET bullets[NUM_BULLETS];
extern ENEMY enemies[NUM_ENEMIES];
extern MINE mines[NUM_MINES];
extern PICKUP pickups[NUM_PICKUP];

// Flags for main
extern int doBattle;
extern int opponentIdx;

// Render counts
extern int drawnEnemies;
extern int drawnMines;

// Battle mode swapping
void returnFromBattle(int victory);

// Init functions
void initWorld();
void initPlayer();
void initBullets();
void initEnemies();
void initMines();
void initPickups();

// Update functions
void updateWorld();
void updatePlayer();
void updateBullet(BULLET* bullet);
void updateEnemy(ENEMY* enemy);
void updateMine(MINE* mine);
void updatePickup(PICKUP* pickup);

// Rendering functions
void freeEnemySprites();
void drawEnemy(ENEMY* enemy);
void freeMineSprites();
void drawMine(MINE* mine);
void freePickupSprites();
void drawPickup(PICKUP* pickup);

// big top healthbar
void updateHealthBar();

// world.h the world part of the game
// battle.h battle part of the game
// game.h contains data relevant to both world and battle like player hp

#endif