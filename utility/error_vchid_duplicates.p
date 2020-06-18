DEF VAR pfilename AS CHAR. 
ASSIGN pfilename = "c:\tmp\error_vchid_gi_acc_hea.txt".
DEF VAR i AS INT.
OUTPUT TO VALUE(pfilename).
FOR EACH gi_Acc_hea WHERE INT(gi_acc_hea.lastVchId) > 0 
    BREAK /*BY vouchertype*/
          BY lastVchId:
    IF FIRST-OF(gi_acc_hea.lastVchId) THEN DO:
        i  = 0.
    END.
    i  = i + 1.
    IF LAST-OF(gi_acc_hea.lastVchId) AND i > 1 THEN DO:
        DISPLAY gi_acc_hea.vouchertype gi_Acc_hea.lastVchId i.
    END.

END.
OUTPUT CLOSE.

