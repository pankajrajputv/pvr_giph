FOR EACH gi_acc_hea_temp:
    FIND gi_acc_hea WHERE gi_Acc_hea.refnum1 = gi_acc_hea_temp.refnum1 NO-ERROR.
    IF AVAILABLE gi_acc_hea THEN DO:
        ASSIGN gi_Acc_hea.lastvchid = gi_acc_hea_temp.lastvchid
               gi_acc_hea.tally-response = gi_acc_hea_temp.tally-response
            .
        MESSAGE gi_Acc_hea.lastvchid. PAUSE 0.

    END.

END.
