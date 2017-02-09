
// メモ：
// ノズルのアレ
// TYPEごとに単位変えればいいんでね？
// GMeter 付いてれば表示なんやらをifで作れるのでは？
// Tempも同じく ついてなければ0で
// 燃料残量取得できるだろうか

WAIT 0.5.
CLEARSCREEN.
PRINT "STARTING CC v1.0a....".
PRINT " ".
WAIT 2.0.
PRINT "STARTING INSTRUMENTS GAUGE SYSTEM v1.0a ....".
WAIT 0.5.
CLEARSCREEN.
PRINT "===== INSTRUMENTS GAUGE SYSTEM v1.0a =====".
UNTIL FALSE {

	LIST ENGINES IN ENG.

	set ASI to (AIRSPEED) * 1.944.	
	set AOA to (0).
	set GMI to (0). //Ship:Sensors:GRAV
	
	set ATTD_P to (0).
	set ATTD_B to (0).
	set HSI_H to (Ship:BEARING) * -1.
	set THROTTLE_POS to (THROTTLE) * 100.
	
	if (HSI_H < 0 )
		{ set HSI_H to HSI_H + 360.}
	
	set ALTI to (ALTITUDE) * 3.28084.	
	set VSI to (VERTICALSPEED) * 3.28084 * 60.
	set CLK to (TIME:CLOCK).

	set RPM1 to (ENG[0]:THRUST / ENG[0]:MAXTHRUST * 100).
	set RPM2 to (ENG[1]:THRUST / ENG[1]:MAXTHRUST * 100).
	set ITT1 to (0).
	set ITT2 to (0).
	set FF1 to (ENG[0]:FUELFLOW) * 0.453592 * 3600. // 1L= 1kg
	set FF2 to (ENG[1]:FUELFLOW) * 0.453592 * 3600.
	if (THROTTLE_POS < 75 )
		{
			set ENG_NOZZLE_TEMP to THROTTLE_POS - 75.
			set ENG_NOZZLE to ENG_NOZZLE_TEMP * -100 / 75.
		}
	else
		{
			set ENG_NOZZLE to THROTTLE_POS .
		}
	set NOZ1 to (ENG_NOZZLE).
	set NOZ2 to (ENG_NOZZLE).
//--------------------------------------------------------------------------
	PRINT "SPD (kts) : " + ROUND(ASI, 2) + "    " AT(1, 2).
	PRINT "AOA ()    : " + ROUND(AOA, 2) + "    " AT(1, 3).
	PRINT "GMETER    : " + GMI + "    " AT(1, 4).
	
	PRINT "PITCH (deg) : " + ROUND(ATTD_P, 2) + "    " AT(1, 6).
	PRINT "BANK  (deg) : " + ROUND(ATTD_B, 2) + "    " AT(1, 7).
	PRINT "H D G (deg) : " + ROUND(HSI_H, 2) + "    " AT(1, 8).
	
	PRINT "ALT (f t)    : " + ROUND(ALTI, 2) + "    " AT(1, 10).	
	PRINT "VSI (ft/min) : " + ROUND(VSI, 2) + "    " AT(1, 11).
	PRINT "CLK          : " + CLK + "    " AT(1, 12).
	
	PRINT "RPM (%)    : " + ROUND(RPM1, 2) + " " + ROUND(RPM2, 2) + "    " AT(1, 14).	
	PRINT "ITT (C)    : " + ROUND(ITT1, 2) + " " + ROUND(ITT2, 2) + "    " AT(1, 15).
	PRINT "FF (PPH)   : " + ROUND(FF1, 2) + " " + ROUND(FF2, 2) + "    " AT(1, 16).	
	PRINT "NOZ (%)    : " + ROUND(NOZ1, 0) + " " + ROUND(NOZ2, 0) + "    " AT(1, 17).	

	WAIT 0.01.
}
