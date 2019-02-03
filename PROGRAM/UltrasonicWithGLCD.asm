
_config:

;UltrasonicWithGLCD.c,27 :: 		void config ()
;UltrasonicWithGLCD.c,29 :: 		ADCON1=0b00001111;                //CONVERT ANALOG TO DIGITAL FOR LAST 4 PINS
	MOVLW       15
	MOVWF       ADCON1+0 
;UltrasonicWithGLCD.c,31 :: 		TRISA.F5=0;                       //TRIGER AS OUTPUT
	BCF         TRISA+0, 5 
;UltrasonicWithGLCD.c,32 :: 		TRISB.F5=1;                       //ECHO AS INPUT
	BSF         TRISB+0, 5 
;UltrasonicWithGLCD.c,33 :: 		TRISC.F4=0;                       //LED1 AS OUTPUT
	BCF         TRISC+0, 4 
;UltrasonicWithGLCD.c,34 :: 		TRISE.F3=1;                       //LCMR (RESET PIC) AS INPUT
	BSF         TRISE+0, 3 
;UltrasonicWithGLCD.c,35 :: 		TRISC.F5=0;                       //BUZZER AS OUTPUT
	BCF         TRISC+0, 5 
;UltrasonicWithGLCD.c,36 :: 		TRISB.F7=1;
	BSF         TRISB+0, 7 
;UltrasonicWithGLCD.c,37 :: 		PORTB.F7=0;
	BCF         PORTB+0, 7 
;UltrasonicWithGLCD.c,39 :: 		GLCD_INIT();
	CALL        _Glcd_Init+0, 0
;UltrasonicWithGLCD.c,40 :: 		GLCD_FILL(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;UltrasonicWithGLCD.c,41 :: 		GLCD_WRITE_TEXT("WELCOME",0,2,1);
	MOVLW       ?lstr1_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr1_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,42 :: 		PORTC.F4=1;
	BSF         PORTC+0, 4 
;UltrasonicWithGLCD.c,43 :: 		DELAY_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_config0:
	DECFSZ      R13, 1, 1
	BRA         L_config0
	DECFSZ      R12, 1, 1
	BRA         L_config0
	DECFSZ      R11, 1, 1
	BRA         L_config0
	NOP
	NOP
;UltrasonicWithGLCD.c,44 :: 		GLCD_FILL(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;UltrasonicWithGLCD.c,45 :: 		PORTC.F4=0;
	BCF         PORTC+0, 4 
;UltrasonicWithGLCD.c,46 :: 		GLCD_WRITE_TEXT("Distance Measuring ",10,0,1);
	MOVLW       ?lstr2_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr2_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       10
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,48 :: 		T1CON=0b00000000;                         //RESET TIMER1
	CLRF        T1CON+0 
;UltrasonicWithGLCD.c,49 :: 		RBIF_bit =0;
	BCF         RBIF_bit+0, 0 
;UltrasonicWithGLCD.c,50 :: 		RBIE_bit =1;
	BSF         RBIE_bit+0, 3 
;UltrasonicWithGLCD.c,51 :: 		PEIE_bit =1;
	BSF         PEIE_bit+0, 6 
;UltrasonicWithGLCD.c,52 :: 		GIE_bit  =1;
	BSF         GIE_bit+0, 7 
;UltrasonicWithGLCD.c,53 :: 		}
L_end_config:
	RETURN      0
; end of _config

_check_object:

;UltrasonicWithGLCD.c,55 :: 		void check_object (){
;UltrasonicWithGLCD.c,56 :: 		if (_distance < 10)
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object63
	MOVLW       10
	SUBWF       __distance+0, 0 
L__check_object63:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object1
;UltrasonicWithGLCD.c,58 :: 		PORTC.F5=1;
	BSF         PORTC+0, 5 
;UltrasonicWithGLCD.c,59 :: 		}
	GOTO        L_check_object2
L_check_object1:
;UltrasonicWithGLCD.c,62 :: 		PORTC.F5=0;
	BCF         PORTC+0, 5 
;UltrasonicWithGLCD.c,63 :: 		}
L_check_object2:
;UltrasonicWithGLCD.c,64 :: 		if (_distance > 2 && _distance < 10 && cnt!=1)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object64
	MOVF        __distance+0, 0 
	SUBLW       2
L__check_object64:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object5
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object65
	MOVLW       10
	SUBWF       __distance+0, 0 
