
//{{BLOCK(splashscreen)

//======================================================================
//
//	splashscreen, 256x256@8, 
//	+ palette 256 entries, not compressed
//	+ 185 tiles (t|f reduced) not compressed
//	+ regular map (in SBBs), not compressed, 32x32 
//	Total size: 512 + 11840 + 2048 = 14400
//
//	Time-stamp: 2022-04-28, 18:35:54
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_SPLASHSCREEN_H
#define GRIT_SPLASHSCREEN_H

#define splashscreenTilesLen 11840
extern const unsigned short splashscreenTiles[5920];

#define splashscreenMapLen 2048
extern const unsigned short splashscreenMap[1024];

#define splashscreenPalLen 512
extern const unsigned short splashscreenPal[256];

#endif // GRIT_SPLASHSCREEN_H

//}}BLOCK(splashscreen)
