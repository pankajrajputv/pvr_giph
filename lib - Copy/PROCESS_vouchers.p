DEF SHARED VAR psearchrefdate1 AS DATE.
DEF SHARED VAR psearchrefdate2 AS DATE.
DEF SHARED VAR poutput-filename AS CHAR.
DEF SHARED VAR pVoucherType LIKE gi_acc_hea.VoucherType.
DEF SHARED VAR prefnum1 LIKE gi_acc_hea.refnum1.
DEF SHARED VAR pLastVchId LIKE gi_acc_hea.LastVchId.

DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.

FOR EACH b_gi_acc_hea WHERE b_gi_acc_hea.refdate >= psearchrefdate1
                        AND b_gi_acc_hea.refdate <= psearchrefdate2
                        AND b_gi_acc_hea.vouchertype = pVoucherType
                        /*AND b_gi_acc_hea.LastVchId = pLastVchId*/
                        AND b_gi_acc_hea.dbcr-diff = 0
                       /* AND (b_gi_acc_hea.lastvchid = 0)*/
    BREAK BY b_gi_acc_hea.yearmonth
          BY b_gi_acc_hea.refdate
          BY b_gi_acc_hea.refnum1:

    /*ASSIGN b_gi_acc_hea.refnum1-clean = REPLACE(b_gi_acc_hea.refnum1," ","").*/
    /*
    IF b_gi_acc_hea.LastVchId = "" THEN DO:
      /*MESSAGE b_gi_acc_hea.refnum1 b_gi_acc_hea.refdate "VchID" b_gi_acc_hea.LastVchId. PAUSE 1.*/
      /*NEXT.*/
    END.
    ELSE DO:
      NEXT.
    END.
    */

    ASSIGN prefnum1 = b_gi_acc_hea.refnum1.
    IF b_gi_acc_hea.vouchertype = "Payment" OR 
       b_gi_acc_hea.vouchertype = "Receipt" OR
       b_gi_acc_hea.vouchertype = "Contra" OR
       b_gi_acc_hea.vouchertype = "Journal" OR 
       b_gi_acc_hea.vouchertype = "Purchase" OR
       b_gi_acc_hea.vouchertype = "Sales" 
        
        THEN DO:
        IF b_gi_acc_hea.vouchertype = "Payment" THEN RUN c:\pvr\giph\lib\CREATE_tally_voucher_payment.p NO-ERROR.
        ELSE
        IF b_gi_acc_hea.vouchertype = "Receipt" THEN RUN c:\pvr\giph\lib\CREATE_tally_voucher_receipt.p NO-ERROR.
        ELSE
        IF b_gi_acc_hea.vouchertype = "Contra" THEN RUN c:\pvr\giph\lib\CREATE_tally_voucher_contra.p NO-ERROR.
        ELSE
        IF b_gi_acc_hea.vouchertype = "Journal" THEN RUN c:\pvr\giph\lib\CREATE_tally_voucher_journal.p NO-ERROR.
        ELSE
        IF b_gi_acc_hea.vouchertype = "Purchase" THEN RUN c:\pvr\giph\lib\CREATE_tally_voucher_purchase.p NO-ERROR.
        ELSE
        IF b_gi_acc_hea.vouchertype = "Sales" THEN RUN c:\pvr\giph\lib\CREATE_tally_voucher_sales.p NO-ERROR.

        RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_acc_hea.LastVchId, OUTPUT b_gi_acc_hea.tally-response) NO-ERROR.
        MESSAGE b_gi_acc_hea.refnum1 b_gi_acc_hea.refdate "VchID" b_gi_acc_hea.LastVchId. PAUSE 1.
    END.

END. /* for each b_gi_acc_hea */


