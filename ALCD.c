#include "ALCD.h"
#include "stm8s_gpio.h"

/* Commands*/
#define ALCD_CLEARDISPLAY        0x01
#define ALCD_RETURNHOME          0x02
#define ALCD_ENTRYMODESET        0x04
#define ALCD_DISPLAYCONTROL      0x08
#define ALCD_CURSORSHIFT         0x10
#define ALCD_FUNCTIONSET         0x20
#define ALCD_SETCGRAMADDR        0x40
#define ALCD_SETDDRAMADDR        0x80

/* Flags for display entry mode */
#define ALCD_ENTRYRIGHT          0x00
#define ALCD_ENTRYLEFT           0x02
#define ALCD_ENTRYSHIFTINCREMENT 0x01
#define ALCD_ENTRYSHIFTDECREMENT 0x00

/* Flags for display on/off control */
#define ALCD_DISPLAYON           0x04
#define ALCD_CURSORON            0x02
#define ALCD_BLINKON             0x01

/* Flags for display/cursor shift */
#define ALCD_DISPLAYMOVE         0x08
#define ALCD_CURSORMOVE          0x00
#define ALCD_MOVERIGHT           0x04
#define ALCD_MOVELEFT            0x00

/* Flags for function set */
#define ALCD_8BITMODE            0x10
#define ALCD_4BITMODE            0x00
#define ALCD_2LINE               0x08
#define ALCD_1LINE               0x00
#define ALCD_5x10DOTS            0x04
#define ALCD_5x8DOTS             0x00

#define ALCD_RS_Low()								GPIO_WriteLow(ALCD_RS_GPIO, ALCD_RS_Pin)
#define ALCD_RS_High()							GPIO_WriteHigh(ALCD_RS_GPIO, ALCD_RS_Pin)
#define ALCD_RW_Low()								GPIO_WriteLow(ALCD_RW_GPIO, ALCD_RW_Pin)
#define ALCD_RW_High()							GPIO_WriteHigh(ALCD_RW_GPIO, ALCD_RW_Pin)
#define ALCD_EN_Low()								GPIO_WriteLow(ALCD_EN_GPIO, ALCD_EN_Pin)
#define ALCD_EN_High()							GPIO_WriteHigh(ALCD_EN_GPIO, ALCD_EN_Pin)

typedef struct _ALCD_Options {
	uint8_t DisplayControl;
	uint8_t DisplayFunction;
	uint8_t DisplayMode;
	uint8_t Rows;
	uint8_t Cols;
	uint8_t CurrentX;
	uint8_t CurrentY;
}ALCD_Options;

ALCD_Options mOptions;

void ALCD_Delay(uint32_t us);
void ALCD_WritePin(GPIO_TypeDef* GPIO, GPIO_Pin_TypeDef Pin, BitAction val);
void ALCD_WriteCmd4Bit(uint8_t cmd);
void ALCD_WriteCmd(uint8_t cmd);
void ALCD_WriteData(uint8_t data);
void ALCD_LatchData(void);

