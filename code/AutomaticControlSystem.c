// Keypad
char  keypadPort at PORTB;
// Lcd
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

#define OV1 PORTD.RD0
#define FAN1 PORTD.RD1
#define ENTER 15
#define CLEAR 13
#define ON 1
#define OFF 0

void main() {
  unsigned short kp,Txt[14];   // Keypad input
  unsigned short Temp_Ref ;                           // User temperature reference
  unsigned char inTemp;
  unsigned int temp;
  float mV, ActualTemp;

  Keypad_Init();                                      // Initialize keypad
  ANSELC = 0;                                         // Configure PORTC as digital
  ANSELB = 0;                                         // Configure PORTB as digital
  ANSELD = 0;                                          // Configure PORTD as digital
  TRISA0_bit = 1;                                      // Configure RA0 as input
  TRISC = 0;                                          // Configure PORTC as output (LCD)
  TRISD0_bit=0;                                       // Configure RD0 as output (OV1)
  TRISD1_bit=0;                                        // Configure RD1 as output (Fan1)

  Lcd_Init();                                         // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);                                // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);                           // Cursor off
  Lcd_Out(1, 1, "Welcome to");                       // Display welcome message
  Lcd_Out(2, 1, "Temprature System");
  delay_ms(2000);                                     //2s delay

  OV1 = OFF;
  FAN1 = OFF;


        START:
       Lcd_Cmd(_LCD_CLEAR);                           // Clear display
       Lcd_Out(1, 1, "Temp Ref GIR");
       Temp_Ref=0;
        Lcd_Out(2, 1, "Temp Ref: ");
        while(1)
        {
         do
         kp = Keypad_Key_Click();                      // Store key code in kp variable
         while (!kp);
         if ( kp == ENTER )break;
         if (kp > 3 && kp < 8) kp = kp-1;
         if (kp > 8 && kp < 12) kp = kp-2;
         if (kp ==14)kp = 0;
         if ( kp == CLEAR )goto START;
         Lcd_Chr_Cp(kp + '0');
         Temp_Ref =(10*Temp_Ref) + kp;
       }
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1, 1, "Temp Ref: ");
      intToStr( Temp_Ref,Txt);
      inTemp=Ltrim(Txt);
       Lcd_Out_CP(inTemp);
      Lcd_Out(2, 1, "Press # to Cont.");
      //Wait until # is pressed
      kp =0;
      while(kp!=ENTER)
      {
         do
           kp = Keypad_Key_Click();
         while(!kp);
      }
       Lcd_Cmd(_LCD_CLEAR);                            // Clear display

   Lcd_Out(1, 1, "Temp Ref: ");    // Use DisplayValue to show RefTemp
   Lcd_Chr(1,15,223);                                  // Degree symbol
   Lcd_Chr(1,16,'C');                                 // Celsius "C"
   //Program loop
  while(1) {
     // Read and convert ADC value
     temp = ADC_Read(0);                               // Read raw ADC value
     mV = temp * 5000.0/1024.0;                        // Convert to millivolts
     ActualTemp = mV/10.0 ;
     intToStr( Temp_Ref,Txt);
     inTemp=Ltrim(Txt);
     //Lcd_Out(1, 1, "Temp Ref: ");
     Lcd_Out(1, 11, inTemp);                           // Ref Temp
     Lcd_Out(2, 1, "Temp= ");
     FloatToStr(ActualTemp,Txt);                       // float to string
     Txt[4] = 0;
     Lcd_Out(2,7,Txt);
     Lcd_Out(2,12,"  ");


      if (Temp_Ref >  ActualTemp)
      {
      OV1 = ON;  // Turn on the heater
      FAN1 = OFF;
      Lcd_Out(1, 1, "Heating..");
      }
       if (Temp_Ref <  ActualTemp)
      {
      OV1 = OFF,
      FAN1 = ON;   // Turn on the fan
      Lcd_Out(1, 1, "Cooling..");
      }
       if (Temp_Ref ==  ActualTemp)
      {
      OV1 = OFF,
      FAN1 = OFF;
      Lcd_Out(1, 1, "Idle..");
      }
      Delay_ms(1000);

      if(  ActualTemp >  25)
       {
       Lcd_Cmd(_LCD_CLEAR);                             //  (Clear display )
       Lcd_Out(1, 1, " So Hot.. ");
      }
      if(  ActualTemp <  10)
       {
       Lcd_Cmd(_LCD_CLEAR);
       Lcd_Out(1, 1, "So Cold.. ");
      }
  }
}