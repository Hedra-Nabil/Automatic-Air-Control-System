
_main:

;AutomaticControlSystem.c,25 :: 		void main() {
;AutomaticControlSystem.c,32 :: 		Keypad_Init();                                      // Initialize keypad
	CALL        _Keypad_Init+0, 0
;AutomaticControlSystem.c,33 :: 		ANSELC = 0;                                         // Configure PORTC as digital
	CLRF        ANSELC+0 
;AutomaticControlSystem.c,34 :: 		ANSELB = 0;                                         // Configure PORTB as digital
	CLRF        ANSELB+0 
;AutomaticControlSystem.c,35 :: 		ANSELD = 0;                                          // Configure PORTD as digital
	CLRF        ANSELD+0 
;AutomaticControlSystem.c,36 :: 		TRISA0_bit = 1;                                      // Configure RA0 as input
	BSF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;AutomaticControlSystem.c,37 :: 		TRISC = 0;                                          // Configure PORTC as output (LCD)
	CLRF        TRISC+0 
;AutomaticControlSystem.c,38 :: 		TRISD0_bit=0;                                       // Configure RD0 as output (OV1)
	BCF         TRISD0_bit+0, BitPos(TRISD0_bit+0) 
;AutomaticControlSystem.c,39 :: 		TRISD1_bit=0;                                        // Configure RD1 as output (Fan1)
	BCF         TRISD1_bit+0, BitPos(TRISD1_bit+0) 
;AutomaticControlSystem.c,41 :: 		Lcd_Init();                                         // Initialize LCD
	CALL        _Lcd_Init+0, 0
;AutomaticControlSystem.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);                                // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                           // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,44 :: 		Lcd_Out(1, 1, "Welcome to");                       // Display welcome message
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,45 :: 		Lcd_Out(2, 1, "Temprature System");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,46 :: 		delay_ms(2000);                                     //2s delay
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;AutomaticControlSystem.c,48 :: 		OV1 = OFF;
	BCF         PORTD+0, 0 
;AutomaticControlSystem.c,49 :: 		FAN1 = OFF;
	BCF         PORTD+0, 1 
;AutomaticControlSystem.c,52 :: 		START:
___main_START:
;AutomaticControlSystem.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);                           // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,54 :: 		Lcd_Out(1, 1, "Temp Ref GIR");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,55 :: 		Temp_Ref=0;
	CLRF        main_Temp_Ref_L0+0 
;AutomaticControlSystem.c,56 :: 		Lcd_Out(2, 1, "Temp Ref: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,57 :: 		while(1)
L_main1:
;AutomaticControlSystem.c,59 :: 		do
L_main3:
;AutomaticControlSystem.c,60 :: 		kp = Keypad_Key_Click();                      // Store key code in kp variable
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;AutomaticControlSystem.c,61 :: 		while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;AutomaticControlSystem.c,62 :: 		if ( kp == ENTER )break;
	MOVF        main_kp_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
	GOTO        L_main2
L_main6:
;AutomaticControlSystem.c,63 :: 		if (kp > 3 && kp < 8) kp = kp-1;
	MOVF        main_kp_L0+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
	MOVLW       8
	SUBWF       main_kp_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
L__main29:
	DECF        main_kp_L0+0, 1 
L_main9:
;AutomaticControlSystem.c,64 :: 		if (kp > 8 && kp < 12) kp = kp-2;
	MOVF        main_kp_L0+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
	MOVLW       12
	SUBWF       main_kp_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
L__main28:
	MOVLW       2
	SUBWF       main_kp_L0+0, 1 
L_main12:
;AutomaticControlSystem.c,65 :: 		if (kp ==14)kp = 0;
	MOVF        main_kp_L0+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
	CLRF        main_kp_L0+0 
L_main13:
;AutomaticControlSystem.c,66 :: 		if ( kp == CLEAR )goto START;
	MOVF        main_kp_L0+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	GOTO        ___main_START
L_main14:
;AutomaticControlSystem.c,67 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       main_kp_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;AutomaticControlSystem.c,68 :: 		Temp_Ref =(10*Temp_Ref) + kp;
	MOVLW       10
	MULWF       main_Temp_Ref_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       main_Temp_Ref_L0+0 
	MOVF        main_kp_L0+0, 0 
	ADDWF       main_Temp_Ref_L0+0, 1 
;AutomaticControlSystem.c,69 :: 		}
	GOTO        L_main1
