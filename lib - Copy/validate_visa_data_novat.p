DEF VAR pcons AS INT.
FOR EACH gi_data_visa_sum: DELETE gi_data_visa_sum. END. 
FOR EACH gi_data_visa:

    ASSIGN 
      gi_data_visa.GrossAmount1 = gi_data_visa.CollectFromAgent - gi_data_visa.AgentComm
      gi_data_visa.AgentComm1   = gi_data_visa.AgentComm
      gi_data_visa.InputVat     = 0
        .

    ASSIGN 
      gi_data_visa.Payable1     = gi_data_visa.Payable
      gi_data_visa.comm-income1 = (gi_data_visa.GrossAmount - gi_data_visa.Payable) 
      gi_data_visa.OutputVat    = 0
        .

    ASSIGN 
      gi_data_visa.total-db = gi_data_visa.GrossAmount1 + gi_data_visa.AgentComm1 + gi_data_visa.InputVat       
      gi_data_visa.total-cr = gi_data_visa.Payable1 + gi_data_visa.comm-income1 + gi_data_visa.OutputVat 
      gi_data_visa.total-db-cr-diff = gi_data_visa.total-db - gi_data_visa.total-cr
        .

    FIND gi_data_visa_sum WHERE gi_data_visa_sum.YearMonthFN = gi_data_visa.YearMonthFN
                            AND gi_data_visa_sum.party-name  = gi_data_visa.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_visa_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_visa_sum.
        ASSIGN 
            gi_data_visa_sum.YearMonth = gi_data_visa.YearMonth
            gi_data_visa_sum.YearMonthFN = gi_data_visa.YearMonthFN
               gi_data_visa_sum.alias-name  = gi_data_visa.alias-name 
               gi_data_visa_sum.party-name  = gi_data_visa.party-name 
               gi_data_visa_sum.visa-sum-cons = pcons
            .
    END.

    ASSIGN 
        gi_data_visa_sum.SellingPrice     = gi_data_visa_sum.SellingPrice     + gi_data_visa.SellingPrice     
        gi_data_visa_sum.MarkUpAmount     = gi_data_visa_sum.MarkUpAmount     + gi_data_visa.MarkUpAmount     
        gi_data_visa_sum.GrossAmount      = gi_data_visa_sum.GrossAmount      + gi_data_visa.GrossAmount      
        gi_data_visa_sum.AgentComm        = gi_data_visa_sum.AgentComm        + gi_data_visa.AgentComm        
        gi_data_visa_sum.CollectFromAgent = gi_data_visa_sum.CollectFromAgent + gi_data_visa.CollectFromAgent 
        gi_data_visa_sum.Payable          = gi_data_visa_sum.Payable          + gi_data_visa.Payable          
        gi_data_visa_sum.Profit           = gi_data_visa_sum.Profit           + gi_data_visa.Profit           
        gi_data_visa_sum.CourierCharges   = gi_data_visa_sum.CourierCharges   + gi_data_visa.CourierCharges   
        gi_data_visa_sum.Penalty          = gi_data_visa_sum.Penalty          + gi_data_visa.Penalty          
        .

    ASSIGN 
      gi_data_visa_sum.GrossAmount1     = gi_data_visa_sum.GrossAmount1      + gi_data_visa.GrossAmount1    
      gi_data_visa_sum.AgentComm1       = gi_data_visa_sum.AgentComm1        + gi_data_visa.AgentComm1      
      gi_data_visa_sum.InputVat         = gi_data_visa_sum.InputVat          + gi_data_visa.InputVat        
      gi_data_visa_sum.Payable1         = gi_data_visa_sum.Payable1          + gi_data_visa.Payable1        
      gi_data_visa_sum.comm-income1     = gi_data_visa_sum.comm-income1      + gi_data_visa.comm-income1     
      gi_data_visa_sum.OutputVat        = gi_data_visa_sum.OutputVat         + gi_data_visa.OutputVat       
      gi_data_visa_sum.total-db         = gi_data_visa_sum.total-db          + gi_data_visa.total-db        
      gi_data_visa_sum.total-cr         = gi_data_visa_sum.total-cr          + gi_data_visa.total-cr        
      gi_data_visa_sum.total-db-cr-diff = gi_data_visa_sum.total-db-cr-diff  + gi_data_visa.total-db-cr-diff
        .

END. /* FOR EACH gi_data_visa */
