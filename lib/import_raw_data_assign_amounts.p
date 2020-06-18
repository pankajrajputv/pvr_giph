FOR EACH gi_rawdata:
    
    ASSIGN gi_rawdata.txt-runbal1 = REPLACE(gi_rawdata.txt-runbal1,"(","").
    ASSIGN gi_rawdata.txt-runbal2 = REPLACE(gi_rawdata.txt-runbal2,"(","").

    ASSIGN 
        gi_rawdata.amount  = DEC(gi_rawdata.txt-amount)
        gi_rawdata.debit   = DEC(gi_rawdata.txt-debit)  
        gi_rawdata.credit  = DEC(gi_rawdata.txt-credit) 
        gi_rawdata.runbal1 = DEC(gi_rawdata.txt-runbal1)
        gi_rawdata.runbal2 = DEC(gi_rawdata.txt-runbal2) NO-ERROR.

    /*
    IF gi_rawdata.txt-amount = "PHP@1.00" THEN DO:
        ASSIGN 
            gi_rawdata.amount  = DEC(gi_rawdata.txt-debit)  
            gi_rawdata.debit   = DEC(gi_rawdata.txt-credit) 
            gi_rawdata.credit  = DEC(gi_rawdata.txt-runbal1)
            gi_rawdata.runbal1 = DEC(gi_rawdata.txt-runbal2)
            gi_rawdata.runbal2 = DEC(gi_rawdata.report-txt) 
                                 
            NO-ERROR.

    END.
    ELSE DO:
        ASSIGN 
            gi_rawdata.amount  = DEC(gi_rawdata.txt-amount)
            gi_rawdata.debit   = DEC(gi_rawdata.txt-debit)  
            gi_rawdata.credit  = DEC(gi_rawdata.txt-credit) 
            gi_rawdata.runbal1 = DEC(gi_rawdata.txt-runbal1)
            gi_rawdata.runbal2 = DEC(gi_rawdata.txt-runbal2) NO-ERROR.

    END.
      */
    IF ERROR-STATUS:ERROR THEN DO:
        MESSAGE gi_rawdata.cons gi_rawdata.account-txt SKIP
gi_rawdata.txt-amount SKIP
gi_rawdata.txt-debit  SKIP
gi_rawdata.txt-credit SKIP
gi_rawdata.txt-runbal1 SKIP
gi_rawdata.txt-runbal2

            VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.
    

END.
     
