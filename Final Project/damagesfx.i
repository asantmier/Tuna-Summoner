# 1 "damagesfx.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "damagesfx.c"


const unsigned int damagesfx_sampleRate = 11025;
const unsigned int damagesfx_length = 1600;

const signed char damagesfx_data[] = {
15, 50, -12, -3, -8, -74, 23, 14, -70, -16, -10, 4, -31, 27, 33, 32, 69, -3, -46, -58, -19,
-28, -44, -8, 47, -1, 45, 62, 45, 54, -41, -46, -1, 46, -53, -50, -43, -44, -7, 64, 4,
-32, 58, -52, 44, 53, 55, 42, -32, -54, 6, 33, -39, -59, -23, 39, -11, -37, -52, 6, 27,
38, -52, -28, 41, -46, -14, 75, 20, -63, 32, 51, -32, -46, 28, 34, 18, 3, -42, -31, -52,
-8, 8, -44, 25, 49, 24, 31, 37, 14, 19, 47, 22, 5, -46, -52, 52, 21, -63, -19, 18,
22, 59, 3, -68, -41, -32, 3, 77, 20, -51, -50, -54, -56, -37, -26, -27, -27, -27, 40, 57,
51, 58, 58, 42, 32, 23, 44, 47, 58, 0, -68, -70, -24, 61, 41, 47, -28, -35, -36, -1,
66, 41, 56, 3, -48, -34, -43, -2, 58, 42, 45, 38, 20, 15, 13, 17, -7, -62, -67, -29,
21, 10, -45, -62, -37, -17, -19, 24, 47, 37, 43, 40, 38, 34, 31, 31, 7, -29, -16, -32,
-44, -39, -37, 33, 46, 38, 38, 42, 35, 42, -3, -71, -52, -57, -45, -39, -35, -32, -31, 39,
53, 44, 43, 40, 47, 44, 41, 37, 34, -48, -65, -53, -54, -47, -36, 27, 25, 26, 21, 22,
18, -41, -54, -43, -44, -38, -37, -33, 29, 51, 39, 42, 34, 35, 29, 31, 22, 15, 13, 13,
11, 11, 9, 10, 6, 11, -8, -48, -43, -41, -38, -35, -32, -30, -28, -25, -24, -22, -21, -18,
-22, -34, -32, -29, -28, -25, -24, -21, -21, -18, -18, -16, -15, -13, -13, -11, -11, -10, -10, -9,
-8, -7, -7, -7, -6, -6, 33, 57, 59, 57, 51, 48, 44, 41, 37, 35, 32, 30, 27, 26,
23, 22, 20, 19, 17, 16, 14, 13, 12, 11, 10, 10, 9, 8, 8, 7, 6, 6, 6, 4,
5, -27, -57, -60, -58, -52, -49, -45, -42, -38, -36, -33, -31, -28, -26, -24, -23, -21, -19, -18,
-17, -16, -14, -14, -12, -12, -10, -10, -9, -9, -8, -7, -7, -6, -6, -5, -6, 21, 30, 25,
25, 22, 21, 19, 18, 16, 15, 14, 13, 11, 11, 10, 10, 8, 8, 6, 8, 5, 7, 2,
18, 47, 40, 39, 35, 33, 30, 28, 26, 24, 22, 20, 19, 17, 16, 14, 14, 12, 12, 10,
11, 20, 21, 18, 17, 15, 15, 13, 13, 11, 11, 9, 10, 7, 8, 6, 8, 4, 9, -10,
-53, -48, -46, -41, -40, -36, -34, -31, -29, -26, -25, -23, -21, -19, -18, -17, -15, -15, 40, 50,
42, 41, 36, 35, 31, 29, 27, 25, 23, 21, 19, 18, 16, 16, 14, 13, -37, -45, -38, -38,
-33, -32, -28, -28, -24, -24, -21, -20, -18, -17, -15, -15, -13, -13, 44, 62, 54, 54, 46, 46,
40, 39, 34, 34, 29, 29, 24, 25, 20, 22, 16, 21, -2, -31, -24, -25, -21, -21, -18, -18,
-16, -15, -14, -13, -11, -12, -9, -11, -7, -11, -3, -26, -57, -47, -47, -41, -40, -36, -34, -31,
-29, -27, -24, -23, -21, -20, -18, -17, -15, -15, -12, -20, -27, -24, -23, -20, -20, -17, -17, -15,
-15, -13, -13, -11, -11, -9, -10, -8, -8, -7, -7, -6, 47, 59, 51, 50, 44, 42, 38, 36,
32, 31, 28, 26, 24, 22, 20, 19, 17, 16, 15, 14, 12, 11, -16, -21, -17, -18, -15, -15,
-13, -13, -11, -11, -10, -10, -8, -8, -7, -7, -6, -7, -5, -6, -3, -7, 0, -22, -52, -42,
-42, -37, -36, -32, -30, -28, -26, -24, -22, -21, -19, -18, -16, -16, -13, -14, -11, -12, -10, -10,
-9, -9, -7, 28, 35, 29, 29, 25, 25, 21, 21, 18, 18, 15, 15, 13, 13, 11, 11, 10,
9, 8, 7, 7, 6, 6, 5, 6, 4, 6, 1, 14, 30, 25, 25, 22, 21, 19, 18, 16,
15, 14, 13, 12, 11, 10, 9, 9, 8, 7, 6, 6, 5, 5, 5, 4, 4, 4, 3, 3,
3, 2, 2, 5, 5, 4, 4, 4, 4, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1,
0, 1, -1, -3, -3, -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -2, -1, -2, -1,
-1, -13, -16, -14, -15, -14, -14, -14, -14, -13, -13, -12, -12, -11, -11, -10, -9, -8, -8, -7,
-7, -6, -6, -6, -5, -5, -4, -4, -4, -3, -3, -3, -3, -2, -2, -2, -2, -1, -2, 0,
-7, -19, -17, -17, -16, -16, -16, -15, -15, -15, -14, -14, -13, -12, -12, -11, -10, -9, -9, -8,
-8, -7, -7, -6, -6, -5, -5, -4, -4, -4, -4, -3, -3, -3, -2, -2, -2, -2, -2, -2,
-1, -2, 15, 22, 19, 21, 19, 20, 19, 19, 18, 18, 17, 16, 16, 15, 13, 13, 11, 11,
10, 9, 8, 8, 7, 6, 6, 5, 5, 4, 4, 4, 4, 3, 3, 2, 2, 2, 2, 1,
1, 1, 1, 1, 1, 0, 0, 8, 10, 9, 9, 8, 9, 8, 8, 8, 7, 7, 7, 6,
6, 6, 5, 5, 4, 4, 3, 3, 3, 3, 2, 2, 1, 2, 1, 1, 1, 1, 0, 0,
0, -18, -24, -23, -24, -22, -23, -22, -22, -21, -20, -19, -19, -18, -17, -16, -15, -14, -13, -12,
-11, -10, -9, -9, -8, -8, -7, -7, -6, -6, -5, -5, -4, -4, -4, -4, -3, -3, -3, -2,
-2, -2, -2, -2, -2, -1, -1, 6, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 6, 6,
6, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 0, 1, 0,
3, 17, 18, 17, 17, 17, 16, 16, 15, 15, 14, 14, 13, 12, 12, 11, 10, 9, 8, 8,
7, 6, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1,
0, 0, 0, 8, 10, 9, 9, 8, 8, 8, 8, 7, 7, 7, 7, 6, 6, 5, 5, 4,
4, 4, 3, 3, 3, 3, 2, 2, 1, 1, 1, 1, 0, 1, 0, 2, -5, -17, -16, -17,
-16, -16, -16, -16, -15, -15, -14, -14, -14, -13, -12, -11, -10, -9, -9, -8, -8, -7, -7, -6,
-6, -5, -5, -5, -4, -4, -4, -3, -3, -3, -2, -2, -2, -2, -1, -2, -1, -2, 5, 10,
9, 9, 9, 9, 9, 8, 8, 8, 8, 7, 7, 7, 6, 6, 5, 5, 4, 4, 4, 3,
3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, -7, -9, -8, -9, -8, -8, -8,
-8, -7, -7, -7, -7, -7, -6, -6, -5, -5, -5, -4, -4, -4, -3, -3, -3, -2, -2, -2,
-2, -2, -1, -2, 1, 4, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1,
0, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, 0, -1, 0,
0, -1, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0,
-1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, -1, 0, -1,
0, -1, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0,
-1, 0, -1, 0, -1, 0, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0,
-1, 0, -1, 0, -1, 0, 0, -1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1,
0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0,
0, 0, 0, -1, 0, -1, 0, -1, 0, 0, 0, -1, 0, -1, -1, 0, -1, 0, -1, 0,
0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, -1, 0,
0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0,
0, -1, 0, 0, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, 0, -1, 0, -1, 0, -1,
0, -1, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1,
0, -1, 0, -1, 0, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, -1, 0,
-1, 0, -1, 0, -1, 0, 0, -1, 0, 0, -1, 0, -1, 0, 0, 0, -1, 0, -1, 0,
0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0,
-1, 0, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0,
-1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1,
0, -1, 0, -1, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0,
-1, 0, -1, 0, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0,
-1, 0, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0, -1,
0, -1, 0, -1, 0, 0, 0, 0, 0, 0, -1, 0, -1, -1, 0, 0, 0, 0, -1, };
