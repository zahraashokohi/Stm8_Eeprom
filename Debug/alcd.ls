   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
  72                     ; 65 void ALCD_Init(uint8_t rows, uint8_t columns){
  74                     	switch	.text
  75  0000               _ALCD_Init:
  77  0000 89            	pushw	x
  78       00000000      OFST:	set	0
  81                     ; 66 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  83  0001 4f            	clr	a
  84  0002 cd0000        	call	_CLK_HSIPrescalerConfig
  86                     ; 68 	GPIO_Init(ALCD_D4_GPIO, ALCD_D4_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
  88  0005 4be0          	push	#224
  89  0007 4b02          	push	#2
  90  0009 ae500f        	ldw	x,#20495
  91  000c cd0000        	call	_GPIO_Init
  93  000f 85            	popw	x
  94                     ; 69 	GPIO_Init(ALCD_D5_GPIO, ALCD_D5_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
  96  0010 4be0          	push	#224
  97  0012 4b04          	push	#4
  98  0014 ae500f        	ldw	x,#20495
  99  0017 cd0000        	call	_GPIO_Init
 101  001a 85            	popw	x
 102                     ; 70 	GPIO_Init(ALCD_D6_GPIO, ALCD_D6_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 104  001b 4be0          	push	#224
 105  001d 4b08          	push	#8
 106  001f ae500f        	ldw	x,#20495
 107  0022 cd0000        	call	_GPIO_Init
 109  0025 85            	popw	x
 110                     ; 71 	GPIO_Init(ALCD_D7_GPIO, ALCD_D7_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 112  0026 4be0          	push	#224
 113  0028 4b10          	push	#16
 114  002a ae500f        	ldw	x,#20495
 115  002d cd0000        	call	_GPIO_Init
 117  0030 85            	popw	x
 118                     ; 72 	GPIO_Init(ALCD_RS_GPIO, ALCD_RS_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 120  0031 4be0          	push	#224
 121  0033 4b02          	push	#2
 122  0035 ae5000        	ldw	x,#20480
 123  0038 cd0000        	call	_GPIO_Init
 125  003b 85            	popw	x
 126                     ; 73 	GPIO_Init(ALCD_RW_GPIO, ALCD_RW_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 128  003c 4be0          	push	#224
 129  003e 4b04          	push	#4
 130  0040 ae5000        	ldw	x,#20480
 131  0043 cd0000        	call	_GPIO_Init
 133  0046 85            	popw	x
 134                     ; 74 	GPIO_Init(ALCD_EN_GPIO, ALCD_EN_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 136  0047 4be0          	push	#224
 137  0049 4b08          	push	#8
 138  004b ae5000        	ldw	x,#20480
 139  004e cd0000        	call	_GPIO_Init
 141  0051 85            	popw	x
 142                     ; 76 	ALCD_RW_Low();
 144  0052 4b04          	push	#4
 145  0054 ae5000        	ldw	x,#20480
 146  0057 cd0000        	call	_GPIO_WriteLow
 148  005a 84            	pop	a
 149                     ; 78 	mOptions.Rows = rows;
 151  005b 7b01          	ld	a,(OFST+1,sp)
 152  005d b703          	ld	_mOptions+3,a
 153                     ; 79 	mOptions.Cols = columns;
 155  005f 7b02          	ld	a,(OFST+2,sp)
 156  0061 b704          	ld	_mOptions+4,a
 157                     ; 80 	mOptions.CurrentX = 0;
 159  0063 3f05          	clr	_mOptions+5
 160                     ; 81 	mOptions.CurrentY = 0;
 162  0065 3f06          	clr	_mOptions+6
 163                     ; 82 	mOptions.DisplayFunction = ALCD_4BITMODE | ALCD_5x8DOTS | ALCD_1LINE;
 165  0067 3f01          	clr	_mOptions+1
 166                     ; 83 	if (rows > 1)
 168  0069 7b01          	ld	a,(OFST+1,sp)
 169  006b a102          	cp	a,#2
 170  006d 2504          	jrult	L33
 171                     ; 84 		mOptions.DisplayFunction |= ALCD_2LINE;
 173  006f 72160001      	bset	_mOptions+1,#3
 174  0073               L33:
 175                     ; 87 	ALCD_WriteCmd4Bit(0x03);
 177  0073 a603          	ld	a,#3
 178  0075 cd01f2        	call	_ALCD_WriteCmd4Bit
 180                     ; 88 	ALCD_Delay(4500);
 182  0078 ae1194        	ldw	x,#4500
 183  007b 89            	pushw	x
 184  007c ae0000        	ldw	x,#0
 185  007f 89            	pushw	x
 186  0080 cd01af        	call	_ALCD_Delay
 188  0083 5b04          	addw	sp,#4
 189                     ; 91 	ALCD_WriteCmd4Bit(0x03);
 191  0085 a603          	ld	a,#3
 192  0087 cd01f2        	call	_ALCD_WriteCmd4Bit
 194                     ; 92 	ALCD_Delay(4500);
 196  008a ae1194        	ldw	x,#4500
 197  008d 89            	pushw	x
 198  008e ae0000        	ldw	x,#0
 199  0091 89            	pushw	x
 200  0092 cd01af        	call	_ALCD_Delay
 202  0095 5b04          	addw	sp,#4
 203                     ; 95 	ALCD_WriteCmd4Bit(0x03);
 205  0097 a603          	ld	a,#3
 206  0099 cd01f2        	call	_ALCD_WriteCmd4Bit
 208                     ; 96 	ALCD_Delay(4500);	
 210  009c ae1194        	ldw	x,#4500
 211  009f 89            	pushw	x
 212  00a0 ae0000        	ldw	x,#0
 213  00a3 89            	pushw	x
 214  00a4 cd01af        	call	_ALCD_Delay
 216  00a7 5b04          	addw	sp,#4
 217                     ; 99 	ALCD_WriteCmd4Bit(0x02);
 219  00a9 a602          	ld	a,#2
 220  00ab cd01f2        	call	_ALCD_WriteCmd4Bit
 222                     ; 100 	ALCD_Delay(100);
 224  00ae ae0064        	ldw	x,#100
 225  00b1 89            	pushw	x
 226  00b2 ae0000        	ldw	x,#0
 227  00b5 89            	pushw	x
 228  00b6 cd01af        	call	_ALCD_Delay
 230  00b9 5b04          	addw	sp,#4
 231                     ; 103 	ALCD_WriteCmd(ALCD_FUNCTIONSET | mOptions.DisplayFunction);
 233  00bb b601          	ld	a,_mOptions+1
 234  00bd aa20          	or	a,#32
 235  00bf cd022f        	call	_ALCD_WriteCmd
 237                     ; 106 	mOptions.DisplayControl = ALCD_DISPLAYON;
 239  00c2 35040000      	mov	_mOptions,#4
 240                     ; 107 	ALCD_DisplayOn();
 242  00c6 ad31          	call	_ALCD_DisplayOn
 244                     ; 109 	ALCD_Clear();
 246  00c8 ad18          	call	_ALCD_Clear
 248                     ; 112 	mOptions.DisplayMode = ALCD_ENTRYLEFT | ALCD_ENTRYSHIFTDECREMENT;
 250  00ca 35020002      	mov	_mOptions+2,#2
 251                     ; 113 	ALCD_WriteCmd(ALCD_ENTRYMODESET | mOptions.DisplayMode);
 253  00ce a606          	ld	a,#6
 254  00d0 cd022f        	call	_ALCD_WriteCmd
 256                     ; 116 	ALCD_Delay(4500);
 258  00d3 ae1194        	ldw	x,#4500
 259  00d6 89            	pushw	x
 260  00d7 ae0000        	ldw	x,#0
 261  00da 89            	pushw	x
 262  00db cd01af        	call	_ALCD_Delay
 264  00de 5b04          	addw	sp,#4
 265                     ; 117 }
 268  00e0 85            	popw	x
 269  00e1 81            	ret
 295                     ; 119 void ALCD_Clear(void){
 296                     	switch	.text
 297  00e2               _ALCD_Clear:
 301                     ; 120 	mOptions.CurrentX = 0;
 303  00e2 3f05          	clr	_mOptions+5
 304                     ; 121 	mOptions.CurrentY = 0;
 306  00e4 3f06          	clr	_mOptions+6
 307                     ; 122 	ALCD_WriteCmd(ALCD_CLEARDISPLAY);
 309  00e6 a601          	ld	a,#1
 310  00e8 cd022f        	call	_ALCD_WriteCmd
 312                     ; 123 	ALCD_Delay(4000);
 314  00eb ae0fa0        	ldw	x,#4000
 315  00ee 89            	pushw	x
 316  00ef ae0000        	ldw	x,#0
 317  00f2 89            	pushw	x
 318  00f3 cd01af        	call	_ALCD_Delay
 320  00f6 5b04          	addw	sp,#4
 321                     ; 124 }
 324  00f8 81            	ret
 349                     ; 125 void ALCD_DisplayOn(void){
 350                     	switch	.text
 351  00f9               _ALCD_DisplayOn:
 355                     ; 126 	mOptions.DisplayControl |= ALCD_DISPLAYON;
 357  00f9 72140000      	bset	_mOptions,#2
 358                     ; 127 	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
 360  00fd b600          	ld	a,_mOptions
 361  00ff aa08          	or	a,#8
 362  0101 cd022f        	call	_ALCD_WriteCmd
 364                     ; 128 }
 367  0104 81            	ret
 392                     ; 129 void ALCD_DisplayOff(void){
 393                     	switch	.text
 394  0105               _ALCD_DisplayOff:
 398                     ; 130 	mOptions.DisplayControl &= ~ALCD_DISPLAYON;
 400  0105 72150000      	bres	_mOptions,#2
 401                     ; 131 	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
 403  0109 b600          	ld	a,_mOptions
 404  010b aa08          	or	a,#8
 405  010d cd022f        	call	_ALCD_WriteCmd
 407                     ; 132 }
 410  0110 81            	ret
 435                     ; 133 void ALCD_CursorOn(void){
 436                     	switch	.text
 437  0111               _ALCD_CursorOn:
 441                     ; 134 	mOptions.DisplayControl |= ALCD_CURSORON;
 443  0111 72120000      	bset	_mOptions,#1
 444                     ; 135 	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
 446  0115 b600          	ld	a,_mOptions
 447  0117 aa08          	or	a,#8
 448  0119 cd022f        	call	_ALCD_WriteCmd
 450                     ; 136 }
 453  011c 81            	ret
 478                     ; 137 void ALCD_CursorOff(void){
 479                     	switch	.text
 480  011d               _ALCD_CursorOff:
 484                     ; 138 	mOptions.DisplayControl &= ~ALCD_CURSORON;
 486  011d 72130000      	bres	_mOptions,#1
 487                     ; 139 	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
 489  0121 b600          	ld	a,_mOptions
 490  0123 aa08          	or	a,#8
 491  0125 cd022f        	call	_ALCD_WriteCmd
 493                     ; 140 }
 496  0128 81            	ret
 521                     ; 141 void ALCD_BlinkOn(void){
 522                     	switch	.text
 523  0129               _ALCD_BlinkOn:
 527                     ; 142 	mOptions.DisplayControl |= ALCD_BLINKON;
 529  0129 72100000      	bset	_mOptions,#0
 530                     ; 143 	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
 532  012d b600          	ld	a,_mOptions
 533  012f aa08          	or	a,#8
 534  0131 cd022f        	call	_ALCD_WriteCmd
 536                     ; 144 }
 539  0134 81            	ret
 564                     ; 145 void ALCD_BlinkOff(void){
 565                     	switch	.text
 566  0135               _ALCD_BlinkOff:
 570                     ; 146 	mOptions.DisplayControl &= ~ALCD_BLINKON;
 572  0135 72110000      	bres	_mOptions,#0
 573                     ; 147 	ALCD_WriteCmd(ALCD_DISPLAYCONTROL | mOptions.DisplayControl);
 575  0139 b600          	ld	a,_mOptions
 576  013b aa08          	or	a,#8
 577  013d cd022f        	call	_ALCD_WriteCmd
 579                     ; 148 }
 582  0140 81            	ret
 585                     .const:	section	.text
 586  0000               L521_row_offsets:
 587  0000 00            	dc.b	0
 588  0001 40            	dc.b	64
 589  0002 14            	dc.b	20
 590  0003 54            	dc.b	84
 643                     ; 149 void ALCD_GotoXY(uint8_t x, uint8_t y){
 644                     	switch	.text
 645  0141               _ALCD_GotoXY:
 647  0141 89            	pushw	x
 648       00000000      OFST:	set	0
 651                     ; 153 	if (y >= mOptions.Rows)
 653  0142 9f            	ld	a,xl
 654  0143 b103          	cp	a,_mOptions+3
 655  0145 2502          	jrult	L551
 656                     ; 154 		y = 0;
 658  0147 0f02          	clr	(OFST+2,sp)
 659  0149               L551:
 660                     ; 157 	mOptions.CurrentX = x;
 662  0149 7b01          	ld	a,(OFST+1,sp)
 663  014b b705          	ld	_mOptions+5,a
 664                     ; 158 	mOptions.CurrentY = y;
 666  014d 7b02          	ld	a,(OFST+2,sp)
 667  014f b706          	ld	_mOptions+6,a
 668                     ; 161 	ALCD_WriteCmd(ALCD_SETDDRAMADDR | (x + row_offsets[y]));
 670  0151 7b02          	ld	a,(OFST+2,sp)
 671  0153 5f            	clrw	x
 672  0154 97            	ld	xl,a
 673  0155 d60000        	ld	a,(L521_row_offsets,x)
 674  0158 1b01          	add	a,(OFST+1,sp)
 675  015a aa80          	or	a,#128
 676  015c cd022f        	call	_ALCD_WriteCmd
 678                     ; 162 }
 681  015f 85            	popw	x
 682  0160 81            	ret
 717                     ; 163 void ALCD_PutChar(char c){
 718                     	switch	.text
 719  0161               _ALCD_PutChar:
 723                     ; 164 	ALCD_WriteData(c);
 725  0161 cd0246        	call	_ALCD_WriteData
 727                     ; 165 }
 730  0164 81            	ret
 767                     ; 166 void ALCD_Puts(const char* str){
 768                     	switch	.text
 769  0165               _ALCD_Puts:
 771  0165 89            	pushw	x
 772       00000000      OFST:	set	0
 775  0166 2022          	jra	L512
 776  0168               L312:
 777                     ; 168 		ALCD_WriteData(*str++);
 779  0168 1e01          	ldw	x,(OFST+1,sp)
 780  016a 1c0001        	addw	x,#1
 781  016d 1f01          	ldw	(OFST+1,sp),x
 782  016f 1d0001        	subw	x,#1
 783  0172 f6            	ld	a,(x)
 784  0173 cd0246        	call	_ALCD_WriteData
 786                     ; 169 		if (++mOptions.CurrentX >= mOptions.Cols){
 788  0176 3c05          	inc	_mOptions+5
 789  0178 b605          	ld	a,_mOptions+5
 790  017a b104          	cp	a,_mOptions+4
 791  017c 250c          	jrult	L512
 792                     ; 170 			mOptions.CurrentX = 0;
 794  017e 3f05          	clr	_mOptions+5
 795                     ; 171 			if (++mOptions.CurrentY >= mOptions.Rows){
 797  0180 3c06          	inc	_mOptions+6
 798  0182 b606          	ld	a,_mOptions+6
 799  0184 b103          	cp	a,_mOptions+3
 800  0186 2502          	jrult	L512
 801                     ; 172 				mOptions.CurrentY = 0;
 803  0188 3f06          	clr	_mOptions+6
 804  018a               L512:
 805                     ; 167 	while ('\0' != *str){
 807  018a 1e01          	ldw	x,(OFST+1,sp)
 808  018c 7d            	tnz	(x)
 809  018d 26d9          	jrne	L312
 810                     ; 176 }
 813  018f 85            	popw	x
 814  0190 81            	ret
 868                     ; 177 void ALCD_PutCharXY(char c, uint8_t x, uint8_t y){
 869                     	switch	.text
 870  0191               _ALCD_PutCharXY:
 872  0191 89            	pushw	x
 873       00000000      OFST:	set	0
 876                     ; 178 	ALCD_GotoXY(x, y);
 878  0192 7b05          	ld	a,(OFST+5,sp)
 879  0194 97            	ld	xl,a
 880  0195 7b02          	ld	a,(OFST+2,sp)
 881  0197 95            	ld	xh,a
 882  0198 ada7          	call	_ALCD_GotoXY
 884                     ; 179 	ALCD_PutChar(c);
 886  019a 7b01          	ld	a,(OFST+1,sp)
 887  019c adc3          	call	_ALCD_PutChar
 889                     ; 180 }
 892  019e 85            	popw	x
 893  019f 81            	ret
 948                     ; 181 void ALCD_PutsXY(const char* str, uint8_t x, uint8_t y){
 949                     	switch	.text
 950  01a0               _ALCD_PutsXY:
 952  01a0 89            	pushw	x
 953       00000000      OFST:	set	0
 956                     ; 182 	ALCD_GotoXY(x, y);
 958  01a1 7b06          	ld	a,(OFST+6,sp)
 959  01a3 97            	ld	xl,a
 960  01a4 7b05          	ld	a,(OFST+5,sp)
 961  01a6 95            	ld	xh,a
 962  01a7 ad98          	call	_ALCD_GotoXY
 964                     ; 183 	ALCD_Puts(str);
 966  01a9 1e01          	ldw	x,(OFST+1,sp)
 967  01ab adb8          	call	_ALCD_Puts
 969                     ; 184 }
 972  01ad 85            	popw	x
 973  01ae 81            	ret
1007                     	switch	.const
1008  0004               L04:
1009  0004 00000003      	dc.l	3
1010                     ; 187 void ALCD_Delay(uint32_t us){
1011                     	switch	.text
1012  01af               _ALCD_Delay:
1014       00000000      OFST:	set	0
1017                     ; 188 	us /= 3;
1019  01af 96            	ldw	x,sp
1020  01b0 1c0003        	addw	x,#OFST+3
1021  01b3 cd0000        	call	c_ltor
1023  01b6 ae0004        	ldw	x,#L04
1024  01b9 cd0000        	call	c_ludv
1026  01bc 96            	ldw	x,sp
1027  01bd 1c0003        	addw	x,#OFST+3
1028  01c0 cd0000        	call	c_rtol
1031  01c3               L123:
1032                     ; 189 	while (us--){}
1034  01c3 96            	ldw	x,sp
1035  01c4 1c0003        	addw	x,#OFST+3
1036  01c7 cd0000        	call	c_ltor
1038  01ca 96            	ldw	x,sp
1039  01cb 1c0003        	addw	x,#OFST+3
1040  01ce a601          	ld	a,#1
1041  01d0 cd0000        	call	c_lgsbc
1043  01d3 cd0000        	call	c_lrzmp
1045  01d6 26eb          	jrne	L123
1046                     ; 190 }
1049  01d8 81            	ret
1263                     ; 191 void ALCD_WritePin(GPIO_TypeDef* GPIO, GPIO_Pin_TypeDef Pin, BitAction val){
1264                     	switch	.text
1265  01d9               _ALCD_WritePin:
1267  01d9 89            	pushw	x
1268       00000000      OFST:	set	0
1271                     ; 192 	if (RESET == val){
1273  01da 0d06          	tnz	(OFST+6,sp)
1274  01dc 2609          	jrne	L744
1275                     ; 193 		GPIO_WriteLow(GPIO, Pin);
1277  01de 7b05          	ld	a,(OFST+5,sp)
1278  01e0 88            	push	a
1279  01e1 cd0000        	call	_GPIO_WriteLow
1281  01e4 84            	pop	a
1283  01e5 2009          	jra	L154
1284  01e7               L744:
1285                     ; 196 		GPIO_WriteHigh(GPIO, Pin);
1287  01e7 7b05          	ld	a,(OFST+5,sp)
1288  01e9 88            	push	a
1289  01ea 1e02          	ldw	x,(OFST+2,sp)
1290  01ec cd0000        	call	_GPIO_WriteHigh
1292  01ef 84            	pop	a
1293  01f0               L154:
1294                     ; 198 }
1297  01f0 85            	popw	x
1298  01f1 81            	ret
1334                     ; 199 void ALCD_WriteCmd4Bit(uint8_t cmd){
1335                     	switch	.text
1336  01f2               _ALCD_WriteCmd4Bit:
1338  01f2 88            	push	a
1339       00000000      OFST:	set	0
1342                     ; 200 	ALCD_WritePin(ALCD_D4_GPIO, ALCD_D4_Pin, cmd & 0x01);
1344  01f3 a401          	and	a,#1
1345  01f5 88            	push	a
1346  01f6 4b02          	push	#2
1347  01f8 ae500f        	ldw	x,#20495
1348  01fb addc          	call	_ALCD_WritePin
1350  01fd 85            	popw	x
1351                     ; 201 	cmd >>= 1;
1353  01fe 0401          	srl	(OFST+1,sp)
1354                     ; 202 	ALCD_WritePin(ALCD_D5_GPIO, ALCD_D5_Pin, cmd & 0x01);
1356  0200 7b01          	ld	a,(OFST+1,sp)
1357  0202 a401          	and	a,#1
1358  0204 88            	push	a
1359  0205 4b04          	push	#4
1360  0207 ae500f        	ldw	x,#20495
1361  020a adcd          	call	_ALCD_WritePin
1363  020c 85            	popw	x
1364                     ; 203 	cmd >>= 1;
1366  020d 0401          	srl	(OFST+1,sp)
1367                     ; 204 	ALCD_WritePin(ALCD_D5_GPIO, ALCD_D6_Pin, cmd & 0x01);
1369  020f 7b01          	ld	a,(OFST+1,sp)
1370  0211 a401          	and	a,#1
1371  0213 88            	push	a
1372  0214 4b08          	push	#8
1373  0216 ae500f        	ldw	x,#20495
1374  0219 adbe          	call	_ALCD_WritePin
1376  021b 85            	popw	x
1377                     ; 205 	cmd >>= 1;
1379  021c 0401          	srl	(OFST+1,sp)
1380                     ; 206 	ALCD_WritePin(ALCD_D5_GPIO, ALCD_D7_Pin, cmd & 0x01);
1382  021e 7b01          	ld	a,(OFST+1,sp)
1383  0220 a401          	and	a,#1
1384  0222 88            	push	a
1385  0223 4b10          	push	#16
1386  0225 ae500f        	ldw	x,#20495
1387  0228 adaf          	call	_ALCD_WritePin
1389  022a 85            	popw	x
1390                     ; 208 	ALCD_LatchData();;
1392  022b ad30          	call	_ALCD_LatchData
1394                     ; 209 }
1398  022d 84            	pop	a
1399  022e 81            	ret
1435                     ; 210 void ALCD_WriteCmd(uint8_t cmd){
1436                     	switch	.text
1437  022f               _ALCD_WriteCmd:
1439  022f 88            	push	a
1440       00000000      OFST:	set	0
1443                     ; 211 	ALCD_RS_Low();
1445  0230 4b02          	push	#2
1446  0232 ae5000        	ldw	x,#20480
1447  0235 cd0000        	call	_GPIO_WriteLow
1449  0238 84            	pop	a
1450                     ; 212 	ALCD_WriteCmd4Bit(cmd >> 4);
1452  0239 7b01          	ld	a,(OFST+1,sp)
1453  023b 4e            	swap	a
1454  023c a40f          	and	a,#15
1455  023e adb2          	call	_ALCD_WriteCmd4Bit
1457                     ; 213 	ALCD_WriteCmd4Bit(cmd);
1459  0240 7b01          	ld	a,(OFST+1,sp)
1460  0242 adae          	call	_ALCD_WriteCmd4Bit
1462                     ; 214 }
1465  0244 84            	pop	a
1466  0245 81            	ret
1502                     ; 215 void ALCD_WriteData(uint8_t data){
1503                     	switch	.text
1504  0246               _ALCD_WriteData:
1506  0246 88            	push	a
1507       00000000      OFST:	set	0
1510                     ; 216 	ALCD_RS_High();
1512  0247 4b02          	push	#2
1513  0249 ae5000        	ldw	x,#20480
1514  024c cd0000        	call	_GPIO_WriteHigh
1516  024f 84            	pop	a
1517                     ; 217 	ALCD_WriteCmd4Bit(data >> 4);
1519  0250 7b01          	ld	a,(OFST+1,sp)
1520  0252 4e            	swap	a
1521  0253 a40f          	and	a,#15
1522  0255 ad9b          	call	_ALCD_WriteCmd4Bit
1524                     ; 218 	ALCD_WriteCmd4Bit(data);
1526  0257 7b01          	ld	a,(OFST+1,sp)
1527  0259 ad97          	call	_ALCD_WriteCmd4Bit
1529                     ; 219 }
1532  025b 84            	pop	a
1533  025c 81            	ret
1559                     ; 220 void ALCD_LatchData(void){
1560                     	switch	.text
1561  025d               _ALCD_LatchData:
1565                     ; 221 		ALCD_EN_Low();
1567  025d 4b08          	push	#8
1568  025f ae5000        	ldw	x,#20480
1569  0262 cd0000        	call	_GPIO_WriteLow
1571  0265 84            	pop	a
1572                     ; 222 		ALCD_Delay(20);
1574  0266 ae0014        	ldw	x,#20
1575  0269 89            	pushw	x
1576  026a ae0000        	ldw	x,#0
1577  026d 89            	pushw	x
1578  026e cd01af        	call	_ALCD_Delay
1580  0271 5b04          	addw	sp,#4
1581                     ; 223 		ALCD_EN_High();
1583  0273 4b08          	push	#8
1584  0275 ae5000        	ldw	x,#20480
1585  0278 cd0000        	call	_GPIO_WriteHigh
1587  027b 84            	pop	a
1588                     ; 224 		ALCD_Delay(20);
1590  027c ae0014        	ldw	x,#20
1591  027f 89            	pushw	x
1592  0280 ae0000        	ldw	x,#0
1593  0283 89            	pushw	x
1594  0284 cd01af        	call	_ALCD_Delay
1596  0287 5b04          	addw	sp,#4
1597                     ; 225 }
1600  0289 81            	ret
1681                     	xdef	_ALCD_LatchData
1682                     	xdef	_ALCD_WriteData
1683                     	xdef	_ALCD_WriteCmd
1684                     	xdef	_ALCD_WriteCmd4Bit
1685                     	xdef	_ALCD_WritePin
1686                     	xdef	_ALCD_Delay
1687                     	switch	.ubsct
1688  0000               _mOptions:
1689  0000 000000000000  	ds.b	7
1690                     	xdef	_mOptions
1691                     	xdef	_ALCD_PutsXY
1692                     	xdef	_ALCD_PutCharXY
1693                     	xdef	_ALCD_Puts
1694                     	xdef	_ALCD_PutChar
1695                     	xdef	_ALCD_GotoXY
1696                     	xdef	_ALCD_BlinkOff
1697                     	xdef	_ALCD_BlinkOn
1698                     	xdef	_ALCD_CursorOff
1699                     	xdef	_ALCD_CursorOn
1700                     	xdef	_ALCD_DisplayOff
1701                     	xdef	_ALCD_DisplayOn
1702                     	xdef	_ALCD_Clear
1703                     	xdef	_ALCD_Init
1704                     	xref	_GPIO_WriteLow
1705                     	xref	_GPIO_WriteHigh
1706                     	xref	_GPIO_Init
1707                     	xref	_CLK_HSIPrescalerConfig
1708                     	xref.b	c_x
1728                     	xref	c_lrzmp
1729                     	xref	c_lgsbc
1730                     	xref	c_rtol
1731                     	xref	c_ludv
1732                     	xref	c_ltor
1733                     	end