L_main2:
;AutomaticControlSystem.c,70 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,71 :: 		Lcd_Out(1, 1, "Temp Ref: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,72 :: 		intToStr( Temp_Ref,Txt);
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_Txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_Txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;AutomaticControlSystem.c,73 :: 		inTemp=Ltrim(Txt);
	MOVLW       main_Txt_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_Txt_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;AutomaticControlSystem.c,74 :: 		Lcd_Out_CP(inTemp);
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AutomaticControlSystem.c,75 :: 		Lcd_Out(2, 1, "Press # to Cont.");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,77 :: 		kp =0;
	CLRF        main_kp_L0+0 
;AutomaticControlSystem.c,78 :: 		while(kp!=ENTER)
L_main15:
	MOVF        main_kp_L0+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
;AutomaticControlSystem.c,80 :: 		do
L_main17:
;AutomaticControlSystem.c,81 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;AutomaticControlSystem.c,82 :: 		while(!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
;AutomaticControlSystem.c,83 :: 		}
	GOTO        L_main15
L_main16:
;AutomaticControlSystem.c,84 :: 		Lcd_Cmd(_LCD_CLEAR);                            // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,86 :: 		Lcd_Out(1, 1, "Temp Ref: ");    // Use DisplayValue to show RefTemp
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,87 :: 		Lcd_Chr(1,15,223);                                  // Degree symbol
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;AutomaticControlSystem.c,88 :: 		Lcd_Chr(1,16,'C');                                 // Celsius "C"
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;AutomaticControlSystem.c,90 :: 		while(1) {
L_main20:
;AutomaticControlSystem.c,92 :: 		temp = ADC_Read(0);                               // Read raw ADC value
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;AutomaticControlSystem.c,93 :: 		mV = temp * 5000.0/1024.0;                        // Convert to millivolts
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;AutomaticControlSystem.c,94 :: 		ActualTemp = mV/10.0 ;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_ActualTemp_L0+0 
	MOVF        R1, 0 
	MOVWF       main_ActualTemp_L0+1 
	MOVF        R2, 0 
	MOVWF       main_ActualTemp_L0+2 
	MOVF        R3, 0 
	MOVWF       main_ActualTemp_L0+3 
;AutomaticControlSystem.c,95 :: 		intToStr( Temp_Ref,Txt);
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_Txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_Txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;AutomaticControlSystem.c,96 :: 		inTemp=Ltrim(Txt);
	MOVLW       main_Txt_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_Txt_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;AutomaticControlSystem.c,98 :: 		Lcd_Out(1, 11, inTemp);                           // Ref Temp
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,99 :: 		Lcd_Out(2, 1, "Temp= ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,100 :: 		FloatToStr(ActualTemp,Txt);                       // float to string
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_Txt_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_Txt_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;AutomaticControlSystem.c,101 :: 		Txt[4] = 0;
	CLRF        main_Txt_L0+4 
;AutomaticControlSystem.c,102 :: 		Lcd_Out(2,7,Txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_Txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_Txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,103 :: 		Lcd_Out(2,12,"  ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,106 :: 		if (Temp_Ref >  ActualTemp)
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R1 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R2 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
;AutomaticControlSystem.c,108 :: 		OV1 = ON;  // Turn on the heater
	BSF         PORTD+0, 0 
;AutomaticControlSystem.c,109 :: 		FAN1 = OFF;
	BCF         PORTD+0, 1 
;AutomaticControlSystem.c,110 :: 		Lcd_Out(1, 1, "Heating..");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,111 :: 		}
L_main22:
;AutomaticControlSystem.c,112 :: 		if (Temp_Ref <  ActualTemp)
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;AutomaticControlSystem.c,114 :: 		OV1 = OFF,
	BCF         PORTD+0, 0 
;AutomaticControlSystem.c,115 :: 		FAN1 = ON;   // Turn on the fan
	BSF         PORTD+0, 1 
;AutomaticControlSystem.c,116 :: 		Lcd_Out(1, 1, "Cooling..");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,117 :: 		}
L_main23:
;AutomaticControlSystem.c,118 :: 		if (Temp_Ref ==  ActualTemp)
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;AutomaticControlSystem.c,120 :: 		OV1 = OFF,
	BCF         PORTD+0, 0 
;AutomaticControlSystem.c,121 :: 		FAN1 = OFF;
	BCF         PORTD+0, 1 
;AutomaticControlSystem.c,122 :: 		Lcd_Out(1, 1, "Idle..");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,123 :: 		}
L_main24:
;AutomaticControlSystem.c,124 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main25:
	DECFSZ      R13, 1, 1
	BRA         L_main25
	DECFSZ      R12, 1, 1
	BRA         L_main25
	DECFSZ      R11, 1, 1
	BRA         L_main25
	NOP
	NOP
;AutomaticControlSystem.c,126 :: 		if(  ActualTemp >  25)
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R4 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R5 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R6 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       72
	MOVWF       R2 
	MOVLW       131
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
;AutomaticControlSystem.c,128 :: 		Lcd_Cmd(_LCD_CLEAR);                             //  (Clear display )
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,129 :: 		Lcd_Out(1, 1, " So Hot.. ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,130 :: 		}
L_main26:
;AutomaticControlSystem.c,131 :: 		if(  ActualTemp <  10)
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        main_ActualTemp_L0+0, 0 
	MOVWF       R0 
	MOVF        main_ActualTemp_L0+1, 0 
	MOVWF       R1 
	MOVF        main_ActualTemp_L0+2, 0 
	MOVWF       R2 
	MOVF        main_ActualTemp_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
;AutomaticControlSystem.c,133 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutomaticControlSystem.c,134 :: 		Lcd_Out(1, 1, "So Cold.. ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_AutomaticControlSystem+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_AutomaticControlSystem+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutomaticControlSystem.c,135 :: 		}
L_main27:
;AutomaticControlSystem.c,136 :: 		}
	GOTO        L_main20
;AutomaticControlSystem.c,137 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
