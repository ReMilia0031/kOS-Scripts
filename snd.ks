// メモ：
RUNONCEPATH("0:/ktnh_CC").

CC().

PRINT "Starting Sound Warning System v2.0b....".
WAIT 0.5.
CLEARSCREEN.

PRINT "===== KTNH HI Sound Warning SYSTEM v2.0b =====".
SET V0 TO GetVoice(0).
SET V0:VOLUME TO 0.3.
set GCA_INIT to 0.
set MCA_INIT to 0.
V0:PLAY( NOTE( 2000, 0.1) ).
		WAIT 0.1.
V0:PLAY( NOTE( 1000, 0.1) ).
		WAIT 0.1.
UNTIL FALSE {
		
		PRINT "MCAS     : " + ROUND(MCAS(), 2) + "    " AT(1, 2).
		PRINT "MCAS_I   : " + ROUND(MCA_INIT, 2) + "    " AT(1, 3).
		PRINT "GCAS     : " + ROUND(GCAS(), 2) + "    " AT(1, 4).
		PRINT "GCAS_I   : " + ROUND(GCA_INIT, 2) + "    " AT(1, 5).
		PRINT "VALT     : " + ROUND((RALTI() - VSI() * -1), 2) + "    " AT(1, 6).
		PRINT "AOA      : " + ROUND(AOAI(), 2) + "    " AT(1, 7).
		PRINT "GMI      : " + ROUND(GMI(), 2) + "    " AT(1, 8).
	if not GEAR{
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
		
		if (GCAS() = 0 and GCA_INIT = 1 ){ set GCA_INIT to 0. }
		
		if (GCAS() = 1 and GCA_INIT = 0 ){
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
			set GCA_INIT to 1.
		}
	}
	if  (MCAS() = 0 and MCA_INIT = 1 ){ set MCA_INIT to 0. }
	
	if (MCAS() = 1 and MCA_INIT = 0 ){
		V0:PLAY( NOTE( 1750, 0.4) ).
		WAIT 0.4.
		V0:PLAY( NOTE( 2300, 0.15) ).
		WAIT 0.15.
		V0:PLAY( NOTE( 1750, 0.4) ).
		WAIT 0.4.
		V0:PLAY( NOTE( 2300, 0.15) ).
		WAIT 0.15.
		set MCA_INIT to 1.
	}
}