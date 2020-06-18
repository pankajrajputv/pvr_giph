
    
FOR EACH gi_acc_hea 
   WHERE gi_acc_hea.refnum1 BEGINS "CDV36461"
     AND gi_acc_hea.dbcr-diff = 0
     AND gi_acc_hea.refdate >= 10/01/19
     AND gi_acc_hea.refdate <= 10/31/19 NO-LOCK, 
     EACH gi_acc_det OF gi_acc_hea NO-LOCK:

    DISPLAY 
        gi_acc_det.refnum1 FORMAT "x(10)"
        gi_acc_det.acc-led-name  FORMAT "x(20)"
        gi_acc_det.debit
        gi_acc_det.credit

        .

    FIND gi_acc_led WHERE gi_acc_led.acc-led-name = gi_acc_det.acc-led-name NO-LOCK NO-ERROR.
    IF NOT AVAILABLE gi_acc_led THEN DO:
        DISPLAY "Not available" gi_acc_det.acc-led-name.
    END.
    ELSE DO:
        DISPLAY 
        gi_acc_det.acc-led-name  FORMAT "x(20)"
        gi_acc_led.acc-grp-name  FORMAT "x(20)"
            .


    END.


END.   /* FOR EACH gi_acc_hea */
