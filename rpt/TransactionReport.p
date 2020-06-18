DEF VAR pfilename AS CHAR.
DEF VAR pbank-code LIKE gi_data_banks.bank-code.
ASSIGN pfilename = "C:\pvr\giph\Account_Reports\GI-Accounts-2.csv".

OUTPUT TO VALUE(pfilename).

EXPORT DELIMITER ","
    "Vch.Type" 
    "Date" 
    "Ref. No" 
    "Ref No 2" 
    "Particulars" 
    "DbCrDff"
    "Ledger" 
    "Debit"
    "Credit"
    "BankCode"
    "BankCons"
    "Party" 
    "Alias"
    "Chq Num"
        .

FOR EACH gi_acc_hea,
    EACH gi_acc_det OF gi_acc_hea
    BREAK BY gi_acc_hea.vouchertype
          BY gi_acc_hea.refdate
          BY gi_acc_hea.refnum1:
    
    ASSIGN pbank-code = "".

    FIND gi_data_banks WHERE gi_data_banks.bank-cons = gi_acc_det.bank-cons NO-LOCK NO-ERROR.
    IF AVAILABLE gi_data_banks THEN DO:
        ASSIGN pbank-code = gi_data_banks.bank-code.
    END.

    EXPORT DELIMITER ","
        gi_acc_hea.vouchertype 
        gi_acc_hea.refdate 
        gi_acc_hea.refnum1 
        gi_acc_hea.refnum2 
        gi_acc_hea.particulars 
        gi_acc_hea.dbcr-diff
        gi_acc_det.acc-led-name 
        gi_acc_det.debit 
        gi_acc_det.credit 
        pbank-code
        gi_acc_det.bank-cons
        gi_acc_det.partyname 
        gi_acc_det.alias-name 
        gi_acc_det.cheque-num 

        .

END.
OUTPUT CLOSE.
MESSAGE "report generated"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.


