BEGIN
	DENOTED A;
	DENOTED B;


	A := "title";
	B := "paper";

S:	IF A ? B  THEN 
	BEGIN
		OUTPUT A;
		OUTPUT SPACE;
		OUTPUT "matches"
		OUTPUT SPACE;
		OUTPUT B;
		OUTPUT NEWLINE
	END;
	OUTPUT "Enter Text Patterns a and b";
	OUTPUT NEWLINE;
	INPUT A;
	INPUT B;
	GOTO S;

END

