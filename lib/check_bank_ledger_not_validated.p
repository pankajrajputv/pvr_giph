/*
FOR EACH gi_acc_led WHERE gi_acc_led.isbank OR gi_acc_led.iscash
    NO-LOCK:

    FOR EACH gi_acc_det WHERE gi_acc_det.acc-led-name = gi_acc_det.acc-led-name
        :
        FIND gi_acc_hea OF gi_acc_det NO-LOCK NO-ERROR.
        IF gi_acc_hea.vouchertype = "" THEN DO:
            DISPLAY gi_acc_hea.refnum1.
        END.

    END.

END.
  */

FOR EACH gi_acc_led WHERE gi_acc_led.isbank OR gi_acc_led.iscash NO-LOCK:
    FOR EACH gi_acc_hea WHERE gi_acc_hea.vouchertype = "":
        FOR EACH gi_acc_det OF gi_acc_hea WHERE gi_acc_det.acc-led-name = gi_acc_det.acc-led-name:
            IF gi_acc_det.debit > 0 THEN DO:
                ASSIGN gi_acc_hea.isreceipt = TRUE.
                ASSIGN gi_acc_hea.vouchertype = "Receipt".
            END.
            ELSE 
            IF gi_acc_det.credit > 0 THEN DO:
                ASSIGN gi_acc_hea.ispayment = TRUE.
                ASSIGN gi_acc_hea.vouchertype = "Payment".
            END.
        END.
    END.
END.

