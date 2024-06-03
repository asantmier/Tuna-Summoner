#include <stdlib.h>
#include "mode0.h"
#include "print.h"
#include "world.h"
#include "world1collision.h"
#include "sound.h"
#include "shootsfx.h"
#include "boomsfx.h"
#include "fanfaresfx.h"

unsigned char* collisionMap = (unsigned char*) world1collisionBitmap;

PLAYER player;
BULLET bullets[NUM_BULLETS];
ENEMY enemies[NUM_ENEMIES];
MINE mines[NUM_MINES];
PICKUP pickups[NUM_PICKUP];
#define DISABLE_ENEMY { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
#define DISABLE_MINE { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
#define DISABLE_PICKUP { 0, 0, 0, 0, 0, 0, 0, 0 }
LEVEL levels[NUM_LEVELS] = {
    { // start 1st LEVEL constructor
        { // start ENEMY list 
            {.int_x=32*64, .int_y=160*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 1
            {.int_x=184*64, .int_y=176*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 2
            {.int_x=64*64, .int_y=336*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 3
            {.int_x=256*64, .int_y=352*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 4
            {.int_x=336*64, .int_y=336*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 5
            {.int_x=416*64, .int_y=184*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 6
            {.int_x=337*64, .int_y=128*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 7
            {.int_x=440*64, .int_y=72*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 8
            {.int_x=608*64, .int_y=88*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 9
            {.int_x=624*64, .int_y=136*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 10
            {.int_x=744*64, .int_y=120*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 11
            {.int_x=832*64, .int_y=136*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 12
            {.int_x=705*64, .int_y=184*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 13
            {.int_x=848*64, .int_y=312*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 14
            {.int_x=648*64, .int_y=321*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 15
            {.int_x=776*64, .int_y=472*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 16
            {.int_x=656*64, .int_y=512*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 17
            {.int_x=753*64, .int_y=536*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 18
            {.int_x=648*64, .int_y=624*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 19
            {.int_x=817*64, .int_y=624*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=BARRACUDA}, // 20
            {.int_x=704*64, .int_y=697*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 21
            {.int_x=936*64, .int_y=672*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 22
            {.int_x=976*64, .int_y=568*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 23
            {.int_x=832*64, .int_y=760*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=PUFFER}, // 24
            {.int_x=776*64, .int_y=808*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=ANGLER}, // 25
            {.int_x=880*64, .int_y=952*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 26
            {.int_x=544*64, .int_y=960*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 27
            {.int_x=424*64, .int_y=960*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 28
            {.int_x=560*64, .int_y=664*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=PUFFER}, // 29
            {.int_x=528*64, .int_y=496*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 30
            {.int_x=546*64, .int_y=400*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=FISH}, // 31
            {.int_x=392*64, .int_y=520*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 32
            {.int_x=472*64, .int_y=553*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 33
            {.int_x=449*64, .int_y=625*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=ANGLER}, // 34
            {.int_x=329*64, .int_y=569*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 35
            {.int_x=360*64, .int_y=648*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=BARRACUDA}, // 36
            {.int_x=360*64, .int_y=696*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 37
            {.int_x=272*64, .int_y=647*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=PUFFER}, // 38
            {.int_x=240*64, .int_y=584*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=SHARK}, // 39
            {.int_x=184*64, .int_y=544*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=ANGLER}, // 40
            {.int_x=96*64, .int_y=600*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=BARRACUDA}, // 41
            {.int_x=32*64, .int_y=556*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=BARRACUDA}, // 42
            {.int_x=68*64, .int_y=464*64, .width=16, .height=8, .active=1, .ai=PASSIVE, .type=PUFFER}, // 43
            {.int_x=168*64, .int_y=928*64, .width=32, .height=16, .active=1, .ai=PASSIVE, .type=BOSS}, // 44
            DISABLE_ENEMY, // 45
            DISABLE_ENEMY, // 46
            DISABLE_ENEMY, // 47
            DISABLE_ENEMY, // 48
            DISABLE_ENEMY, // 49
            DISABLE_ENEMY, // 50
            DISABLE_ENEMY, // 51
            DISABLE_ENEMY, // 52
            DISABLE_ENEMY, // 53
            DISABLE_ENEMY, // 54
            DISABLE_ENEMY, // 55
            DISABLE_ENEMY, // 56
            DISABLE_ENEMY, // 57
            DISABLE_ENEMY, // 58
            DISABLE_ENEMY, // 59
            DISABLE_ENEMY, // 60
        },
        { // start MINE list
            { .int_x = 152 * 64, .int_y = 352 * 64, .active = 1, .damage = 10 }, // 1
            { .int_x = 176 * 64, .int_y = 352 * 64, .active = 1, .damage = 10 }, // 2
            { .int_x = 200 * 64, .int_y = 352 * 64, .active = 1, .damage = 10 }, // 3
            { .int_x = 256 * 64, .int_y = 328 * 64, .active = 1, .damage = 10 }, // 4
            { .int_x = 392 * 64, .int_y = 328 * 64, .active = 1, .damage = 10 }, // 5
            { .int_x = 464 * 64, .int_y = 312 * 64, .active = 1, .damage = 10 }, // 6
            { .int_x = 520 * 64, .int_y = 184 * 64, .active = 1, .damage = 10 }, // 7
            { .int_x = 488 * 64, .int_y = 216 * 64, .active = 1, .damage = 10 }, // 8
            { .int_x = 472 * 64, .int_y = 216 * 64, .active = 1, .damage = 10 }, // 9
            { .int_x = 736 * 64, .int_y = 336 * 64, .active = 1, .damage = 10 }, // 10
            { .int_x = 752 * 64, .int_y = 328 * 64, .active = 1, .damage = 10 }, // 11
            { .int_x = 768 * 64, .int_y = 334 * 64, .active = 1, .damage = 10 }, // 12
            { .int_x = 784 * 64, .int_y = 336 * 64, .active = 1, .damage = 10 }, // 13
            { .int_x = 800 * 64, .int_y = 336 * 64, .active = 1, .damage = 10 }, // 14
            { .int_x = 816 * 64, .int_y = 336 * 64, .active = 1, .damage = 10 }, // 15
            { .int_x = 832 * 64, .int_y = 328 * 64, .active = 1, .damage = 10 }, // 16
            { .int_x = 848 * 64, .int_y = 328 * 64, .active = 1, .damage = 10 }, // 17
            { .int_x = 864 * 64, .int_y = 328 * 64, .active = 1, .damage = 10 }, // 18
            { .int_x = 792 * 64, .int_y = 488 * 64, .active = 1, .damage = 10 }, // 19
            { .int_x = 960 * 64, .int_y = 416 * 64, .active = 1, .damage = 10 }, // 20
            { .int_x = 976 * 64, .int_y = 416 * 64, .active = 1, .damage = 10 }, // 21
            { .int_x = 960 * 64, .int_y = 376 * 64, .active = 1, .damage = 10 }, // 22
            { .int_x = 1000 * 64, .int_y = 376 * 64, .active = 1, .damage = 10 }, // 23
            { .int_x = 976 * 64, .int_y = 344 * 64, .active = 1, .damage = 10 }, // 24
            { .int_x = 992 * 64, .int_y = 312 * 64, .active = 1, .damage = 10 }, // 25
            { .int_x = 968 * 64, .int_y = 280 * 64, .active = 1, .damage = 10 }, // 26
            { .int_x = 984 * 64, .int_y = 256 * 64, .active = 1, .damage = 10 }, // 27
            { .int_x = 1000 * 64, .int_y = 240 * 64, .active = 1, .damage = 10 }, // 28
            { .int_x = 976 * 64, .int_y = 208 * 64, .active = 1, .damage = 10 }, // 29
            { .int_x = 984 * 64, .int_y = 200 * 64, .active = 1, .damage = 10 }, // 30
            { .int_x = 968 * 64, .int_y = 160 * 64, .active = 1, .damage = 10 }, // 31
            { .int_x = 992 * 64, .int_y = 128 * 64, .active = 1, .damage = 10 }, // 32
            { .int_x = 968 * 64, .int_y = 112 * 64, .active = 1, .damage = 10 }, // 33
            { .int_x = 984 * 64, .int_y = 88 * 64, .active = 1, .damage = 10 }, // 34
            { .int_x = 1000 * 64, .int_y = 88 * 64, .active = 1, .damage = 10 }, // 35
            { .int_x = 752 * 64, .int_y = 760 * 64, .active = 1, .damage = 10 }, // 36
            { .int_x = 704 * 64, .int_y = 808 * 64, .active = 1, .damage = 10 }, // 37
            { .int_x = 648 * 64, .int_y = 744 * 64, .active = 1, .damage = 10 }, // 38
            { .int_x = 672 * 64, .int_y = 808 * 64, .active = 1, .damage = 10 }, // 39
            { .int_x = 624 * 64, .int_y = 784 * 64, .active = 1, .damage = 10 }, // 40
            { .int_x = 600 * 64, .int_y = 760 * 64, .active = 1, .damage = 10 }, // 41
            { .int_x = 592 * 64, .int_y = 824 * 64, .active = 1, .damage = 10 }, // 42
            { .int_x = 560 * 64, .int_y = 808 * 64, .active = 1, .damage = 10 }, // 43
            { .int_x = 520 * 64, .int_y = 792 * 64, .active = 1, .damage = 10 }, // 44
            { .int_x = 504 * 64, .int_y = 824 * 64, .active = 1, .damage = 10 }, // 45
            { .int_x = 472 * 64, .int_y = 768 * 64, .active = 1, .damage = 10 }, // 46
            { .int_x = 448 * 64, .int_y = 816 * 64, .active = 1, .damage = 10 }, // 47
            { .int_x = 432 * 64, .int_y = 760 * 64, .active = 1, .damage = 10 }, // 48
            { .int_x = 360 * 64, .int_y = 816 * 64, .active = 1, .damage = 10 }, // 49
            { .int_x = 336 * 64, .int_y = 808 * 64, .active = 1, .damage = 10 }, // 50
            { .int_x = 472 * 64, .int_y = 672 * 64, .active = 1, .damage = 10 }, // 51
            { .int_x = 272 * 64, .int_y = 704 * 64, .active = 1, .damage = 10 }, // 52
            { .int_x = 200 * 64, .int_y = 616 * 64, .active = 1, .damage = 10 }, // 53
            { .int_x = 448 * 64, .int_y = 456 * 64, .active = 1, .damage = 10 }, // 54
            { .int_x = 448 * 64, .int_y = 424 * 64, .active = 1, .damage = 10 }, // 55
            DISABLE_MINE, // 56
            DISABLE_MINE, // 57
            DISABLE_MINE, // 58
            DISABLE_MINE, // 59
            DISABLE_MINE, // 60
        },
        { // start PICKUP list
            { .int_x = 768 * 64, .int_y = 8 * 64, .active = 1, .effect = UPGRADE_TORP }, // 1
            { .int_x = 760 * 64, .int_y = 808 * 64, .active = 1, .effect = UPGRADE_SHIELD }, // 2
            { .int_x = 20 * 64, .int_y = 464 * 64, .active = 1, .effect = UPGRADE_BLAST }, // 3
            { .int_x = 904 * 64, .int_y = 24 * 64, .active = 1, .effect = RESTORE_HP }, // 4
            { .int_x = 432 * 64, .int_y = 945 * 64, .active = 1, .effect = RESTORE_HP }, // 5
            { .int_x = 568 * 64, .int_y = 700 * 64, .active = 1, .effect = RESTORE_HP }, // 6
            { .int_x = 688 * 64, .int_y = 960 * 64, .active = 1, .effect = RESTORE_HP }, // 7
            DISABLE_PICKUP, // 8
            DISABLE_PICKUP, // 9
            DISABLE_PICKUP, // 10
        }
    } 
};

int level = 0; // level counter
int doBattle = 0;
int opponentIdx; // we trust that we remember to set this each time
int drawnEnemies = 0;
int drawnMines = 0;
int drawnPickups = 0;
// Frame counters for collective animations modified in updateWorld
int enemyFrameCounter = 0;
int enemyAniFrame = 0;
int mineFrameCounter = 0;
int mineAniFrame = 0;

// Sets up the overworld for after a battle finishes
void returnFromBattle(int victory) {
    if (victory) {
        // get rid of that annoying warning. victory really just exists in case its useful one day
    }
    // if (victory) {
        doBattle = 0;
        enemies[opponentIdx].active = 0;
    // } else {
        // lose the game
    // }
}

// Initialize world data
void initWorld() {
    level = 0;
    doBattle = 0;

    initPlayer();
    initBullets();
    initEnemies();
    initMines();
    initPickups();
}

// Initialize player
void initPlayer() {
    player.int_x = 128 * 64;
    player.int_y = 32 * 64;
    player.x = 128;
    player.y = 32;
    player.dx = 0;
    player.dy = 0;
    player.width = 16;
    player.height = 8;
    player.facing = RIGHT;
}

// Initialize bullet pool
void initBullets() {
    for (int i = 0; i < NUM_BULLETS; i++) {
        bullets[i].int_x = 0;
        bullets[i].int_y = 0;
        bullets[i].x = 0;
        bullets[i].y = 0;
        bullets[i].dx = 0;
        bullets[i].dy = 0;
        bullets[i].width = 2;
        bullets[i].height = 1;
        bullets[i].active = 0;
        bullets[i].spriteIdx = BULLET1 + i; // bullets are contiguous
    }
}

// Initialize enemies
void initEnemies() {
    for (int i = 0; i < NUM_ENEMIES; i++) {
        enemies[i].int_x = levels[level].enemyList[i].int_x;
        enemies[i].int_y = levels[level].enemyList[i].int_y;
        enemies[i].x = DECODE26_6(enemies[i].int_x) - bg2xOff; // doesn't need to be preset
        enemies[i].y = DECODE26_6(enemies[i].int_y) - bg2yOff; // doesn't need to be preset
        enemies[i].dx = levels[level].enemyList[i].dx;
        enemies[i].dy = levels[level].enemyList[i].dy;
        enemies[i].width = levels[level].enemyList[i].width;
        enemies[i].height = levels[level].enemyList[i].height;
        enemies[i].active = levels[level].enemyList[i].active;
        enemies[i].ai = levels[level].enemyList[i].ai; // enemies chasing the player is a problem for later
        enemies[i].type = levels[level].enemyList[i].type;
    }
}

// Initialize mines
void initMines() {
    for (int i = 0; i < NUM_MINES; i++) {
        mines[i].int_x = levels[level].mineList[i].int_x;
        mines[i].int_y = levels[level].mineList[i].int_y;
        mines[i].x = DECODE26_6(mines[i].int_x) - bg2xOff; // doesn't need to be preset
        mines[i].y = DECODE26_6(mines[i].int_y) - bg2yOff; // doesn't need to be preset
        mines[i].dx = levels[level].mineList[i].dx;
        mines[i].dy = levels[level].mineList[i].dy;
        // mines[i].width = levels[level].mineList[i].width;
        // mines[i].height = levels[level].mineList[i].height;
        mines[i].width = 8;
        mines[i].height = 8;
        mines[i].active = levels[level].mineList[i].active;
        mines[i].damage = levels[level].mineList[i].damage;
    }
}

// Initialize pickups
void initPickups() {
    for (int i = 0; i < NUM_PICKUP; i++) {
        pickups[i].int_x = levels[level].pickupList[i].int_x;
        pickups[i].int_y = levels[level].pickupList[i].int_y;
        pickups[i].x = DECODE26_6(pickups[i].int_x) - bg2xOff; // doesn't need to be preset
        pickups[i].y = DECODE26_6(pickups[i].int_y) - bg2yOff; // doesn't need to be preset
        pickups[i].width = 8; // ditto
        pickups[i].height = 8;
        pickups[i].active = levels[level].pickupList[i].active;
        pickups[i].effect = levels[level].pickupList[i].effect;
    }
}

// Handle collision between actors
void doCollision() {
    for (int i = 0; i < NUM_ENEMIES; i++) {
        if (enemies[i].active) {
            if (collision(player.int_x, player.int_y, ENCODE26_6(player.width), ENCODE26_6(player.height),
            enemies[i].int_x, enemies[i].int_y, ENCODE26_6(enemies[i].width), ENCODE26_6(enemies[i].height))) {
                // DO BATTLE
                doBattle = 1;
                opponentIdx = i;
                return;
            }
            for (int j = 0; j < NUM_BULLETS; j++) {
                if (bullets[j].active) {
                    if (collision(bullets[j].int_x, bullets[j].int_y, ENCODE26_6(bullets[j].width), ENCODE26_6(bullets[j].height),
                    enemies[i].int_x, enemies[i].int_y, ENCODE26_6(enemies[i].width), ENCODE26_6(enemies[i].height))) {
                        // Disable bullet
                        bullets[j].active = 0;
                        shadowOAM[bullets[j].spriteIdx].attr0 = ATTR0_HIDE | ATTR0_8BPP;
                        // DO BATTLE
                        doBattle = 1;
                        opponentIdx = i;
                        return;
                    }
                }
            }
        }
    }
    for (int i = 0; i < NUM_MINES; i++) {
        if (mines[i].active) {
            if (collision(player.int_x, player.int_y, ENCODE26_6(player.width), ENCODE26_6(player.height),
            mines[i].int_x, mines[i].int_y, ENCODE26_6(mines[i].width), ENCODE26_6(mines[i].height))) {
                // Get hurt
                mines[i].active = 0;
                submarineHp -= mines[i].damage;
                playSoundB(boomsfx_data, boomsfx_length, 0);
            }
        }
    }
    for (int i = 0; i < NUM_PICKUP; i++) {
        if (pickups[i].active) {
            if (collision(player.int_x, player.int_y, ENCODE26_6(player.width), ENCODE26_6(player.height),
            pickups[i].int_x, pickups[i].int_y, ENCODE26_6(pickups[i].width), ENCODE26_6(pickups[i].height))) {
                pickups[i].active = 0;
                playSoundB(fanfaresfx_data, fanfaresfx_length, 0);
                switch (pickups[i].effect)
                {
                case UPGRADE_TORP:
                    battleAllies[0].moves[0] = &MOVE_TORPEDO2;
                    break;
                case UPGRADE_BLAST:
                    battleAllies[0].moves[2] = &MOVE_BLAST2;
                    break;
                case UPGRADE_SHIELD:
                    battleAllies[0].moves[1] = &MOVE_SHIELD2;
                    break;
                case RESTORE_HP:
                    submarineHp += 50;
                    if (submarineHp > submarineMaxHp) submarineHp = submarineMaxHp;
                    for (int j = 0; j < 4; j++) {
                        battleAllies[j].hp = battleAllies[j].maxHp;
                    }
                    break;
                }
            }
        }
    }



    
}

// Update the world
void updateWorld() {
    // Stuff for animating all of the enemies together
    if (enemyFrameCounter > 20) {
        enemyAniFrame++;
        enemyAniFrame %= 3;
        enemyFrameCounter = 0;
    }
    enemyFrameCounter++;
    // Stuff for animating all of the mines together
    if (mineFrameCounter > 20) {
        mineAniFrame++;
        mineAniFrame %= 3;
        mineFrameCounter = 0;
    }
    mineFrameCounter++;
    updatePlayer();
    for (int i = 0; i < NUM_BULLETS; i++) {
        if (bullets[i].active) {
            updateBullet(&bullets[i]);
        }
    }
    freeEnemySprites();
    for (int i = 0; i < NUM_ENEMIES; i++) {
        if (enemies[i].active) {
            updateEnemy(&enemies[i]);
        }
    }
    freeMineSprites();
    for (int i = 0; i < NUM_MINES; i++) {
        if (mines[i].active) {
            updateMine(&mines[i]);
        }
    }
    freePickupSprites();
    for (int i = 0; i < NUM_PICKUP; i++) {
        if (pickups[i].active) {
            updatePickup(&pickups[i]);
        }
    }
    
    doCollision(); // BATTLE IS FLAGGED HERE
    // We need to update the healthbar after its possible to take damage
    updateHealthBar();
}

// Move the player
void movePlayer() {
    // Lets figure out how far we can travel
    // first we need to make sure we land within the world
    fp64 rdx = player.dx;
    fp64 rdy = player.dy;
    // first off, lets check to make sure the internal coordinates are within the level
    // We can't decode or else we lose precision! both of these statements also cannot be true
    if (player.int_x + player.dx < 0) { // off the left edge
        rdx = player.dx - (player.int_x + player.dx);
    } else if (player.int_x + player.dx + ENCODE26_6(player.width) > ENCODE26_6(GAMEWIDTH)) { // off the right edge
        rdx = player.dx - (player.int_x + player.dx + ENCODE26_6(player.width) - ENCODE26_6(GAMEWIDTH));
    }
    if (player.int_y + player.dy < 0) { // off the top
        rdy = player.dy - (player.int_y + player.dy);
    } else if (player.int_y + ENCODE26_6(player.height) > ENCODE26_6(GAMEHEIGHT)) { // off the bottom
        rdy = player.dy - (player.int_y + player.dy + ENCODE26_6(player.height) - ENCODE26_6(GAMEHEIGHT));
    }
    // Now that we know how fast we are allowed to go without breaking the game, where can we land that isn't in a wall
    // We're gonna check every quarter step of travel
    // TODO possible optimization, can we get away with half steps?
    if (collisionCheck(collisionMap, 1024, DECODE26_6(player.int_x + rdx), DECODE26_6(player.int_y + rdy), player.width, player.height) > 0) {
        if (collisionCheck(collisionMap, 1024, DECODE26_6(player.int_x + ((rdx * 3) / 4)), DECODE26_6(player.int_y + ((rdy * 3) / 4)), player.width, player.height) > 0) {
            if (collisionCheck(collisionMap, 1024, DECODE26_6(player.int_x + (rdx / 2)), DECODE26_6(player.int_y + (rdy / 2)), player.width, player.height) > 0) {
                if (collisionCheck(collisionMap, 1024, DECODE26_6(player.int_x + (rdx / 4)), DECODE26_6(player.int_y + (rdy / 4)), player.width, player.height) > 0) {
                    // you can't move
                    rdx = 0;
                    rdy = 0;
                }  else { 
                    // else 1/4 is ok
                    rdx /= 4;
                    rdy /= 4;
                    // We have to decode encode to keep consistent with the fact that the 6 decimal digits aren't checked for collision
                    // We could totally just bitmask this though
                    player.int_x = ENCODE26_6(DECODE26_6(player.int_x + rdx));
                    player.int_y = ENCODE26_6(DECODE26_6(player.int_y + rdy));
                }
            }  else {
                // else 1/2 is ok
                rdx /= 2;
                rdy /= 2;
                player.int_x = ENCODE26_6(DECODE26_6(player.int_x + rdx));
                player.int_y = ENCODE26_6(DECODE26_6(player.int_y + rdy));
            }
        }  else {
            // else 3/4 is ok
            rdx = (rdx * 3) / 4;
            rdy = (rdy * 3) / 4;
            player.int_x = ENCODE26_6(DECODE26_6(player.int_x + rdx));
            player.int_y = ENCODE26_6(DECODE26_6(player.int_y + rdy));
        }
    } else {
        // else rdx, rdy is ok, no change needed
        player.int_x += rdx;
        player.int_y += rdy;
    }
    // TODO let the player slide along walls maybe
    
    // If we hit something in a direction, zero our directional velocity
    if (abs(rdx) < abs(player.dx)) {
        player.dx = 0;
        
    }
    if (abs(rdy) < abs(player.dy)) {
        player.dy = 0;
    }

    // Update the screen space coordinates now that we have valid internal coordinates
    player.x = DECODE26_6(player.int_x) - bg2xOff;
    player.y = DECODE26_6(player.int_y) - bg2yOff;
    // If the sprite is outside of the camera bounds, try to move it
    if (player.x < CAM_BOUND_L) {
        // First, check if we can even move the camera left
        if (bg2xOff > 0) { 
            int xDiff = CAM_BOUND_L - player.x;
            if (xDiff <= bg2xOff) { // we can move the whole distance
                player.x = CAM_BOUND_L;
                bg2xOff -= xDiff;
            } else { // we can only move part of the distance
                int netDx = xDiff - bg2xOff; // this is how far we can't move
                bg2xOff -= xDiff - netDx; // move the camera left how far we can move
                player.x -= netDx; // move the player left how far we can't move
            }
        }
    }
    if (player.x + player.width > CAM_BOUND_R) {
        if (bg2xOff < GAMEWIDTH - SCREENWIDTH) { 
            int xDiff = player.x + player.width - CAM_BOUND_R;
            if (xDiff + bg2xOff <= GAMEWIDTH - SCREENWIDTH) {
                player.x = CAM_BOUND_R - player.width;
                bg2xOff += xDiff;
            } else {
                int netDx = (xDiff + bg2xOff + SCREENWIDTH) - GAMEWIDTH;
                bg2xOff += xDiff - netDx;
                player.x += netDx;
            }
        }
    }
    if (player.y < CAM_BOUND_T) {
        if (bg2yOff > 0) { 
            int yDiff = CAM_BOUND_T - player.y;
            if (yDiff <= bg2yOff) {
                player.y = CAM_BOUND_T;
                bg2yOff -= yDiff;
            } else {
                int netDy = yDiff - bg2yOff;
                bg2yOff -= yDiff - netDy;
                player.y -= netDy;
            }
        }
    }
    if (player.y + player.height > CAM_BOUND_B) {
        if (bg2yOff < GAMEHEIGHT - SCREENHEIGHT) { 
            int yDiff = player.y + player.height - CAM_BOUND_B;
            if (yDiff + bg2yOff <= GAMEHEIGHT - SCREENHEIGHT) {
                player.y = CAM_BOUND_B - player.height;
                bg2yOff += yDiff;
            } else {
                int netDy = (yDiff + bg2yOff + SCREENHEIGHT) - GAMEHEIGHT;
                bg2yOff += yDiff - netDy;
                player.y += netDy;
            }
        }
    }
}

// ShadowOAM sprite stuff for the player
void drawPlayer() {
    // Stuff for animating the player
    static int frameCounter = 0;
    static int aniFrame = 0;
    if (frameCounter > 10) {
        aniFrame++;
        aniFrame %= 4;
        frameCounter = 0;
    }
    shadowOAM[PLAYER_IDX].attr0 = (player.y & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[PLAYER_IDX].attr1 = (player.x & COLMASK) | ATTR1_TINY;
    switch (aniFrame)
    {
    case 0:
        shadowOAM[PLAYER_IDX].attr2 = ATTR2_TILEID64(0, 28) | ATTR2_PRIORITY(PLAYER_PRIORITY);
        break;
    case 1:
        shadowOAM[PLAYER_IDX].attr2 = ATTR2_TILEID64(2, 28) | ATTR2_PRIORITY(PLAYER_PRIORITY);
        break;
    case 2:
        shadowOAM[PLAYER_IDX].attr2 = ATTR2_TILEID64(4, 28) | ATTR2_PRIORITY(PLAYER_PRIORITY);
        break;
    case 3:
        shadowOAM[PLAYER_IDX].attr2 = ATTR2_TILEID64(6, 28) | ATTR2_PRIORITY(PLAYER_PRIORITY);
        break;
    }
    if (player.facing == LEFT) {
        shadowOAM[PLAYER_IDX].attr1 |= ATTR1_HFLIP;
    }
    frameCounter++;
}

// Shoot a bullet
void firePlayer() {
    // Player shoots in the direction they're facing
    fp64 dx, startx, starty;
    if (player.facing == RIGHT) { // right
        dx = BULLET_MAX_V;
        startx = player.int_x + ENCODE26_6(player.width);
        starty = player.int_y + ENCODE26_6(player.height / 2);
    } else { // left
        dx = -BULLET_MAX_V;
        startx = player.int_x - ENCODE26_6(bullets[0].width);
        starty = player.int_y + ENCODE26_6(player.height / 2);
    }
    for (int i = 0; i < NUM_BULLETS; i++) {
        if (!bullets[i].active) {
            bullets[i].active = 1;
            bullets[i].dx = dx;
            bullets[i].dy = 0;
            bullets[i].int_x = startx;
            bullets[i].int_y = starty;
            bullets[i].x = DECODE26_6(bullets[i].int_x);
            bullets[i].y = DECODE26_6(bullets[i].int_y);
            playSoundB(shootsfx_data, shootsfx_length, 0);
            break;
        }
    }
}

// Update the player
void updatePlayer() {
    // Interpret player input
    int slowMode = 0;
    if (BUTTON_HELD(BUTTON_R)) {
        slowMode = 1;
    }
    if (BUTTON_HELD(BUTTON_LEFT)) {
        player.dx += -(slowMode ? PLAYER_MAX_A / 2 : PLAYER_MAX_A);
        if (cheater && BUTTON_HELD(BUTTON_L)) {
            player.dx = -PLAYER_MAX_V * 4;
        }
    } else if (BUTTON_HELD(BUTTON_RIGHT)) {
        player.dx += (slowMode ? PLAYER_MAX_A / 2 : PLAYER_MAX_A);
        if (cheater && BUTTON_HELD(BUTTON_L)) {
            player.dx = PLAYER_MAX_V * 4;
        }
    } else {
        if (cheater && BUTTON_HELD(BUTTON_L)) {
            player.dx = 0;
        }
        if (player.dx > 0) {
            player.dx -= PLAYER_DRAG;
        } else if (player.dx < 0) {
            player.dx += PLAYER_DRAG;
        }
    }
    if (BUTTON_HELD(BUTTON_UP)) {
        player.dy += -(slowMode ? PLAYER_MAX_A / 2 : PLAYER_MAX_A);
        if (cheater && BUTTON_HELD(BUTTON_L)) {
            player.dy = -PLAYER_MAX_V * 4;
        }
    } else if (BUTTON_HELD(BUTTON_DOWN)) {
        player.dy += (slowMode ? PLAYER_MAX_A / 2 : PLAYER_MAX_A);
        if (cheater && BUTTON_HELD(BUTTON_L)) {
            player.dy = PLAYER_MAX_V * 4;
        }
    } else {
        if (cheater && BUTTON_HELD(BUTTON_L)) {
            player.dy = 0;
        }
        if (player.dy > 0) {
            player.dy -= PLAYER_DRAG;
        } else if (player.dy < 0) {
            player.dy += PLAYER_DRAG;
        }
    }
    if (!(cheater && BUTTON_HELD(BUTTON_L))) {
        if (player.dx > (slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V)) player.dx = (slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V);
        if (player.dx < -(slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V)) player.dx = -(slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V);
        if (player.dy > (slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V)) player.dy = (slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V);
        if (player.dy < -(slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V)) player.dy = -(slowMode ? PLAYER_MAX_V / 2 : PLAYER_MAX_V);
    }

    // Move player
    movePlayer();

    if (player.dx > 0) {
        player.facing = RIGHT;
    } else if (player.dx < 0) {
        player.facing = LEFT;
    }

    // bang bang
    if (BUTTON_PRESSED(BUTTON_A)) {
        firePlayer();
    }
    
    // Update sprite
    drawPlayer();
}

// Update a bullet
void updateBullet(BULLET* bullet) {
    bullet->int_x += bullet->dx;
    bullet->int_y += bullet->dy;
    // remove the bullet if it hits the collision map, level edge, or a dude
    if ((bullet->int_x < 0) ||
        (bullet->int_x + ENCODE26_6(bullet->width) > ENCODE26_6(GAMEWIDTH)) ||
        (bullet->int_y < 0) ||
        (bullet->int_y + ENCODE26_6(bullet->height) > ENCODE26_6(GAMEHEIGHT))) 
    {
        bullet->active = 0;
    }
    if (collisionCheck(collisionMap, 1024, DECODE26_6(bullet->int_x), DECODE26_6(bullet->int_y), bullet->width, bullet->height)) {
        bullet->active = 0;
    }

    bullet->x = DECODE26_6(bullet->int_x) - bg2xOff;
    bullet->y = DECODE26_6(bullet->int_y) - bg2yOff;
    // Only draw the bullet if any part of it is onscreen
    if (bullet->active && !(
        (bullet->x + bullet->width - 1 < 0) ||
        (bullet->x > SCREENWIDTH) ||
        (bullet->y + bullet->height - 1 < 0) ||
        (bullet->y > SCREENHEIGHT)))
    {
        shadowOAM[bullet->spriteIdx].attr0 = (bullet->y & ROWMASK) | ATTR0_REGULAR | ATTR0_SQUARE | ATTR0_8BPP;
        shadowOAM[bullet->spriteIdx].attr1 = (bullet->x & COLMASK) | ATTR1_TINY;
        // The bullet is gonna be way too big but this is just placeholder until we get a real sprite
        shadowOAM[bullet->spriteIdx].attr2 = ATTR2_TILEID64(0, 31) | ATTR2_PRIORITY(BULLET_PRIORITY);
    } else {
        shadowOAM[bullet->spriteIdx].attr0 = ATTR0_HIDE;
    }
}

// Update an enemy
void updateEnemy(ENEMY* enemy) {
    // Right now enemies don't do anything
    enemy->int_x += enemy->dx;
    enemy->int_y += enemy->dy;
    enemy->x = DECODE26_6(enemy->int_x) - bg2xOff;
    enemy->y = DECODE26_6(enemy->int_y) - bg2yOff;
    // Only draw the enemy if any part of it is onscreen
    if (enemy->active && !(
        (enemy->x + enemy->width - 1 < 0) ||
        (enemy->x > SCREENWIDTH) ||
        (enemy->y + enemy->height - 1 < 0) ||
        (enemy->y > SCREENHEIGHT)))
    {
        drawEnemy(enemy);
    }
}

// Update a mine
void updateMine(MINE* mine) {
    mine->int_x += mine->dx;
    mine->int_y += mine->dy;
    mine->x = DECODE26_6(mine->int_x) - bg2xOff;
    mine->y = DECODE26_6(mine->int_y) - bg2yOff;
    // Only draw the mine if any part of it is onscreen
    if (mine->active && !(
        (mine->x + mine->width - 1 < 0) ||
        (mine->x > SCREENWIDTH) ||
        (mine->y + mine->height - 1 < 0) ||
        (mine->y > SCREENHEIGHT)))
    {
        drawMine(mine);
    }
}

// Update a pickup
void updatePickup(PICKUP* pickup) {
    pickup->x = DECODE26_6(pickup->int_x) - bg2xOff;
    pickup->y = DECODE26_6(pickup->int_y) - bg2yOff;
    // Only draw if partly onscreen
    if (pickup->active && !(
        (pickup->x + pickup->width - 1 < 0) ||
        (pickup->x > SCREENWIDTH) ||
        (pickup->y + pickup->height - 1 < 0) ||
        (pickup->y > SCREENHEIGHT)))
    {
        drawPickup(pickup);
    }
}

// Hides all enemy sprites
void freeEnemySprites() {
    for (int i = 0; i < NUM_ENEMY_SPRITES; i++) {
        shadowOAM[ENEMY1 + i].attr0 = ATTR0_HIDE;
    }
    drawnEnemies = 0;
}

// Draws an enemy sprite
void drawEnemy(ENEMY* enemy) {
    // Only draw as many enemies as we have sprites for
    if (drawnEnemies < NUM_ENEMY_SPRITES) {
        if (enemy->type == BOSS) {
            shadowOAM[ENEMY1 + drawnEnemies].attr0 = (enemy->y & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
            shadowOAM[ENEMY1 + drawnEnemies].attr1 = (enemy->x & COLMASK) | ATTR1_MEDIUM;
            shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(8, 26) | ATTR2_PRIORITY(ENEMY_PRIORITY);
        } else {
            shadowOAM[ENEMY1 + drawnEnemies].attr0 = (enemy->y & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
            shadowOAM[ENEMY1 + drawnEnemies].attr1 = (enemy->x & COLMASK) | ATTR1_TINY;
            switch (enemyAniFrame)
            {
            case 0:
                switch (enemy->type)
                {
                case FISH:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(0, 29) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case BARRACUDA:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(8, 28) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case SHARK:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(8, 29) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case ANGLER:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(8, 30) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case PUFFER:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(8, 31) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                }
                break;
            case 1:
                switch (enemy->type)
                {
                case FISH:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(2, 29) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case BARRACUDA:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(10, 28) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case SHARK:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(10, 29) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case ANGLER:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(10, 30) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case PUFFER:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(10, 31) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                }
                break;
            case 2:
                switch (enemy->type)
                {
                case FISH:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(4, 29) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case BARRACUDA:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(12, 28) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case SHARK:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(12, 29) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case ANGLER:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(12, 30) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                case PUFFER:
                    shadowOAM[ENEMY1 + drawnEnemies].attr2 = ATTR2_TILEID64(12, 31) | ATTR2_PRIORITY(ENEMY_PRIORITY);
                    break;
                }
                break;
            }  
        }
        drawnEnemies++;
    }
}

// Hides all mine sprites
void freeMineSprites() {
    for (int i = 0; i < NUM_MINE_SPRITES; i++) {
        shadowOAM[MINE1 + i].attr0 = ATTR0_HIDE;
    }
    drawnMines = 0;
}

// Draws a mine sprite
void drawMine(MINE* mine) {
    // Only draw as many mines as we have sprites for
    if (drawnMines < NUM_MINE_SPRITES) {
        switch (mineAniFrame)
        {
        case 0:
            shadowOAM[MINE1 + drawnMines].attr2 = ATTR2_TILEID64(0, 30) | ATTR2_PRIORITY(MINE_PRIORITY);
            break;
        case 1:
            shadowOAM[MINE1 + drawnMines].attr2 = ATTR2_TILEID64(1, 30) | ATTR2_PRIORITY(MINE_PRIORITY);
            break;
        case 2:
            shadowOAM[MINE1 + drawnMines].attr2 = ATTR2_TILEID64(2, 30) | ATTR2_PRIORITY(MINE_PRIORITY);
            break;
        }
        shadowOAM[MINE1 + drawnMines].attr0 = (mine->y & ROWMASK) | ATTR0_REGULAR | ATTR0_SQUARE | ATTR0_8BPP;
        shadowOAM[MINE1 + drawnMines].attr1 = (mine->x & COLMASK) | ATTR1_TINY;
        drawnMines++;
    }
}

// Hides all pickup sprites
void freePickupSprites() {
    for (int i = 0; i < NUM_PICKUP_SPRITES; i++) {
        shadowOAM[PICKUP1 + i].attr0 = ATTR0_HIDE;
    }
    drawnPickups = 0;
}

// Draws a pickup sprite
void drawPickup(PICKUP* pickup) {
    // Only draw as many pickups as we have sprites for
    if (drawnPickups < NUM_PICKUP_SPRITES) {
        shadowOAM[PICKUP1 + drawnPickups].attr0 = (pickup->y & ROWMASK) | ATTR0_REGULAR | ATTR0_SQUARE | ATTR0_8BPP;
        shadowOAM[PICKUP1 + drawnPickups].attr1 = (pickup->x & COLMASK) | ATTR1_TINY;
        switch (pickup->effect)
        {
        case UPGRADE_TORP:
            shadowOAM[PICKUP1 + drawnPickups].attr2 = ATTR2_TILEID64(3, 31) | ATTR2_PRIORITY(PICKUP_PRIORITY);
            break;
        case UPGRADE_BLAST:
            shadowOAM[PICKUP1 + drawnPickups].attr2 = ATTR2_TILEID64(4, 31) | ATTR2_PRIORITY(PICKUP_PRIORITY);
            break;
        case UPGRADE_SHIELD:
            shadowOAM[PICKUP1 + drawnPickups].attr2 = ATTR2_TILEID64(2, 31) | ATTR2_PRIORITY(PICKUP_PRIORITY);
            break;
        case RESTORE_HP:
            shadowOAM[PICKUP1 + drawnPickups].attr2 = ATTR2_TILEID64(5, 31) | ATTR2_PRIORITY(PICKUP_PRIORITY);
            break;
        }
        drawnPickups++;
    }
}

// Display the submarine's healthbar
void updateHealthBar() {
    // This is done using simpler techniques than battle mode
    // There are 26 tiles of healthbar
    // Left nub
    shadowOAM[HEALTHBAR1].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_SQUARE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR1].attr1 = (16 & COLMASK) | ATTR1_TINY;
    if (submarineHp > 0) {
        shadowOAM[HEALTHBAR1].attr2 = ATTR2_TILEID64(0, 24) | ATTR2_PRIORITY(HUD_PRIORITY);
    } else {
        shadowOAM[HEALTHBAR1].attr2 = ATTR2_TILEID64(0, 25) | ATTR2_PRIORITY(HUD_PRIORITY);
    }

    // Middle section
    shadowOAM[HEALTHBAR2].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR2].attr1 = ((24 + 32 * 0) & COLMASK) | ATTR1_SMALL;
    shadowOAM[HEALTHBAR2].attr2 = ATTR2_TILEID64(5 - tilesRed(1, submarineHp, submarineMaxHp, 26), 24) | ATTR2_PRIORITY(HUD_PRIORITY);
    
    shadowOAM[HEALTHBAR3].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR3].attr1 = ((24 + 32 * 1) & COLMASK) | ATTR1_SMALL;
    shadowOAM[HEALTHBAR3].attr2 = ATTR2_TILEID64(5 - tilesRed(5, submarineHp, submarineMaxHp, 26), 24) | ATTR2_PRIORITY(HUD_PRIORITY);

    shadowOAM[HEALTHBAR4].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR4].attr1 = ((24 + 32 * 2) & COLMASK) | ATTR1_SMALL;
    shadowOAM[HEALTHBAR4].attr2 = ATTR2_TILEID64(5 - tilesRed(9, submarineHp, submarineMaxHp, 26), 24) | ATTR2_PRIORITY(HUD_PRIORITY);

    shadowOAM[HEALTHBAR5].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR5].attr1 = ((24 + 32 * 3) & COLMASK) | ATTR1_SMALL;
    shadowOAM[HEALTHBAR5].attr2 = ATTR2_TILEID64(5 - tilesRed(13, submarineHp, submarineMaxHp, 26), 24) | ATTR2_PRIORITY(HUD_PRIORITY);

    shadowOAM[HEALTHBAR6].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR6].attr1 = ((24 + 32 * 4) & COLMASK) | ATTR1_SMALL;
    shadowOAM[HEALTHBAR6].attr2 = ATTR2_TILEID64(5 - tilesRed(17, submarineHp, submarineMaxHp, 26), 24) | ATTR2_PRIORITY(HUD_PRIORITY);

    shadowOAM[HEALTHBAR7].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_WIDE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR7].attr1 = ((24 + 32 * 5) & COLMASK) | ATTR1_SMALL;
    shadowOAM[HEALTHBAR7].attr2 = ATTR2_TILEID64(5 - tilesRed(21, submarineHp, submarineMaxHp, 26), 24) | ATTR2_PRIORITY(HUD_PRIORITY);

    // Right nub
    shadowOAM[HEALTHBAR8].attr0 = (HEALTHBAR_VOFF & ROWMASK) | ATTR0_REGULAR | ATTR0_SQUARE | ATTR0_8BPP;
    shadowOAM[HEALTHBAR8].attr1 = ((24 + 32 * 6) & COLMASK) | ATTR1_TINY | ATTR1_HFLIP;
    if (submarineHp > ((25 * submarineMaxHp) / 26)) {
        shadowOAM[HEALTHBAR8].attr2 = ATTR2_TILEID64(0, 24) | ATTR2_PRIORITY(HUD_PRIORITY);
    } else {
        shadowOAM[HEALTHBAR8].attr2 = ATTR2_TILEID64(0, 25) | ATTR2_PRIORITY(HUD_PRIORITY);
    }
}