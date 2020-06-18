
DEF VAR ptxt AS CHAR FORMAT "x(200)".
DEF VAR ptxt1 AS CHAR FORMAT "x(200)".
DEF VAR pchnum AS CHAR FORMAT "x(200)".
DEF VAR i AS INT.
DEF VAR n AS INT.
DEF VAR b AS INT.
DEF VAR p AS INT.
DEF VAR s AS INT.
DEF VAR r AS INT.
DEF VAR k AS INT.

DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.
DEF BUFFER b_gi_acc_det FOR gi_acc_det.

    ASSIGN k = 0.
FOR EACH gi_acc_hea /*WHERE gi_acc_hea.refnum1 = "CDV31313"*/ /*NO-LOCK*/,
    EACH gi_acc_det OF gi_acc_hea /*NO-LOCK*/
    BREAK BY gi_acc_det.refnum1:

    ASSIGN k = k + 1.
    IF k = 5000 THEN DO:
        ASSIGN k = 0.
        PAUSE 1.
    END.
    MESSAGE gi_Acc_hea.refnum1. PAUSE 0.
    ASSIGN gi_acc_hea.refnum1-clean = REPLACE(gi_acc_hea.refnum1," ","").
    ASSIGN gi_acc_det.refnum1-clean = REPLACE(gi_acc_det.refnum1," ","").

    IF FIRST-OF(gi_acc_det.refnum1) THEN DO:
        n = 0. b = 0.
        FOR EACH b_gi_acc_det OF gi_acc_hea NO-LOCK:

            FIND gi_acc_led WHERE gi_acc_led.acc-led-name = b_gi_acc_det.acc-led-name NO-LOCK NO-ERROR.
            IF AVAILABLE gi_acc_led AND (gi_acc_led.isexpenses OR gi_acc_led.isap) THEN DO: /* expenses or accounts payable */
                n = n + 1.
            END.
            IF AVAILABLE gi_acc_led AND (gi_acc_led.isbank OR gi_acc_led.iscash) THEN DO:
                b = b + 1.
            END.
            IF n >= 1 AND b >= 1 THEN DO:
                FIND b_gi_acc_hea OF gi_acc_hea NO-ERROR.
                IF AVAILABLE b_gi_acc_hea THEN DO:
                    ASSIGN b_gi_acc_hea.ispayment = TRUE.
                    ASSIGN b_gi_acc_hea.vouchertype = "Payment".
                END.
            END.
        END. /* for each b_gi_acc_det */
    END.
END.
