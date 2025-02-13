DEF SHARED VAR ppackages-sum-cons LIKE gi_data_packages_sum.packages-sum-cons.
/*DEF NEW SHARED VAR ppackages-sum-cons LIKE gi_data_packages_sum.packages-sum-cons.*/

DEF VAR pfilename-xml AS CHAR.

DEF VAR pacc-group-name AS CHAR FORMAT "x(100)".
DEF VAR pacc-group-parent-name AS CHAR FORMAT "x(100)".

DEF VAR pacc-ledger-name AS CHAR FORMAT "x(100)".
DEF VAR pacc-ledger-name-party AS CHAR FORMAT "x(100)".
DEF VAR pacc-ledger-name-alias AS CHAR FORMAT "x(100)".
DEF VAR pacc-ledger-parent-name AS CHAR FORMAT "x(100)".

DEF VAR pvouchertype AS CHAR.
DEF VAR pvouchernumber AS CHAR.
DEF VAR pvoucherdate AS DATE.
DEF VAR pvoucherdate-txt AS CHAR.
DEF VAR pnarration AS CHAR.
DEF VAR pvchkey AS CHAR.
DEF VAR pguid AS CHAR.
DEF VAR premoteid AS CHAR.
DEF VAR ppartyledgername AS CHAR.
DEF VAR pledgername-debit1 AS CHAR.
DEF VAR pledgername-debit2 AS CHAR.
DEF VAR pledgername-debit3 AS CHAR.
DEF VAR pledgername-debit4 AS CHAR.
DEF VAR pledgername-debit5 AS CHAR.
DEF VAR pledgername-credit1 AS CHAR.
DEF VAR pledgername-credit2 AS CHAR.
DEF VAR pledgername-credit3 AS CHAR.
DEF VAR pledgername-credit4 AS CHAR.
DEF VAR pledgername-credit5 AS CHAR.
DEF VAR pledgeramount-debit1 AS DEC.
DEF VAR pledgeramount-debit2 AS DEC.
DEF VAR pledgeramount-debit3 AS DEC.
DEF VAR pledgeramount-debit4 AS DEC.
DEF VAR pledgeramount-debit5 AS DEC.
DEF VAR pledgeramount-credit1 AS DEC.
DEF VAR pledgeramount-credit2 AS DEC.
DEF VAR pledgeramount-credit3 AS DEC.
DEF VAR pledgeramount-credit4 AS DEC.
DEF VAR pledgeramount-credit5 AS DEC.
DEF VAR pvouchertotalamount AS DEC.
DEF VAR pledgernarration AS CHAR.

DEF VAR pcashbankledger AS CHAR.
DEF VAR peffectivedate AS DATE.
DEF VAR peffectivedate-txt AS CHAR.

DEF VAR pchequedate AS DATE.
DEF VAR pchequenumber AS CHAR.
DEF VAR pchequedate-txt AS CHAR.
DEF VAR ppaymentfovouring AS CHAR.
DEF VAR pbankpartyname AS CHAR.

DEF VAR palterid AS CHAR.
DEF VAR pmasterid AS CHAR.
DEF VAR pvoucherkey AS CHAR.
DEF VAR ppackagessname AS CHAR.

DEF VAR pLastVchId AS CHAR.
DEF VAR poutput-filename AS CHAR. 
DEF VAR pbat-filename AS CHAR. 


ASSIGN pacc-group-name = "My Debtors".
ASSIGN pacc-group-parent-name = "Accounts Receivable".

ASSIGN pacc-ledger-name = "Communication Expenses".
ASSIGN pacc-ledger-parent-name = "Indirect Expenses".

DEF VAR pvoudate AS DATE.

/*ASSIGN ppackages-sum-cons = 20.*/

ASSIGN pfilename-xml = "C:\pvr\giph\tallylib\CreateVoucherJournal.xml".
ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt". 
ASSIGN pbat-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal.BAT".

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

