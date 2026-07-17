BEGIN
        DENOTED TITLE;
	TITLE := "TEST 3 : Words\n";
        OUTPUT TITLE;      
	DENOTED A;

LOOP:	INPUT A;    
        OUTPUT A;
	OUTPUT "\t";
	YIELD;
	IF A ? "blank" THEN GOTO FINIS; 
	GOTO LOOP;

FINIS:  OUTPUT "\n"
END