void ALCD_Init(uint8_t rows, uint8_t columns){
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	
	GPIO_Init(ALCD_D4_GPIO, ALCD_D4_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(ALCD_D5_GPIO, ALCD_D5_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(ALCD_D6_GPIO, ALCD_D6_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(ALCD_D7_GPIO, ALCD_D7_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(ALCD_RS_GPIO, ALCD_RS_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(ALCD_RW_GPIO, ALCD_RW_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	GPIO_Init(ALCD_EN_GPIO, ALCD_EN_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
	
	ALCD_RW_Low();
	
	mOptions.Rows = rows;
	mOptions.Cols = columns;
	mOptions.CurrentX = 0;
	mOptions.CurrentY = 0;
	mOptions.DisplayFunction = ALCD_4BITMODE | ALCD_5x8DOTS | ALCD_1LINE;
	if (rows > 1)
		mOptions.DisplayFunction |= ALCD_2LINE;
	
	// Try to set 4bit mode
	ALCD_WriteCmd4Bit(0x03);
	ALCD_Delay(4500);
	
	// Second try
	ALCD_WriteCmd4Bit(0x03);
	ALCD_Delay(4500);
	
	// Third goo!
	ALCD_WriteCmd4Bit(0x03);
	ALCD_Delay(4500);	
	
	// Set 4-bit interface
	ALCD_WriteCmd4Bit(0x02);
	ALCD_Delay(100);
	
	// Set # lines, font size, etc.
	ALCD_WriteCmd(ALCD_FUNCTIONSET | mOptions.DisplayFunction);

	// Turn the display on with no cursor or blinking default
	mOptions.DisplayControl = ALCD_DISPLAYON;
	ALCD_DisplayOn();
	
	ALCD_Clear();
	
	// Default font directions
	mOptions.DisplayMode = ALCD_ENTRYLEFT | ALCD_ENTRYSHIFTDECREMENT;
	ALCD_WriteCmd(ALCD_ENTRYMODESET | mOptions.DisplayMode);
	
	// Delay
	ALCD_Delay(4500);
}

void ALCD_Clear(void){
	mOptions.CurrentX = 0;
	mOptions.CurrentY = 0;
	ALCD_WriteCmd(ALCD_CLEARDISPLAY);
	ALCD_Delay(4000);
}
void ALCD_DisplayOn(void){
	mOptions.DisplayControl |= ALCD_DISPLAYON;
	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
}
void ALCD_DisplayOff(void){
	mOptions.DisplayControl &= ~ALCD_DISPLAYON;
	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
}
void ALCD_CursorOn(void){
	mOptions.DisplayControl |= ALCD_CURSORON;
	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
}
void ALCD_CursorOff(void){
	mOptions.DisplayControl &= ~ALCD_CURSORON;
	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
}
void ALCD_BlinkOn(void){
	mOptions.DisplayControl |= ALCD_BLINKON;
	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
}
void ALCD_BlinkOff(void){
	mOptions.DisplayControl &= ~ALCD_BLINKON;
	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
}
void ALCD_GotoXY(uint8_t x, uint8_t y){
	static const uint8_t row_offsets[4] = {0x00, 0x40, 0x14, 0x54};
	
	/* Go to beginning */
	if (y >= mOptions.Rows)
		y = 0;
	
	/* Set current column and row */
	mOptions.CurrentX = x;
	mOptions.CurrentY = y;
	
	/* Set location address */
	ALCD_WriteCmd(ALCD_SETDDRAMADDR | (x + row_offsets[y]));
}
void ALCD_PutChar(char c){
	ALCD_WriteData(c);
}
void ALCD_Puts(const char* str){
	while ('\0' != *str){
		ALCD_WriteData(*str++);
		if (++mOptions.CurrentX >= mOptions.Cols){
			mOptions.CurrentX = 0;
			if (++mOptions.CurrentY >= mOptions.Rows){
				mOptions.CurrentY = 0;
			}
		}
	}
}
void ALCD_PutCharXY(char c, uint8_t x, uint8_t y){
	ALCD_GotoXY(x, y);
	ALCD_PutChar(c);
}
void ALCD_PutsXY(const char* str, uint8_t x, uint8_t y){
	ALCD_GotoXY(x, y);
	ALCD_Puts(str);
}


void ALCD_Delay(uint32_t us){
	us /= 3;
	while (us--){}
}
void ALCD_WritePin(GPIO_TypeDef* GPIO, GPIO_Pin_TypeDef Pin, BitAction val){
	if (RESET == val){
		GPIO_WriteLow(GPIO, Pin);
	}
	else {
		GPIO_WriteHigh(GPIO, Pin);
	}
}
void ALCD_WriteCmd4Bit(uint8_t cmd){
	ALCD_WritePin(ALCD_D4_GPIO, ALCD_D4_Pin, cmd & 0x01);
	cmd >>= 1;
	ALCD_WritePin(ALCD_D5_GPIO, ALCD_D5_Pin, cmd & 0x01);
	cmd >>= 1;
	ALCD_WritePin(ALCD_D5_GPIO, ALCD_D6_Pin, cmd & 0x01);
	cmd >>= 1;
	ALCD_WritePin(ALCD_D5_GPIO, ALCD_D7_Pin, cmd & 0x01);
	
	ALCD_LatchData();;
}
void ALCD_WriteCmd(uint8_t cmd){
	ALCD_RS_Low();
	ALCD_WriteCmd4Bit(cmd >> 4);
	ALCD_WriteCmd4Bit(cmd);
}
void ALCD_WriteData(uint8_t data){
	ALCD_RS_High();
	ALCD_WriteCmd4Bit(data >> 4);
	ALCD_WriteCmd4Bit(data);
}
void ALCD_LatchData(void){
		ALCD_EN_Low();
		ALCD_Delay(20);
		ALCD_EN_High();
		ALCD_Delay(20);
}