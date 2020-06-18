DEF SHARED VAR pfilename-csv AS CHAR.

DEF VAR pfilename-ini AS CHAR.
DEF VAR pfilename-fin AS CHAR.
DEF VAR pcons AS INT.
DEF TEMP-TABLE det
    FIELD pcons AS INT
    FIELD ptext AS CHAR FORMAT "x(1000)"
    INDEX idx AS PRIMARY UNIQUE pcons.

ASSIGN pfilename-ini = "C:\pvr\giph\lib\fix_csvfiles.txt".
ASSIGN pfilename-fin = "C:\pvr\giph\lib\fix_csvfiles.ps1".
/*ASSIGN pfilename-csv = "C:\pvr\giph\GL2019-CSV\temp\abc.csv".*/
ASSIGN pcons = 0.
INPUT FROM VALUE(pfilename-ini).
REPEAT:
    ASSIGN pcons = pcons + 1.
    CREATE det.
    ASSIGN det.pcons = pcons.
    IMPORT UNFORMATTED det.ptext.
    IF det.ptext MATCHES "*abcde12345*" THEN DO:
        ASSIGN det.ptext = REPLACE(det.ptext,'abcde12345',pfilename-csv).
    END.
END.
INPUT CLOSE.

OUTPUT TO VALUE(pfilename-fin).
FOR EACH det BREAK BY det.pcons:
    PUT UNFORMATTED det.ptext SKIP.
END.
OUTPUT CLOSE.

