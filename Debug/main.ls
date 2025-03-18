   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
  70                     ; 19 void main(void)
  70                     ; 20 {
  72                     	switch	.text
  73  0000               _main:
  75  0000 5209          	subw	sp,#9
  76       00000009      OFST:	set	9
  79                     ; 22 	FLASH_DeInit();
  81  0002 cd0000        	call	_FLASH_DeInit
  83                     ; 24 	EnableClocks();
  85  0005 cd00de        	call	_EnableClocks
  87                     ; 26 	ALCD_Init(2, 16);
  89  0008 ae0210        	ldw	x,#528
  90  000b cd0000        	call	_ALCD_Init
  92                     ; 29 	UART1_Init((uint32_t)115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO,
  92                     ; 30               UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
  94  000e 4b0c          	push	#12
  95  0010 4b80          	push	#128
  96  0012 4b00          	push	#0
  97  0014 4b00          	push	#0
  98  0016 4b00          	push	#0
  99  0018 aec200        	ldw	x,#49664
 100  001b 89            	pushw	x
 101  001c ae0001        	ldw	x,#1
 102  001f 89            	pushw	x
 103  0020 cd0000        	call	_UART1_Init
 105  0023 5b09          	addw	sp,#9
 106                     ; 31 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 108  0025 4b01          	push	#1
 109  0027 ae0255        	ldw	x,#597
 110  002a cd0000        	call	_UART1_ITConfig
 112  002d 84            	pop	a
 113                     ; 34 	Remote = FLASH_ReadByte(Address_EEPROM);
 115  002e ae4000        	ldw	x,#16384
 116  0031 89            	pushw	x
 117  0032 ae0000        	ldw	x,#0
 118  0035 89            	pushw	x
 119  0036 cd0000        	call	_FLASH_ReadByte
 121  0039 5b04          	addw	sp,#4
 122  003b 5f            	clrw	x
 123  003c 97            	ld	xl,a
 124  003d bf00          	ldw	_Remote,x
 125                     ; 35 	FLASH_Unlock(FLASH_MEMTYPE_PROG);
 127  003f a6fd          	ld	a,#253
 128  0041 cd0000        	call	_FLASH_Unlock
 130                     ; 36 	FLASH_ProgramWord(Address_EEPROM,	++Remote);
 132  0044 be00          	ldw	x,_Remote
 133  0046 1c0001        	addw	x,#1
 134  0049 bf00          	ldw	_Remote,x
 135  004b be00          	ldw	x,_Remote
 136  004d cd0000        	call	c_uitolx
 138  0050 be02          	ldw	x,c_lreg+2
 139  0052 89            	pushw	x
 140  0053 be00          	ldw	x,c_lreg
 141  0055 89            	pushw	x
 142  0056 ae4000        	ldw	x,#16384
 143  0059 89            	pushw	x
 144  005a ae0000        	ldw	x,#0
 145  005d 89            	pushw	x
 146  005e cd0000        	call	_FLASH_ProgramWord
 148  0061 5b08          	addw	sp,#8
 149                     ; 37 	FLASH_Lock(FLASH_MEMTYPE_PROG);
 151  0063 a6fd          	ld	a,#253
 152  0065 cd0000        	call	_FLASH_Lock
 154                     ; 38 	ALCD_Clear();
 156  0068 cd0000        	call	_ALCD_Clear
 158                     ; 40 		enableInterrupts();
 161  006b 9a            rim
 163  006c               L72:
 164                     ; 43 			sprintf(str,"%d", Remote);
 166  006c be00          	ldw	x,_Remote
 167  006e 89            	pushw	x
 168  006f ae0000        	ldw	x,#L33
 169  0072 89            	pushw	x
 170  0073 96            	ldw	x,sp
 171  0074 1c0005        	addw	x,#OFST-4
 172  0077 cd0000        	call	_sprintf
 174  007a 5b04          	addw	sp,#4
 175                     ; 44 			ALCD_PutsXY(str,0,1);
 177  007c 4b01          	push	#1
 178  007e 4b00          	push	#0
 179  0080 96            	ldw	x,sp
 180  0081 1c0003        	addw	x,#OFST-6
 181  0084 cd0000        	call	_ALCD_PutsXY
 183  0087 85            	popw	x
 184                     ; 45 			UART_Puts(str);
 186  0088 96            	ldw	x,sp
 187  0089 1c0001        	addw	x,#OFST-8
 188  008c ad2c          	call	_UART_Puts
 191  008e 20dc          	jra	L72
 405                     ; 50 void GPIO_WritePin(GPIO_TypeDef* GPIO, GPIO_Pin_TypeDef Pin, BitAction Value){
 406                     	switch	.text
 407  0090               _GPIO_WritePin:
 409  0090 89            	pushw	x
 410       00000000      OFST:	set	0
 413                     ; 51 	if (RESET == Value){
 415  0091 0d06          	tnz	(OFST+6,sp)
 416  0093 2609          	jrne	L751
 417                     ; 52 		GPIO_WriteLow(GPIO, Pin);
 419  0095 7b05          	ld	a,(OFST+5,sp)
 420  0097 88            	push	a
 421  0098 cd0000        	call	_GPIO_WriteLow
 423  009b 84            	pop	a
 425  009c 2009          	jra	L161
 426  009e               L751:
 427                     ; 55 		GPIO_WriteHigh(GPIO, Pin);
 429  009e 7b05          	ld	a,(OFST+5,sp)
 430  00a0 88            	push	a
 431  00a1 1e02          	ldw	x,(OFST+2,sp)
 432  00a3 cd0000        	call	_GPIO_WriteHigh
 434  00a6 84            	pop	a
 435  00a7               L161:
 436                     ; 57 }
 439  00a7 85            	popw	x
 440  00a8 81            	ret
 476                     ; 58 void UART_PutChar(char c){
 477                     	switch	.text
 478  00a9               _UART_PutChar:
 480  00a9 88            	push	a
 481       00000000      OFST:	set	0
 484  00aa               L302:
 485                     ; 59 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == 0){}
 487  00aa ae0080        	ldw	x,#128
 488  00ad cd0000        	call	_UART1_GetFlagStatus
 490  00b0 4d            	tnz	a
 491  00b1 27f7          	jreq	L302
 492                     ; 60 	UART1_SendData8(c);
 494  00b3 7b01          	ld	a,(OFST+1,sp)
 495  00b5 cd0000        	call	_UART1_SendData8
 497                     ; 61 }
 500  00b8 84            	pop	a
 501  00b9 81            	ret
 537                     ; 62 void UART_Puts(const char* str){
 538                     	switch	.text
 539  00ba               _UART_Puts:
 541  00ba 89            	pushw	x
 542       00000000      OFST:	set	0
 545  00bb 200d          	jra	L722
 546  00bd               L522:
 547                     ; 64 		UART_PutChar(*str++);
 549  00bd 1e01          	ldw	x,(OFST+1,sp)
 550  00bf 1c0001        	addw	x,#1
 551  00c2 1f01          	ldw	(OFST+1,sp),x
 552  00c4 1d0001        	subw	x,#1
 553  00c7 f6            	ld	a,(x)
 554  00c8 addf          	call	_UART_PutChar
 556  00ca               L722:
 557                     ; 63 	while ('\0' != *str){
 559  00ca 1e01          	ldw	x,(OFST+1,sp)
 560  00cc 7d            	tnz	(x)
 561  00cd 26ee          	jrne	L522
 562                     ; 66 }
 565  00cf 85            	popw	x
 566  00d0 81            	ret
 591                     ; 67 char UART_GetChar(void){
 592                     	switch	.text
 593  00d1               _UART_GetChar:
 597  00d1               L542:
 598                     ; 68 	while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == 0){}
 600  00d1 ae0020        	ldw	x,#32
 601  00d4 cd0000        	call	_UART1_GetFlagStatus
 603  00d7 4d            	tnz	a
 604  00d8 27f7          	jreq	L542
 605                     ; 69 	return UART1_ReceiveData8();
 607  00da cd0000        	call	_UART1_ReceiveData8
 611  00dd 81            	ret
 643                     ; 71 void EnableClocks(void){
 644                     	switch	.text
 645  00de               _EnableClocks:
 649                     ; 72 	CLK_DeInit();
 651  00de cd0000        	call	_CLK_DeInit
 653                     ; 73 	CLK_FastHaltWakeUpCmd(ENABLE);
 655  00e1 a601          	ld	a,#1
 656  00e3 cd0000        	call	_CLK_FastHaltWakeUpCmd
 658                     ; 74   CLK_HSICmd(ENABLE);
 660  00e6 a601          	ld	a,#1
 661  00e8 cd0000        	call	_CLK_HSICmd
 663                     ; 75 	CLK_HSECmd(DISABLE);
 665  00eb 4f            	clr	a
 666  00ec cd0000        	call	_CLK_HSECmd
 668                     ; 76 	CLK_CCOCmd(DISABLE);
 670  00ef 4f            	clr	a
 671  00f0 cd0000        	call	_CLK_CCOCmd
 673                     ; 77   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 675  00f3 4f            	clr	a
 676  00f4 cd0000        	call	_CLK_HSIPrescalerConfig
 678                     ; 79 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 680  00f7 ae0701        	ldw	x,#1793
 681  00fa cd0000        	call	_CLK_PeripheralClockConfig
 683                     ; 80 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 685  00fd ae0501        	ldw	x,#1281
 686  0100 cd0000        	call	_CLK_PeripheralClockConfig
 688                     ; 81 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 690  0103 ae0401        	ldw	x,#1025
 691  0106 cd0000        	call	_CLK_PeripheralClockConfig
 693                     ; 82 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 695  0109 ae1301        	ldw	x,#4865
 696  010c cd0000        	call	_CLK_PeripheralClockConfig
 698                     ; 83 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 700  010f ae0301        	ldw	x,#769
 701  0112 cd0000        	call	_CLK_PeripheralClockConfig
 703                     ; 85 	CLK_SWIMConfig(CLK_SWIMDIVIDER_2);
 705  0115 4f            	clr	a
 706  0116 cd0000        	call	_CLK_SWIMConfig
 708                     ; 86 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI,
 708                     ; 87 										DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
 710  0119 4b00          	push	#0
 711  011b 4b00          	push	#0
 712  011d ae01e1        	ldw	x,#481
 713  0120 cd0000        	call	_CLK_ClockSwitchConfig
 715  0123 85            	popw	x
 716                     ; 88 }
 719  0124 81            	ret
 762                     ; 90 void Delay_ms(uint16_t ms)
 762                     ; 91 {
 763                     	switch	.text
 764  0125               _Delay_ms:
 766  0125 5204          	subw	sp,#4
 767       00000004      OFST:	set	4
 770                     ; 93 	uint32_t Count = 5333 * ms;
 772  0127 90ae14d5      	ldw	y,#5333
 773  012b cd0000        	call	c_imul
 775  012e cd0000        	call	c_uitolx
 777  0131 96            	ldw	x,sp
 778  0132 1c0001        	addw	x,#OFST-3
 779  0135 cd0000        	call	c_rtol
 783  0138               L703:
 784                     ; 94 	while (Count--){}
 786  0138 96            	ldw	x,sp
 787  0139 1c0001        	addw	x,#OFST-3
 788  013c cd0000        	call	c_ltor
 790  013f 96            	ldw	x,sp
 791  0140 1c0001        	addw	x,#OFST-3
 792  0143 a601          	ld	a,#1
 793  0145 cd0000        	call	c_lgsbc
 796  0148 cd0000        	call	c_lrzmp
 798  014b 26eb          	jrne	L703
 799                     ; 95 }
 802  014d 5b04          	addw	sp,#4
 803  014f 81            	ret
 827                     	xdef	_UART_GetChar
 828                     	xdef	_UART_PutChar
 829                     	xdef	_GPIO_WritePin
 830                     	xdef	_main
 831                     	switch	.ubsct
 832  0000               _Remote:
 833  0000 0000          	ds.b	2
 834                     	xdef	_Remote
 835                     	xdef	_EnableClocks
 836                     	xdef	_Delay_ms
 837                     	xdef	_UART_Puts
 838                     	xref	_ALCD_PutsXY
 839                     	xref	_ALCD_Clear
 840                     	xref	_ALCD_Init
 841                     	xref	_sprintf
 842                     	xref	_FLASH_ProgramWord
 843                     	xref	_FLASH_ReadByte
 844                     	xref	_FLASH_DeInit
 845                     	xref	_FLASH_Lock
 846                     	xref	_FLASH_Unlock
 847                     	xref	_UART1_GetFlagStatus
 848                     	xref	_UART1_SendData8
 849                     	xref	_UART1_ReceiveData8
 850                     	xref	_UART1_ITConfig
 851                     	xref	_UART1_Init
 852                     	xref	_GPIO_WriteLow
 853                     	xref	_GPIO_WriteHigh
 854                     	xref	_CLK_SWIMConfig
 855                     	xref	_CLK_HSIPrescalerConfig
 856                     	xref	_CLK_ClockSwitchConfig
 857                     	xref	_CLK_PeripheralClockConfig
 858                     	xref	_CLK_FastHaltWakeUpCmd
 859                     	xref	_CLK_CCOCmd
 860                     	xref	_CLK_HSICmd
 861                     	xref	_CLK_HSECmd
 862                     	xref	_CLK_DeInit
 863                     .const:	section	.text
 864  0000               L33:
 865  0000 256400        	dc.b	"%d",0
 866                     	xref.b	c_lreg
 867                     	xref.b	c_x
 887                     	xref	c_lrzmp
 888                     	xref	c_lgsbc
 889                     	xref	c_ltor
 890                     	xref	c_rtol
 891                     	xref	c_imul
 892                     	xref	c_uitolx
 893                     	end
