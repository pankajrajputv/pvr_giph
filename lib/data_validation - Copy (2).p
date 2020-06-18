DEF VAR ptxt AS CHAR FORMAT "x(200)".
DEF VAR ptxt1 AS CHAR FORMAT "x(200)".
DEF VAR pchnum AS CHAR FORMAT "x(200)".
DEF VAR i AS INT.
DEF VAR n AS INT.
DEF VAR b AS INT.
DEF VAR p AS INT.
DEF VAR s AS INT.

DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.
DEF BUFFER b_gi_acc_det FOR gi_acc_det.


FOR EACH gi_acc_hea NO-LOCK,
    EACH gi_acc_det OF gi_acc_hea NO-LOCK
    BREAK BY gi_acc_det.refnum1:

    IF FIRST-OF(gi_acc_det.refnum1) THEN DO:
        n = 0.
        FOR EACH b_gi_acc_det OF gi_acc_hea NO-LOCK:
            FIND gi_acc_led WHERE gi_acc_led.acc-led-name = b_gi_acc_det.acc-led-name NO-LOCK NO-ERROR.
            IF AVAILABLE gi_acc_led AND (gi_acc_led.isbank OR gi_acc_led.iscash) THEN DO: /* is bank */
                n = n + 1.
            END.
            IF n > 1 THEN DO:
                FIND b_gi_acc_hea OF gi_acc_hea NO-ERROR.
                IF AVAILABLE b_gi_acc_hea THEN DO:
                    ASSIGN b_gi_acc_hea.iscontra = TRUE.
                END.
            END.
        END. /* for each b_gi_acc_det */

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
                END.
            END.
        END. /* for each b_gi_acc_det */

        p = 0.
        FOR EACH b_gi_acc_det OF gi_acc_hea NO-LOCK:
            FIND gi_acc_led WHERE gi_acc_led.acc-led-name = b_gi_acc_det.acc-led-name NO-LOCK NO-ERROR.
            IF AVAILABLE gi_acc_led AND gi_acc_led.acc-led-name = "Advances to Suppliers" THEN DO: /* */
                p = p + 1.
            END.
            IF p >= 1 THEN DO:
                FIND b_gi_acc_hea OF gi_acc_hea NO-ERROR.
                IF AVAILABLE b_gi_acc_hea THEN DO:
                    ASSIGN b_gi_acc_hea.ispurchase = TRUE.
                END.
            END.
        END. /* for each b_gi_acc_det */

    END. /* first-of */

    IF gi_acc_det.is-cheque = FALSE THEN DO:
        FIND gi_acc_led WHERE gi_acc_led.acc-led-name = gi_acc_det.acc-led-name NO-LOCK NO-ERROR.
        IF AVAILABLE gi_acc_led THEN DO:
            IF gi_acc_led.isbank THEN DO:
                IF gi_acc_det.particulars MATCHES "*ch*no**" THEN DO:
                    ASSIGN ptxt = gi_acc_det.particulars.
                    ASSIGN ptxt1 = SUBSTRING(ptxt,1,35).
                    ASSIGN pchnum = "".
                    DO i = 1 TO 50:
                        IF SUBSTRING(ptxt1,i,1) = "0" OR 
                            SUBSTRING(ptxt1,i,1) = "1" OR
                            SUBSTRING(ptxt1,i,1) = "2" OR
                            SUBSTRING(ptxt1,i,1) = "3" OR
                            SUBSTRING(ptxt1,i,1) = "4" OR
                            SUBSTRING(ptxt1,i,1) = "5" OR
                            SUBSTRING(ptxt1,i,1) = "6" OR
                            SUBSTRING(ptxt1,i,1) = "7" OR
                            SUBSTRING(ptxt1,i,1) = "8" OR
                            SUBSTRING(ptxt1,i,1) = "9" THEN DO:
                            ASSIGN pchnum = pchnum + SUBSTRING(ptxt1,i,1).
                        END.
                        IF SUBSTRING(ptxt1,i,5) = "being" THEN DO:
                            FIND b_gi_acc_det OF gi_acc_det NO-ERROR.
                            IF AVAILABLE b_gi_acc_det THEN DO:
                                ASSIGN b_gi_acc_det.is-cheque = TRUE
                                       b_gi_acc_det.cheque-num = pchnum.
                                RELEASE b_gi_acc_det.
                                ASSIGN pchnum = "".
                            END.
                            LEAVE.
                            /* MESSAGE SUBSTRING(ptxt1,i,5) VIEW-AS ALERT-BOX INFO BUTTONS OK.*/
                        END.
                    END.
                END. /* if matches check number */
            END.
        END. /*  IF AVAILABLE gi_acc_led */
    END.

    
END. /* FOR EACH gi_acc_hea */
