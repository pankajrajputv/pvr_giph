DEF VAR pdate-txt AS CHAR.    
DEF VAR pcons AS INT.
DEF VAR ptotal-amount AS DEC.

FOR EACH gi_data_airline_sum /*WHERE gi_data_Airline_sum.yearmonth = "2019-10"*/:
    DELETE gi_data_airline_sum.
END.

ASSIGN pcons = 0.

FOR EACH gi_data_airline WHERE gi_data_Airline.yearmonth BEGINS "2019"
    BREAK BY gi_data_airline.YearMonth
          BY gi_data_airline.YearMonthFN
          BY gi_data_airline.party-name:
    
    ASSIGN gi_data_airline.alias-name = "Airlines Purchases".

    IF gi_data_airline.trnstype = "Total" THEN DO:
        DELETE gi_data_airline.
        NEXT.
    END.

    /*
    ASSIGN gi_data_airline.IssuedDate = DATE(gi_data_airline.IssuedDate-txt) NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN gi_data_airline.errortxt = STRING(gi_data_airline.Airline-Cons).
        NEXT.
    END.
    */

    ASSIGN pdate-txt = REPLACE(gi_data_airline.IssuedDate-txt,"/",",").
    ASSIGN gi_data_airline.temp-date = DATE(INT(ENTRY(2,pdate-txt)),INT(ENTRY(1,pdate-txt)),INT(ENTRY(3,pdate-txt))).
    ASSIGN gi_data_airline.IssuedDate = gi_data_airline.temp-date.

    IF DAY(gi_data_airline.issueddate) >= 1 AND DAY(gi_data_airline.issueddate) <= 15 THEN DO:
        ASSIGN gi_data_airline.YearMonthFN = gi_data_airline.YearMonth + "-" + "01".
    END.

    IF DAY(gi_data_airline.issueddate) >= 16 AND DAY(gi_data_airline.issueddate) <= 31 THEN DO:
        ASSIGN gi_data_airline.YearMonthFN = gi_data_airline.YearMonth + "-" + "02".
    END.

    ASSIGN ptotal-amount = ptotal-amount + gi_data_airline.topupamt.

    /* DEBIT */
    ASSIGN gi_data_airline.CollectFromAgent1    = gi_data_airline.BasicAmt + 
                                                  gi_data_airline.Tax + 
                                                  gi_data_airline.TopUpAmt + 
                                                  gi_data_airline.MtagentComm + 
                                                  gi_data_airline.transfee +    
                                                  gi_data_airline.Penalty .

    /* CREDIT */
    ASSIGN gi_data_airline.mtagentcomm1         = gi_data_airline.mtagentcomm.
    ASSIGN gi_data_airline.agentcomm1           = gi_data_airline.agentcomm.
    ASSIGN gi_data_airline.Profit1              = gi_data_airline.Profit.

    /* THIS AMOUNT IS FORCED TO TALLY BECAUSE THE TOTALS ARE NOT MATCHING */
    ASSIGN gi_data_airline.PayableToAirline1    = gi_data_airline.CollectFromAgent1 - gi_data_airline.mtagentcomm1 - gi_data_airline.agentcomm1 - gi_data_airline.Profit1.

    ASSIGN gi_data_airline.outputvat            = 0 /*gi_data_airline.Profit1 / 1.12 * 0.12 */.
    ASSIGN gi_data_airline.inputvat             = 0.

    ASSIGN gi_data_airline.total-db = gi_data_airline.CollectFromAgent1.
    ASSIGN gi_data_airline.total-cr = gi_data_airline.mtagentcomm1 + gi_data_airline.agentcomm1 + gi_data_airline.PayableToAirline1 + gi_data_airline.Profit1 + gi_data_airline.outputvat.
    ASSIGN gi_data_airline.total-db-cr-diff = gi_data_airline.total-db - gi_data_airline.total-cr.
    
    FIND gi_data_airline_sum WHERE gi_data_airline_sum.YearMonthFN = gi_data_airline.YearMonth
                               AND gi_data_airline_sum.party-name  = gi_data_airline.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_airline_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_airline_sum.
        ASSIGN 
               gi_data_airline_sum.YearMonth = gi_data_airline.YearMonth
               gi_data_airline_sum.YearMonthFN = gi_data_airline.YearMonth
               gi_data_airline_sum.IataStock   = gi_data_airline.IataStock
               gi_data_airline_sum.party-name = gi_data_airline.party-name
               gi_data_airline_sum.alias-name = gi_data_airline.alias-name
               gi_data_airline_sum.YearMonth = gi_data_airline.YearMonth
               gi_data_airline_sum.airline-sum-cons = pcons.
    END.

    ASSIGN
        gi_data_airline_sum.BasicAmt	      = gi_data_airline_sum.BasicAmt         + gi_data_airline.BasicAmt        
        gi_data_airline_sum.Tax	              = gi_data_airline_sum.Tax              + gi_data_airline.Tax             
        gi_data_airline_sum.TopUpAmt	      = gi_data_airline_sum.TopUpAmt         + gi_data_airline.TopUpAmt        
        gi_data_airline_sum.MtagentComm       = gi_data_airline_sum.MtagentComm      + gi_data_airline.MtagentComm     
        gi_data_airline_sum.TransFee	      = gi_data_airline_sum.TransFee         + gi_data_airline.TransFee        
        gi_data_airline_sum.Penalty	          = gi_data_airline_sum.Penalty          + gi_data_airline.Penalty         
        gi_data_airline_sum.AgentComm         = gi_data_airline_sum.AgentComm        + gi_data_airline.AgentComm       
        gi_data_airline_sum.CollectFromAgent  =	gi_data_airline_sum.CollectFromAgent + gi_data_airline.CollectFromAgent
        gi_data_airline_sum.SupplierComm      = gi_data_airline_sum.SupplierComm     + gi_data_airline.SupplierComm    
        gi_data_airline_sum.PayableToAirline  =	gi_data_airline_sum.PayableToAirline + gi_data_airline.PayableToAirline
        gi_data_airline_sum.SegmentFee	      = gi_data_airline_sum.SegmentFee       + gi_data_airline.SegmentFee      
        gi_data_airline_sum.Profit            = gi_data_airline_sum.Profit           + gi_data_airline.Profit          
        .


    ASSIGN

        gi_data_airline_sum.db-AgentComm        = gi_data_airline_sum.AgentComm
        gi_data_airline_sum.db-ControlAgent     = gi_data_airline_sum.CollectFromAgent

        gi_data_airline_sum.cr-TopUp            = gi_data_airline_sum.TopUpAmt 
        gi_data_airline_sum.cr-MtAgentComm      = gi_data_airline_sum.MtagentComm
        gi_data_airline_sum.cr-TransFee         = gi_data_airline_sum.TransFee 
        gi_data_airline_sum.cr-SupplierComm     = gi_data_airline_sum.SupplierComm   
        gi_data_airline_sum.cr-PayableToAirline = gi_data_airline_sum.PayableToAirline
        .

    ASSIGN 
        gi_data_airline_sum.total-db         = gi_data_airline_sum.db-AgentComm        + gi_data_airline_sum.db-ControlAgent 
        
        gi_data_airline_sum.total-cr         = gi_data_airline_sum.cr-TopUp            + gi_data_airline_sum.cr-MtAgentComm  +   
                                               gi_data_airline_sum.cr-TransFee         + gi_data_airline_sum.cr-SupplierComm +   
                                               gi_data_airline_sum.cr-PayableToAirline
        gi_data_airline_sum.total-db-cr-diff = gi_data_airline_sum.total-db  - gi_data_airline_sum.total-cr
        .

    ASSIGN
        gi_data_airline_sum.AutoGP =  gi_data_airline_sum.cr-TopUp + 
                                      gi_data_airline_sum.cr-TransFee + 
                                      gi_data_airline_sum.cr-SupplierComm -
                                      gi_data_airline_sum.db-AgentComm
        gi_data_airline_sum.DiffGP = gi_data_airline_sum.AutoGP  - gi_data_airline_sum.Profit 
        .



END. /* FOR EACH gi_data_airline */

