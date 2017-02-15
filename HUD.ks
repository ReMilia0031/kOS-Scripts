// メモ：
RUNONCEPATH("0:/ktnh_CC").

CC().

PRINT "Starting HUD Warning System v2.0c ....".
WAIT 0.5.
CLEARSCREEN.

PRINT "===== KTNH HI HUD WARNNING System v2.0c =====".
UNTIL FALSE {
	PRINT "RALT     : " + RALTI() + "    " AT(1, 2).
	PRINT "VSI      : " + VSI() + "    " AT(1, 3).
	PRINT "RALT     : " + RALTI() + "    " AT(1, 4).
	PRINT "FUEL QTY : " + FUEL_QTY() + "    " AT(1, 5).
	PRINT "ELEC QTY : " + ELEC_QTY() + "    " AT(1, 6).
	PRINT "INT QTY  : " + INT_QTY() + "    " AT(1, 7).
	PRINT "THR(GEN) : " + THRUST1() + "    " AT(1, 8).
	PRINT "AOA      : " + AOAI() + "    " AT(1, 9).

	if (PULL_UP_WARN() = 1 and not GEAR ){HUDTEXT("PULL UP!",2,4,20,Red,false).}
	if (OVSPD()){HUDTEXT("OV SPEED!",2,4,20,Red,false).}

	if (aoa() > 20){ HUDTEXT("WARN AOA",2,1,20,YELLOW,false). }

	if (FUEL_QTY() < 3000){ HUDTEXT("BINGO FUEL",10,1,20,YELLOW,false). }
	if (FUEL_QTY() < 1500){ HUDTEXT("FUEL LOW",10,1,20,RED,false). }
	if (THRUST1() < 2){ HUDTEXT("GEN OUT",10,1,20,YELLOW,false). }
	if (INT_QTY() < 0.20){ HUDTEXT("INLET",10,1,20,RED,false). }
	if (ELEC_QTY() < 15){ HUDTEXT("BAT LOW",10,1,20,RED,false). }
	WAIT 0.5.
}