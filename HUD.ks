// メモ：

	if SHIP:NAME:CONTAINS("F-6") {
	WAIT 0.5.
	CLEARSCREEN.
	PRINT "STARTING F-6 Series HUD System v1.0b....".
	PRINT " ".
	WAIT 0.5.
	
	set MAINENG to list().
	set COMPRESSOR to list().
	LIST ENGINES IN ENG.
	LIST RESOURCES IN RESLIST.
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
	for RES IN RESLIST {
		PRINT RES:NAME.
		if RES:NAME:CONTAINS("Fuel") {
			set FUEL_QTY to RES:AMOUNT * 8.345404.
		}
		if RES:NAME:CONTAINS("Elec") {
			set ELEC_QTY to RES:AMOUNT.
		}
		if RES:NAME:CONTAINS("INTA") {
			set INT_QTY to RES:AMOUNT.
		}
	}
	WAIT 0.1.
	CLEARSCREEN.
	PRINT "===== F-6 Series HUD WARNNING System v1.0b =====".
	UNTIL FALSE {
	
		for RES IN RESLIST {
			if RES:NAME:CONTAINS("Fuel") {
				set FUEL_QTY to RES:AMOUNT * 8.345404.
			}
			if RES:NAME:CONTAINS("Elec") {
				set ELEC_QTY to RES:AMOUNT.
			}
			if RES:NAME:CONTAINS("INTA") {
				set INT_QTY to RES:AMOUNT.
			}
		}
		set RALTI to (ALT:RADAR).	
		set VSI to (VERTICALSPEED).
		set GCAS_RDO_VERT to RALTI - (VSI * -8).
	
		PRINT "RALT    : " + ROUND(RALTI, 2) + "    " AT(1, 2).
		PRINT "VSI    : " + ROUND(VSI, 2) + "    " AT(1, 3).
		PRINT "VALT    : " + ROUND(GCAS_RDO_VERT, 2) + "    " AT(1, 4).
		PRINT "FUEL QTY    : " + ROUND(FUEL_QTY, 2) + "    " AT(1, 5).	
		PRINT "ELEC QTY    : " + ROUND(ELEC_QTY, 2) + "    " AT(1, 6).
		PRINT "INT QTY    : " + ROUND(INT_QTY, 2) + "    " AT(1, 7).
		PRINT "THR(GEN)    : " + ROUND(MAINENG[0]:THRUST, 2) + "    " AT(1, 8).
		if not GEAR{
			if (GCAS_RDO_VERT < 0 ){HUDTEXT("PULL UP!",2,4,20,Red,false).}
		}
		if (FUEL_QTY < 1500){ HUDTEXT("BINGO FUEL",10,1,20,YELLOW,false). }	
		if (FUEL_QTY < 250){ HUDTEXT("FUEL LOW",10,1,20,RED,false). }
		if (MAINENG[0]:THRUST < 5){ HUDTEXT("LGEN OUT",10,1,20,YELLOW,false). }
		if (MAINENG[1]:THRUST < 5){ HUDTEXT("RGEN OUT",10,1,20,YELLOW,false). }
		if (INT_QTY < 5){ HUDTEXT("INLET",10,1,20,RED,false). }
		if (ELEC_QTY < 20){ HUDTEXT("AV BIT",10,1,20,RED,false). }
	WAIT 0.5.
	}
}
else{
	WAIT 0.5.
	CLEARSCREEN.
	PRINT "STARTING KTNH HI  HUD System v1.0b....".
	PRINT " ".
	WAIT 0.5.
	
	LIST ENGINES IN ENG.
	LIST RESOURCES IN RESLIST.
	
	for RES IN RESLIST {
		PRINT RES:NAME.
		if RES:NAME:CONTAINS("Fuel") {
			set FUEL_QTY to RES:AMOUNT * 8.345404.
		}
		if RES:NAME:CONTAINS("Elec") {
			set ELEC_QTY to RES:AMOUNT.
		}
		if RES:NAME:CONTAINS("INTA") {
			set INT_QTY to RES:AMOUNT.
		}
	}
	WAIT 0.1.
	CLEARSCREEN.
	PRINT "===== KTNH HI HUD WARNNING System v1.0b =====".
	UNTIL FALSE {
	
		for RES IN RESLIST {
			if RES:NAME:CONTAINS("Fuel") {
				set FUEL_QTY to RES:AMOUNT.
			}
			if RES:NAME:CONTAINS("Elec") {
				set ELEC_QTY to RES:AMOUNT.
			}
			if RES:NAME:CONTAINS("INTA") {
				set INT_QTY to RES:AMOUNT.
			}
		}
		set RALTI to (ALT:RADAR).	
		set VSI to (VERTICALSPEED).
		set GCAS_RDO_VERT to RALTI - (VSI * -8).
	
		PRINT "RALT    : " + ROUND(RALTI, 2) + "    " AT(1, 2).
		PRINT "VSI    : " + ROUND(VSI, 2) + "    " AT(1, 3).
		PRINT "VALT    : " + ROUND(GCAS_RDO_VERT, 2) + "    " AT(1, 4).
		PRINT "FUEL QTY    : " + ROUND(FUEL_QTY, 2) + "    " AT(1, 5).	
		PRINT "ELEC QTY    : " + ROUND(ELEC_QTY, 2) + "    " AT(1, 6).
		PRINT "INT QTY    : " + ROUND(INT_QTY, 2) + "    " AT(1, 7).
		PRINT "THR(GEN)    : " + ROUND(ENG[0]:THRUST, 2) + "    " AT(1, 8).
		if not GEAR{
			if (GCAS_RDO_VERT < 0 ){HUDTEXT("PULL UP!",2,4,20,Red,false).}
		}
		if (FUEL_QTY < 200){ HUDTEXT("BINGO FUEL",10,1,20,YELLOW,false). }	
		if (FUEL_QTY < 50){ HUDTEXT("FUEL LOW",10,1,20,RED,false). }
		if (ENG[0]:THRUST < 2){ HUDTEXT("GEN OUT",10,1,20,YELLOW,false). }
		if (INT_QTY < 1){ HUDTEXT("INLET",10,1,20,RED,false). }
		if (ELEC_QTY < 15){ HUDTEXT("AV BIT",10,1,20,RED,false). }
	WAIT 0.5.
	}
}