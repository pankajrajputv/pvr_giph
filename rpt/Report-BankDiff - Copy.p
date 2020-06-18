DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF SHARED VAR pbank-des LIKE gi_data_banks.bank-des.
DEF VAR pfilename AS CHAR FORMAT "x(200)".
DEF VAR pdate AS DATE.

/*
DEF VAR pbank-code AS CHAR. 
DEF VAR pbank-des AS CHAR. 
DEF VAR pdate AS DATE.
*/

/*
DEF TEMP-TABLE det
    FIELD bank-code LIKE gi_data_banks.bank-code
    FIELD bank-des  LIKE gi_data_banks.bank-des
    FIELD YearMonth LIKE gi_data_banks.YearMonth
    FIELD date-cleared AS DATE
    FIELD amt-db LIKE gi_data_banks.amt-db
    FIELD amt-cr LIKE gi_data_banks.amt-cr
    FIELD debit LIKE gi_acc_gi_banks_diff.debit
    FIELD credit LIKE gi_acc_gi_banks_diff.credit
    FIELD diff-debit AS DECIMAL
    FIELD diff-credit AS DECIMAL

    INDEX idx AS PRIMARY UNIQUE bank-code date-cleared.
  */  

/*
FOR EACH gi_banks: DELETE gi_banks. END.
FOR EACH gi_data_banks BREAK BY gi_data_banks.bank-code:
    IF FIRST-OF(gi_data_banks.bank-code) THEN DO:
        CREATE gi_banks.
        ASSIGN gi_banks.bank-code = gi_data_banks.bank-code.
        ASSIGN gi_banks.bank-des = gi_data_banks.bank-des.
    END.
END.
ASSIGN pbank-code = "BDO_DOLLAR".
ASSIGN pbank-des = "BDO S/A USD".
  */

ASSIGN pfilename = "c:\temp\" + pbank-code + "-bank-diff.csv".

FOR EACH gi_banks_diff:
    DELETE gi_banks_diff.
END.

/*DO pdate = 1/1/19 TO 12/31/19:*/
DO pdate = 5/9/19 TO 5/9/19:
    FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code 
                             AND gi_data_banks.date-cleared = pdate NO-LOCK
            BREAK BY gi_data_banks.bank-code
                  BY gi_data_banks.date-cleared:

        FIND gi_banks_diff WHERE gi_banks_diff.bank-code = pbank-code
                             AND gi_banks_diff.date-cleared = pdate NO-ERROR.
        IF NOT AVAILABLE gi_banks_diff THEN DO:
            CREATE gi_banks_diff.
            ASSIGN gi_banks_diff.bank-code = pbank-code
                   gi_banks_diff.bank-des = pbank-des
                   gi_banks_diff.date-cleared = gi_data_banks.date-cleared.
        END.
        
        MESSAGE  "Bank Db" gi_data_banks.amt-db "Bank USD Cr" gi_data_banks.usd-amt-cr
             "Bank Cr" gi_data_banks.amt-cr "BANK USD Db" gi_data_banks.usd-amt-db
             "Rate" gi_data_banks.rate-exchange. PAUSE 0.
          
        ASSIGN gi_banks_diff.amt-db = gi_banks_diff.amt-db + gi_data_banks.amt-db.
        ASSIGN gi_banks_diff.amt-cr = gi_banks_diff.amt-cr + gi_data_banks.amt-cr.

        ASSIGN gi_banks_diff.usd-amt-db = gi_banks_diff.usd-amt-db + gi_data_banks.usd-amt-db.
        ASSIGN gi_banks_diff.usd-amt-cr = gi_banks_diff.usd-amt-cr + gi_data_banks.usd-amt-cr.


    END. /* for each gi_data_banks.*/

    FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = pbank-des
                          AND gi_acc_det.refdate      = pdate NO-LOCK:

        FIND gi_banks_diff WHERE gi_banks_diff.bank-code    = pbank-code
                             AND gi_banks_diff.date-cleared = pdate NO-ERROR.
        IF NOT AVAILABLE gi_banks_diff THEN DO:
            CREATE gi_banks_diff.
            ASSIGN gi_banks_diff.bank-code    = pbank-code
                   gi_banks_diff.bank-des = pbank-des
                   gi_banks_diff.date-cleared = pdate.
        END.

        ASSIGN gi_banks_diff.debit  = gi_banks_diff.debit  + gi_acc_det.debit.
        ASSIGN gi_banks_diff.credit = gi_banks_diff.credit + gi_acc_det.credit.
        /*
        IF gi_acc_det.refdate = 1/25/19 THEN DO:
            MESSAGE gi_acc_det.cons gi_acc_det.refdate gi_acc_det.acc-led-name gi_acc_det.debit gi_acc_det.credit. PAUSE 0.
        END.
        */

    END.
    FIND gi_banks_diff WHERE gi_banks_diff.bank-code = pbank-code
                         AND gi_banks_diff.date-cleared = pdate NO-ERROR.
    IF AVAILABLE gi_banks_diff THEN DO:
        ASSIGN gi_banks_diff.diff-debit = gi_banks_diff.amt-db - gi_banks_diff.credit.
        ASSIGN gi_banks_diff.diff-credit = gi_banks_diff.amt-cr - gi_banks_diff.debit.
    END.


END.



OUTPUT TO VALUE(pfilename).
EXPORT DELIMITER ","
    "Code"
    "Description"
    "Bank Debit"
    "Trans Credit"
    "Diff Debit"
    "Bank Credit"
    "Trans Debit"
    "Diff Credit"
    "USD-Debit"
    "USD-Credit"
.
FOR EACH gi_banks_diff:
    EXPORT DELIMITER ","
        gi_banks_diff.bank-code 
        gi_banks_diff.date-cleared 
        gi_banks_diff.amt-db
        gi_banks_diff.credit
        gi_banks_diff.diff-debit
        gi_banks_diff.amt-cr
        gi_banks_diff.debit
        gi_banks_diff.diff-credit
        gi_banks_diff.usd-amt-db
        gi_banks_diff.usd-amt-cr
        .

END.
OUTPUT CLOSE.

/*
OS-COMMAND NO-WAIT VALUE(pfilename).
  */


