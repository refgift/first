BEGIN
	INTEGER A;
	INTEGER B;
	INTEGER C
HERE:
	OUTPUT "\nEnter A\n";
	INPUT A;
	OUTPUT "\nEnter B\n";
	INPUT B;
	C := A + B;
	OUTPUT "\nC = A + B\n";
	OUTPUT C;
	IF C > 9 THEN GOTO HERE;
	OUTPUT "\nEnded.\n"
END
