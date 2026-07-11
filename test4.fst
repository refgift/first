BEGIN
	DENOTED A;
	DENOTED B;
	A := "title";
	B := "paper";
S1:
	IF A ? B  THEN 
	BEGIN
		OUTPUT "Match";
		OUTPUT A;
		OUTPUT B;
		OUTPUT "\n"
	END
	OUTPUT "\nEnter Text Patterns a and b\n";
	INPUT A;
	INPUT B;
	YIELD ;
	GOTO S1
END

