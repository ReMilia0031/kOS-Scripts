//@LAZYGLOBAL OFF.
RUNONCEPATH("0:/lib8492").

function CC{
	WAIT 0.5.
	CLEARSCREEN.
	PRINT "STARTING F-6 Series CC v2.0d....".
	PRINT " ".
	WAIT 2.0.

	//センサー列挙
	PRINT "----- Sensor Finding -----".
	WAIT 0.2.
	SNSL().
	LIST SENSORS IN SENSELIST.
	for S IN SENSELIST {
		//PRINT "SENSOR: " + S:TYPE.
		if S:TYPE:CONTAINS("ACC") {
			PRINT " ".
			PRINT "ACC DETECTED".
		}
		if S:TYPE:CONTAINS("grav") {
			PRINT " ".
			PRINT "GRAVIOLI DETECTED".
		}
		if S:TYPE:CONTAINS("pres") {
			PRINT " ".
			PRINT "PRESSURE DETECTED".
		}
		if S:TYPE:CONTAINS("temp") {
			PRINT " ".
			PRINT "TEMPERTURE DETECTED".
		}
	}
	PRINT " ".
	PRINT "-------------------".
	PRINT " ".
	WAIT 0.5.

	//エンジン列挙
	PRINT "----- Engine Finding -----".
	PRINT "".
	WAIT 0.2.
	ENGL().
	LIST ENGINES IN ENG.
	for E IN ENG {
		PRINT " ".
		if E:TITLE:CONTAINS("J-X4") {
			PRINT "MAIN ENGINE: " + E:TITLE.
			PRINT "J-X4 Detected!".
			set ENG_JX4 to 1.
		}
		else {
			if E:TITLE:CONTAINS("PT100") {
				PRINT "COMPRESSOR FAN: " + E:TITLE.
			}
			else { PRINT "OTHER: " + E:TITLE.}
		}
	}
	PRINT " ".
	PRINT "-------------------".
	PRINT " ".
	WAIT 0.5.

	//燃料系列挙
	PRINT "----- Resource Finding -----".
	WAIT 0.2.
	LIST RESOURCES IN RESLIST.
	for RES IN RESLIST {
		PRINT " ".
		PRINT RES:NAME +" - " + RES:AMOUNT.
	}.
	PRINT " ".
	PRINT "-------------------".
	PRINT " ".
	WAIT 0.5.
	CLEARSCREEN.

}

function LOGO{
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
}

function ENGL{
	set MAINENG to list().
	set COMPRESSOR to list().

	LIST ENGINES IN ENGLIST.
	for E IN ENGLIST {
		if E:TITLE:CONTAINS("J-X4") {
			MAINENG:ADD(E).
		}
		else {
			if E:TITLE:CONTAINS("PT100") {
				COMPRESSOR:ADD(E).
			}
		}
	}
}

function SNSL{
	LIST SENSORS IN SENSEL.
	set ACC_EQI to 0.
	set GRAV_EQI to 0.
	set PRES_EQI to 0.
	set TEMP_EQI to 0.
	for S IN SENSEL {
		//PRINT "SENSOR: " + S:TYPE.
		if S:TYPE:CONTAINS("ACC") {
			set ACC_EQI to 1.
		}
		if S:TYPE:CONTAINS("grav") {
			set GRAV_EQI to 1.
		}
		if S:TYPE:CONTAINS("pres") {
			set PRES_EQI to 1.
		}
		if S:TYPE:CONTAINS("temp") {
			set TEMP_EQI to 1.
		}
	}
}

function OVSPD{
		if ENG_JX4 {
			if (THROTTLE > 0.75 and AIRSPEED > 1350 ){RETURN 1.}
			if (THROTTLE < 0.75 or AIRSPEED < 1350 ){RETURN 0.}
		}
		else{
			if (THROTTLE > 0.75 and AIRSPEED > 1200 ){RETURN 1.}
			if (THROTTLE < 0.75 or AIRSPEED < 1200 ){RETURN 0.}
		}
}

function PULL_UP_WARN {
	if (VSI() > 0 or GEAR) {RETURN 0.}
	if ( RALTI() > 2000 and VSI() < -100000 and ASI() > 1000) {RETURN 1.}
	if ( RALTI() < 500 and VSI() < -1500 and ASI() < 400) {RETURN 1.}
}

function LAAJ {
	RETURN 0.
}

