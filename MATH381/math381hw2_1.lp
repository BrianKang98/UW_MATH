/* Objective function */
max: 72x_1+80x_2+66x_3+75x_4+68x_5+47x_6+85x_7+55x_8+82x_9;

/* Variable bounds */
c1: +10x_1+11x_2+7x_3+12x_4+3x_5+4x_6+9x_7+2x_8+8x_9 <= 40;
c2: +5x_1+6x_2+10x_3+4x_4+9x_5+8x_6+12x_7+10x_8+8x_9 <= 45;

/* Variables */
int x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9;