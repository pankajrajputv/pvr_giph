DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF VAR prefnum-temp AS CHAR FORMAT "x(15)".
DEF VAR n AS INT. 

DEF SHARED VAR pbank-des LIKE gi_data_banks.bank-des.


DEF VAR pamt-cr-bank AS DEC.
DEF VAR pamt-db-tran AS DEC.

DEF VAR pamt-db-bank AS DEC.
DEF VAR pamt-cr-tran AS DEC.

DEF VAR pbal-amt1 AS DEC.
DEF VAR pbal-amt2 AS DEC.

DEF VAR pdate AS DATE.

DEF VAR pdate-ini AS DATE.
DEF VAR pdate-fin AS DATE.
ASSIGN pdate-ini = 3/1/2019 pdate-fin = 3/1/2019.
ASSIGN pdate-ini = 1/1/2019 pdate-fin = 12/31/2019.


DO pdate = pdate-ini TO pdate-fin:
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
                          AND gi_acc_det.bank-cons = 0 
                          AND gi_acc_det.debit > 0:
         ASSIGN pamt-db-tran = pamt-db-tran + gi_acc_det.debit.
    END. 
    /*MESSAGE pdate pamt-cr-bank pamt-db-tran. PAUSE 0.*/
    ASSIGN pbal-amt1 = pamt-cr-bank
           pbal-amt2 = pamt-cr-bank.

    MESSAGE "xx" pamt-cr-bank pamt-db-tran. PAUSE 0.
    IF pamt-cr-bank >= pamt-db-tran THEN DO:
    /*IF pamt-cr-bank <> pamt-db-tran THEN DO:*/
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

  
/****************************************************/

DO pdate = pdate-ini TO pdate-fin:
    ASSIGN pamt-db-bank = 0 pamt-cr-tran = 0
           pbal-amt1 = 0 pbal-amt2 = 0.
    FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
        /*
                             AND gi_data_banks.bank-cons >= pbank-cons-ini
                             AND gi_data_banks.bank-cons <= pbank-cons-fin
                             */
                             AND gi_data_banks.date-cleared = pdate:
        IF gi_data_banks.tran-refnum1 = "" THEN DO:
            ASSIGN pamt-db-bank = pamt-db-bank + gi_data_bank.amt-db.
        END.
    END.

    FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = pbank-des
                          AND gi_acc_det.refdate = pdate
                          AND gi_acc_det.bank-cons = 0 :
         ASSIGN pamt-cr-tran = pamt-cr-tran + gi_acc_det.credit.
    END. 
    MESSAGE pdate pamt-db-bank pamt-cr-tran. PAUSE 0.
    ASSIGN pbal-amt1 = pamt-db-bank
           pbal-amt2 = pamt-db-bank.

    IF pamt-db-bank >= pamt-cr-tran THEN DO:
        FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = pbank-des
                              AND gi_acc_det.refdate = pdate 
                              AND gi_acc_det.bank-cons = 0 :
            ASSIGN pbal-amt1 = /*pbal-amt1 -*/ gi_acc_det.credit.
            /*MESSAGE "yyy" gi_acc_det.debit pbal-amt1. PAUSE 0.*/
            a:
            FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = pbank-code
                                     AND gi_data_banks.date-cleared = pdate
                                     AND gi_data_banks.tran-refnum1 = ""
                                     AND gi_data_banks.amt-db > 0:
                ASSIGN pbal-amt1 = pbal-amt1 - gi_data_banks.amt-db.
                /*MESSAGE "zzz" pbal-amt1 gi_data_banks.amt-db. PAUSE 0.*/

                ASSIGN gi_data_banks.has-tran = TRUE.
                ASSIGN gi_data_banks.tran-refnum1 = gi_acc_det.refnum1.
                ASSIGN gi_acc_det.bank-cons = gi_data_banks.bank-cons.

                IF pbal-amt1 <= 0 THEN DO:
                    LEAVE a.
                END.

            END.
        END. 
    END. /* IF pamt-db-bank = pamt-cr-tran */

END.



