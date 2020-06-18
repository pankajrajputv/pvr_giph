DEF INPUT PARAMETER pinputfile AS CHAR FORMAT "x(200)".
DEF OUTPUT PARAMETER pLastVchId AS INT.
DEF OUTPUT PARAMETER ptally-response LIKE gi_acc_hea.tally-response.
DEF VAR ptexto AS CHAR FORMAT "x(200)".
DEF VAR ptexto1 AS CHAR FORMAT "x(200)".
/*
ASSIGN pinputfile = "C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt".
*/

ASSIGN ptally-response = "".
IF SEARCH(pinputfile) = ? THEN DO:
   ASSIGN plastvchid = 0.
   MESSAGE plastvchid. PAUSE 1.
   RETURN.
END.

INPUT FROM VALUE(pinputfile).
REPEAT:
    IMPORT UNFORMATTED ptexto.
    ASSIGN ptexto1 = ptexto.
    IF ptexto MATCHES "*<LASTVCHID>*" THEN DO:
        ASSIGN ptexto = REPLACE(ptexto,"<LASTVCHID>","").
        ASSIGN ptexto = REPLACE(ptexto,"</LASTVCHID>","").
        ASSIGN plastvchid = INT(ptexto) NO-ERROR.
        /*LEAVE.*/
    END.
    ASSIGN ptally-response = ptally-response + ptexto1 + CHR(10).
END.
INPUT CLOSE.

/*

------------------[http-ping: 1 @ Saturday, January 11, 2020 18:53:21]------------------
HTTP/1.1 200 OK
Unicode: No
CONTENT-TYPE: text/xml; charset=utf-8
RESPSTATUS: 1
CONNECTION: KEEP-ALIVE
CONTENT-LENGTH: 242

<RESPONSE>
 <CREATED>0</CREATED>
 <ALTERED>2</ALTERED>
 <DELETED>0</DELETED>
 <LASTVCHID>203</LASTVCHID>
 <LASTMID>0</LASTMID>
 <COMBINED>0</COMBINED>
 <IGNORED>0</IGNORED>
 <ERRORS>0</ERRORS>
 <CANCELLED>0</CANCELLED>
</RESPONSE>


*/
