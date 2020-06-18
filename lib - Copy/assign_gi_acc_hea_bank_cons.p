
    /*
FOR EACH gi_acc_hea WHERE gi_acc_hea.bank-cons = 0.

    FIND FIRST gi_bank_data WHERE gi_bank_data
   FOR EACH gi_acc_det OF gi_acc_hea /*WHERE gi_acc_det.bank-cons > 0*/:
       MESSAGE gi_acc_det.bank-cons
           VIEW-AS ALERT-BOX INFO BUTTONS OK.
       /*ASSIGN gi_acc_hea.bank-cons = gi_acc_det.bank-cons.*/
   END.
END. /* for each ig_Acc_hea */
*/

FOR EACH gi_data_banks WHERE gi_data_banks.tran-refnum1 <> "":
    FIND gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_data_banks.tran-refnum1 NO-ERROR.
    IF AVAILABLE gi_acc_hea /*AND gi_acc_hea.bank-cons = 0*/ THEN DO:
        ASSIGN gi_acc_hea.bank-cons = gi_data_banks.bank-cons.
    END.
END.
