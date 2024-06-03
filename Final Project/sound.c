#include "mode0.h"
#include "sound.h"

void setupSounds() {

    REG_SOUNDCNT_X = SND_ENABLED;

	REG_SOUNDCNT_H = SND_OUTPUT_RATIO_100 |
                     DSA_OUTPUT_RATIO_100 |
                     DSA_OUTPUT_TO_BOTH |
                     DSA_TIMER0 |
                     DSA_FIFO_RESET |
                     DSB_OUTPUT_RATIO_100 |
                     DSB_OUTPUT_TO_BOTH |
                     DSB_TIMER1 |
                     DSB_FIFO_RESET;

	REG_SOUNDCNT_L = 0;
}

// Play sound A with an offset in vblanks. Used for playing paused BGM
void playSoundA( const signed char* sound, int length, int loops, int offset) {
    length -= (11025); // Ignore the last second. Same idea as playSoundB, but a full second since this plays longer songs
    dma[1].cnt = 0;

    int ticks = PROCESSOR_CYCLES_PER_SECOND / SOUND_FREQ;

    // start DMA partway through the song
    DMANow(1, sound + ((offset * 11025) / 60), REG_FIFO_A, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

    REG_TM0CNT = 0;

    REG_TM0D = -ticks;
    REG_TM0CNT = TIMER_ON;

    soundA.data = sound;
    soundA.length = length;
    soundA.loops = loops;
    soundA.isPlaying = 1;
    soundA.duration = (VBLANK_FREQ * length) / SOUND_FREQ;
    soundA.vBlankCount = offset; // move vblankcount to offset
}


void playSoundB( const signed char* sound, int length, int loops) {
    length -= (11025 / 25); // Ignore the last 1/25th of a second (it's silence). This fixes weird popping sounds
    dma[2].cnt = 0;

    int ticks = PROCESSOR_CYCLES_PER_SECOND / SOUND_FREQ;

    DMANow(2, sound, REG_FIFO_B, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

    REG_TM1CNT = 0;

    REG_TM1D = -ticks;
    REG_TM1CNT = TIMER_ON;

    soundB.data = sound;
    soundB.length = length;
    soundB.loops = loops;
    soundB.isPlaying = 1;
    soundB.duration = (VBLANK_FREQ * length) / SOUND_FREQ;
    soundB.vBlankCount = 0;
}

// Set up ONLY sound related interrupts
void setupSoundInterrupts() {

	REG_IME = 0;

    REG_IE |= INT_VBLANK;
    REG_DISPSTAT |= INT_VBLANK_ENABLE;

    // REG_INTERRUPT = soundInterruptHandler;
	REG_IME = 1;
}

// Handle ONLY sound related interrupts
void soundInterruptHandler() {

	// REG_IME = 0;

	if(REG_IF & INT_VBLANK) {
        if (soundA.isPlaying) {

            soundA.vBlankCount = soundA.vBlankCount + 1;
            if (soundA.vBlankCount > soundA.duration) {
                if (soundA.loops) {
                    playSoundA(soundA.data, soundA.length, soundA.loops, 0);
                } else {
                    soundA.isPlaying = 0;
                    dma[1].cnt = 0;
                    REG_TM0CNT = TIMER_OFF;
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
                    REG_TM1CNT = TIMER_OFF;
                }
            }
		}


		REG_IF = INT_VBLANK;
	}

	// REG_IME = 1;
}

void pauseSound() {
    soundA.isPlaying = 0;
    soundB.isPlaying = 0;
    REG_TM0CNT = TIMER_OFF;
    REG_TM1CNT = TIMER_OFF;
}

void unpauseSound() {
    soundA.isPlaying = 1;
    soundB.isPlaying = 1;
    REG_TM0CNT = TIMER_ON;
    REG_TM1CNT = TIMER_ON;
}

void stopSound() {
    soundA.isPlaying = 0;
    soundB.isPlaying = 0;
    REG_TM0CNT = TIMER_OFF;
    REG_TM1CNT = TIMER_OFF;
    dma[1].cnt = 0;
    dma[2].cnt = 0;
}