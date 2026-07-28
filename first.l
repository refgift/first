LABELDECL	[A-Z]+[0-9]*":"
LABEL		[A-Z]+[0-9]*
BG		[ \t\n]
ARITMETICS	[&^|+-/*%]
CONDITIONALS  	[<>!=]
DENOTER		["]
DENOTATION	["]+.+["]+
BOOLEAN		TRUE|FALSE
DIGIT		[0-9]
LETTER		[A-Z]
INTEGER		[-]*[0-9]+
ASSIGNER	[:][=]
COLOR		RED|BLUE|GREEN|WHITE|BLACK|CLEAR|YELLOW|MAGENTA|CYAN
%{

#include <stdbool.h>
	
	static char label[256];
	static char text1[256];
	static char text2[256];
	static char text3[256];
	static char text4[256];
	static long longeger1;
	unsigned char data1;

	struct types {
		char label[256];
		long type;
	};

	static struct types vars[10000];
	static long tp;
	static long type;
/* ; NASM Syntax for a Cold Reboot
mov dx, 0xCF9
mov al, 0x0E
out dx, al
*/

%}

%%
{BG}*OUT{BG}*({DIGIT})+{BG}*[,]+{BG}*{LABEL}+ {
						bzero(label,256);
						sscanf(yytext, " OUT %ld , %s",&data1, label);
						printf("\n\t{unsigned char data;");
						printf("\n\tdata = %s;",label);
						printf("\n\tasm(\"outb %%0, $%ld\": :\"a\"(data));}",longeger1);
						}
{BG}*IN{BG}*({DIGIT})+{BG}*[,]+{BG}*{LABEL}+ {
						bzero(label,256);
						sscanf(yytext, " IN %ld , %s",&longeger1, label);
						printf("\n\t{unsigned char data;");
						printf("\n\tasm(\"inb $%ld, %%q0;\":\"=a\"(data));",longeger1);
						printf("\n\t%s = data;}",label);
					}
{BG}*{LABEL}{BG}*:={BG}*RANDOM{BG}*[;]*    {
					 bzero(label,256);
					 sscanf(yytext," %s := RANDOM",label);
				         for (long i=0;i<tp;i++) {                                                                                                           
                                                if (strcmp(vars[i].label,label)==0) {                                                                                      
                                                        type = vars[i].type;                                                                                               
                                                        break;                                                                                                             
                                                }                                                                                                                          
                                        } 
					if (type==0) {  			
						printf("\tasm\(\"1: pause; rdrand %%q0; jae 1b;\":\"=R\"\(%s));\n",label);
						//printf("\t%s=longeger1;\n",label);
					}
				}                                                                                                                                                                             
{BG}*YIELD{BG}*[;]*                  {                                                                                                                                                                              
                                        printf("\n\tasm\(\"pause;\");\n");                                                                                                                                     
                                } 

{BG}*{LABEL}{BG}+:={BG}*COUNT{BG}+{LABEL}+	{
					bzero(label,256);
					bzero(text1,256);
					sscanf(yytext," %s := %*s %s", label, text1); 
				 	static long type;       
					for (long i=0;i<tp;i++) {
                                                if (strcmp(vars[i].label,label)==0) {
                                                        type = vars[i].type;                                                                                             
							break;
						}
					}
					if (type == 0) { 
						printf("\n\t%s = strlen(%s); ", label, text1);
					}
				}
					



{BG}*OUTPUT{BG}+\".+\"		{
					bzero(text1,256);
					sscanf(yytext," OUTPUT \"%256c\"", text1);
					printf("	printf\(\"%%s\",\" %s);\n",text1);
					}

{BG}*OUTPUT{BG}+{COLOR}+	{
					bzero(label,256);					
					sscanf(yytext," OUTPUT %s", label);
					if (strcmp(label,"RED")==0) printf("\n\tprintf(\"\033[31m\");");
					else if (strcmp(label,"CLEAR")==0) printf("\n\tprintf(\"\033[0m\");");
					else if (strcmp(label,"BLUE")==0) printf("\n\tprintf(\"\033[34m\");");
					else if (strcmp(label,"GREEN")==0) printf("\n\tprintf(\"\033[32m\");");
					else if (strcmp(label,"YELLOW")==0) printf("\n\tprintf(\"\033[33m\");");
					else if (strcmp(label,"MAGENTA")==0) printf("\n\tprintf(\"\033[35m\");");
					else if (strcmp(label,"CYAN")==0) printf("\n\tprintf(\"\033[36m\");");
					else if (strcmp(label,"WHITE")==0) printf("\n\tprintf(\"\033[37m\");");
					else if (strcmp(label,"BLACK")==0) printf("\n\tprintf(\"\033[30m\");");
				}
{BG}*OUTPUT{BG}+{LABEL}+	{

					bzero(label,256);
					sscanf(yytext," OUTPUT %s", label);
					for (long i=0;i<tp;i++) {
						if (strcmp(vars[i].label,label)==0) {
							type = vars[i].type;
							break;
						}
					}
					if (type==0) printf("\n\tprintf\(\"%%ld \", %s);\n",label);
					else if (type==1) printf("\n\tprintf\(\"%%s\", %s);\n",label);
					else REJECT;
				}

