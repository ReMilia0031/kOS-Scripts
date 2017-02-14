// メモ：
RUNONCEPATH("0:/ktnh_CC").

CC().

PRINT "Starting INST GAUGE SYSTEM v2.0a ....".
WAIT 0.5.
CLEARSCREEN.

PRINT "===== KTNH HI INSTRUMENTS GAUGE SYSTEM v2.0a =====".
UNTIL FALSE {
	SNSL().
//--------------------------------------------------------------------------
	PRINT "SPD (kts)    : " + ROUND(ASI(), 2) + "    " AT(1, 2).
	PRINT "MACH         : " + ROUND(MACH(), 2) + "    " AT(1, 3).
	PRINT "AOA          : " + ROUND(AOAI(), 2) + "    " AT(1, 4).
	PRINT "GMETER       : " + GMI() + "    " AT(1, 5).
	
	PRINT "PITCH (deg)  : " + ROUND(ATTD_P(), 2) + "    " AT(1, 7).
	PRINT "BANK  (deg)  : " + ROUND(ATTD_B(), 2) + "    " AT(1, 8).
	PRINT "H D G (deg)  : " + ROUND(HSI_H(), 2) + "    " AT(1, 9).
	
	PRINT "ALT (f t)    : " + ROUND(ALTI(), 2) + "    " AT(1, 11).	
	PRINT "VSI (ft/min) : " + ROUND(VSI(), 2) + "    " AT(1, 12).
	PRINT "CLK          : " + CLK() + "    " AT(1, 13).
	
	PRINT "RPM (%)      : " + ROUND(RPM1(), 2) + " " + ROUND(RPM2(), 2) + "    " AT(1, 15).	
	PRINT "ITT (C)      : " + ROUND(ITT1(), 2) + " " + ROUND(ITT2(), 2) + "    " AT(1, 16).
	PRINT "FF (PPH)     : " + ROUND(FF1(), 2) + " " + ROUND(FF2(), 2) + "    " AT(1, 17).	
	PRINT "NOZ (%)      : " + ROUND(NOZ1(), 0) + " " + ROUND(NOZ2(), 0) + "    " AT(1, 18).	
	PRINT "FUEL (LBS)   : " + ROUND(FUEL_QTY(), 0) + "    " AT(1, 20).	

	WAIT 0.01.
}