FOR EACH gi_data_packages_sum WHERE gi_data_packages_sum.packages-sum-cons = ppackages-sum-cons NO-LOCK
    BREAK BY gi_data_packages_sum.packages-sum-cons:
    
    /*
    FIND FIRST gi_data_packages WHERE gi_data_packages. gi_data_packages_sum NO-LOCK NO-ERROR.
    IF AVAILABLE gi_data_packages THEN DO:
        ASSIGN ppackagessname = gi_data_packages.packagessname.
    END.
    ELSE DO:
        ASSIGN ppackagessname = "".
    END.
    */

    IF FIRST-OF(gi_data_packages_sum.packages-sum-cons) THEN DO:
        ASSIGN 
               pacc-ledger-name = replace(gi_data_packages_sum.party-name,"&","&amp;")
               pacc-ledger-name-party = replace(gi_data_packages_sum.party-name,"&","&amp;")
               pacc-ledger-parent-name = "Accounts Payable". 
        RUN CreateLedger.
        
        ASSIGN 
               pacc-ledger-name = replace(gi_data_packages_sum.alias-name,"&","&amp;")
               pacc-ledger-name-alias = replace(gi_data_packages_sum.alias-name,"&","&amp;")
               pacc-ledger-parent-name = "Accounts Payable". 
        RUN CreateLedger.

        RUN c:\pvr\giph\lib\Calc_Vou_Date_From_Fn.p(INPUT gi_data_packages_sum.YearMonthFN,OUTPUT pvoudate).

        ASSIGN 
            pvouchertype         = "Journal-Packages"
            pvouchernumber       = /*"CDV36462"*/ "JP-" + STRING(gi_data_packages_sum.packages-sum-cons,"999999")
            /*pvouchernumber       = /*"CDV36462"*/  STRING(gi_data_packages_sum.packages-sum-cons)*/
            pvoucherdate         = /*10/31/19*/ pvoudate
            peffectivedate       = /*10/31/19*/ pvoudate
            pchequedate          = /*10/31/19*/ pvoudate
            pchequenumber        = /*STRING(gi_data_packages_sum.cheque-num)*/ ""
            pvoucherdate-txt     = STRING(YEAR(pvoucherdate),"9999")   + STRING(MONTH(pvoucherdate),"99")   + STRING(DAY(pvoucherdate),"99") 
            peffectivedate-txt   = STRING(YEAR(peffectivedate),"9999") + STRING(MONTH(peffectivedate),"99") + STRING(DAY(peffectivedate),"99") 
            pchequedate-txt      = STRING(YEAR(peffectivedate),"9999") + STRING(MONTH(peffectivedate),"99") + STRING(DAY(peffectivedate),"99") 
            ppartyledgername     = /*"UCPB C/A PHP 201120001328"*/ ""
            pnarration           = replace(gi_data_packages_sum.party-name,"&","&amp;")
            .

        ASSIGN 
            pvchkey              = "a9545bdc-3762-40ba-8917-ec660dcacc0e-bu" + "00" + pvouchernumber + ":" + "000001d6"
            pguid                = "a9545bdc-3762-40ba-8917-ec660dcacc0e-bu" + "00" + pvouchernumber 
            premoteid            = "a9545bdc-3762-40ba-8917-ec660dcacc0e-bu" + "00" + pvouchernumber 
            .

        PUT UNFORMATTED '     <VOUCHER REMOTEID="' premoteid '" VCHKEY="' pvchkey '"VCHTYPE="' pvouchertype '" ACTION="Create" OBJVIEW="Accounting Voucher View">' SKIP.     
        PUT UNFORMATTED "      <DATE>" pvoucherdate-txt "</DATE>" SKIP.                                 
        PUT UNFORMATTED "      <GUID>" pguid "</GUID>" SKIP.                                            
        PUT UNFORMATTED "      <NARRATION>" pnarration "</NARRATION>" SKIP.                             
        PUT UNFORMATTED "      <VOUCHERTYPENAME>" pvouchertype "</VOUCHERTYPENAME>" SKIP.               
        PUT UNFORMATTED "      <VOUCHERNUMBER>" pvouchernumber "</VOUCHERNUMBER>" SKIP.                 
        PUT UNFORMATTED "      <PARTYLEDGERNAME>" ppartyledgername "</PARTYLEDGERNAME>" SKIP.           
        PUT UNFORMATTED "      <EFFECTIVEDATE>" peffectivedate-txt "</EFFECTIVEDATE>" SKIP.             
        PUT UNFORMATTED "      <ALTERID>" palterid "</ALTERID>" SKIP.                                   
        PUT UNFORMATTED "      <MASTERID>" pmasterid "</MASTERID>" SKIP.                                
        PUT UNFORMATTED "      <VOUCHERKEY>" pvoucherkey "</VOUCHERKEY>" SKIP. 

    END. /* IF FIRST-OF(gi_data_packages_sum.packages-sum-cons) */

    /*************** DEBIT *****************/
    ASSIGN pledgername-debit1 = "Control Agent" pledgeramount-debit1 = gi_data_packages_sum.SellingPrice1 * -1 pledgernarration = "Coll. from Agent / " +  STRING((gi_data_packages_sum.CollectFromAgent),"-zz,zzz,zz9.99").
    RUN debit_entry.

    IF gi_data_packages_sum.total-db-cr-diff < 0 THEN DO:
        /*ASSIGN pledgername-debit1 = "Income - Miscellaneous" pledgeramount-debit1 = gi_data_packages_sum.total-db-cr-diff * -1  pledgernarration = "Diff Db Cr / " + STRING("").*/
        ASSIGN pledgername-debit1 = "Income - Miscellaneous" pledgeramount-debit1 = gi_data_packages_sum.total-db-cr-diff pledgernarration = "Diff Db Cr / " + STRING("").
        RUN debit_entry.
    END.



    /*************** CREDIT *****************/

    ASSIGN pledgername-credit1 = pacc-ledger-name-alias pledgeramount-credit1 = gi_data_packages_sum.payable1 pledgernarration = "Payable. / " + pacc-ledger-name-party /*+ STRING(gi_data_packages_sum.mtagentcomm,"-zz,zzz,zz9.99") */.
    RUN credit_entry.


    ASSIGN pledgername-credit1 = "Commission Income - Packages" pledgeramount-credit1 = gi_data_packages_sum.MarkUp1 pledgernarration = "MarkUp / " + STRING(gi_data_packages_sum.MarkUp,"-zz,zzz,zz9.99"). 
    /*ASSIGN pledgername-credit1 = "Packages" pledgeramount-credit1 = gi_data_packages_sum.MarkUp1 pledgernarration = "MarkUp / " + STRING(gi_data_packages_sum.MarkUp,"-zz,zzz,zz9.99"). */
    RUN credit_entry.

    /*ASSIGN pledgername-credit1 = "Output Vat @ 12%" pledgeramount-credit1 = gi_data_packages_sum.outputvat pledgernarration = "MarkUp / x 0.12 " + STRING(gi_data_packages_sum.MarkUp1, "-zz,zzz,zz9.99").*/
    ASSIGN pledgername-credit1 = "Output Tax Payable" pledgeramount-credit1 = gi_data_packages_sum.outputvat pledgernarration = "MarkUp / x 0.12 " + STRING(gi_data_packages_sum.MarkUp1, "-zz,zzz,zz9.99").
    RUN credit_entry.

    /*
    ASSIGN pledgername-credit1 = "Income - Miscellaneous" pledgeramount-credit1 = gi_data_packages_sum.total-db-cr-diff  pledgernarration = "Diff Db Cr / " + STRING("").
    RUN credit_entry.
      */

    IF gi_data_packages_sum.total-db-cr-diff > 0 THEN DO:
        ASSIGN pledgername-credit1 = "Income - Miscellaneous" pledgeramount-credit1 = gi_data_packages_sum.total-db-cr-diff  pledgernarration = "Diff Db Cr / " + STRING("").
        RUN credit_entry.
    END.


