DEF VAR pfilename-xml AS CHAR.
DEF VAR poutput-filename AS CHAR. 
DEF VAR pbat-filename AS CHAR. 

DEF VAR pacc-group-name AS CHAR FORMAT "x(100)".
DEF VAR pacc-group-parent-name AS CHAR FORMAT "x(100)".
DEF VAR pacc-ledger-name AS CHAR FORMAT "x(100)".
DEF VAR pacc-ledger-parent-name AS CHAR FORMAT "x(100)".

ASSIGN pfilename-xml = "C:\pvr\giph\tallylib\CreateVoucherJournal.xml".
ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt". 
ASSIGN pbat-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal.BAT".
DEF VAR n AS INT.

OUTPUT TO VALUE(pfilename-xml).

PUT UNFORMATTED "<ENVELOPE>" SKIP.
PUT UNFORMATTED " <HEADER>" SKIP.
PUT UNFORMATTED "  <TALLYREQUEST>Import Data</TALLYREQUEST>" SKIP.
PUT UNFORMATTED " </HEADER>" SKIP.
PUT UNFORMATTED " <BODY>" SKIP.
PUT UNFORMATTED "  <IMPORTDATA>" SKIP.
PUT UNFORMATTED "   <REQUESTDESC>" SKIP.
PUT UNFORMATTED "    <REPORTNAME>All Masters</REPORTNAME>" SKIP.
PUT UNFORMATTED "   </REQUESTDESC>" SKIP.
PUT UNFORMATTED "   <REQUESTDATA>" SKIP.
PUT UNFORMATTED '    <TALLYMESSAGE xmlns:UDF="TallyUDF">' SKIP.


FOR EACH gi_acc_hea WHERE gi_acc_hea.vouchertype = "Payment"
                      AND gi_acc_hea.lastvchid = 0
                    /*  AND gi_acc_hea.refnum1 = "CDV36525"*/
                      AND gi_acc_hea.dbcr-diff = 0,
    EACH gi_acc_det WHERE gi_acc_det.refnum1 = gi_acc_hea.refnum1
    BREAK BY gi_acc_det.partyname:

    IF FIRST-OF(gi_acc_det.partyname) AND gi_acc_det.partyname <> "" THEN DO:
        ASSIGN pacc-ledger-parent-name = "Accounts  Payable".
        ASSIGN pacc-ledger-name = replace(gi_acc_det.partyname,"&","&amp;").
        RUN CreateLedger.
    END.

END. /* for each gi_acc_hea */

PUT UNFORMATTED "    </TALLYMESSAGE>" SKIP.
PUT UNFORMATTED "   </REQUESTDATA>" SKIP.
PUT UNFORMATTED "  </IMPORTDATA>" SKIP.
PUT UNFORMATTED " </BODY>" SKIP.
PUT UNFORMATTED "</ENVELOPE>" SKIP.

OUTPUT CLOSE.
/*
OS-DELETE SILENT VALUE(poutput-filename) NO-ERROR.
OS-COMMAND SILENT VALUE(pbat-filename) NO-ERROR.
  */

PROCEDURE CreateLedger.
    PUT UNFORMATTED '     <LEDGER NAME="' pacc-ledger-name '" RESERVEDNAME="">' SKIP.
    PUT UNFORMATTED "      <CURRENCYNAME>p</CURRENCYNAME>" SKIP.
    PUT UNFORMATTED "      <PARENT>" pacc-ledger-parent-name "</PARENT>" SKIP.
    PUT UNFORMATTED "      <ISBILLWISEON>No</ISBILLWISEON>" SKIP.
    PUT UNFORMATTED "      <ISCOSTCENTRESON>Yes</ISCOSTCENTRESON>" SKIP.
    PUT UNFORMATTED "      <LANGUAGENAME.LIST>" SKIP.
    PUT UNFORMATTED '       <NAME.LIST TYPE="String">' SKIP.
    PUT UNFORMATTED "        <NAME>" pacc-ledger-name "</NAME>" SKIP.
    PUT UNFORMATTED "       </NAME.LIST>" SKIP.
    PUT UNFORMATTED "       <LANGUAGEID> 1033</LANGUAGEID>" SKIP.
    PUT UNFORMATTED "      </LANGUAGENAME.LIST>" SKIP.
    PUT UNFORMATTED "     </LEDGER>" SKIP.
END PROCEDURE.
  
