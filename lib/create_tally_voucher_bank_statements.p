DEF SHARED VAR pbank-cons LIKE gi_data_banks.bank-cons.
    

DEF VAR pfilename-xml AS CHAR.

DEF VAR pacc-group-name AS CHAR FORMAT "x(100)".
DEF VAR pacc-group-parent-name AS CHAR FORMAT "x(100)".

DEF VAR pacc-ledger-name AS CHAR FORMAT "x(100)".
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

DEF VAR ptran-amt AS DEC. 
DEF VAR palterid AS CHAR.
DEF VAR pmasterid AS CHAR.
DEF VAR pvoucherkey AS CHAR.
DEF VAR pledgername AS CHAR.
DEF VAR ptally-acc-ledger LIKE gi_acc_led.tally-acc-ledger.
DEF VAR pdate-cleared AS DATE.
DEF VAR pdate-cleared-txt AS CHAR.
DEF VAR pbank-reg-txt AS CHAR.

ASSIGN pacc-group-name = "My Debtors".
ASSIGN pacc-group-parent-name = "Accounts Receivable".

ASSIGN pacc-ledger-name = "Communication Expenses".
ASSIGN pacc-ledger-parent-name = "Indirect Expenses".

ASSIGN pfilename-xml = "C:\pvr\giph\tallylib\CreateVoucher.xml".

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