END. /* for each gi_data_packages_sum */



PUT UNFORMATTED "     </VOUCHER>" SKIP.
PUT UNFORMATTED "    </TALLYMESSAGE>" SKIP.
PUT UNFORMATTED "   </REQUESTDATA>" SKIP.
PUT UNFORMATTED "  </IMPORTDATA>" SKIP.
PUT UNFORMATTED " </BODY>" SKIP.
PUT UNFORMATTED "</ENVELOPE>" SKIP.

OUTPUT CLOSE.


OS-DELETE SILENT VALUE(poutput-filename) NO-ERROR.
OS-COMMAND SILENT VALUE(pbat-filename) NO-ERROR.
/*
OS-COMMAND NO-WAIT VALUE("C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt") NO-ERROR.
  */


FOR EACH gi_data_packages_sum WHERE gi_data_packages_sum.packages-sum-cons = ppackages-sum-cons:
    RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT pLastVchId, OUTPUT gi_data_packages_sum.tally-response).
    /*
    ASSIGN gi_data_packages_sum.LastVchId = pLastVchId.
    */
END.


PROCEDURE CreateAccGroup.
    PUT UNFORMATTED '     <GROUP ACTION="Create" NAME="' pacc-group-name '">' SKIP.
    PUT UNFORMATTED "      <NAME.LIST>" SKIP.
    PUT UNFORMATTED "      <NAME>" pacc-group-name "</NAME>" SKIP.
    PUT UNFORMATTED "      </NAME.LIST>" SKIP.
    PUT UNFORMATTED "      <PARENT>" pacc-group-parent-name "</PARENT>" SKIP.
    PUT UNFORMATTED "      <ISSUBLEDGER>No</ISSUBLEDGER>" SKIP.
    PUT UNFORMATTED "      <ISBILLWISEON>No</ISBILLWISEON>" SKIP.
    PUT UNFORMATTED "      <ISCOSTCENTRESON>No</ISCOSTCENTRESON>" SKIP.
    PUT UNFORMATTED "     </GROUP>" SKIP.
END PROCEDURE.

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



PROCEDURE debit_entry.
    PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
    PUT UNFORMATTED "       <NARRATION>" pledgernarration "</NARRATION>" SKIP.
    PUT UNFORMATTED "       <LEDGERNAME>" pledgername-debit1 "</LEDGERNAME>" SKIP.                  
    PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>yes</ISDEEMEDPOSITIVE>" SKIP.
    PUT UNFORMATTED "       <AMOUNT>" pledgeramount-debit1 "</AMOUNT>" SKIP.                        
    PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.

END.

PROCEDURE credit_entry.
    PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
    PUT UNFORMATTED "       <NARRATION>" pledgernarration "</NARRATION>" SKIP.
    PUT UNFORMATTED "       <LEDGERNAME>" pledgername-credit1 "</LEDGERNAME>" SKIP.                  
    PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>" SKIP.
    PUT UNFORMATTED "       <AMOUNT>" pledgeramount-credit1 "</AMOUNT>" SKIP.                        
    PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.

END.


