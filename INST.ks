// メモ：
RUNONCEPATH("0:/ktnh_CC").

CC().

PRINT "Starting INST Gauge System v2.0c ....".
WAIT 0.5.
CLEARSCREEN.

PRINT "===== KTNH HI INSTRUMENTS GAUGE SYSTEM v2.0c =====".
UNTIL FALSE {
	SNSL().
	PRINT "SPD (kts)    : " + ASI() + "    " AT(1, 2).
	PRINT "MACH         : " + MACH() + "    " AT(1, 3).
	PRINT "AOA          : " + AOAI() + "    " AT(1, 4).
	PRINT "GMETER       : " + GMI() + "    " AT(1, 5).

	PRINT "PITCH (deg)  : " + ATTD_P() + "    " AT(1, 7).
	PRINT "BANK  (deg)  : " + ATTD_B() + "    " AT(1, 8).
	PRINT "H D G (deg)  : " + HSI_H() + "    " AT(1, 9).

	PRINT "ALT (f t)    : " + ALTI()+ "    " AT(1, 11).
	PRINT "VSI (ft/min) : " + VSI() + "    " AT(1, 12).
	PRINT "CLK          : " + CLK() + "    " AT(1, 13).

	PRINT "RPM (%)      : " + RPM1() + " " + RPM2() + "    " AT(1, 15).
	PRINT "ITT (C)      : " + ITT1() + " " + ITT2() + "    " AT(1, 16).
	PRINT "FF (PPH)     : " + FF1() + " " + FF2() + "    " AT(1, 17).
	PRINT "NOZ (%)      : " + NOZ1() + " " + NOZ2() + "    " AT(1, 18).

	PRINT "FUEL (LBS)   : " + FUEL_QTY() + "    " AT(1, 20).

	WAIT 0.01.
}
