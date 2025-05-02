#line 1 "C:/Users/Nagham/Desktop/New folder/AutomaticControlSystem.c"

char keypadPort at PORTB;

sbit LCD_RS at LATC4_bit;
sbit LCD_EN at LATC5_bit;
sbit LCD_D4 at LATC0_bit;
sbit LCD_D5 at LATC1_bit;
sbit LCD_D6 at LATC2_bit;
sbit LCD_D7 at LATC3_bit;

sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC0_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D7_Direction at TRISC3_bit;








void main() {
 unsigned short kp,Txt[14];
 unsigned short Temp_Ref ;
 unsigned char inTemp;
 unsigned int temp;
 float mV, ActualTemp;

 Keypad_Init();
 ANSELC = 0;
 ANSELB = 0;
 ANSELD = 0;
 TRISA0_bit = 1;
 TRISC = 0;
 TRISD0_bit=0;
 TRISD1_bit=0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Welcome to");
 Lcd_Out(2, 1, "Temprature System");
 delay_ms(2000);

  PORTD.RD0  =  0 ;
  PORTD.RD1  =  0 ;


 START:
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Temp Ref GIR");
 Temp_Ref=0;
 Lcd_Out(2, 1, "Temp Ref: ");
 while(1)
 {
 do
 kp = Keypad_Key_Click();
 while (!kp);
 if ( kp ==  15  )break;
 if (kp > 3 && kp < 8) kp = kp-1;
 if (kp > 8 && kp < 12) kp = kp-2;
 if (kp ==14)kp = 0;
 if ( kp ==  13  )goto START;
 Lcd_Chr_Cp(kp + '0');
 Temp_Ref =(10*Temp_Ref) + kp;
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Temp Ref: ");
 intToStr( Temp_Ref,Txt);
 inTemp=Ltrim(Txt);
 Lcd_Out_CP(inTemp);
 Lcd_Out(2, 1, "Press # to Cont.");

 kp =0;
 while(kp!= 15 )
 {
 do
 kp = Keypad_Key_Click();
 while(!kp);
 }
 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1, 1, "Temp Ref: ");
 Lcd_Chr(1,15,223);
 Lcd_Chr(1,16,'C');

 while(1) {

 temp = ADC_Read(0);
 mV = temp * 5000.0/1024.0;
 ActualTemp = mV/10.0 ;
 intToStr( Temp_Ref,Txt);
 inTemp=Ltrim(Txt);

 Lcd_Out(1, 11, inTemp);
 Lcd_Out(2, 1, "Temp= ");
 FloatToStr(ActualTemp,Txt);
 Txt[4] = 0;
 Lcd_Out(2,7,Txt);
 Lcd_Out(2,12,"  ");


 if (Temp_Ref > ActualTemp)
 {
  PORTD.RD0  =  1 ;
  PORTD.RD1  =  0 ;
 Lcd_Out(1, 1, "Heating..");
 }
 if (Temp_Ref < ActualTemp)
 {
  PORTD.RD0  =  0 ,
  PORTD.RD1  =  1 ;
 Lcd_Out(1, 1, "Cooling..");
 }
 if (Temp_Ref == ActualTemp)
 {
  PORTD.RD0  =  0 ,
  PORTD.RD1  =  0 ;
 Lcd_Out(1, 1, "Idle..");
 }
 Delay_ms(1000);

 if( ActualTemp > 25)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, " So Hot.. ");
 }
 if( ActualTemp < 10)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "So Cold.. ");
 }
 }
}
