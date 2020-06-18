DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF VAR n AS INT. 

FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
                         AND gi_data_banks.bank-cons >= pbank-cons-ini
                         AND gi_data_banks.bank-cons <= pbank-cons-fin:


    IF gi_data_banks.tran-refnum1 = "" THEN DO:
        n = 0.
        FOR EACH gi_acc_det WHERE gi_acc_det.refnum1 = gi_data_banks.refnum1
                              AND gi_acc_det.acc-led-name = gi_data_banks.bank-des:
            ASSIGN gi_data_banks.has-tran = TRUE.
            ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
            n = n + 1.
        END. /* for each gi_acc_det */
        IF gi_data_banks.tran-refnum1 = "" THEN DO:
            FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = gi_data_banks.bank-des
                                  AND (gi_acc_det.debit = gi_data_bank.amt-cr 
                                       OR gi_acc_det.credit = gi_data_bank.amt-db)
                                  AND gi_acc_det.refdate = gi_data_banks.date-cleared:
                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                n = n + 1.
            END. /* for each gi_acc_det */
        END.

    END. /* IF refnum1 <> "" */

        
END.


    /*
    IF gi_data_banks.refnum1 =  THEN
    FOR EACH gi_acc_det WHERE gi_acc_det.refdate = gi_data_banks.date-cleared
                          AND gi_acc_det.acc-led-name = gi_data_banks.bank-des
                          AND gi_acc_det.amount = ptran-amount NO-LOCK
    BREAK BY gi_acc_det.refdate 
        
        
    END.
    */
