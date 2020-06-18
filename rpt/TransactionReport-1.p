DEF VAR pfilename AS CHAR.
DEF VAR pbank-code LIKE gi_data_banks.bank-code.
ASSIGN pfilename = "C:\pvr\giph\Account_Reports\GIPH2019.csv".

DEF VAR pdate-ini AS DATE.
DEF VAR pdate-fin AS DATE.
DEF VAR pdate-txt AS CHAR FORMAT "x(100)".

DEF VAR ptot-debit AS DEC.
DEF VAR ptot-credit AS DEC.
DEF VAR ptot-db-cr-diff AS DEC.

ASSIGN pdate-ini = 1/1/2019
       pdate-fin = 12/31/19.
ASSIGN pdate-txt = "01-Jan-2019 to 31-Dec-2019".

OUTPUT TO VALUE(pfilename).


FOR EACH gi_acc_hea WHERE gi_acc_hea.refdate >= pdate-ini
                      AND gi_acc_hea.refdate <= pdate-fin,
    EACH gi_acc_det OF gi_acc_hea
    BREAK BY gi_acc_det.acc-led-name
          BY gi_acc_hea.refdate
          BY gi_acc_hea.refnum1:
    
    FIND gi_data_banks WHERE gi_data_banks.bank-cons = gi_acc_hea.bank-cons NO-LOCK NO-ERROR.
    IF AVAILABLE gi_data_banks THEN DO:
        ASSIGN pbank-code = gi_data_banks.bank-code.
    END.
    ELSE DO:
        ASSIGN pbank-code = "".
    END.
    IF FIRST-OF(gi_acc_det.acc-led-name) THEN DO:
        
        ASSIGN ptot-debit = 0 ptot-credit = 0.

        EXPORT DELIMITER "," "Account Analysis".
        EXPORT DELIMITER "," "Period Cowering " + pdate-txt.
        EXPORT "".
        EXPORT DELIMITER "," "Account: " gi_acc_det.acc-led-name.
        EXPORT "".
        EXPORT "".
        EXPORT "".

        EXPORT DELIMITER ","
            "Ref. No" 
            "Ref No 2" 
            "Date" 
            "Vch.Type" 
            "Party" 
            "Chq Num"
            "Particulars" 
            "Currency"
            "Debit"
            "Credit"
            "RunBal1"
            "Alias"
            "VchId"
            "BankCode"
            "BankCons"
                .
        EXPORT "".

    END.
    ASSIGN ptot-debit = ptot-debit + gi_acc_det.debit.
    ASSIGN ptot-credit = ptot-credit + gi_acc_det.credit.


    EXPORT DELIMITER ","
        gi_acc_hea.refnum1 
        gi_acc_hea.refnum2 
        gi_acc_hea.refdate 
        gi_acc_hea.vouchertype 
        gi_acc_det.partyname 
        gi_acc_det.cheque-num 
        gi_acc_hea.particulars 
        gi_acc_det.currency
        gi_acc_det.debit 
        gi_acc_det.credit 
        gi_acc_det.runbal1 
        gi_acc_det.alias-name 
        gi_acc_hea.LastVchId
        pbank-code
        gi_acc_hea.bank-cons

        .
    IF LAST-OF(gi_acc_det.acc-led-name) THEN DO:
        ASSIGN ptot-db-cr-diff = ptot-debit - ptot-credit.
        EXPORT "".
        EXPORT DELIMITER "," 
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            "Total"
            ptot-debit
            ptot-credit
            ptot-db-cr-diff
            .
        EXPORT "".
        EXPORT "".
        EXPORT "".
        EXPORT DELIMITER "," "Report:".
        EXPORT "".
        EXPORT "".

    END.

END.
OUTPUT CLOSE.
MESSAGE "report generated"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.



