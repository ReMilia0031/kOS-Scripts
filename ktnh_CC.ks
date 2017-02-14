//@LAZYGLOBAL OFF.
RUNONCEPATH("0:/lib8492").

function CC{
	WAIT 0.5.
	CLEARSCREEN.
	PRINT "STARTING F-6 Series CC v2.0b....".
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

	function ASI { RETURN (AIRSPEED) * 1.944.}
	function MACH { RETURN (-255).} //INOP
	function AOAI { RETURN AOA().}
	
	function GMI {
		if (GRAV_EQI and ACC_EQI){ RETURN ROUND(gforce(), 2) .}
		else { RETURN ("NO SNSR").}
	}

	function ATTD_P { RETURN pitch().}
	function ATTD_B { RETURN roll().}
	
	function HSI_H {
			if ( -Ship:BEARING < 0 ){ RETURN -Ship:BEARING + 360.}
			else { RETURN -Ship:BEARING.}
		}
		
	function ALTI { RETURN (ALTITUDE) * 3.28084.}
	function RALTI { RETURN (ALT:RADAR) * 3.28084.}
	function VSI { RETURN (VERTICALSPEED) * 3.28084 * 60.}
	function CLK { RETURN (TIME:CLOCK).}

	function THROTTLE_POS { RETURN (THROTTLE) * 100.}

// ENG 1-------------------------------------------------------
	function RPM1 {		
		if (MAINENG[0]:MAXTHRUST <> 0){
			RETURN (MAINENG[0]:THRUST / MAINENG[0]:MAXTHRUST * 100).
		}
		else{RETURN (0).}
	}
	function ITT1 { RETURN (-255).}	//INOP
		
	function FF1 { RETURN (MAINENG[0]:FUELFLOW) * 0.453592 * 3600.}

	function NOZ1 { 
		if (THROTTLE_POS < 75 ){
				set ENG_NOZZLE_TEMP to THROTTLE_POS - 75.
				RETURN ENG_NOZZLE_TEMP * -100 / 75.
		}
		else{ RETURN (THROTTLE_POS -75) * 100 / 25. }
	}

	function THRUST1 { RETURN (MAINENG[0]:THRUST).}

	// ENG 2-------------------------------------------------------
	function RPM2 {
		if (MAINENG[1]:MAXTHRUST <> 0){
			RETURN (MAINENG[1]:THRUST / MAINENG[1]:MAXTHRUST * 100).
		}
		else{RETURN (0).}
	}
	function ITT2 { RETURN (-255).}	//INOP
		
	function FF2 { RETURN (MAINENG[1]:FUELFLOW) * 0.453592 * 3600.}

	function NOZ2 { 
		if (THROTTLE_POS < 75 ){
				set ENG_NOZZLE_TEMP to THROTTLE_POS - 75.
				RETURN ENG_NOZZLE_TEMP * -100 / 75.
		}
		else{ RETURN (THROTTLE_POS -75) * 100 / 25. }
	}

	function THRUST2 { RETURN (MAINENG[1]:THRUST).}
	
	function FUEL_QTY {
		LIST RESOURCES IN RESL.
		for RES IN RESL {
			if RES:NAME:CONTAINS("Fuel") {
				set FUEL_Q to RES:AMOUNT * 8.345404.
				RETURN RES:AMOUNT * 8.345404.
			}
		}
	}

	function ELEC_QTY {
		LIST RESOURCES IN RESL.
		for RES IN RESL {
			if RES:NAME:CONTAINS("Elec") {
				set ELEC_Q to RES:AMOUNT.
				RETURN RES:AMOUNT.
			}
		}
	}

	function INT_QTY {
		LIST RESOURCES IN RESL.
		for RES IN RESL {
			if RES:NAME:CONTAINS("Inta") {				
				set INT_Q to RES:AMOUNT.
				RETURN RES:AMOUNT.
			}
		}
	}
	
	function GCAS {
		 if (RALTI() - (VSI() * -1) < 0 and ALTITUDE < 2000 and ATTD_P() < -15 ) {RETURN 1.}
		 if (RALTI() - (VSI() * -1) < 0 and ALTITUDE < 100) {RETURN 1.}	
		 if (RALTI() - (VSI() * -1) > 0) {RETURN 0.}	
		
	}
	
	function MCAS {
		 if (FUEL_QTY() < 1500 or INT_QTY() < 0.20 or ELEC_QTY() < 15) {RETURN 1.}		
		 if (FUEL_QTY() > 1500 and INT_QTY() > 0.20 and ELEC_QTY() > 15) {RETURN 0.}
	}
