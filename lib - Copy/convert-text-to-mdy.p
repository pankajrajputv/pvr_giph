DEF INPUT PARAMETER ptext AS CHAR INIT "25/01/2019 15:28:39" FORMAT "x(50)".
DEF OUTPUT PARAMETER pdate AS DATE.

ASSIGN ptext = REPLACE(ptext,"/",",").
ASSIGN ptext = REPLACE(ptext," ",",").

ASSIGN pdate = DATE(INT(ENTRY(2,ptext)),INT(ENTRY(1,ptext)),INT(ENTRY(3,ptext))).
