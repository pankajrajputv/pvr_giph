DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF VAR prefnum-temp AS CHAR FORMAT "x(15)".
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

FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
                         AND gi_data_banks.bank-cons >= pbank-cons-ini
                         AND gi_data_banks.bank-cons <= pbank-cons-fin:

    ASSIGN prefnum-temp = gi_data_banks.refnum1.
    IF gi_data_banks.refnum1 BEGINS "CDV" THEN DO:
        ASSIGN prefnum-temp = REPLACE(gi_data_banks.refnum1," ","").
    END.

        n = 0.
        IF gi_data_banks.refnum1 <> "" THEN DO:
            FOR EACH gi_acc_det WHERE gi_acc_det.refnum1 = prefnum-temp
                                  AND gi_acc_det.acc-led-name = gi_data_banks.bank-des:
                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                ASSIGN gi_acc_det.bank-cons = gi_data_banks.bank-cons.
                n = n + 1.
                FIND gi_acc_hea OF gi_acc_det NO-ERROR.
                IF AVAILABLE gi_acc_hea THEN DO:
                    ASSIGN gi_acc_hea.bank-cons = gi_acc_det.bank-cons.
                END.
            END. /* for each gi_acc_det */
        END.
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
        ELSE DO:
            FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = gi_data_banks.bank-des
                                  AND (
                                      (gi_data_bank.amt-cr > 0  AND gi_acc_det.debit = gi_data_bank.amt-cr)
                                       OR 
                                      (gi_data_bank.amt-db > 0 AND gi_acc_det.credit = gi_data_bank.amt-db)
                                      )
                                  AND gi_acc_det.refdate = gi_data_banks.date-cleared:
                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                n = n + 1.
            END. /* for each gi_acc_det */


        END.
        */

        
END.

RUN c:\pvr\giph\lib\auto_assign_bank_deposits.p.

/*
DEF VAR pamt-cr-bank AS DEC.
DEF VAR pamt-db-tran AS DEC.
DEF VAR pbal-amt1 AS DEC.
DEF VAR pbal-amt2 AS DEC.

DEF VAR pdate AS DATE.
DO pdate = 1/1/2019 TO 12/31/2019:
/*DO pdate = 12/3/2019 TO 12/3/2019:*/
    ASSIGN pamt-cr-bank = 0 pamt-db-tran = 0
           pbal-amt1 = 0 pbal-amt2 = 0.
    FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
        /*
                             AND gi_data_banks.bank-cons >= pbank-cons-ini
                             AND gi_data_banks.bank-cons <= pbank-cons-fin
                             */
                             AND gi_data_banks.date-cleared = pdate:
        IF gi_data_banks.tran-refnum1 = "" THEN DO:
            ASSIGN pamt-cr-bank = pamt-cr-bank + gi_data_bank.amt-cr.
        END.
    END.

    FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = pbank-des
                          AND gi_acc_det.refdate = pdate
                          AND gi_acc_det.bank-cons = 0 :
         ASSIGN pamt-db-tran = pamt-db-tran + gi_acc_det.debit.
    END. 
    MESSAGE pdate pamt-cr-bank pamt-db-tran. PAUSE 0.
    ASSIGN pbal-amt1 = pamt-cr-bank
           pbal-amt2 = pamt-cr-bank.

    IF pamt-cr-bank >= pamt-db-tran THEN DO:
        FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = pbank-des
                              AND gi_acc_det.refdate = pdate 
                              AND gi_acc_det.bank-cons = 0 :
            ASSIGN pbal-amt1 = /*pbal-amt1 -*/ gi_acc_det.debit.
            /*MESSAGE "yyy" gi_acc_det.debit pbal-amt1. PAUSE 0.*/
            a:
            FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
                                     AND gi_data_banks.date-cleared = pdate
                                     AND gi_data_banks.tran-refnum1 = ""
                                     AND gi_data_banks.amt-cr > 0:
                ASSIGN pbal-amt1 = pbal-amt1 - gi_data_banks.amt-cr.
                /*MESSAGE "zzz" pbal-amt1 gi_data_banks.amt-cr. PAUSE 0.*/

                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                ASSIGN gi_acc_det.bank-cons = gi_data_banks.bank-cons.

                IF pbal-amt1 <= 0 THEN DO:
                    LEAVE a.
                END.

            END.
        END. 
    END. /* IF pamt-cr-bank = pamt-db-tran */

END.
  */





