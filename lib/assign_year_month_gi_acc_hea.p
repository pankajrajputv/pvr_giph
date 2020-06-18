FOR EACH gi_acc_hea,
    EACH gi_acc_det OF gi_acc_hea:
    ASSIGN gi_acc_hea.YearMonth = STRING(YEAR(gi_acc_hea.refdate),"9999") + "-" + STRING(MONTH(gi_acc_hea.refdate),"99"). 
    ASSIGN gi_acc_det.YearMonth = gi_acc_hea.YearMonth. 

    IF DAY(gi_acc_hea.refdate) >= 1 AND DAY(gi_acc_hea.refdate) <= 15 THEN DO:
        ASSIGN gi_acc_hea.YearMonthFN = gi_acc_hea.YearMonth + "-" + "01".
        ASSIGN gi_acc_det.YearMonthFN = gi_acc_hea.YearMonthFn.
    END.
    IF DAY(gi_acc_hea.refdate) >= 16 AND DAY(gi_acc_hea.refdate) <= 31 THEN DO:
        ASSIGN gi_acc_hea.YearMonthFN = gi_acc_hea.YearMonth + "-" + "02".
        ASSIGN gi_acc_det.YearMonthFN = gi_acc_hea.YearMonthFn.
    END.


END.
MESSAGE "finished"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
