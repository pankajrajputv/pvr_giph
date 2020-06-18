DEF VAR ptexto LIKE gi_acc_hea.particulars.


OUTPUT TO "C:\pvr\giph\bidata\gi_acc_hea.txt".
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
        .

FOR EACH gi_acc_hea:
    ASSIGN ptexto = gi_acc_hea.particulars .
    ptexto = REPLACE(ptexto,"~r"," /// ") /* strip cr */.

    ptexto = REPLACE(ptexto,"~n"," /// ") /* strip lf */.

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
        /*gi_acc_hea.particulars */ ptexto
        gi_acc_hea.debit 
        gi_acc_hea.credit 
        gi_acc_hea.dbcr-diff 
        gi_acc_hea.amount 
        gi_acc_hea.lastvchid
        gi_acc_hea.yearmonth
        gi_acc_hea.yearmonthFN
         .

END.
OUTPUT CLOSE.

MESSAGE "finish"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
