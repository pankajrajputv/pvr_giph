DEF VAR ptxt AS CHAR FORMAT "x(200)".
DEF VAR ptxt1 AS CHAR FORMAT "x(200)".
DEF VAR pchnum AS CHAR FORMAT "x(200)".
DEF VAR i AS INT.

DEF BUFFER b_gi_acc_det FOR gi_acc_det.

FOR EACH gi_acc_hea NO-LOCK,
    EACH gi_acc_det OF gi_acc_hea NO-LOCK:

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
END. /* FOR EACH gi_acc_hea */
