// メモ：
RUNONCEPATH("0:/ktnh_CC").

CC().

PRINT "Starting Sound Warning System v2.0d....".
WAIT 0.5.
CLEARSCREEN.

PRINT "===== KTNH HI Sound Warning SYSTEM v2.0d =====".
SET V0 TO GetVoice(0).
SET V0:VOLUME TO 0.3.
set LAAJ_INIT to 0.
set PULL_UP_INIT to 0.
V0:PLAY( NOTE( 2000, 0.1) ).
WAIT 0.1.
V0:PLAY( NOTE( 1000, 0.1) ).
WAIT 0.1.
UNTIL FALSE {
	PRINT "Master Caution   : " + MCAS_NUMBER()+ "    " AT(1, 2).
	PRINT "PULL UP Warning  : " + PULL_UP_WARN() + "    " AT(1, 5).
	PRINT "PULL UP INIT     : " + PULL_UP_INIT + "    " AT(1, 6).
	if not GEAR{
		//AOA Warning Tone
		if (AOAI() > 20 and AOAI() < 25){
				V0:PLAY( NOTE( 850, 0.05) ).
				WAIT 0.3.
		}
		if (AOAI() > 25 and AOAI() < 30){
				V0:PLAY( NOTE( 850, 0.05) ).
				WAIT 0.2.
		}
		if (AOAI() > 30){
				V0:PLAY( NOTE( 850, 0.1) ).
		}
		//OWS Warning Tone
		if (GMI() > 5 and GMI() < 7){
			V0:PLAY( NOTE( 900, 0.24)).
			WAIT 0.24.
		}
		if (GMI() > 7 and GMI() < 9){
			V0:PLAY( NOTE( 900, 0.12)).
			WAIT 0.12.
		}
		if (GMI() > 9){
			V0:PLAY( NOTE( 900, 0.05)).
			WAIT 0.05.
		}
	}
	// Master Caution Tone
	if (MCAS()){
		V0:PLAY( NOTE( 1750, 0.4) ).
		WAIT 0.4.
		V0:PLAY( NOTE( 2300, 0.15) ).
		WAIT 0.15.
		V0:PLAY( NOTE( 1750, 0.4) ).
		WAIT 0.4.
		V0:PLAY( NOTE( 2300, 0.15) ).
		WAIT 0.15.
	}

	// Pull Up Warning Tone
	if (PULL_UP_WARN() = 0 and PULL_UP_INIT = 1 ){ set PULL_UP_INIT to 0. }
	if (PULL_UP_WARN() = 1 and PULL_UP_INIT = 0 ){
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.1.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.2.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.1.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.2.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.1.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.2.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.1.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.2.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.1.
		V0:PLAY( NOTE( 850, 0.05) ).
		WAIT 0.2.
		set PULL_UP_INIT to 1.
	}

	// Nearst TGT DEST Tone [INOP]
	if (LAAJ() = 0 and LAAJ_INIT = 1 ){ set LAAJ_INIT to 0. }
	if (LAAJ() = 1 and LAAJ_INIT = 0  ){
		V0:PLAY(list(NOTE( 1000, 0.25) ,NOTE( 0, 0.1),NOTE( 1000, 0.1),NOTE( 0, 0.1),NOTE( 1000, 0.1),NOTE( 0, 0.1),NOTE( 1000, 0.1),NOTE( 0, 0.1),NOTE( 1000, 0.1) ,NOTE( 0, 0.1),NOTE( 1000, 0.1) ,NOTE( 0, 0.1)) ).
		set LAAJ_INIT to 1.
	}
	

	}