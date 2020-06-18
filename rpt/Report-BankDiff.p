DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF SHARED VAR pbank-des LIKE gi_data_banks.bank-des.
DEF SHARED VAR preport-type AS INT.
DEF VAR pfilename AS CHAR FORMAT "x(200)".
DEF VAR pdate AS DATE.

IF preport-type = 1 THEN
ASSIGN pfilename = "C:\pvr\giph\Bank_Reports\" + pbank-code + "_Diff.csv".

IF preport-type = 9 THEN
ASSIGN pfilename = "C:\pvr\giph\Bank_Reports\" + "AllBanks" + "_Diff.csv".

OUTPUT TO VALUE(pfilename).
EXPORT DELIMITER ","
    "Code"
    "Month"
    "Date"
    "Bank Debit"
    "Trans Credit"
    "Diff Debit"
    "Bank Credit"
    "Trans Debit"
    "Diff Credit"
    "USD-Debit"
    "USD-Credit"
.
 FOR EACH gi_banks_diff WHERE 
     (preport-type = 1 AND gi_banks_diff.bank-code = pbank-code) OR
     (preport-type = 9 AND gi_banks_diff.bank-code <> ""):     
     EXPORT DELIMITER ","
        gi_banks_diff.bank-code 
        gi_banks_diff.yearmonth
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

OS-COMMAND NO-WAIT VALUE(pfilename).