set SND_MC_Slave to 0.
function MCAS {
	set SND_MC to 0.
	if (FUEL_QTY() < 1500) { set SND_MC to SND_MC + 1. }
	if (INT_QTY() < 0.200) { set SND_MC to SND_MC + 2. }
	if (ELEC_QTY() < 15.0) { set SND_MC to SND_MC + 4. }
	set SND_MC_CNGD to 0.
	if (SND_MC <= SND_MC_Slave) {set SND_MC_CNGD to 0.}
	else {
		set SND_MC_CNGD to 1.
	}
	set SND_MC_Slave to SND_MC.
	return SND_MC_CNGD.

}
function MCAS_NUMBER {
	return SND_MC_Slave.
}


	function ASI { RETURN ROUND( (AIRSPEED) * 1.944).}
	function MACH { RETURN ("NO DATA").}
	function AOAI { RETURN ROUND( AOA(), 2).}

	function GMI {
		if (GRAV_EQI and ACC_EQI){ RETURN ROUND( gforce(), 2) .}
		else { RETURN ("NO SNSR").}
	}

	function ATTD_P { RETURN ROUND( pitch(), 2).}
	function ATTD_B { RETURN ROUND( roll(), 2).}

	function HSI_H {
			if ( -Ship:BEARING < 0 ){ RETURN ROUND( -Ship:BEARING + 360, 2).}
			else { RETURN ROUND( -Ship:BEARING, 2).}
		}

	function ALTI { RETURN ROUND( (ALTITUDE) * 3.28084, 2).}
	function RALTI { RETURN ROUND( (ALT:RADAR), 2).}
	function VSI { RETURN ROUND( (VERTICALSPEED) * 3.28084 * 60, 2).}
	function CLK { RETURN (TIME:CLOCK).}

	function THROTTLE_POS { RETURN ROUND( (THROTTLE) * 100, 2).}

// ENG 1-------------------------------------------------------
	function RPM1 {
		if (MAINENG[0]:MAXTHRUST <> 0){
			RETURN ROUND( (MAINENG[0]:THRUST / MAINENG[0]:MAXTHRUST * 100), 2).
		}
		else{RETURN (0).}
	}
	function ITT1 { RETURN ("NO DATA").}

	function FF1 { RETURN ROUND( (MAINENG[0]:FUELFLOW) * 0.453592 * 3600, 2).}

	function NOZ1 {
		if (THROTTLE_POS < 75 ){
				set ENG_NOZZLE_TEMP to THROTTLE_POS - 75.
				RETURN ROUND( ENG_NOZZLE_TEMP * -100 / 75, 2).
		}
		else{ RETURN ROUND( (THROTTLE_POS -75) * 100 / 25, 2). }
	}

	function THRUST1 { RETURN ROUND( (MAINENG[0]:THRUST), 2).}

	// ENG 2-------------------------------------------------------
	function RPM2 {
		if (MAINENG[1]:MAXTHRUST <> 0){
			RETURN ROUND( (MAINENG[1]:THRUST / MAINENG[1]:MAXTHRUST * 100), 2).
		}
		else{RETURN (0).}
	}
	function ITT2 { RETURN ("NO DATA").}

	function FF2 { RETURN ROUND( (MAINENG[1]:FUELFLOW) * 0.453592 * 3600, 2).}

	function NOZ2 {
		if (THROTTLE_POS < 75 ){
				set ENG_NOZZLE_TEMP to THROTTLE_POS - 75.
				RETURN ROUND( ENG_NOZZLE_TEMP * -100 / 75, 2).
		}
		else{ RETURN ROUND( (THROTTLE_POS -75) * 100 / 25, 2). }
	}

	function THRUST2 { RETURN ROUND ( (MAINENG[1]:THRUST), 2).}

	function FUEL_QTY {
		LIST RESOURCES IN RESL.
		for RES IN RESL {
			if RES:NAME:CONTAINS("Fuel") {
				RETURN ROUND (RES:AMOUNT * 8.345404, 2).
			}
		}
	}

	function ELEC_QTY {
		LIST RESOURCES IN RESL.
		for RES IN RESL {
			if RES:NAME:CONTAINS("Elec") {
				RETURN ROUND (RES:AMOUNT, 2).
			}
		}
	}

	function INT_QTY {
		LIST RESOURCES IN RESL.
		for RES IN RESL {
			if RES:NAME:CONTAINS("Inta") {
				RETURN ROUND (RES:AMOUNT, 2).
			}
		}
	}

