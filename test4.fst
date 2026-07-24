BEGIN
	DENOTED A;
	DENOTED B;
	DENOTED QUIT;
	QUIT := "BLANK";
	A := "title";
	B := "paper";
S:	IF A ? B  THEN 
	BEGIN
		OUTPUT "Match";
		OUTPUT A;
		OUTPUT B;
		OUTPUT "\n"
	END;
	OUTPUT "\nEnter Text Patterns a and b\n";
	INPUT A;
	OUTPUT A;
	INPUT B;
	OUTPUT B;
	YIELD ;
	IF A ? QUIT THEN
	BEGIN
		GOTO T;
	END 
	GOTO S;
T:	OUTPUT "\nEnded\n";
END

