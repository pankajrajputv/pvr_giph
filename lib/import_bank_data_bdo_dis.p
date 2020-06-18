DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pbank-cons AS INT.
DEF VAR pbank-reg AS INT.
DEF VAR pbank-code AS CHAR. 
DEF VAR pbank-des AS CHAR. 
DEF VAR pbank-code1 AS CHAR. 

DEF BUFFER b_gi_data_banks FOR gi_data_banks.
DEF TEMP-TABLE tt_gi_data_banks LIKE gi_data_banks.

ASSIGN pbank-code = "BDO_DISBURSEMENT".
ASSIGN pbank-des = "BDO S/A PHP 260116895".
ASSIGN pbank-code1 = "Data_" +  pbank-code.
ASSIGN pfilename-import = "C:\pvr\giph\tempdata-BankStatements\" + pbank-code1 + ".csv".
MESSAGE "Deleting bank data". PAUSE 1.

/* delete bank data */
FOR EACH gi_data_banks WHERE gi_data_banks.bank-cod = pbank-code: 
    DELETE gi_data_banks. 
END.


FIND LAST b_gi_data_banks USE-INDEX idx NO-LOCK NO-ERROR.
IF AVAILABLE b_gi_data_banks THEN DO:
    ASSIGN pbank-cons = b_gi_data_banks.bank-cons.
END.

MESSAGE "Importing raw data". PAUSE 1.
ASSIGN pbank-reg = 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    pbank-cons = pbank-cons + 1.
    pbank-reg = pbank-reg + 1.
    CREATE tt_gi_data_banks.
    ASSIGN tt_gi_data_banks.bank-cons = pbank-cons
           tt_gi_data_banks.bank-reg  = pbank-reg
           tt_gi_data_banks.bank-code = pbank-code
           tt_gi_data_banks.bank-des = pbank-des
           .
    IMPORT DELIMITER ","
        tt_gi_data_banks.date-cleared
        tt_gi_data_banks.branch 
        tt_gi_data_banks.description 
        tt_gi_data_banks.amt-db 
        tt_gi_data_banks.amt-cr 
        tt_gi_data_banks.amt-bal 
        tt_gi_data_banks.remarks 
        tt_gi_data_banks.ch-num 
        tt_gi_data_banks.refnum1 
        tt_gi_data_banks.refnum1a 
        tt_gi_data_banks.acc-origin 
        tt_gi_data_banks.acc-destination 
        tt_gi_data_banks.acc-receiver 
        tt_gi_data_banks.acc-payer 
        tt_gi_data_banks.narration 
        tt_gi_data_banks.date-issue
        tt_gi_data_banks.ledger-db
        tt_gi_data_banks.ledger-cr

        NO-ERROR.


    MESSAGE pbank-reg. PAUSE 0.
END.
INPUT CLOSE.
MESSAGE "Finished raw data import". PAUSE 0.


FOR EACH tt_gi_data_banks:
   /* ASSIGN tt_gi_data_banks.amt-db = tt_gi_data_banks.amt-db * - 1.*/

    ASSIGN tt_gi_data_banks.YearMonth = STRING(YEAR(tt_gi_data_banks.date-cleared),"9999") + "-" + STRING(MONTH(tt_gi_data_banks.date-cleared),"99") .

    IF DAY(tt_gi_data_banks.date-cleared) >= 1 AND DAY(tt_gi_data_banks.date-cleared) <= 15 THEN DO:
        ASSIGN tt_gi_data_banks.YearMonthFN = tt_gi_data_banks.YearMonth + "-" + "01".
    END.
    IF DAY(tt_gi_data_banks.date-cleared) >= 16 AND DAY(tt_gi_data_banks.date-cleared) <= 31 THEN DO:
        ASSIGN tt_gi_data_banks.YearMonthFN = tt_gi_data_banks.YearMonth + "-" + "02".
    END.

    CREATE gi_data_banks.
    ASSIGN gi_data_banks.bank-cons = pbank-cons.
    BUFFER-COPY tt_gi_data_banks TO gi_data_banks .

END.
EMPTY TEMP-TABLE tt_gi_data_banks.


/*
gi_data_banks.account-name 
gi_data_banks.account-number 
gi_data_banks.alias-name 
gi_data_banks.date-issued
gi_data_banks.LastVchId 
gi_data_banks.narrative 
gi_data_banks.rate-exchange 
gi_data_banks.recon-date 
gi_data_banks.recon-status 
gi_data_banks.sba-num 
gi_data_banks.servicing 
gi_data_banks.supplier-name 
gi_data_banks.tran-code 
*/