FOR EACH gi_data_banks WHERE gi_data_banks.bank-cons = pbank-cons
                      /*AND gi_data_banks.vouchertype <> ""*/ /*NO-LOCK*/
    BREAK BY gi_data_banks.bank-cons:
    

    IF FIRST-OF(gi_data_banks.bank-cons) THEN DO:
        ASSIGN 
            pvoucherdate         = /*10/31/19*/ gi_data_banks.date-cleared
            peffectivedate       = /*10/31/19*/ gi_data_banks.date-cleared
            pchequedate          = /*10/31/19*/ gi_data_banks.date-cleared
            pchequenumber        = STRING(gi_data_banks.ch-num)
            pvoucherdate-txt     = STRING(YEAR(pvoucherdate),"9999") + STRING(MONTH(pvoucherdate),"99") + STRING(DAY(pvoucherdate),"99") 
            peffectivedate-txt   = STRING(YEAR(peffectivedate),"9999") + STRING(MONTH(peffectivedate),"99") + STRING(DAY(peffectivedate),"99") 
            pchequedate-txt      = STRING(YEAR(peffectivedate),"9999") + STRING(MONTH(peffectivedate),"99") + STRING(DAY(peffectivedate),"99") 
            ppartyledgername     = /*"UCPB C/A PHP 201120001328"*/ ""
            pnarration           = "Cons:" + STRING(gi_data_banks.bank-cons,"999999") +  " Narration: " + replace(gi_data_banks.narration + " (" + gi_data_banks.remarks + ")","&","&amp;")  + " // " + 
                                    "Description: " + replace(gi_data_banks.DESCRIPTION + " (" + gi_data_banks.remarks + ")","&","&amp;") 
            .


        ASSIGN pbank-reg-txt = STRING(gi_data_banks.bank-reg,"999999").
        ASSIGN pacc-ledger-name = replace(gi_data_banks.other-account,"&","&amp;").
        IF gi_data_banks.amt-cr > 0 THEN pacc-ledger-parent-name = "Accounts Receivable". 
        IF gi_data_banks.amt-db > 0 THEN pacc-ledger-parent-name = "Accounts Payable". 

        IF gi_data_banks.bank-code = "Aub" THEN DO:
            ASSIGN pvouchertype         = "Bank-AUB" pvouchernumber       = "AUB" + pbank-reg-txt.
            RUN CreateLedger.
            IF gi_data_banks.amt-cr > 0  THEN DO:
                ASSIGN pledgername-debit1  = gi_data_banks.bank-des 
                       pledgername-credit1 = pacc-ledger-name.
            END.
            IF gi_data_banks.amt-db > 0  THEN DO:
                ASSIGN pledgername-debit1  = pacc-ledger-name
                       pledgername-credit1 = gi_data_banks.bank-des.
            END.
        END.
        ELSE
        IF gi_data_banks.bank-code = "BDO_Dollar" THEN DO:
            ASSIGN pvouchertype         = "Bank-BDO-USD" pvouchernumber       = "BDO-USD" + pbank-reg-txt
                .
            RUN CreateLedger.
            IF gi_data_banks.amt-cr > 0  THEN DO:
                ASSIGN pledgername-debit1  = gi_data_banks.bank-des 
                       pledgername-credit1 = pacc-ledger-name.
            END.
            IF gi_data_banks.amt-db > 0  THEN DO:
                ASSIGN pledgername-debit1  = pacc-ledger-name
                       pledgername-credit1 = gi_data_banks.bank-des.
            END.
        END.
        ELSE
        IF gi_data_banks.bank-code = "BDO_Disbursement" THEN DO:
            ASSIGN pvouchertype         = "Bank-BDO-Disb" pvouchernumber       = "BDO-Dis" + pbank-reg-txt
                .
            RUN CreateLedger.
            IF gi_data_banks.amt-cr > 0  THEN DO:
                ASSIGN pledgername-debit1  = gi_data_banks.bank-des 
                       pledgername-credit1 = pacc-ledger-name.
            END.
            IF gi_data_banks.amt-db > 0  THEN DO:
                ASSIGN pledgername-debit1  = pacc-ledger-name
                       pledgername-credit1 = gi_data_banks.bank-des.
            END.



        END.
        ELSE
        IF gi_data_banks.bank-code = "BPI" THEN DO:
            ASSIGN pvouchertype         = "Bank-BPI" pvouchernumber       = "BPI" + pbank-reg-txt
                .
        END.
        ELSE
        IF gi_data_banks.bank-code = "PNB" THEN DO:
            ASSIGN pvouchertype         = "Bank-PNB" pvouchernumber       = "PNB" + pbank-reg-txt
                .
        END.
        ELSE
        IF gi_data_banks.bank-code = "SECURITY" THEN DO:
            ASSIGN pvouchertype         = "Bank-Security" pvouchernumber       = "Secu" + pbank-reg-txt
                .
        END.
        ELSE
        IF gi_data_banks.bank-code = "UCPB_Disbursement" THEN DO:
            ASSIGN pvouchertype         = "Bank-UCPB-Disb" pvouchernumber       = "BDO-USD" + pbank-reg-txt
                .
        END.
        ELSE
        IF gi_data_banks.bank-code = "BDO_TopUp" THEN DO:
            ASSIGN pvouchertype         = "Bank-BDO-TopUp" pvouchernumber       = "BDO-Tp" + pbank-reg-txt
                .
            RUN CreateLedger.
            IF gi_data_banks.amt-cr > 0  THEN DO:
                ASSIGN pledgername-debit1  = gi_data_banks.bank-des 
                       pledgername-credit1 = pacc-ledger-name.
            END.
            IF gi_data_banks.amt-db > 0  THEN DO:
                ASSIGN pledgername-debit1  = pacc-ledger-name
                       pledgername-credit1 = gi_data_banks.bank-des.
            END.

        END.
        ELSE 
        IF gi_data_banks.bank-code = "Metrobank" THEN DO:
           ASSIGN pvouchertype         = "Bank-MBTC" pvouchernumber       = "MBTC" + pbank-reg-txt
                .

           IF gi_data_banks.narration = "BEING DEPOSIT BY THE AGENT" AND
              gi_data_banks.amt-cr > 0  THEN DO:
              ASSIGN gi_data_banks.acc-payer = "Control Agent"
                     gi_data_banks.acc-receiver = "MBTC S/A PHP 7019516004". 
           END.
        END.
        ELSE 
        IF gi_data_banks.bank-code = "UCPB_Topup" THEN DO:
           ASSIGN pvouchertype         = "Bank-UCPB-Topup" pvouchernumber       = "UCPB-Tp" + pbank-reg-txt
                .
                  
           IF gi_data_banks.narration = "BEING DEPOSIT BY THE AGENT" AND
              gi_data_banks.amt-cr > 0  THEN DO:
              ASSIGN gi_data_banks.acc-payer = "Control Agent" gi_data_banks.acc-receiver = "MBTC S/A PHP 7019516004". 
           END.
           
        END.
        ELSE DO:
            NEXT.
        END.


        /*
        ASSIGN 
            pvchkey              = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00036462:000001d6"
            pguid                = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00036462"
            premoteid            = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00036462"
            .
            */

        ASSIGN 
            pvchkey              = "a9545bdc-3762-40ba-8917-ec660dcacc0e-" + "00" + pvouchernumber + ":" + "000001d6"
            pguid                = "a9545bdc-3762-40ba-8917-ec660dcacc0e-" + "00" + pvouchernumber 
            premoteid            = "a9545bdc-3762-40ba-8917-ec660dcacc0e-" + "00" + pvouchernumber 
            .
        ASSIGN 
            palterid             = /*" 169"*/ ""
            pmasterid            = /*" 82"*/ ""
            pvoucherkey          = /*"187982128611798"*/ ""
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

    END. /* IF FIRST-OF(gi_data_banks.refnum1) */
    ASSIGN ptally-acc-ledger = "".

    /*
    FIND gi_acc_led WHERE gi_acc_led.acc-led-name = gi_data_banks.acc-receiver NO-LOCK NO-ERROR.
    IF NOT AVAILABLE gi_acc_led THEN DO:
        CREATE gi_acc_led.
        ASSIGN gi_acc_led.acc-led-name = gi_data_banks.acc-receiver.
    END.
    FIND gi_acc_led WHERE gi_acc_led.acc-led-name = gi_data_banks.acc-payer NO-LOCK NO-ERROR.
    IF NOT AVAILABLE gi_acc_led THEN DO:
        CREATE gi_acc_led.
        ASSIGN gi_acc_led.acc-led-name = gi_data_banks.acc-payer.
    END.
      */


    /*
    ASSIGN pacc-ledger-name = replace(gi_data_banks.acc-receiver,"&","&amp;")
           pacc-ledger-parent-name = "Bank Accounts". 
    RUN CreateLedger.

    ASSIGN pacc-ledger-name = replace(gi_data_banks.acc-payer,"&","&amp;")
           pacc-ledger-parent-name = "Bank Accounts". 
    RUN CreateLedger.
    */
    ASSIGN ptran-amt = gi_data_banks.amt-db + gi_data_banks.amt-cr.
      

    IF gi_data_banks.date-cleared <> ? THEN DO:
        ASSIGN pdate-cleared = gi_data_banks.date-cleared.
        ASSIGN pdate-cleared-txt = STRING(YEAR(pdate-cleared),"9999") + STRING(MONTH(pdate-cleared),"99") + STRING(DAY(pdate-cleared),"99") . 
    END.
    ELSE DO:
        ASSIGN pdate-cleared = ?.
        ASSIGN pdate-cleared-txt = "". 
    END.


    IF gi_data_banks.amt-cr > 0 THEN DO:
        ASSIGN 
            pledgeramount-debit1  = /*3838.39 * -1*/ ptran-amt * -1
            .
        PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
        PUT UNFORMATTED "       <NARRATION>" pledgernarration "</NARRATION>" SKIP.
        PUT UNFORMATTED "       <LEDGERNAME>" pledgername-debit1 "</LEDGERNAME>" SKIP.                  
        PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>" SKIP.
        PUT UNFORMATTED "       <AMOUNT>" pledgeramount-debit1 "</AMOUNT>" SKIP.                        
        PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.


        ASSIGN
            pledgeramount-credit1  = /*4299.00*/ ptran-amt
         .


        PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
        PUT UNFORMATTED "       <NARRATION>" pledgernarration "</NARRATION>" SKIP.
        PUT UNFORMATTED "       <LEDGERNAME>" pledgername-credit1 "</LEDGERNAME>" SKIP.                 
        PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>" SKIP.
        PUT UNFORMATTED "       <AMOUNT>" pledgeramount-credit1  "</AMOUNT>" SKIP.                      
        PUT UNFORMATTED "       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>" SKIP.
        PUT UNFORMATTED "       <BANKALLOCATIONS.LIST>" SKIP.
        PUT UNFORMATTED "        <DATE>" pvoucherdate-txt "</DATE>" SKIP.                               
        PUT UNFORMATTED "        <INSTRUMENTDATE>" pchequedate-txt "</INSTRUMENTDATE>" SKIP.            
        /*PUT UNFORMATTED "        <BANKERSDATE>" pdate-cleared-txt  "</BANKERSDATE>" SKIP.*/
        PUT UNFORMATTED "        <INSTRUMENTNUMBER>" pchequenumber "</INSTRUMENTNUMBER>" SKIP.
        
        PUT UNFORMATTED "        <NAME>80b5ca2c-72d1-4faa-95dc-7f18b275579c</NAME>" SKIP.
        
        PUT UNFORMATTED "        <TRANSACTIONTYPE>Cheque</TRANSACTIONTYPE>" SKIP.                       
        PUT UNFORMATTED "        <PAYMENTFAVOURING>" ppaymentfovouring "</PAYMENTFAVOURING>" SKIP.      
        PUT UNFORMATTED "        <CHEQUECROSSCOMMENT>A/c Payee</CHEQUECROSSCOMMENT>" SKIP.              
        PUT UNFORMATTED "        <UNIQUEREFERENCENUMBER>4rHnRatSlmtwZwWR</UNIQUEREFERENCENUMBER>" SKIP.
        PUT UNFORMATTED "        <STATUS>No</STATUS>" SKIP.
        PUT UNFORMATTED "        <PAYMENTMODE>Transacted</PAYMENTMODE>" SKIP.                           
        PUT UNFORMATTED "        <BANKPARTYNAME>" pbankpartyname "</BANKPARTYNAME>" SKIP.               
        PUT UNFORMATTED "        <ISCONNECTEDPAYMENT>No</ISCONNECTEDPAYMENT>" SKIP.
        PUT UNFORMATTED "        <ISSPLIT>No</ISSPLIT>" SKIP.
        PUT UNFORMATTED "        <ISCONTRACTUSED>No</ISCONTRACTUSED>" SKIP.
        PUT UNFORMATTED "        <ISACCEPTEDWITHWARNING>No</ISACCEPTEDWITHWARNING>" SKIP.
        PUT UNFORMATTED "        <ISTRANSFORCED>No</ISTRANSFORCED>" SKIP.
        PUT UNFORMATTED "        <AMOUNT>" pledgeramount-credit1 "</AMOUNT>" SKIP.                      
        PUT UNFORMATTED "        <CONTRACTDETAILS.LIST>        </CONTRACTDETAILS.LIST>" SKIP.
        PUT UNFORMATTED "        <BANKSTATUSINFO.LIST>        </BANKSTATUSINFO.LIST>" SKIP.
        PUT UNFORMATTED "       </BANKALLOCATIONS.LIST>" SKIP.
        PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.
    END. /* IF gi_data_banks.amt-db > 0 */


    IF gi_data_banks.amt-db > 0 THEN DO:
        ASSIGN
            pledgeramount-credit1  = /*4299.00*/ ptran-amt
         .

        PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
        PUT UNFORMATTED "       <NARRATION>" pledgernarration "</NARRATION>" SKIP.
        PUT UNFORMATTED "       <LEDGERNAME>" pledgername-credit1 "</LEDGERNAME>" SKIP.                 
        PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>" SKIP.
        PUT UNFORMATTED "       <AMOUNT>" pledgeramount-credit1  "</AMOUNT>" SKIP.                      
        PUT UNFORMATTED "       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>" SKIP.
        PUT UNFORMATTED "       <BANKALLOCATIONS.LIST>" SKIP.
        PUT UNFORMATTED "        <DATE>" pvoucherdate-txt "</DATE>" SKIP.                               
        PUT UNFORMATTED "        <INSTRUMENTDATE>" pchequedate-txt "</INSTRUMENTDATE>" SKIP.            
        PUT UNFORMATTED "        <INSTRUMENTNUMBER>" pchequenumber "</INSTRUMENTNUMBER>" SKIP.
        PUT UNFORMATTED "        <BANKERSDATE>" pdate-cleared-txt  "</BANKERSDATE>" SKIP.
        
        PUT UNFORMATTED "        <NAME>80b5ca2c-72d1-4faa-95dc-7f18b275579c</NAME>" SKIP.
        
        PUT UNFORMATTED "        <TRANSACTIONTYPE>Cheque</TRANSACTIONTYPE>" SKIP.                       
        PUT UNFORMATTED "        <PAYMENTFAVOURING>" ppaymentfovouring "</PAYMENTFAVOURING>" SKIP.      
        PUT UNFORMATTED "        <CHEQUECROSSCOMMENT>A/c Payee</CHEQUECROSSCOMMENT>" SKIP.              
        PUT UNFORMATTED "        <UNIQUEREFERENCENUMBER>4rHnRatSlmtwZwWR</UNIQUEREFERENCENUMBER>" SKIP.
        PUT UNFORMATTED "        <STATUS>No</STATUS>" SKIP.
        PUT UNFORMATTED "        <PAYMENTMODE>Transacted</PAYMENTMODE>" SKIP.                           
        PUT UNFORMATTED "        <BANKPARTYNAME>" pbankpartyname "</BANKPARTYNAME>" SKIP.               
        PUT UNFORMATTED "        <ISCONNECTEDPAYMENT>No</ISCONNECTEDPAYMENT>" SKIP.
        PUT UNFORMATTED "        <ISSPLIT>No</ISSPLIT>" SKIP.
        PUT UNFORMATTED "        <ISCONTRACTUSED>No</ISCONTRACTUSED>" SKIP.
        PUT UNFORMATTED "        <ISACCEPTEDWITHWARNING>No</ISACCEPTEDWITHWARNING>" SKIP.
        PUT UNFORMATTED "        <ISTRANSFORCED>No</ISTRANSFORCED>" SKIP.
        PUT UNFORMATTED "        <AMOUNT>" pledgeramount-credit1 "</AMOUNT>" SKIP.                      
        PUT UNFORMATTED "        <CONTRACTDETAILS.LIST>        </CONTRACTDETAILS.LIST>" SKIP.
        PUT UNFORMATTED "        <BANKSTATUSINFO.LIST>        </BANKSTATUSINFO.LIST>" SKIP.
        PUT UNFORMATTED "       </BANKALLOCATIONS.LIST>" SKIP.
        PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.
        
        ASSIGN 
            pledgeramount-debit1  = /*3838.39 * -1*/ ptran-amt * -1
            .
        PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
        PUT UNFORMATTED "       <NARRATION>" pledgernarration "</NARRATION>" SKIP.
        PUT UNFORMATTED "       <LEDGERNAME>" pledgername-debit1 "</LEDGERNAME>" SKIP.                  
        PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>" SKIP.
        PUT UNFORMATTED "       <AMOUNT>" pledgeramount-debit1 "</AMOUNT>" SKIP.                        
        PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.


    END. /* IF gi_data_banks.amt-db > 0 */



          

