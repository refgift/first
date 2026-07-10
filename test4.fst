BEGIN
	DENOTED A;
	DENOTED B;
	A := "title";
	B := "paper";

	IF A ? B  THEN 
	BEGIN
		OUTPUT "Match";
		OUTPUT A;
		OUTPUT B;
		OUTPUT "\n"
	END
END

