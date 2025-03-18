#ifndef _ALCD_H_
#define _ALCD_H_

#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_clk.h"

#define ALCD_D4_GPIO							GPIOD
#define ALCD_D4_Pin								GPIO_PIN_1
#define ALCD_D5_GPIO							GPIOD
#define ALCD_D5_Pin								GPIO_PIN_2
#define ALCD_D6_GPIO							GPIOD
#define ALCD_D6_Pin								GPIO_PIN_3
#define ALCD_D7_GPIO							GPIOD
#define ALCD_D7_Pin								GPIO_PIN_4

#define ALCD_RS_GPIO							GPIOA
#define ALCD_RS_Pin								GPIO_PIN_1

#define ALCD_RW_GPIO							GPIOA
#define ALCD_RW_Pin								GPIO_PIN_2

#define ALCD_EN_GPIO							GPIOA
#define ALCD_EN_Pin								GPIO_PIN_3



void ALCD_Init(uint8_t rows, uint8_t columns);

void ALCD_Clear(void);
void ALCD_DisplayOn(void);
void ALCD_DisplayOff(void);
void ALCD_CursorOn(void);
void ALCD_CursorOff(void);
void ALCD_BlinkOn(void);
void ALCD_BlinkOff(void);

void ALCD_GotoXY(uint8_t x, uint8_t y);

void ALCD_PutChar(char c);
void ALCD_Puts(const char* str);

void ALCD_PutCharXY(char c, uint8_t x, uint8_t y);
void ALCD_PutsXY(const char* str, uint8_t x, uint8_t y);




#endif //_ALCD_H_

