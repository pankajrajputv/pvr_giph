DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF VAR n AS INT.

DEF SHARED VAR pbank-des LIKE gi_data_banks.bank-des.


IF pbank-cons-ini = 1 AND pbank-cons-fin = 999999999 THEN DO:
    
    FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = pbank-des:
        ASSIGN gi_acc_det.bank-cons = 0.
        FIND gi_acc_hea OF gi_acc_det NO-ERROR.
        IF AVAILABLE gi_acc_hea THEN DO:
            ASSIGN gi_acc_hea.bank-cons = gi_acc_det.bank-cons.
        END.
    END.
    FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code:
        ASSIGN gi_data_banks.has-tran = FALSE.
        ASSIGN gi_data_banks.tran-refnum1 = "".

    END.
END.


/*
DEF SHARED VAR pbank-cons LIKE gi_data_banks.bank-cons. 
IF pbank-cons = 0 THEN DO:
    MESSAGE "Bank cons is zero"
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
    RETURN NO-APPLY.
END.
MESSAGE pbank-cons
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
  */
FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
                         AND gi_data_banks.bank-cons >= pbank-cons-ini
                         AND gi_data_banks.bank-cons <= pbank-cons-fin
    :

    ASSIGN gi_data_banks.other-account = gi_data_banks.ledger-db.
    IF gi_data_banks.other-account = gi_data_banks.bank-des THEN DO:
        ASSIGN gi_data_banks.other-account = gi_data_banks.ledger-cr.
    END.
    IF gi_data_banks.other-account = gi_data_banks.bank-des THEN DO:
        ASSIGN gi_data_banks.other-account = gi_data_banks.ledger-db.
    END.

    n = 0.
    FOR EACH gi_acc_det WHERE gi_acc_det.refnum1 = gi_data_banks.refnum1
                          AND gi_acc_det.acc-led-name = gi_data_banks.bank-des:

        ASSIGN gi_data_banks.has-tran = TRUE.
        ASSIGN gi_data_banks.tran-refnum1 = gi_data_banks.refnum1.
        n = n + 1.
        FIND gi_acc_hea OF gi_acc_det NO-ERROR.
        IF AVAILABLE gi_acc_hea THEN DO:
            ASSIGN gi_acc_hea.bank-cons = gi_acc_det.bank-cons.
        END.
        
    END. /* for each gi_acc_det */

    IF n = 0 THEN DO:
        IF gi_data_bank.amt-cr > 0 THEN DO:
            FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = gi_data_banks.bank-des
                                  AND gi_acc_det.debit        = gi_data_bank.amt-cr
                                  AND gi_acc_det.refdate      = gi_data_banks.date-cleared
                                  AND gi_acc_det.bank-cons    = 0:
                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                ASSIGN gi_acc_det.bank-cons = gi_data_banks.bank-cons.
                FIND gi_acc_hea OF gi_acc_det NO-ERROR.
                IF AVAILABLE gi_acc_hea THEN DO:
                    ASSIGN gi_acc_hea.bank-cons = gi_acc_det.bank-cons.
                END.
                LEAVE.
            END. /* for each gi_acc_det */
        END.
        IF gi_data_bank.amt-db > 0 THEN DO:
            FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = gi_data_banks.bank-des
                                  AND gi_acc_det.credit        = gi_data_bank.amt-db
                                  AND gi_acc_det.refdate      = gi_data_banks.date-cleared
                                  AND gi_acc_det.bank-cons    = 0:
                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                ASSIGN gi_acc_det.bank-cons = gi_data_banks.bank-cons.
                FIND gi_acc_hea OF gi_acc_det NO-ERROR.
                IF AVAILABLE gi_acc_hea THEN DO:
                    ASSIGN gi_acc_hea.bank-cons = gi_acc_det.bank-cons.
                END.
                LEAVE.
            END. /* for each gi_acc_det */
        END.
    END.


    /*
    IF gi_data_banks.refnum1 =  THEN
    FOR EACH gi_acc_det WHERE gi_acc_det.refdate = gi_data_banks.date-cleared
                          AND gi_acc_det.acc-led-name = gi_data_banks.bank-des
                          AND gi_acc_det.amount = ptran-amount NO-LOCK
    BREAK BY gi_acc_det.refdate 
        
        
    END.
    */
        
END.