L__check_object65:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object5
	MOVF        _cnt+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object5
L__check_object58:
;UltrasonicWithGLCD.c,66 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,67 :: 		glcd_box(30,50,38,55,1);
	MOVLW       30
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,68 :: 		cnt=1;
	MOVLW       1
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,69 :: 		}
L_check_object5:
;UltrasonicWithGLCD.c,70 :: 		if (_distance > 10 && _distance < 20 && cnt!=2)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object66
	MOVF        __distance+0, 0 
	SUBLW       10
L__check_object66:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object8
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object67
	MOVLW       20
	SUBWF       __distance+0, 0 
L__check_object67:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object8
	MOVF        _cnt+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object8
L__check_object57:
;UltrasonicWithGLCD.c,72 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,73 :: 		glcd_box(20,50,30,55,1);
	MOVLW       20
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       30
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,74 :: 		cnt=2;
	MOVLW       2
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,75 :: 		}
L_check_object8:
;UltrasonicWithGLCD.c,76 :: 		if (_distance > 20 && _distance < 30 && cnt!=3)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object68
	MOVF        __distance+0, 0 
	SUBLW       20
L__check_object68:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object11
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object69
	MOVLW       30
	SUBWF       __distance+0, 0 
L__check_object69:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object11
	MOVF        _cnt+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object11
L__check_object56:
;UltrasonicWithGLCD.c,78 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,79 :: 		glcd_box(10,50,20,55,1);
	MOVLW       10
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       20
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,80 :: 		cnt=3;
	MOVLW       3
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,81 :: 		}
L_check_object11:
;UltrasonicWithGLCD.c,82 :: 		if (_distance > 30 && _distance < 40 && cnt!=4)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object70
	MOVF        __distance+0, 0 
	SUBLW       30
L__check_object70:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object14
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object71
	MOVLW       40
	SUBWF       __distance+0, 0 
L__check_object71:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object14
	MOVF        _cnt+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object14
L__check_object55:
;UltrasonicWithGLCD.c,84 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,85 :: 		glcd_box(2,50,10,55,1);
	MOVLW       2
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       10
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,86 :: 		cnt=4;
	MOVLW       4
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,87 :: 		}
L_check_object14:
;UltrasonicWithGLCD.c,88 :: 		if (_distance > 40 && _distance < 50 && cnt!=5)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object72
	MOVF        __distance+0, 0 
	SUBLW       40
L__check_object72:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object17
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object73
	MOVLW       50
	SUBWF       __distance+0, 0 
L__check_object73:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object17
	MOVF        _cnt+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object17
L__check_object54:
;UltrasonicWithGLCD.c,90 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,91 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,92 :: 		glcd_box(120,50,127,55,1);
	MOVLW       120
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,93 :: 		cnt=5;
	MOVLW       5
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,94 :: 		}
L_check_object17:
;UltrasonicWithGLCD.c,95 :: 		if (_distance > 50 && _distance < 60 && cnt!=6)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object74
	MOVF        __distance+0, 0 
	SUBLW       50
L__check_object74:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object20
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object75
	MOVLW       60
	SUBWF       __distance+0, 0 
L__check_object75:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object20
	MOVF        _cnt+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object20
L__check_object53:
;UltrasonicWithGLCD.c,97 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,98 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,99 :: 		glcd_box(110,50,120,55,1);
	MOVLW       110
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       120
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,100 :: 		cnt=6;
	MOVLW       6
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,101 :: 		}
L_check_object20:
;UltrasonicWithGLCD.c,102 :: 		if (_distance > 60 && _distance < 70 && cnt!=7)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object76
	MOVF        __distance+0, 0 
	SUBLW       60
L__check_object76:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object23
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object77
	MOVLW       70
	SUBWF       __distance+0, 0 
L__check_object77:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object23
	MOVF        _cnt+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object23
L__check_object52:
;UltrasonicWithGLCD.c,104 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,105 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,106 :: 		glcd_box(100,50,110,55,1);
	MOVLW       100
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       110
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,107 :: 		cnt=7;
	MOVLW       7
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,108 :: 		}
L_check_object23:
;UltrasonicWithGLCD.c,109 :: 		if (_distance > 70 && _distance < 80 && cnt!=8)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object78
	MOVF        __distance+0, 0 
	SUBLW       70
L__check_object78:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object26
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object79
	MOVLW       80
	SUBWF       __distance+0, 0 
