DEF VAR ptot-amount LIKE gi_acc_hea.amount.
DEF VAR ptot-credit LIKE gi_acc_hea.credit. 
DEF VAR ptot-debit  LIKE gi_acc_hea.debit. 
DEF VAR ptexto LIKE gi_acc_hea.particulars.

DEF TEMP-TABLE tt_gi_acc_hea LIKE gi_acc_hea.
EMPTY TEMP-TABLE tt_gi_acc_hea.

DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.
DEF BUFFER b_gi_acc_det FOR gi_acc_det.

DEF VAR preg AS INT.
DEF VAR n AS INT.
    
DEF VAR pdatetime AS CHAR.
ASSIGN pdatetime = STRING(TODAY,"99999999") + "_" + REPLACE(STRING(TIME,"HH:MM:SS"),":","").

DEF VAR pfilename AS CHAR.
ASSIGN pfilename = "C:\temp\gi_acc_hea_" + pdatetime + ".txt".
OUTPUT TO VALUE(pfilename).
    EXPORT DELIMITER "^"
        "refnum1"
        "vouchertype"
        "refdate"
        "refnum2"
        "IsContra"
        "IsJV"
        "IsReceipt"
        "IsPayment"
        "IsPurchase"
        "IsSales"
        "particulars"
        "debit"
        "credit"
        "dbcr-diff"
        "amount"
        "VchId"
        "YearMonth"
        "YearMonthFN"
        "BankCons"
        .

FOR EACH gi_acc_hea:
    CREATE tt_gi_acc_hea.
    BUFFER-COPY gi_acc_hea TO tt_gi_acc_hea.

    ASSIGN 
        gi_acc_hea.particulars  = REPLACE(gi_acc_hea.particulars ,"~r"," /// ") /* strip cr */
        gi_acc_hea.particulars  = REPLACE(gi_acc_hea.particulars ,"~n"," /// ") /* strip lf */.

    EXPORT DELIMITER "^"
        gi_acc_hea.refnum1 
        gi_acc_hea.vouchertype
        gi_acc_hea.refdate 
        gi_acc_hea.refnum2 
        gi_acc_hea.IsContra 
        gi_acc_hea.IsJV 
        gi_acc_hea.IsReceipt 
        gi_acc_hea.IsPayment 
        gi_acc_hea.IsPurchase 
        gi_acc_hea.IsSales 
        gi_acc_hea.particulars 
        gi_acc_hea.debit 
        gi_acc_hea.credit 
        gi_acc_hea.dbcr-diff 
        gi_acc_hea.amount 
        gi_acc_hea.lastvchid
        gi_acc_hea.yearmonth
        gi_acc_hea.yearmonthFN
        gi_acc_hea.bank-cons
         .

END.
OUTPUT CLOSE.




FOR EACH gi_acc_hea: DELETE gi_acc_hea. END.
FOR EACH gi_acc_det: DELETE gi_Acc_det. END.

FOR EACH gi_rawdata BREAK BY gi_rawdata.refnum1 :

    ASSIGN gi_rawdata.particulars  = REPLACE(gi_rawdata.particulars ,"~r"," /// ") /* strip cr */.
           gi_rawdata.particulars  = REPLACE(gi_rawdata.particulars ,"~n"," /// ") /* strip lf */.

    ASSIGN n = n + 1.
    IF FIRST-OF(gi_rawdata.refnum1) THEN DO:
        FOR EACH b_gi_acc_hea WHERE b_gi_acc_hea.refnum1 = gi_rawdata.refnum1:
            DELETE b_gi_acc_hea.
        END.
        FOR EACH b_gi_acc_det WHERE b_gi_acc_det.refnum1 = gi_rawdata.refnum1:
            DELETE b_gi_acc_det.
        END.

        ASSIGN ptot-amount = 0
               ptot-credit = 0
               ptot-debit  = 0
               preg        = 0.

        CREATE gi_acc_hea.
        ASSIGN gi_acc_hea.refnum1     = gi_rawdata.refnum1.
        ASSIGN gi_acc_hea.particulars = gi_rawdata.particulars
               gi_acc_hea.refdate     = gi_rawdata.refdate
               gi_acc_hea.refnum1     = gi_rawdata.refnum1
               gi_acc_hea.refnum2     = gi_rawdata.refnum2
            .

        RELEASE gi_acc_hea.
    END.
    IF n = 10000 THEN DO:
        MESSAGE gi_rawdata.cons. PAUSE 1.
        ASSIGN n = 0.
    END.

    FIND b_gi_acc_hea WHERE b_gi_acc_hea.refnum1 = gi_rawdata.refnum1 NO-ERROR.
    IF AVAILABLE b_gi_acc_hea THEN DO:
        ASSIGN ptot-amount = ptot-amount + gi_rawdata.amount
               ptot-credit = ptot-credit + gi_rawdata.credit 
               ptot-debit  = ptot-debit  + gi_rawdata.debit. 
    END.

    ASSIGN preg = preg + 1.
    CREATE gi_acc_det.
    ASSIGN gi_acc_det.refnum1 = gi_rawdata.refnum1
           gi_acc_det.reg = preg.
        .
    BUFFER-COPY gi_rawdata EXCEPT refnum1 
        TO gi_acc_det.

    IF LAST-OF(gi_rawdata.refnum1) THEN DO:
        FIND b_gi_acc_hea WHERE b_gi_acc_hea.refnum1 = gi_rawdata.refnum1 NO-ERROR.
        IF AVAILABLE b_gi_acc_hea THEN DO:
            ASSIGN b_gi_acc_hea.amount = ptot-amount
                   b_gi_acc_hea.credit = ptot-credit
                   b_gi_acc_hea.debit  = ptot-debit.
            ASSIGN b_gi_acc_hea.dbcr-diff = b_gi_acc_hea.debit - b_gi_acc_hea.credit.
        END.
    END.


END. /* for each gi_rawdata */


FOR EACH gi_acc_hea:
    FIND tt_gi_acc_hea WHERE tt_gi_acc_hea.refnum1 = gi_acc_hea.refnum1 NO-LOCK NO-ERROR.
    IF tt_gi_acc_hea.amount = gi_acc_hea.amount THEN DO:
        ASSIGN gi_acc_hea.Lastvchid = tt_gi_acc_hea.Lastvchid.
        ASSIGN gi_acc_hea.Bank-Cons = tt_gi_acc_hea.bank-cons.
    END.
END.

MESSAGE "Creating Data ended"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

    /*
    ASSIGN 
        gi_acc_det.refdate 
        gi_acc_det.refnum2 
        gi_acc_det.partyname 
        gi_acc_det.particulars 
        gi_acc_det.currency 
        gi_acc_det.amount 
        gi_acc_det.debit 
        gi_acc_det.credit 
        gi_acc_det.runbal1 
        gi_acc_det.runbal2
        gi_acc_det.report-txt 
        gi_acc_det.amt1 
        gi_acc_det.amt2 
        gi_acc_det.amt3 
        gi_acc_det.amt4 
        gi_acc_det.reg 
        gi_acc_det.report-txt2 

      */




