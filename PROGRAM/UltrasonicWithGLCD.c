// Glcd module connections
char GLCD_DataPort at PORTD;
sbit GLCD_CS1 at RE0_bit;
sbit GLCD_CS2 at RE1_bit;
sbit GLCD_RS at RE2_bit;
sbit GLCD_RW at RC0_bit;
sbit GLCD_EN at RC1_bit;
sbit GLCD_RST at RC2_bit;
sbit GLCD_CS1_Direction at TRISE0_bit;
sbit GLCD_CS2_Direction at TRISE1_bit;
sbit GLCD_RS_Direction at TRISE2_bit;
sbit GLCD_RW_Direction at TRISC0_bit;
sbit GLCD_EN_Direction at TRISC1_bit;
sbit GLCD_RST_Direction at TRISC2_bit;
// End Glcd module connections



unsigned int time;  //stores timer1 value
char time_txt[8];  //stores time in uS converted to stirng
unsigned int distance , _distance; //stores the calculated distance
char distance_txt[8];  //stores distance converted to stirng
unsigned short cnt=0;
bit flag;
void get_distance();

void config ()
{
 ADCON1=0b00001111;                //CONVERT ANALOG TO DIGITAL FOR LAST 4 PINS

 TRISA.F5=0;                       //TRIGER AS OUTPUT
 TRISB.F5=1;                       //ECHO AS INPUT
 TRISC.F4=0;                       //LED1 AS OUTPUT
 TRISE.F3=1;                       //LCMR (RESET PIC) AS INPUT
 TRISC.F5=0;                       //BUZZER AS OUTPUT
 TRISB.F7=1;
 PORTB.F7=0;
 
 GLCD_INIT();
 GLCD_FILL(0);
 GLCD_WRITE_TEXT("WELCOME",0,2,1);
 PORTC.F4=1;
 DELAY_ms(1000);
 GLCD_FILL(0);
 PORTC.F4=0;
 GLCD_WRITE_TEXT("Distance Measuring ",10,0,1);

 T1CON=0b00000000;                         //RESET TIMER1
 RBIF_bit =0;
 RBIE_bit =1;
 PEIE_bit =1;
 GIE_bit  =1;
}

void check_object (){
 if (_distance < 10)
 {
  PORTC.F5=1;
 }
 else
 {
  PORTC.F5=0;
 }
 if (_distance > 2 && _distance < 10 && cnt!=1)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(30,50,38,55,1);
  cnt=1;
 }
 if (_distance > 10 && _distance < 20 && cnt!=2)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(20,50,30,55,1);
  cnt=2;
 }
 if (_distance > 20 && _distance < 30 && cnt!=3)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(10,50,20,55,1);
  cnt=3;
 }
 if (_distance > 30 && _distance < 40 && cnt!=4)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(2,50,10,55,1);
  cnt=4;
 }
 if (_distance > 40 && _distance < 50 && cnt!=5)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  glcd_box(120,50,127,55,1);
  cnt=5;
 }
 if (_distance > 50 && _distance < 60 && cnt!=6)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  glcd_box(110,50,120,55,1);
  cnt=6;
 }
 if (_distance > 60 && _distance < 70 && cnt!=7)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  glcd_box(100,50,110,55,1);
  cnt=7;
 }
 if (_distance > 70 && _distance < 80 && cnt!=8)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  glcd_box(90,50,100,55,1);
  cnt=8;
 }
 if (_distance > 80 && _distance < 90 && cnt!=9)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  glcd_box(80,50,90,55,1);
  cnt=9;
 }
 if (_distance > 90 && _distance < 100 && cnt!=10)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  glcd_box(70,50,80,55,1);
  cnt=10;
 }
 if(_distance > 100 && cnt!=11)
 {
  glcd_box(1,45,38,63,0);
  glcd_box(64,45,127,63,0);
  GLCD_WRITE_TEXT("out of range",64,3,1);
  cnt=11;
 }
}

void get_distsnce()
{
 TMR1H=0;            //RESET TIMER1 4BYTES FOR HGH EDGE
 TMR1L=0;            //RESET TIMER1 4BYTES FOR LOW
 PORTC.F3=1;         //trigger pulse
 delay_us(10);
 PORTC.F3=0;

 if(flag == 1 && _distance != distance)
 {
 _distance=distance;

 wordtostr(time,time_txt);
 wordtostr(distance,distance_txt);

 Ltrim(time_txt);
 Ltrim(distance_txt);

 if( distance>=2 && distance<=400)
 {
  GLCD_WRITE_TEXT("         " ,65,2,1);
  GLCD_WRITE_TEXT("DISTANCE=",65,2,1);
  GLCD_WRITE_TEXT(distance_txt ,1,2,1);
 }
 check_object();
 flag=0;
 }

}



void main() {
config();
GLCD_WRITE_TEXT("DISTANCE=" ,65,2,1);
GLCD_WRITE_TEXT("CM" ,52,2,1);
GLCD_RECTANGLE(40,45,63,63,1);
while (1)
{
get_distsnce();
}
}

void interrupt(){
 if (RBIF==1)
 {
  RBIE_bit=0;
  if (PORTB.F5==1)
  {
   TMR1ON_bit=1;
  }
  if (PORTB.F5==0)
  {
   TMR1ON_bit=0;
   time=((TMR1H << 8)+TMR1L);
   distance=(time/58)/2;
   flag=1;
  }
  RBIF_bit=0;
  RBIE_bit=1;
 }
}