L__check_object79:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object26
	MOVF        _cnt+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object26
L__check_object51:
;UltrasonicWithGLCD.c,111 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,112 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,113 :: 		glcd_box(90,50,100,55,1);
	MOVLW       90
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       100
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,114 :: 		cnt=8;
	MOVLW       8
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,115 :: 		}
L_check_object26:
;UltrasonicWithGLCD.c,116 :: 		if (_distance > 80 && _distance < 90 && cnt!=9)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object80
	MOVF        __distance+0, 0 
	SUBLW       80
L__check_object80:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object29
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object81
	MOVLW       90
	SUBWF       __distance+0, 0 
L__check_object81:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object29
	MOVF        _cnt+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object29
L__check_object50:
;UltrasonicWithGLCD.c,118 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,119 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,120 :: 		glcd_box(80,50,90,55,1);
	MOVLW       80
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       90
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,121 :: 		cnt=9;
	MOVLW       9
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,122 :: 		}
L_check_object29:
;UltrasonicWithGLCD.c,123 :: 		if (_distance > 90 && _distance < 100 && cnt!=10)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object82
	MOVF        __distance+0, 0 
	SUBLW       90
L__check_object82:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object32
	MOVLW       0
	SUBWF       __distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object83
	MOVLW       100
	SUBWF       __distance+0, 0 
L__check_object83:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object32
	MOVF        _cnt+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object32
L__check_object49:
;UltrasonicWithGLCD.c,125 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,126 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,127 :: 		glcd_box(70,50,80,55,1);
	MOVLW       70
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       50
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       80
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       55
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,128 :: 		cnt=10;
	MOVLW       10
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,129 :: 		}
L_check_object32:
;UltrasonicWithGLCD.c,130 :: 		if(_distance > 100 && cnt!=11)
	MOVLW       0
	MOVWF       R0 
	MOVF        __distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_object84
	MOVF        __distance+0, 0 
	SUBLW       100
L__check_object84:
	BTFSC       STATUS+0, 0 
	GOTO        L_check_object35
	MOVF        _cnt+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_check_object35
L__check_object48:
;UltrasonicWithGLCD.c,132 :: 		glcd_box(1,45,38,63,0);
	MOVLW       1
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       38
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,133 :: 		glcd_box(64,45,127,63,0);
	MOVLW       64
	MOVWF       FARG_Glcd_Box_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Box_y_upper_left+0 
	MOVLW       127
	MOVWF       FARG_Glcd_Box_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Box_y_bottom_right+0 
	CLRF        FARG_Glcd_Box_color+0 
	CALL        _Glcd_Box+0, 0
;UltrasonicWithGLCD.c,134 :: 		GLCD_WRITE_TEXT("out of range",64,3,1);
	MOVLW       ?lstr3_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       64
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,135 :: 		cnt=11;
	MOVLW       11
	MOVWF       _cnt+0 
;UltrasonicWithGLCD.c,136 :: 		}
L_check_object35:
;UltrasonicWithGLCD.c,137 :: 		}
L_end_check_object:
	RETURN      0
; end of _check_object

_get_distsnce:

;UltrasonicWithGLCD.c,139 :: 		void get_distsnce()
;UltrasonicWithGLCD.c,141 :: 		TMR1H=0;            //RESET TIMER1 4BYTES FOR HGH EDGE
	CLRF        TMR1H+0 
;UltrasonicWithGLCD.c,142 :: 		TMR1L=0;            //RESET TIMER1 4BYTES FOR LOW
	CLRF        TMR1L+0 
;UltrasonicWithGLCD.c,143 :: 		PORTC.F3=1;         //trigger pulse
	BSF         PORTC+0, 3 
;UltrasonicWithGLCD.c,144 :: 		delay_us(10);
	MOVLW       6
	MOVWF       R13, 0
L_get_distsnce36:
	DECFSZ      R13, 1, 1
	BRA         L_get_distsnce36
	NOP
;UltrasonicWithGLCD.c,145 :: 		PORTC.F3=0;
	BCF         PORTC+0, 3 
;UltrasonicWithGLCD.c,147 :: 		if(flag == 1 && _distance != distance)
	BTFSS       _flag+0, BitPos(_flag+0) 
	GOTO        L_get_distsnce39
	MOVF        __distance+1, 0 
	XORWF       _distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_distsnce86
	MOVF        _distance+0, 0 
	XORWF       __distance+0, 0 
