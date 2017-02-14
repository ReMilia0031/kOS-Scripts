// メモ：
RUNONCEPATH("0:/ktnh_CC").

CC().

PRINT "Starting HUD WARNNING System v2.0a ....".
WAIT 0.5.	
LIST ENGINES IN ENG.
set ENG_JX4 to 0.

PRINT " ".	
for E IN ENG {
	if E:TITLE:CONTAINS("J-X4") {
		PRINT "J-X4 Detected!".			
		set ENG_JX4 to 1.
	}
}
WAIT 0.5.
CLEARSCREEN.
PRINT "--------------------------------------------".
WAIT 0.1.
PRINT "\     \     \     \     \     \     \     \ ".
WAIT 0.1.
PRINT "--------------------------------------------".
WAIT 0.1.
PRINT "/     /     /     /     /     /     /     / ".
WAIT 0.1.
PRINT "------ |  /  ------- |\    |  |     | ------".
WAIT 0.1.
PRINT "\      | /      |    | \   |  |     |     \ ".
WAIT 0.1.
PRINT "------ |<       |    |  \  |  |-----| ------".
WAIT 0.1.
PRINT "/      | \      |    |   \ |  |     |     / ".
WAIT 0.1.
PRINT "------ |  \     |    |    \|  |     | ------".
WAIT 0.1.
PRINT "\     \     \     \     \     \     \     \ ".
WAIT 0.1.
PRINT "--------------------------------------------".
WAIT 0.1.
PRINT "/     /     /     /     /     /     /     / ".
WAIT 0.1.
PRINT "--------------------------------------------".
WAIT 0.1.
WAIT 1.0.
CLEARSCREEN.

PRINT "===== KTNH HI HUD WARNNING System v2.0a =====".
	UNTIL FALSE {
		
		PRINT "RALT    : " + ROUND(RALTI(), 2) + "    " AT(1, 2).
		PRINT "VSI    : " + ROUND(VSI(), 2) + "    " AT(1, 3).
		PRINT "VALT    : " + ROUND(GCAS(), 2) + "    " AT(1, 4).
		PRINT "FUEL QTY    : " + ROUND(FUEL_QTY(), 2) + "    " AT(1, 5).	
		PRINT "ELEC QTY    : " + ROUND(ELEC_QTY(), 2) + "    " AT(1, 6).
		PRINT "INT QTY    : " + ROUND(INT_QTY(), 2) + "    " AT(1, 7).
		PRINT "THR(GEN)    : " + ROUND(THRUST1(), 2) + "    " AT(1, 8).
		PRINT "AOA      : " + ROUND(AOA(), 2) + "    " AT(1, 9).
		if not GEAR{
			if (GCAS() = 1 ){HUDTEXT("PULL UP!",2,4,20,Red,false).}
		}
		
		if (aoa() > 20){ HUDTEXT("WARN AOA",2,1,20,YELLOW,false). }
		
		if ENG_JX4 {			
			if (THROTTLE > 0.75 and AIRSPEED > 1350 ){HUDTEXT("OV SPEED!",2,4,20,Red,false).}
		}		
		else{
			if (THROTTLE > 0.75 and AIRSPEED > 1200 ){HUDTEXT("OV SPEED!",2,4,20,Red,false).}
		}
		
		if (FUEL_QTY() < 3000){ HUDTEXT("BINGO FUEL",10,1,20,YELLOW,false). }	
		if (FUEL_QTY() < 1500){ HUDTEXT("FUEL LOW",10,1,20,RED,false). }
		if (THRUST1() < 2){ HUDTEXT("GEN OUT",10,1,20,YELLOW,false). }
		if (INT_QTY() < 0.20){ HUDTEXT("INLET",10,1,20,RED,false). }
		if (ELEC_QTY() < 15){ HUDTEXT("BAT LOW",10,1,20,RED,false). }
	WAIT 0.5.
	}