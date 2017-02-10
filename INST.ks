// メモ：
// TYPEごとに単位変えればいいんでね？ ＜ 却下
WAIT 0.5.
CLEARSCREEN.
PRINT "STARTING F-6 Series CC v1.0e....".
PRINT " ".

set ACC_EQI to 0.
set GRAV_EQI to 0.
set PRES_EQI to 0.
set TEMP_EQI to 0.

set MAINENG to list().
set COMPRESSOR to list().

LIST SENSORS IN SENSELIST.
LIST ENGINES IN ENG.
LIST RESOURCES IN RESLIST.
WAIT 2.0.

//センサー列挙
PRINT "Sensor Finding ....".
WAIT 0.2.
for S IN SENSELIST {
	//PRINT "SENSOR: " + S:TYPE.
	if S:TYPE:CONTAINS("ACC") {
		PRINT " ".
		PRINT "ACC DETECTED".
		set ACC_EQI to 1.
	}
	if S:TYPE:CONTAINS("grav") {
		PRINT " ".
		PRINT "GRAVIOLI DETECTED".
		set GRAV_EQI to 1.
	}
	if S:TYPE:CONTAINS("pres") {
		PRINT " ".
		PRINT "PRESSURE DETECTED".
		set PRES_EQI to 1.
	}
	if S:TYPE:CONTAINS("temp") {
		PRINT " ".
		PRINT "TEMPERTURE DETECTED".
		set TEMP_EQI to 1.
	}
}
PRINT " ".
WAIT 0.5.

//エンジン列挙
PRINT "Engine Finding ....".
WAIT 0.2.
for E IN ENG {	
	PRINT " ".	
	if E:TITLE:CONTAINS("J-X4") {
		PRINT "MAIN ENGINE: " + E:TITLE.
		MAINENG:ADD(E).
	}
	else {
		if E:TITLE:CONTAINS("PT100") {
			PRINT "COMPRESSOR FAN: " + E:TITLE.
			COMPRESSOR:ADD(E).
		}
		else { PRINT "OTHER: " + E:TITLE.}
	}
}
PRINT " ".
WAIT 0.5.

//燃料系列挙
PRINT "Resource Finding ....".
WAIT 0.2.
for RES IN RESLIST {
    PRINT "Resource " + RES:NAME.
    PRINT "    value = " + RES:AMOUNT.
    PRINT "    which is "
          + ROUND(100*RES:AMOUNT/RES:CAPACITY)
          + "% full.".
}.
PRINT " ".
WAIT 0.5.

PRINT "STARTING INSTRUMENTS GAUGE SYSTEM v1.0b ....".
WAIT 0.5.
CLEARSCREEN.
PRINT "===== INSTRUMENTS GAUGE SYSTEM v1.0b =====".
UNTIL FALSE {

//センサー付いてるかどうか
	LIST ENGINES IN ENG.
	LIST RESOURCES IN RESLIST.
	LIST SENSORS IN SENSORS.
	SET TEMP_EQI TO 0.
	SET PRES_EQI TO 0.
	SET GRAV_EQI TO 0.
	SET ACC_EQI TO 0.
	for sense IN SENSORS {
		IF sense:TYPE = "TEMP" { set TEMP_EQI to 1. }
		IF sense:TYPE = "PRES" { set PRES_EQI to 1. }
		IF sense:TYPE = "GRAV" { set GRAV_EQI to 1. }
		IF sense:TYPE = "ACC" { set ACC_EQI to 1. }
	}
//燃料残量取得
	for RES IN RESLIST {
		if RES:NAME:CONTAINS("Fuel") {
			set FUEL_QTY to  RES:AMOUNT * 8.345404.
		}
	}

//--------------------------------------------------------------------------
	set ASI to (AIRSPEED) * 1.944.
	set MACH to (-255).	//INOP
	set AOA to (-255).	//INOP
	
	if (GRAV_EQI){ set GMI to (Ship:Sensors:GRAV).}
	else { set GMI to ("NO SNSR").}

	set ATTD_P to (-255).	//INOP
	set ATTD_B to (-255).	//INOP
	set HSI_H to (Ship:BEARING) * -1.
	set THROTTLE_POS to (THROTTLE) * 100.
	
	if (HSI_H < 0 ){ set HSI_H to HSI_H + 360.}
	
	set ALTI to (ALTITUDE) * 3.28084.	
	set VSI to (VERTICALSPEED) * 3.28084 * 60.
	set CLK to (TIME:CLOCK).

	if (MAINENG[0]:MAXTHRUST <> 0){
		set RPM1 to (MAINENG[0]:THRUST / MAINENG[0]:MAXTHRUST * 100).
		set ITT1 to (-255).	//INOP
		set FF1 to (MAINENG[0]:FUELFLOW) * 0.453592 * 3600.

		if (THROTTLE_POS < 75 ){
				set ENG_NOZZLE_TEMP to THROTTLE_POS - 75.
				set ENG_NOZZLE to ENG_NOZZLE_TEMP * -100 / 75.
		}
		else{ set ENG_NOZZLE to (THROTTLE_POS -75) * 100 / 25. }

		set NOZ1 to (ENG_NOZZLE).
	}		
	else{
		set RPM1 to (0).
		set ITT1 to (-255).	//INOP
		set FF1 to (0).
		set NOZ1 to (0).
		}
	if (MAINENG[1]:MAXTHRUST <> 0){
		set RPM2 to (MAINENG[1]:THRUST / MAINENG[1]:MAXTHRUST * 100).
		set ITT2 to (-255).	//INOP
		set FF2 to (MAINENG[1]:FUELFLOW) * 0.453592 * 3600.	
		set NOZ2 to (ENG_NOZZLE).
	}		
	else{
		set RPM2 to (0).
		set ITT2 to (-255).	//INOP
		set FF2 to (0).
		set NOZ2 to (0).
	}
//--------------------------------------------------------------------------
	PRINT "SPD (kts)    : " + ROUND(ASI, 2) + "    " AT(1, 2).
	PRINT "MACH         : " + ROUND(MACH, 2) + "    " AT(1, 3).
	PRINT "AOA          : " + ROUND(AOA, 2) + "    " AT(1, 4).
	PRINT "GMETER       : " + GMI + "    " AT(1, 5).
	
	PRINT "PITCH (deg)  : " + ROUND(ATTD_P, 2) + "    " AT(1, 7).
	PRINT "BANK  (deg)  : " + ROUND(ATTD_B, 2) + "    " AT(1, 8).
	PRINT "H D G (deg)  : " + ROUND(HSI_H, 2) + "    " AT(1, 9).
	
	PRINT "ALT (f t)    : " + ROUND(ALTI, 2) + "    " AT(1, 11).	
	PRINT "VSI (ft/min) : " + ROUND(VSI, 2) + "    " AT(1, 12).
	PRINT "CLK          : " + CLK + "    " AT(1, 13).
	
	PRINT "RPM (%)      : " + ROUND(RPM1, 2) + " " + ROUND(RPM2, 2) + "    " AT(1, 15).	
	PRINT "ITT (C)      : " + ROUND(ITT1, 2) + " " + ROUND(ITT2, 2) + "    " AT(1, 16).
	PRINT "FF (PPH)     : " + ROUND(FF1, 2) + " " + ROUND(FF2, 2) + "    " AT(1, 17).	
	PRINT "NOZ (%)      : " + ROUND(NOZ1, 0) + " " + ROUND(NOZ2, 0) + "    " AT(1, 18).	
	PRINT "FUEL (LBS)   : " + ROUND(FUEL_QTY, 0) + "    " AT(1, 20).	

	WAIT 0.01.
}
