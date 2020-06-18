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

DEF VAR pcashbankledger AS CHAR.
DEF VAR peffectivedate AS DATE.
DEF VAR peffectivedate-txt AS CHAR.

DEF VAR pchequedate AS DATE.
DEF VAR pchequedate-txt AS CHAR.
DEF VAR ppaymentfovouring AS CHAR.
DEF VAR pbankpartyname AS CHAR.

DEF VAR palterid AS CHAR.
DEF VAR pmasterid AS CHAR.
DEF VAR pvoucherkey AS CHAR.

ASSIGN pacc-group-name = "My Debtors".
ASSIGN pacc-group-parent-name = "Accounts Receivable".

ASSIGN pacc-ledger-name = "Communication Expenses".
ASSIGN pacc-ledger-parent-name = "Indirect Expenses".

ASSIGN pfilename-xml = "C:\pvr\giph\tallylib\CreateVoucher.xml".


ASSIGN pvouchertype         = "Payment"
       pvouchernumber       = "CDV36462"
       pvoucherdate         = 10/31/19
       peffectivedate       = 10/31/19
       pchequedate          = 10/31/19
       pvoucherdate-txt     = STRING(YEAR(pvoucherdate),"9999") + STRING(MONTH(pvoucherdate),"99") + STRING(DAY(pvoucherdate),"99") 
       peffectivedate-txt   = STRING(YEAR(peffectivedate),"9999") + STRING(MONTH(peffectivedate),"99") + STRING(DAY(peffectivedate),"99") 
       pchequedate-txt      = STRING(YEAR(peffectivedate),"9999") + STRING(MONTH(peffectivedate),"99") + STRING(DAY(peffectivedate),"99") 
       ppartyledgername     = "UCPB C/A PHP 201120001328"
       pnarration           = "cdv36461 - PLDT"

/*   
       pvchkey              = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00000052:000001d6"
       
       pguid                = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00000052"
       premoteid            = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00000052"
       */
      
       pvchkey              = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00036462:000001d6"
       pguid                = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00036462"
       premoteid            = "a9545bdc-3762-40ba-8917-ec660dcacc0e-00036462"


       pcashbankledger      = "UCPB C/A PHP 201120001328"
       palterid             = " 169"
       pmasterid            = " 82"
       pvoucherkey          = "187982128611798"


       pledgername-debit1    = "Communication Expenses"
       pledgeramount-debit1  = 3838.39 * -1
       
       pledgername-debit2    = "Input Vat @ 12%"
       pledgeramount-debit2  = 460.61 * -1

       pledgername-debit3    = ""
       pledgeramount-debit3  = 0
       pledgername-debit4    = ""
       pledgeramount-debit4  = 0
       pledgername-debit5    = ""
       pledgeramount-debit5  = 0


       pledgername-credit1    = "UCPB C/A PHP 201120001328"
       pledgeramount-credit1  = 4299.00
       ppaymentfovouring      = "Communication Expenses"
       pbankpartyname         = "Communication Expenses"
       pledgername-credit2    = ""
       pledgeramount-credit2  = 0
       pledgername-credit3    = ""
       pledgeramount-credit3  = 0
       pledgername-credit4    = ""
       pledgeramount-credit4  = 0
       pledgername-credit5    = ""
       pledgeramount-credit5  = 0

       pvouchertotalamount  = 0

    .
    


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
    
    /*
    RUN CreateAccGroup.
    RUN CreateLedger.
    */
    RUN CreatePaymentTrans.
    
    PUT UNFORMATTED "    </TALLYMESSAGE>" SKIP.
    PUT UNFORMATTED "   </REQUESTDATA>" SKIP.
    PUT UNFORMATTED "  </IMPORTDATA>" SKIP.
    PUT UNFORMATTED " </BODY>" SKIP.
    PUT UNFORMATTED "</ENVELOPE>" SKIP.

OUTPUT CLOSE.

OS-DELETE VALUE("C:\pvr\giph\tallylib\CreateVoucher-response.txt") NO-ERROR.
OS-COMMAND SILENT VALUE("C:\pvr\giph\tallylib\CreateVoucher.BAT").
OS-COMMAND NO-WAIT VALUE("C:\pvr\giph\tallylib\CreateVoucher-response.txt") NO-ERROR.

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

    PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
    PUT UNFORMATTED "       <LEDGERNAME>" pledgername-debit1 "</LEDGERNAME>" SKIP.                  
    PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>" SKIP.
    PUT UNFORMATTED "       <AMOUNT>" pledgeramount-debit1 "</AMOUNT>" SKIP.                        
    PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.

    PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
    PUT UNFORMATTED "       <LEDGERNAME>" pledgername-debit2 "</LEDGERNAME>" SKIP.                  
    PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>" SKIP.
    PUT UNFORMATTED "       <AMOUNT>" pledgeramount-debit2 "</AMOUNT>" SKIP.                        
    PUT UNFORMATTED "      </ALLLEDGERENTRIES.LIST>" SKIP.

    PUT UNFORMATTED "      <ALLLEDGERENTRIES.LIST>" SKIP.
    PUT UNFORMATTED "       <LEDGERNAME>" pledgername-credit1 "</LEDGERNAME>" SKIP.                 
    PUT UNFORMATTED "       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>" SKIP.
    PUT UNFORMATTED "       <AMOUNT>" pledgeramount-credit1  "</AMOUNT>" SKIP.                      
    PUT UNFORMATTED "       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>" SKIP.
    PUT UNFORMATTED "       <BANKALLOCATIONS.LIST>" SKIP.
    PUT UNFORMATTED "        <DATE>" pvoucherdate-txt "</DATE>" SKIP.                               
    PUT UNFORMATTED "        <INSTRUMENTDATE>" pchequedate-txt "</INSTRUMENTDATE>" SKIP.            
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

    PUT UNFORMATTED "     </VOUCHER>" SKIP.

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

/************




************/
