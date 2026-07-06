LABELDECL	[A-Z]+[0-9]*":"
LABEL		[A-Z]+[0-9]*
BG		[ \t\n]
ARITMETICS	[+-/*%]
CONDITIONALS  	[<>!=?]
DENOTER		["]
DENOTATION	["]+.+["]+
BOOLEAN		TRUE|FALSE
DIGIT		[0-9]
LETTER		[A-Z]
%{
	static char label[256];
	static char text1[256];
	static char text2[256];
	static char text3[256];
	static char text4[256];
	static int integer1;

	struct types {
		char label[256];
		int type;
	};

	static struct types vars[10000];
	static int tp;
	static int type;
%}

%%
{BG}*{LABEL}{BG}*:={BG}*RANDOM[;]*                  {

					 bzero(label,256);
					 sscanf(yytext," %s := RANDOM",label);
				         for (int i=0;i<tp;i++) {                                                                                                           
                                                if (strcmp(vars[i].label,label)==0) {                                                                                      
                                                        type = vars[i].type;                                                                                               
                                                        break;                                                                                                             
                                                }                                                                                                                          
                                        } if (type==0) {  			
						printf("\tasm\(\"1: pause; rdrand %%0; jae 1b;\":\"=r\"\(%s));\n",label);
						//printf("\t%s=integer1;\n",label);
					}
				}                                                                                                                                                                             
{BG}*YIELD[;]*                  {                                                                                                                                                                              
                                        printf("\n\tasm\(\"pause;\");\n");                                                                                                                                     
                                } 

{BG}*COUNT{BG}+({LABEL}|{DENOTATION})+	{
						if (yytext[0]=='"') integer1=strlen(yytext);

					}

					



{BG}*OUTPUT{BG}+\".+\"		{
					bzero(text1,256);
					sscanf(yytext," OUTPUT \"%256c\"", text1);
					printf("	printf\(\"%%s \",\" %s);\n",text1);
					}

{BG}*OUTPUT{BG}+{LABEL}+		{

					bzero(label,256);
					sscanf(yytext," OUTPUT %s", label);
					for (int i=0;i<tp;i++) {
						if (strcmp(vars[i].label,label)==0) {
							type = vars[i].type;
							break;
						}
					}
					if (type==0) printf("\n\tprintf\(\"%%d \", %s);\n",label);
					else if (type==1) printf("\n\tprintf\(\"%%s\", %s);\n",label);
					else REJECT;
				}

{BG}*INPUT{BG}+{LABEL}+		{
					bzero(label,256);
					sscanf(yytext," INPUT %s", label);
					for (int i=0;i<tp;i++) {
						if (strcmp(vars[i].label,label)==0) {					
							type = vars[i].type;
							break;
						}
					}
					if (type==0) printf("\n\tscanf\(\" %%d \", &%s);\n",label);
					else if (type==1) printf("\n\tscanf\(\" %%256c \", %s);\n",label);
					else REJECT;


				}

{BG}*INTEGER{BG}+{LABEL}+	{
					bzero(label,256);
					sscanf(yytext," INTEGER %s", label);
					printf("static int %s;\n", label);
					strcpy(vars[tp].label,label);
					vars[tp++].type=0;
				}

{BG}*DENOTED{BG}+{LABEL}+	{
					bzero(label,256);
					sscanf(yytext," DENOTED %s", label);
					printf("static char %s[256];\n", label);
					strcpy(vars[tp].label,label);
					vars[tp++].type=1;
				}

{BG}*IF{BG}*{DENOTATION}+{BG}*[?]{BG}+{DENOTATION}+{BG}*THEN+	{

				}
{BG}*IF{BG}*.+{BG}*THEN+	{
					bzero(text1,256);
					bzero(text2,256);
					bzero(text3,256);					
					sscanf(yytext," IF %s %s %s THEN", text1, text2 , text3);
					if (strcmp(text2,"=")==0) strcpy(text2,"==");
					printf("	if ( %s %s %s )", text1,text2,text3);
				}
{BG}*{LABEL}+{BG}*":="+{BG}*({LETTER}|{DIGIT})+{BG}*{ARITMETICS}*{BG}*({LETTER}|{DIGIT})*[;]*	{
					bzero(text1,256);
					bzero(text2,256);
					bzero(text3,256);
					bzero(text4,256);					
					int s = sscanf(yytext, "%s := %s %s %s", text1, text2, text3 ,text4);
					//printf("%s Scan Count: %d\n",yytext, s);
					printf("\t%s=%s %s %s ; \n",text1, text2, text3 , text4);
				}
{BG}*{LABEL}+{BG}*:={BG}*{DENOTATION}+[;]*	 	{
							bzero(label,256);
							bzero(text1,256);
							int s = sscanf(yytext, "%s := \" %[^\"] \"", label, text1);
							if (s==2) printf("\tstrcpy(%s,\" %s \");", label, text1);
							else printf("\tError: parsed %d tokens %s\n",s, yytext);
							}
		
{BG}*BEGIN		printf("{\n");
{BG}*END		printf("}\n");
{BG}*GOTO{BG}+{LABEL}+	{ 
				bzero(label,256);
				sscanf(yytext," GOTO %s", label); 
				printf("	goto %s;\n", label); 
			}
^{LABELDECL}+		printf("%s\n",yytext);
{BG}*			;
";"			;
.			printf("?");
%%
int main(void) 
{
	printf("/* first Generated C code */\n");
	printf("#include <stdlib.h>\n");
	printf("#include <stdio.h>\n");
	printf("#include <string.h>\n");	
	printf("int main(void) {\n");
	yylex();
	printf("	return(0);\n");
	printf("}\n");	
	return (0);
}