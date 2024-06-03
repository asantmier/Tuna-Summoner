/* PROGRESS REPORT
 * So far the core gameplay mechanics of the game are complete.
 * All world exploration mechanics are in place, with the exception of items you can pick up to heal yourself.
 * The world design is also done. 
 * The combat system is also done to a satisfactory extent.
 * There are a variety of enemies. It would be cool if they moved back and forth, but there were more important features to implement.
 * 
 * BUGS: None known
 * 
 * Not a bug, but for some reason, a loud burst of static plays at the end of all sound. Apparently the provided 
 *      functions are reading too far. As a solution, I manually added 1/25th of a second to all audio and subtracted 
 *      that much from the length of each in the playSound functions. Thought it might be worthwhile to explain that
 *      solution.
 * 
 * HOW TO PLAY: Directional pad to move, right bumper to move slower, A to shoot.
 *     If you collide with or shoot the enemies (red box) you will enter combat.
 *     If you collide with the mines (pink box) you will take damage.
 *     Your health bar is at the top of your screen, if it runs out you lose.
 *     Use the directional pad, A (select), and B (go back) to navigate the menus in combat. Defeat all the enemies to win.
 *     If the enemies defeat your team, you will lose the battle and take damage.
 *     Your team starts at full health in every battle. You can expand or upgrade your team by capturing enemies.
 *     Capturing enemies is easier the lower their health is. You can replace an empty slot on your team to expand it, but if
 *     your team is full you will have to replace a teammate or hit B to just not use the captured enemy.
 * 
 * CHEATING: Activate the cheat by inputting the Konami code in either the overworld or battle states.
 *      (up, up, down, down, left, right, left, right, b, a, start)
 *      The cheat gives you a lot of health, two new overpowered moves, and enables speedup mode.
 *      With the cheat active in the overworld, hold down the left bumper to move really fast.
 * 
 * TO DO LIST:
 * PLAYTEST
 * MAIN MENU MUSIC?
 * MOSAIC
 * SAVING
 * BUDDY EVOLUTION
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "mode0.h"
#include "print.h"
#include "world.h"
#include "battle.h"
#include "game.h"
#include "spritesheet.h"
#include "splashscreen.h"
#include "instructions.h"
#include "pause.h"
#include "win.h"
#include "lose.h"
#include "tempbattle.h"
#include "world1.h"
#include "world1parallax.h"
#include "sound.h"
#include "worldTheme.h"
#include "battleTheme.h"
#include "bossTheme.h"

// Prototypes.
void interruptHandler();
void initialize();
void worldAnim();
void prepareWorldAnim();
void lmao();

// State Prototypes.
void goToStart();
void start();
void goToInstructions();
void instructions();
void goToGame();
void game();
void goToBattle();
void battle();
void goToPause();
void pause();
void goToWin();
void win();
void goToLose();
void lose();

// States.
enum {
    START,
    INSTRUCTIONS,
    GAME,
    BATTLE,
    PAUSE,
    WIN,
    LOSE
};
int state;

// Button Variables.
unsigned short buttons;
unsigned short oldButtons;

// Shadow OAM.
OBJ_ATTR shadowOAM[128];
fp256 bg2xOff, bg2yOff;
int bg1xOff, bg1yOff;

// Timer for srand
int randTimer;

// Store position in songs
int worldThemeCtr;

int main() {
    // Enable debug logging
    mgba_open();

    initialize();

    while (1) {
        // Update button variables.
        oldButtons = buttons;
        buttons = BUTTONS;

        // State Machine.
        switch (state) {
        case START:
            start();
            break;
        case INSTRUCTIONS:
            instructions();
            break;
        case GAME:
            game();
            lmao();
            break;
        case BATTLE:
            battle();
            lmao();
            break;
        case PAUSE:
            pause();
            break;
        case WIN:
            win();
            break;
        case LOSE:
            lose();
            break;
        }
    }
}

// only run the cheat detection function in game and battle. it wouldn't make much sense in the other states
// lol
void lmao() {
    // cheating is fun
    // i lied, this was unnaturally difficult to make work
    static int konami[] = { BUTTON_UP, BUTTON_UP, BUTTON_DOWN, BUTTON_DOWN, BUTTON_LEFT, BUTTON_RIGHT, BUTTON_LEFT, BUTTON_RIGHT, BUTTON_B, BUTTON_A, BUTTON_START };
    static int konamiIdx = 0;
    int prev = konamiIdx - 1;
    if (prev < 0) prev = 0;
    if (BUTTON_PRESSED(konami[konamiIdx])) {
        konamiIdx++;
        mgba_printf("Konami %d", konamiIdx);
    } else {
        // if the right button was not just pressed this frame, check if any other button was JUST pressed
        // the button register freaky, so we have to use BUTTON_PRESSED here
        // TIL that the button register is flagged on button release too. i think? just checking if the button register was its default
        // value + the previous button still held down didn't give sensible output
        for (int i = 0; i <= 9; i++) {
            if (BUTTON_PRESSED(1 << i)) {
                konamiIdx = 0;
                mgba_printf("Konami reset %d", buttons);
                break;
            }
        }
    }
    
    // if the full code was input, its cheating time
    if (konamiIdx == 11) {
        cheater = 1;
        battleAllies[0].numMoves = 5;
        battleAllies[0].moves[3] = &MOVE_DEATHRAY;
        battleAllies[0].moves[4] = &MOVE_BRUH;
        battleAllies[0].maxHp = 99;
        battleAllies[0].hp = 99;
        strncpy(battleAllies[0].name, "CHEATER", NAME_LEN);
        submarineHp = submarineMaxHp;

        mgba_printf("Konami code confirmed");
        konamiIdx = 0;
    }
}

void interruptHandler() {
	REG_IME = 0;

	soundInterruptHandler();

    if(REG_IF & INT_TM2) {
        waiting = 0;
        // Set turnPoints to nextTurnPoints. After each turn, the turn token counter displays turnPoints tokens.
        // When we swap teams turns, we want to show 0 tokens during the wait period, so we set nextTurnPoints equal
        // to the number of turn tokens the next team is going to need. When the wait timer finishes, we can then update turnPoints
        // and the game will display the number of tokens we want.
        mgba_printf("Battle timer interrupt");
        turnPoints = nextTurnPoints;
        fighterIdx = nextFighterIdx;
        turn = nextTurn;
        REG_TM2CNT = TIMER_OFF;

		REG_IF = INT_TM2;
	}

	REG_IME = 1;
}

// Sets up GBA.
void initialize() {
    // Turn of display so the weirdest thing the player sees is black
    REG_DISPCTL = MODE1;
    // The almighty DMA
    // Sprites
    DMANow(3, &spritesheetPal, SPRITEPALETTE, 256);
    DMANow(3, &spritesheetTiles, &CHARBLOCK[4], DMA_32 | (spritesheetTilesLen / 4));
    // Backgrounds
    // BG0 contains the splashscreen and instructions. Later it will contain the battle background and pause
    DMANow(3, &splashscreenTiles, &CHARBLOCK[1], DMA_32 | (splashscreenTilesLen / 4));
    DMANow(3, &splashscreenMap, &SCREENBLOCK[15], DMA_32 | (splashscreenMapLen / 4));
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_8BPP | BG_SIZE_SMALL;
    // BG1 contains the parallax background
    // IF THE PARALLAX BACKGROUND IS BLACK YOU FORGOT TO IMPORT THE PALETTE INTO THE FOREGROUND
    DMANow(3, &world1parallaxTiles, &CHARBLOCK[2], DMA_32 | (world1parallaxTilesLen / 4));
    DMANow(3, &world1parallaxMap, &SCREENBLOCK[22], DMA_32 | (world1parallaxMapLen / 4));
    // Priority is set to 3 so that it draws below everything
    REG_BG1CNT = BG_CHARBLOCK(2) | BG_SCREENBLOCK(22) | BG_8BPP | BG_SIZE_TALL | 3;
    // Move background back to its origin
    bg1xOff = 0;
    bg1yOff = 0;
    REG_BG1HOFF = bg1xOff;
    REG_BG1VOFF = bg1yOff;
    // BG2 contains the world. It's a 128x tile map so it uses the entire 3rd charblock for its map
    DMANow(3, &world1Tiles, &CHARBLOCK[0], DMA_32 | (world1TilesLen / 4));
    DMANow(3, &world1Map, &SCREENBLOCK[24], DMA_32 | (world1MapLen / 4));
    REG_BG2CNT = BG_CHARBLOCK(0) | BG_SCREENBLOCK(24) | BG_8BPP | BG_SIZE_LARGE | BG_WRAP | 2;
    *REG_BG2_AFFINE = bg_aff_default;
    // Move background back to its origin
    bg2xOff = 0;
    bg2yOff = 0;
    REG_BG2X = ENCODE24_8(bg2xOff);
    REG_BG2Y = ENCODE24_8(bg2yOff);
    // begone sprites
    hideSprites();
    DMANow(3, &shadowOAM, OAM, 128 * 4);

    // Activate sound
    setupSounds();
    setupSoundInterrupts();

    // Activiate interrupt handler
    REG_IME = 0;
    REG_INTERRUPT = interruptHandler;
	REG_IME = 1;

    // Play around with memory for a bit to assist in animating the world
    prepareWorldAnim();

    // Doing this makes the entire screen flash black for 1 frame when restarting the game rather than introducing a
    // black tearing artifact at the top of the screen for 1 frame. I think it looks better
    waitForVBlank();

    // gaming: activated
    REG_DISPCTL = MODE1 | SPRITE_ENABLE | BG2_ENABLE;

    buttons = BUTTONS;
    oldButtons = 0;
    randTimer = 0;

    // its gamer time
    goToStart();
}

// Sets up the start state.
void goToStart() {
    DMANow(3, &splashscreenTiles, &CHARBLOCK[1], DMA_32 | (splashscreenTilesLen / 4));
    DMANow(3, &splashscreenMap, &SCREENBLOCK[15], DMA_32 | (splashscreenMapLen / 4));
    DMANow(3, &world1Pal, PALETTE, 256);
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_8BPP | BG_SIZE_SMALL;
    REG_BG1CNT = BG_CHARBLOCK(2) | BG_SCREENBLOCK(22) | BG_8BPP | BG_SIZE_TALL | 3;
    REG_DISPCTL = MODE1 | SPRITE_ENABLE | BG0_ENABLE | BG2_ENABLE | BG1_ENABLE;

    bg2xOff = 424;
    bg2yOff = 716;
    REG_BG2X = ENCODE24_8(bg2xOff);
    REG_BG2Y = ENCODE24_8(bg2yOff);
    bg1xOff = 0;
    bg1yOff = 512-160;
    REG_BG1HOFF = bg1xOff;
    REG_BG1VOFF = bg1yOff;

    state = START;
}

// Runs every frame of the start state.
void start() {
    randTimer++;
    worldAnim();
    if (BUTTON_PRESSED(BUTTON_SELECT)) {
        REG_DISPCTL = MODE1 | SPRITE_ENABLE | BG2_ENABLE | BG1_ENABLE;
        goToInstructions();
    } else if (BUTTON_PRESSED(BUTTON_START)) {
        // Seed RNG
        srand(randTimer);
        initGame();
        initWorld();
        worldThemeCtr = 0;
        playSoundA(worldTheme_data, worldTheme_length, 1, worldThemeCtr);
        // Reset the camera
        bg2xOff = 0;
        bg2yOff = 0;
        REG_BG2X = ENCODE24_8(bg2xOff);
        REG_BG2Y = ENCODE24_8(bg2yOff);
        bg1xOff = 0;
        bg1yOff = 0;
        REG_BG1HOFF = bg1xOff;
        REG_BG1VOFF = bg1yOff;
        goToGame();
    }

    waitForVBlank();

}

// Sets up instructions
void goToInstructions() {
    DMANow(3, &instructionsTiles, &CHARBLOCK[1], DMA_32 | (instructionsTilesLen / 4));
    DMANow(3, &instructionsMap, &SCREENBLOCK[15], DMA_32 | (instructionsMapLen / 4));
    DMANow(3, &instructionsPal, PALETTE, 256);
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_4BPP | BG_SIZE_SMALL;
    REG_DISPCTL = MODE1 | SPRITE_ENABLE | BG0_ENABLE;

    state = INSTRUCTIONS;
}

// Runs every frame of instructions
void instructions() {
    if (BUTTON_PRESSED(BUTTON_SELECT)) {
        goToStart();
    }

    waitForVBlank();

}

// Sets up the game state.
void goToGame() {
    DMANow(3, &world1Pal, PALETTE, 256);
    REG_BG1CNT = BG_CHARBLOCK(2) | BG_SCREENBLOCK(22) | BG_8BPP | BG_SIZE_TALL | 3;
    REG_DISPCTL = MODE1 | SPRITE_ENABLE | BG2_ENABLE | BG1_ENABLE;

    state = GAME;
}

// Runs every frame of the game state.
void game() {
    updateWorld();
    worldAnim();

    if (BUTTON_PRESSED(BUTTON_SELECT)) {
        goToPause();
    }
    if (gameVictory) {
        goToWin();
    }
    
    waitForVBlank();

    DMANow(3, &shadowOAM, OAM, 128 * 4);
    REG_BG2X = ENCODE24_8(bg2xOff);
    REG_BG2Y = ENCODE24_8(bg2yOff);

    // Move the parallax background at a slower rate than the main background
    bg1xOff = bg2xOff / 4;
    bg1yOff = (int)(bg2yOff / 2.5); // Floating points math is definitely not fast, but, hey, it works
    REG_BG1HOFF = bg1xOff;
    REG_BG1VOFF = bg1yOff;

    if (submarineHp <= 0) {
        goToLose();
    }

    if (doBattle) {
        worldThemeCtr = soundA.vBlankCount; // save position in song
        stopSound();
        // Turn off all the sprites from the game state
        hideSprites();
        DMANow(3, &shadowOAM, OAM, 128 * 4);
        initBattle(enemies[opponentIdx].type); // tell the battle system what kind of enemy we're encountering
        if (bossBattle) {
            playSoundA(bossTheme_data, bossTheme_length, 1, 0);
        } else {
            playSoundA(battleTheme_data, battleTheme_length, 1, 0);
        }
        
        goToBattle();
    }
}

// Sets up the battle state
void goToBattle() {
    // DMA in the battle background (maybe we could do this earlier?)
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_8BPP | BG_SIZE_SMALL;
    DMANow(3, &tempbattlePal, PALETTE, 256);
    DMANow(3, &tempbattleTiles, &CHARBLOCK[1], DMA_32 | (tempbattleTilesLen / 4));
    DMANow(3, &tempbattleMap, &SCREENBLOCK[15], DMA_32 | (tempbattleMapLen / 4));
    REG_DISPCTL = MODE1 | SPRITE_ENABLE | BG0_ENABLE;

    state = BATTLE;
}

// Runs every frame of the battle state
void battle() {
    updateBattle();

    if (battleStatus == LOST || battleStatus == WON) {
        battleAllies[0].hp = battleAllies[0].maxHp;
        for (int i = 1; i < 4; i++) {
            battleAllies[i].hp += battleAllies[i].maxHp / 2;
            if (battleAllies[i].hp > battleAllies[i].maxHp) battleAllies[i].hp = battleAllies[i].maxHp;
        }
        if (battleStatus == LOST) {
            if (bossBattle) {
                goToLose();
            }
            submarineHp -= 20;
            returnFromBattle(0);
        } else if (battleStatus == WON) {
            returnFromBattle(1);
        }
        // Turn off all the sprites from the battle state
        hideSprites();
        DMANow(3, &shadowOAM, OAM, 128 * 4);
        stopSound();
        playSoundA(worldTheme_data, worldTheme_length, 1, worldThemeCtr);
        goToGame();
    }

    waitForVBlank();

    DMANow(3, &shadowOAM, OAM, 128 * 4);
    REG_BG2X = ENCODE24_8(bg2xOff);
    REG_BG2Y = ENCODE24_8(bg2yOff);
}

// Sets up the pause state.
void goToPause() {
    // TODO MAKE BG TRANSPARENT
    pauseSound();
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_8BPP | BG_SIZE_SMALL;
    // DMANow(3, &pausePal, PALETTE, 256);
    DMANow(3, &pauseTiles, &CHARBLOCK[1], DMA_32 | (pauseTilesLen / 4));
    DMANow(3, &pauseMap, &SCREENBLOCK[15], DMA_32 | (pauseMapLen / 4));
    REG_DISPCTL = MODE1 | BG0_ENABLE | BG1_ENABLE | BG2_ENABLE | SPRITE_ENABLE;

    state = PAUSE;
}

// Runs every frame of the pause state.
void pause() {
    if (BUTTON_PRESSED(BUTTON_SELECT)) {
        unpauseSound();
        goToGame();
    } else if (BUTTON_PRESSED(BUTTON_START)) {
        initialize(); // restart the game
    }

    waitForVBlank();

}

// Sets up the win state.
void goToWin() {
    stopSound();
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_8BPP | BG_SIZE_SMALL;
    // DMANow(3, &winPal, PALETTE, 256);
    DMANow(3, &winTiles, &CHARBLOCK[1], DMA_32 | (winTilesLen / 4));
    DMANow(3, &winMap, &SCREENBLOCK[15], DMA_32 | (winMapLen / 4));
    bg2xOff = 5;
    bg2yOff = 858;
    REG_BG2X = ENCODE24_8(bg2xOff);
    REG_BG2Y = ENCODE24_8(bg2yOff);
    bg1xOff = 0;
    bg1yOff = 512-160;
    REG_BG1HOFF = bg1xOff;
    REG_BG1VOFF = bg1yOff;
    REG_DISPCTL = MODE1 | BG0_ENABLE | BG1_ENABLE | BG2_ENABLE;

    state = WIN;
}

// Runs every frame of the win state.
void win() {
    if (BUTTON_PRESSED(BUTTON_START)) {
        initialize(); // restart the game
    }

    waitForVBlank();

}

// Sets up the lose state.
void goToLose() {
    stopSound();
    REG_BG0CNT = BG_CHARBLOCK(1) | BG_SCREENBLOCK(15) | BG_4BPP | BG_SIZE_SMALL;
    DMANow(3, &losePal, PALETTE, 256);
    DMANow(3, &loseTiles, &CHARBLOCK[1], DMA_32 | (loseTilesLen / 4));
    DMANow(3, &loseMap, &SCREENBLOCK[15], DMA_32 | (loseMapLen / 4));
    REG_DISPCTL = MODE1 | BG0_ENABLE;

    state = LOSE;
}

// Runs every frame of the lose state.
void lose() {
    if (BUTTON_PRESSED(BUTTON_START)) {
        initialize(); // restart the game
    }

    waitForVBlank();

}

/* TILE IDS
    * XX FLOOR LWALL RWALL CEIL COR1 COR2 COR3 COR4 XCOR1 XCOR2 XCOR3 XCOR4
    * F1  7     26    25    24   13   4    14   5    23    8     22    12
    * F2  72    68    64    66   70   61   59   57   55    53    51    49
    * F3  73    69    65    67   71   62   60   58   56    54    52    50
    * 
    * FIRST UNUSED TILE: 74
*/
enum { FLOOR_SRC=7, LWALL_SRC=2, RWALL_SRC=3, CEILI_SRC=6, CORN1_SRC=13, CORN2_SRC=4, CORN3_SRC=14, CORN4_SRC=5, XCOR1_SRC=22, XCOR2_SRC=8, XCOR3_SRC=21, XCOR4_SRC=12 };
enum { FLOOR_F2=66, LWALL_F2=62, RWALL_F2=58, CEILI_F2=60, CORN1_F2=64, CORN2_F2=56, CORN3_F2=53, CORN4_F2=51, XCOR1_F2=49, XCOR2_F2=47, XCOR3_F2=45, XCOR4_F2=43 };
enum { FLOOR_F3=67, LWALL_F3=63, RWALL_F3=59, CEILI_F3=61, CORN1_F3=65, CORN2_F3=57, CORN3_F3=54, CORN4_F3=52, XCOR1_F3=50, XCOR2_F3=48, XCOR3_F3=46, XCOR4_F3=44 };
#define FREETILE 80
enum { FLOOR_F1 = FREETILE + 0, LWALL_F1, RWALL_F1, CEILI_F1, CORN1_F1, CORN2_F1, CORN3_F1, CORN4_F1, XCOR1_F1, XCOR2_F1, XCOR3_F1, XCOR4_F1 };

// DMAs tile frame 1s into a spot after the rest of the tiles for safe keeping
void prepareWorldAnim() {
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_F1)) / 2], DMA_32 | ((8 * 8) / 4));
    DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_SRC)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_F1)) / 2], DMA_32 | ((8 * 8) / 4));
}

// Animates the world's tiles
void worldAnim() {
    static int frameCounter = 0;
    // 0: F1, 1: F2, 2: F3, 3: F2
    static int aniFrame = 0;
    if (frameCounter > 30) {
        aniFrame++;
        aniFrame %= 3;
        frameCounter = 0;
    }

    switch (aniFrame)
    {
    case 0:
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_F1)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        break;
    // case 3: // Fall through
    case 1:
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_F2)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        break;
    case 2:
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (FLOOR_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (LWALL_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (RWALL_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CEILI_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN1_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN2_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN3_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (CORN4_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR1_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR2_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR3_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        DMANow(3, &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_F3)) / 2], &CHARBLOCK[0].tileimg[((8 * 8) * (XCOR4_SRC)) / 2], DMA_32 | ((8 * 8) / 4));
        break;
    }

   frameCounter++;
}