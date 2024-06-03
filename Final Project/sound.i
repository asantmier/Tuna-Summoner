# 1 "sound.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "sound.c"
# 1 "mode0.h" 1




typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
# 60 "mode0.h"
typedef int fp256;

extern fp256 bg2xOff, bg2yOff;


typedef struct {
    short pa, pb;
    short pc, pd;
    int dx, dy;
} BG_AFFINE;




extern const BG_AFFINE bg_aff_default;
# 84 "mode0.h"
extern volatile unsigned short *videoBuffer;
# 105 "mode0.h"
typedef struct {
    u16 tileimg[8192];
} charblock;


typedef struct {
    u16 tilemap[1024];
} screenblock;



void setPixel3(int col, int row, unsigned short color);
void drawRect3(int col, int row, int width, int height, volatile unsigned short color);
void fillScreen3(volatile unsigned short color);
void drawImage3(int col, int row, int width, int height, const unsigned short *image);
void drawFullscreenImage3(const unsigned short *image);


void setPixel4(int col, int row, unsigned char colorIndex);
void drawRect4(int col, int row, int width, int height, volatile unsigned char colorIndex);
void fillScreen4(volatile unsigned char colorIndex);
void drawImage4(int col, int row, int width, int height, const unsigned short *image);
void drawFullscreenImage4(const unsigned short *image);


void waitForVBlank();
void flipPage();




typedef struct {
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
} OBJ_ATTR;



extern OBJ_ATTR shadowOAM[];
# 177 "mode0.h"
void hideSprites();






typedef struct {
    int worldRow;
    int worldCol;
    int rdel;
    int cdel;
    int width;
    int height;
    int aniCounter;
    int aniState;
    int prevAniState;
    int curFrame;
    int numFrames;
    int hide;
} SPRITE;
# 217 "mode0.h"
extern unsigned short oldButtons;
extern unsigned short buttons;
# 227 "mode0.h"
typedef volatile struct {
    volatile const void *src;
    volatile void *dst;
    volatile unsigned int cnt;
} DMA;


extern DMA *dma;
# 267 "mode0.h"
void DMANow(int channel, volatile const void *src, volatile void *dst, unsigned int cnt);
# 303 "mode0.h"
typedef void (*ihp)(void);
# 322 "mode0.h"
int collision(int colA, int rowA, int widthA, int heightA, int colB, int rowB, int widthB, int heightB);
int collisionCheck(unsigned char *collisionMap, int mapWidth, int x, int y, int width, int height);
# 2 "sound.c" 2
# 1 "sound.h" 1
void setupSounds();
void playSoundA(const signed char* sound, int length, int loops, int offset);
void playSoundB(const signed char* sound, int length, int loops);

void setupSoundInterrupts();
void soundInterruptHandler();

void pauseSound();
void unpauseSound();
void stopSound();
# 49 "sound.h"
typedef struct{
    const signed char* data;
    int length;
    int frequency;
    int isPlaying;
    int loops;
    int duration;
    int priority;
    int vBlankCount;
} SOUND;

SOUND soundA;
SOUND soundB;
# 3 "sound.c" 2

void setupSounds() {

    *(volatile u16 *)0x04000084 = (1<<7);

 *(volatile u16*)0x04000082 = (1<<1) |
                     (1<<2) |
                     (3<<8) |
                     (0<<10) |
                     (1<<11) |
                     (1<<3) |
                     (3<<12) |
                     (1<<14) |
                     (1<<15);

 *(u16*)0x04000080 = 0;
}


void playSoundA( const signed char* sound, int length, int loops, int offset) {
    length -= (11025);
    dma[1].cnt = 0;

    int ticks = (16777216) / 11025;


    DMANow(1, sound + ((offset * 11025) / 60), (u16*)0x040000A0, (2 << 21) | (3 << 28) | (1 << 25) | (1 << 26));

    *(volatile unsigned short*)0x4000102 = 0;

    *(volatile unsigned short*)0x4000100 = -ticks;
    *(volatile unsigned short*)0x4000102 = (1<<7);

    soundA.data = sound;
    soundA.length = length;
    soundA.loops = loops;
    soundA.isPlaying = 1;
    soundA.duration = ((59.727) * length) / 11025;
    soundA.vBlankCount = offset;
}


void playSoundB( const signed char* sound, int length, int loops) {
    length -= (11025 / 25);
    dma[2].cnt = 0;

    int ticks = (16777216) / 11025;

    DMANow(2, sound, (u16*)0x040000A4, (2 << 21) | (3 << 28) | (1 << 25) | (1 << 26));

    *(volatile unsigned short*)0x4000106 = 0;

    *(volatile unsigned short*)0x4000104 = -ticks;
    *(volatile unsigned short*)0x4000106 = (1<<7);

    soundB.data = sound;
    soundB.length = length;
    soundB.loops = loops;
    soundB.isPlaying = 1;
    soundB.duration = ((59.727) * length) / 11025;
    soundB.vBlankCount = 0;
}


void setupSoundInterrupts() {

 *(unsigned short*)0x4000208 = 0;

    *(unsigned short*)0x4000200 |= 1 << 0;
    *(unsigned short*)0x4000004 |= 1 << 3;


 *(unsigned short*)0x4000208 = 1;
}


void soundInterruptHandler() {



 if(*(volatile unsigned short*)0x4000202 & 1 << 0) {
        if (soundA.isPlaying) {

            soundA.vBlankCount = soundA.vBlankCount + 1;
            if (soundA.vBlankCount > soundA.duration) {
                if (soundA.loops) {
                    playSoundA(soundA.data, soundA.length, soundA.loops, 0);
                } else {
                    soundA.isPlaying = 0;
                    dma[1].cnt = 0;
                    *(volatile unsigned short*)0x4000102 = (0<<7);
                }
            }
        }

        if (soundB.isPlaying) {

            soundB.vBlankCount = soundB.vBlankCount + 1;
            if (soundB.vBlankCount > soundB.duration) {
                if (soundB.loops) {
                    playSoundB(soundB.data, soundB.length, soundB.loops);
                } else {
                    soundB.isPlaying = 0;
                    dma[2].cnt = 0;
                    *(volatile unsigned short*)0x4000106 = (0<<7);
                }
            }
  }


  *(volatile unsigned short*)0x4000202 = 1 << 0;
 }


}

void pauseSound() {
    soundA.isPlaying = 0;
    soundB.isPlaying = 0;
    *(volatile unsigned short*)0x4000102 = (0<<7);
    *(volatile unsigned short*)0x4000106 = (0<<7);
}

void unpauseSound() {
    soundA.isPlaying = 1;
    soundB.isPlaying = 1;
    *(volatile unsigned short*)0x4000102 = (1<<7);
    *(volatile unsigned short*)0x4000106 = (1<<7);
}

void stopSound() {
    soundA.isPlaying = 0;
    soundB.isPlaying = 0;
    *(volatile unsigned short*)0x4000102 = (0<<7);
    *(volatile unsigned short*)0x4000106 = (0<<7);
    dma[1].cnt = 0;
    dma[2].cnt = 0;
}