L__get_distsnce86:
	BTFSC       STATUS+0, 2 
	GOTO        L_get_distsnce39
L__get_distsnce60:
;UltrasonicWithGLCD.c,149 :: 		_distance=distance;
	MOVF        _distance+0, 0 
	MOVWF       __distance+0 
	MOVF        _distance+1, 0 
	MOVWF       __distance+1 
;UltrasonicWithGLCD.c,151 :: 		wordtostr(time,time_txt);
	MOVF        _time+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _time+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _time_txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_time_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;UltrasonicWithGLCD.c,152 :: 		wordtostr(distance,distance_txt);
	MOVF        _distance+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _distance+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _distance_txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_distance_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;UltrasonicWithGLCD.c,154 :: 		Ltrim(time_txt);
	MOVLW       _time_txt+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_time_txt+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;UltrasonicWithGLCD.c,155 :: 		Ltrim(distance_txt);
	MOVLW       _distance_txt+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_distance_txt+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;UltrasonicWithGLCD.c,157 :: 		if( distance>=2 && distance<=400)
	MOVLW       0
	SUBWF       _distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__get_distsnce87
	MOVLW       2
	SUBWF       _distance+0, 0 
L__get_distsnce87:
	BTFSS       STATUS+0, 0 
	GOTO        L_get_distsnce42
	MOVF        _distance+1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__get_distsnce88
	MOVF        _distance+0, 0 
	SUBLW       144
L__get_distsnce88:
	BTFSS       STATUS+0, 0 
	GOTO        L_get_distsnce42
L__get_distsnce59:
;UltrasonicWithGLCD.c,159 :: 		GLCD_WRITE_TEXT("         " ,65,2,1);
	MOVLW       ?lstr4_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr4_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       65
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,160 :: 		GLCD_WRITE_TEXT("DISTANCE=",65,2,1);
	MOVLW       ?lstr5_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       65
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,161 :: 		GLCD_WRITE_TEXT(distance_txt ,1,2,1);
	MOVLW       _distance_txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_distance_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,162 :: 		}
L_get_distsnce42:
;UltrasonicWithGLCD.c,163 :: 		check_object();
	CALL        _check_object+0, 0
;UltrasonicWithGLCD.c,164 :: 		flag=0;
	BCF         _flag+0, BitPos(_flag+0) 
;UltrasonicWithGLCD.c,165 :: 		}
L_get_distsnce39:
;UltrasonicWithGLCD.c,167 :: 		}
L_end_get_distsnce:
	RETURN      0
; end of _get_distsnce

_main:

;UltrasonicWithGLCD.c,171 :: 		void main() {
;UltrasonicWithGLCD.c,172 :: 		config();
	CALL        _config+0, 0
;UltrasonicWithGLCD.c,173 :: 		GLCD_WRITE_TEXT("DISTANCE=" ,65,2,1);
	MOVLW       ?lstr6_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr6_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       65
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,174 :: 		GLCD_WRITE_TEXT("CM" ,52,2,1);
	MOVLW       ?lstr7_UltrasonicWithGLCD+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr7_UltrasonicWithGLCD+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       52
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;UltrasonicWithGLCD.c,175 :: 		GLCD_RECTANGLE(40,45,63,63,1);
	MOVLW       40
	MOVWF       FARG_Glcd_Rectangle_x_upper_left+0 
	MOVLW       45
	MOVWF       FARG_Glcd_Rectangle_y_upper_left+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Rectangle_x_bottom_right+0 
	MOVLW       63
	MOVWF       FARG_Glcd_Rectangle_y_bottom_right+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Rectangle_color+0 
	CALL        _Glcd_Rectangle+0, 0
;UltrasonicWithGLCD.c,176 :: 		while (1)
L_main43:
;UltrasonicWithGLCD.c,178 :: 		get_distsnce();
	CALL        _get_distsnce+0, 0
;UltrasonicWithGLCD.c,179 :: 		}
	GOTO        L_main43
;UltrasonicWithGLCD.c,180 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;UltrasonicWithGLCD.c,182 :: 		void interrupt(){
;UltrasonicWithGLCD.c,199 :: 		}
L_interrupt45:
;UltrasonicWithGLCD.c,200 :: 		}
L_end_interrupt:
L__interrupt91:
	RETFIE      1
; end of _interrupt