END. /* for each gi_data_banks */

PUT UNFORMATTED "     </VOUCHER>" SKIP.
PUT UNFORMATTED "    </TALLYMESSAGE>" SKIP.
PUT UNFORMATTED "   </REQUESTDATA>" SKIP.
PUT UNFORMATTED "  </IMPORTDATA>" SKIP.
PUT UNFORMATTED " </BODY>" SKIP.
PUT UNFORMATTED "</ENVELOPE>" SKIP.

OUTPUT CLOSE.

OS-DELETE VALUE("C:\pvr\giph\tallylib\CreateVoucher-response.txt") NO-ERROR.
OS-COMMAND SILENT VALUE("C:\pvr\giph\tallylib\CreateVoucher.BAT").
/*OS-COMMAND NO-WAIT VALUE("C:\pvr\giph\tallylib\CreateVoucher-response.txt") NO-ERROR.*/

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

PROCEDURE CreatePaymentTrans.
    PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
    PUT UNFORMATTED "       <LEDGERNAME>" pledgername-debit2 "</LEDGERNAME>" SKIP.                  
    PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>" SKIP.
    PUT UNFORMATTED "       <AMOUNT>" pledgeramount-debit2 "</AMOUNT>" SKIP.                        
    PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.
END PROCEDURE.

