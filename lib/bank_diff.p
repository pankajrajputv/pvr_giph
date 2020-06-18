DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF SHARED VAR pbank-des LIKE gi_data_banks.bank-des.
DEF SHARED VAR pyearmonth1 LIKE gi_data_banks.yearmonth.
DEF VAR pdate AS DATE.
DEF SHARED VAR preport-type AS INT.
/*
DEF VAR pbank-code AS CHAR. 
DEF VAR pbank-des AS CHAR. 
  */

/*
ASSIGN pbank-code = "BDO_DOLLAR".
ASSIGN pbank-des = "BDO S/A USD".

ASSIGN pfilename = "c:\temp\giph-bank-diff.csv".
  */

/*
MESSAGE pbank-code 
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
QUIT.
*/

DEF TEMP-TABLE det
    FIELD bank-code LIKE gi_banks_diff.bank-code
    FIELD bank-des LIKE gi_banks_diff.bank-des.

FOR EACH gi_data_banks WHERE (preport-type = 1 AND gi_data_banks.bank-code = pbank-code) OR
                             (preport-type = 9 AND gi_data_banks.bank-code <> "")    
    BREAK BY gi_data_banks.bank-code:
    IF FIRST-OF(gi_data_banks.bank-code) THEN DO:
        CREATE det.
        ASSIGN det.bank-code = gi_data_banks.bank-code
               det.bank-des  = gi_data_banks.bank-des.

    END.

END.



FOR EACH gi_banks_diff WHERE /*gi_banks_diff.bank-code = pbank-code*/
                         /*AND gi_banks_diff.yearmonth MATCHES pyearmonth1*/
    (preport-type = 1 AND gi_banks_diff.bank-code = pbank-code) OR
       (preport-type = 9 AND gi_banks_diff.bank-code <> "")
       :     
    DELETE gi_banks_diff.
END.


FOR EACH det:
    FOR EACH gi_calendar WHERE gi_calendar.YearMonth MATCHES pyearmonth1
        :
        ASSIGN pdate = gi_calendar.pdate.

        FOR EACH gi_data_banks WHERE gi_data_banks.bank-code = det.bank-code
            /*
            (preport-type = 1 AND gi_data_banks.bank-code = pbank-code) OR
       (preport-type = 9 AND gi_data_banks.bank-code <> "")   */
            AND gi_data_banks.date-cleared = pdate  NO-LOCK
                BREAK BY gi_data_banks.bank-code
                      BY gi_data_banks.date-cleared:

            IF FIRST-OF(gi_data_banks.date-cleared) THEN DO:
                MESSAGE gi_data_banks.bank-code pdate. PAUSE 0.
            END.
            FIND gi_banks_diff WHERE gi_banks_diff.bank-code = gi_data_banks.bank-code
                                 AND gi_banks_diff.date-cleared = gi_data_banks.date-cleared NO-ERROR.
            IF NOT AVAILABLE gi_banks_diff THEN DO:
                CREATE gi_banks_diff.
                ASSIGN gi_banks_diff.bank-code    = gi_data_banks.bank-code
                       gi_banks_diff.bank-des     = gi_data_banks.bank-des
                       gi_banks_diff.date-cleared = gi_data_banks.date-cleared
                    .
            END.
            ASSIGN gi_banks_diff.yearmonth    = gi_data_banks.yearmonth
                   gi_banks_diff.yearmonthfn  = gi_data_banks.yearmonthfn
                .

            /*
            IF pdate =  THEN
            MESSAGE  "Bank Db" gi_data_banks.amt-db "Bank USD Cr" gi_data_banks.usd-amt-cr
                 "Bank Cr" gi_data_banks.amt-cr "BANK USD Db" gi_data_banks.usd-amt-db
                 "Rate" gi_data_banks.rate-exchange. PAUSE 0.
              */
            ASSIGN gi_banks_diff.amt-db = gi_banks_diff.amt-db + gi_data_banks.amt-db.
            ASSIGN gi_banks_diff.amt-cr = gi_banks_diff.amt-cr + gi_data_banks.amt-cr.

            ASSIGN gi_banks_diff.usd-amt-db = gi_banks_diff.usd-amt-db + gi_data_banks.usd-amt-db.
            ASSIGN gi_banks_diff.usd-amt-cr = gi_banks_diff.usd-amt-cr + gi_data_banks.usd-amt-cr.

            IF LAST-OF(gi_data_banks.date-cleared) THEN DO:

                FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = gi_data_banks.bank-des
                                      AND gi_acc_det.refdate      = pdate NO-LOCK:

                    FIND gi_banks_diff WHERE gi_banks_diff.bank-code    = gi_data_banks.bank-code
                                         AND gi_banks_diff.date-cleared = pdate NO-ERROR.
                    IF NOT AVAILABLE gi_banks_diff THEN DO:
                        CREATE gi_banks_diff.
                        ASSIGN gi_banks_diff.bank-code = gi_data_banks.bank-code
                               gi_banks_diff.bank-des = gi_data_banks.bank-des
                               gi_banks_diff.date-cleared = pdate.
                    END.

                    ASSIGN gi_banks_diff.debit  = gi_banks_diff.debit  + gi_acc_det.debit.
                    ASSIGN gi_banks_diff.credit = gi_banks_diff.credit + gi_acc_det.credit.
                    /*
                    IF gi_acc_det.refdate = 1/25/19 THEN DO:
                        MESSAGE gi_acc_det.cons gi_acc_det.refdate gi_acc_det.acc-led-name gi_acc_det.debit gi_acc_det.credit. PAUSE 0.
                    END.
                    */

                END.
                FIND gi_banks_diff WHERE gi_banks_diff.bank-code = gi_data_banks.bank-code
                                     AND gi_banks_diff.date-cleared = pdate NO-ERROR.
                IF AVAILABLE gi_banks_diff THEN DO:
                    ASSIGN gi_banks_diff.diff-debit = gi_banks_diff.amt-db - gi_banks_diff.credit.
                    ASSIGN gi_banks_diff.diff-credit = gi_banks_diff.amt-cr - gi_banks_diff.debit.
                END.


            END.

        END. /* for each gi_data_banks.*/
    END. /* do pdate */
END. /* for each det */


