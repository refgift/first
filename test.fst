BEGIN
	INTEGER A;
	INTEGER B;
	INTEGER C
HERE:
	OUTPUT "\nEnter integer A\n";
	INPUT A;
	OUTPUT "\nEnter integer B\n";
	INPUT B;
	C := A + B;
	OUTPUT "\nC = A + B\n";
	OUTPUT C;
	IF C > 9 THEN GOTO HERE;
	OUTPUT "\nEnded.\n"
END
