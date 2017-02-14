// メモ：

	WAIT 0.5.
	set MAXASI to 0.
	CLEARSCREEN.
		PRINT "==========" + SHIP:NAME + "==========" AT(1, 2).
		PRINT "WETMASS    : " + ROUND(ship:WETMASS, 2) + "    " AT(1, 4).
		PRINT "DRYMASS    : " + ROUND(ship:DRYMASS, 2) + "    " AT(1, 5).
	UNTIL FALSE {
		if ( AIRSPEED > MAXASI ){set MAXASI to (AIRSPEED).}		
		
		PRINT "MAXSPD     : " + ROUND(MAXASI, 2) + "    " AT(1, 3).
	WAIT 0.1.
	}