{BG}*INPUT{BG}+{LABEL}+		{
					bzero(label,256);
					sscanf(yytext," INPUT %s", label);
					long i;
					for (i=0;i<tp;i++) {
						if (strcmp(vars[i].label,label)==0) {					
							type = vars[i].type;
							break;
						}
					}
					if (type==0) printf("\n\tscanf\(\"%%ld\", &%s);\n",label);
					else if (type==1) { 
						printf("\n\tbzero(%s,256);\n",label);
						printf("\n\tscanf\(\"%%s\",%s);\n",label);
					}
					else REJECT;


				}

{BG}*INTEGER{BG}+{LABEL}+	{
					bzero(label,256);
					sscanf(yytext," INTEGER %s", label);
					printf("static long %s;\n", label);
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

{BG}*IF{BG}*{LABEL}+{BG}*"?"+{BG}*{LABEL}+{BG}*THEN+	{
					bzero(text1,256);					
					bzero(text2,256);
					sscanf(yytext," IF %s ? %s THEN", text1, text2);
					//printf("DEBUG: %s ? %s\n",text1, text2);
					printf("\tif\(is_isomorphic\(%s,%s))\n",text1,text2);
					}
{BG}*IF{BG}*.+{BG}*THEN+	{
					bzero(text1,256);
					bzero(text2,256);
					bzero(text3,256);					
					sscanf(yytext," IF %s %s %s THEN", text1, text2 , text3);
					if (strcmp(text2,"=")==0) strcpy(text2,"==");
					printf("	if ( %s %s %s )", text1,text2,text3);
				}
{BG}*{LABEL}+{BG}*:={BG}*{LABEL}+{BG}*{ARITMETICS}+{BG}*({LABEL}|{INTEGER})+{BG}*[;]*;	{
					bzero(text1,256);
					bzero(text2,256);
					bzero(text3,256);
					bzero(label,256);
					sscanf(yytext, "%s := %s %s %s", label, text1, text2, text3);
					printf("\t%s=%s%s%s;\n",label, text1,text2,text3);
					}

{BG}*{LABEL}+{BG}+:={BG}+{INTEGER}{BG}*[;]*	{
					bzero(text1,256);
					bzero(text2,256);
					sscanf(yytext, "%s := %ld", text1, &longeger1);
					printf("\t%s=%ld;\n",text1, longeger1);
				}
{BG}*{LABEL}+{BG}+:={BG}+{LABEL}{BG}*[;]*	{
					bzero(text1,256);
					bzero(text2,256);
					sscanf(yytext, "%s := %s", text1, text2);
					printf("\t%s=%s;\n",text1, text2);
					}
{BG}*{LABEL}+{BG}+:={BG}+{DENOTATION}+{BG}*[;]*	 	{
							bzero(label,256);
							bzero(text1,256);
							long s = sscanf(yytext, " %s := \"%[^\"]\" )", label, text1);
							if (s==2) printf("\tstrcpy(%s,\"%s\");", label, text1);
							else printf("\t/* Error: parsed %ld tokens %s*/\n",s, label);
							}
		
{BG}*BEGIN		printf("{\n");
{BG}*END		printf("}\n");
{BG}*GOTO{BG}+{LABEL}+	{ 
				bzero(label,256);
				sscanf(yytext," GOTO %s", label); 
				printf("	goto %s;\n", label); 
			}
^{LABELDECL}+		printf("\n%s",yytext);
{BG}*			;
";"			;
.			printf("?");
\x04			;
%%

static char isofunct [] = R"(
/**                                                                           
 * Checks if two strings are isomorphic.                                      
 * @param s1 The first string.                                                
 * @param s2 The second string.                                               
 * @return True if the strings are isomorphic, false otherwise.               
 */                                                                           
bool is_isomorphic(const char* s1, const char* s2) {                          
   long len1 = strlen(s1);                                                     
   long len2 = strlen(s2);                                                     
                                                                              
                                                                              
    // Use arrays as hash maps to store character mappings                    
    // Assuming ASCII characters, we can use an array of size 128 (or 256)    
    static long map1[128] = {0}; // Maps characters from s1 to s2              
    static long map2[128] = {0}; // Maps characters from s2 to s1 (to ensure on
                                                                              
    static long leni;                                                          
                                                                              
    if (len1>len2) leni=len2;                                                 
    else leni=len1;                                                           
                                                                              
                                                                              
    for (long i = 0; i < leni; i++) {                                          
        char c1 = s1[i];                                                      
        char c2 = s2[i];                                                      
                                                                              
        // Check mapping from c1 to c2                                        
        if (map1[c1] == 0) {                                                  
            map1[c1] = c2;                                                    
        } else if (map1[c1] != c2) {                                          
            return false; // Inconsistent mapping                             
        }                                                                     
                                                                              
        // Check mapping from c2 to c1                                        
        if (map2[c2] == 0) {                                                  
            map2[c2] = c1;                                                    
        } else if (map2[c2] != c1) {                                          
            return false; // Ensures one-to-one mapping                       
        }                                                                     
    }                                                                         
                                                                              
    return true;                                                              

})";

long main(void) 
{
	printf("/* first Generated C code */\n");
	printf("#include <stdlib.h>\n");
	printf("#include <stdio.h>\n");
	printf("#include <string.h>\n");	
	printf("#include <stdbool.h>\n");	
	printf("#include <strings.h>\n");	
//	printf("#include <sys/io.h>\n");	
	printf("%s\n",isofunct);
	printf("long main(void) {\n");
	yylex();
	printf("	return(0);\n");
	printf("}\n");	
	return (0);
}