/*
PROCEDURE CreateAccGroup.
    PUT UNFORMATTED '     <GROUP ACTION="Create" NAME="My Debtors">' SKIP.
    PUT UNFORMATTED "      <NAME.LIST>" SKIP.
    PUT UNFORMATTED "      <NAME>My Debtors</NAME>" SKIP.
    PUT UNFORMATTED "      </NAME.LIST>" SKIP.
    PUT UNFORMATTED "      <PARENT>Accounts Receivable</PARENT>" SKIP.
    PUT UNFORMATTED "      <ISSUBLEDGER>No</ISSUBLEDGER>" SKIP.
    PUT UNFORMATTED "      <ISBILLWISEON>No</ISBILLWISEON>" SKIP.
    PUT UNFORMATTED "      <ISCOSTCENTRESON>No</ISCOSTCENTRESON>" SKIP.
    PUT UNFORMATTED "     </GROUP>" SKIP.
END PROCEDURE.

PROCEDURE CreateLedger.
    PUT UNFORMATTED '    <LEDGER NAME="cccCommunication Expenses" RESERVEDNAME="">' SKIP.
    PUT UNFORMATTED "     <CURRENCYNAME>p</CURRENCYNAME>" SKIP.
    PUT UNFORMATTED "     <PARENT>Indirect Expenses</PARENT>" SKIP.
    PUT UNFORMATTED "     <ISBILLWISEON>No</ISBILLWISEON>" SKIP.
    PUT UNFORMATTED "     <ISCOSTCENTRESON>Yes</ISCOSTCENTRESON>" SKIP.
    PUT UNFORMATTED "     <LANGUAGENAME.LIST>" SKIP.
    PUT UNFORMATTED '      <NAME.LIST TYPE="String">' SKIP.
    PUT UNFORMATTED "       <NAME>cccCommunication Expenses</NAME>" SKIP.
    PUT UNFORMATTED "      </NAME.LIST>" SKIP.
    PUT UNFORMATTED "      <LANGUAGEID> 1033</LANGUAGEID>" SKIP.
    PUT UNFORMATTED "     </LANGUAGENAME.LIST>" SKIP.
    PUT UNFORMATTED "    </LEDGER>" SKIP.
END PROCEDURE.
*/

