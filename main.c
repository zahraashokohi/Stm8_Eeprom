
#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_clk.h"
#include "stm8s_uart1.h"
#include "stm8s_tim1.h"
#include "stm8s_flash.h"
#include "stdio.h"
#include "ALCD.h"

#define Address_EEPROM			0X004000
void UART_Puts(const char* str);
//
void Delay_ms(uint16_t ms);

void EnableClocks(void);
uint16_t Remote;

void main(void)
{
	char str[9];
	FLASH_DeInit();
	//enable periph clocks
	EnableClocks();
	//Init ALCD
	ALCD_Init(2, 16);
	//Init Relay
	//Init UART1
	UART1_Init((uint32_t)115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO,
              UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
	//Init ADC

	Remote = FLASH_ReadByte(Address_EEPROM);
	FLASH_Unlock(FLASH_MEMTYPE_PROG);
	FLASH_ProgramWord(Address_EEPROM,	++Remote);
	FLASH_Lock(FLASH_MEMTYPE_PROG);
	ALCD_Clear();
	
		enableInterrupts();
	while (1)
	{
			sprintf(str,"%d", Remote);
			ALCD_PutsXY(str,0,1);
			UART_Puts(str);
	}
}


void GPIO_WritePin(GPIO_TypeDef* GPIO, GPIO_Pin_TypeDef Pin, BitAction Value){
	if (RESET == Value){
		GPIO_WriteLow(GPIO, Pin);
	}
	else {
		GPIO_WriteHigh(GPIO, Pin);
	}
}
void UART_PutChar(char c){
	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == 0){}
	UART1_SendData8(c);
}
void UART_Puts(const char* str){
	while ('\0' != *str){
		UART_PutChar(*str++);
	}
}
char UART_GetChar(void){
	while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == 0){}
	return UART1_ReceiveData8();
}
void EnableClocks(void){
	CLK_DeInit();
	CLK_FastHaltWakeUpCmd(ENABLE);
  CLK_HSICmd(ENABLE);
	CLK_HSECmd(DISABLE);
	CLK_CCOCmd(DISABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	//enable used peripheral clocks
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);

	CLK_SWIMConfig(CLK_SWIMDIVIDER_2);
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI,
										DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
}

void Delay_ms(uint16_t ms)
{
	//Clock / 3 / 1000 * ms
	uint32_t Count = 5333 * ms;
	while (Count--){}
}
