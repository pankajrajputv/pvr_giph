DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.
DEF BUFFER b_gi_acc_det FOR gi_acc_det.


FOR EACH b_gi_acc_hea :
    ASSIGN b_gi_acc_hea.refnum1-clean = REPLACE(b_gi_acc_hea.refnum1," ","").
END.

FOR EACH b_gi_acc_det:
    ASSIGN b_gi_acc_det.refnum1-clean = REPLACE(b_gi_acc_det.refnum1," ","").
END.

MESSAGE "Process Ended"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
