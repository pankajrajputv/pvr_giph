DEF VAR pcons AS INT.
FOR EACH gi_data_bus_sum: DELETE gi_data_bus_sum. END. 
FOR EACH gi_data_bus:

    ASSIGN 
      /*  gi_data_bus.GrossAmount1 = gi_data_bus.CollectFromAgent - gi_data_bus.AgentComm*/
      gi_data_bus.GrossAmount1 = gi_data_bus.grossAmount - gi_data_bus.AgentComm
      gi_data_bus.AgentComm1   = gi_data_bus.AgentComm 
      gi_data_bus.InputVat     = 0
        .

    ASSIGN 
      gi_data_bus.Payable1     = gi_data_bus.Payable
      gi_data_bus.comm-income1 = (gi_data_bus.GrossAmount - gi_data_bus.Payable) 
      gi_data_bus.OutputVat    = 0
        .

    ASSIGN 
      gi_data_bus.total-db = gi_data_bus.GrossAmount1 + gi_data_bus.AgentComm1 + gi_data_bus.InputVat       
      gi_data_bus.total-cr = gi_data_bus.Payable1 + gi_data_bus.comm-income1 + gi_data_bus.OutputVat 
      gi_data_bus.total-db-cr-diff = gi_data_bus.total-db - gi_data_bus.total-cr
        .

    FIND gi_data_bus_sum WHERE gi_data_bus_sum.YearMonthFN = gi_data_bus.YearMonthFN
                            AND gi_data_bus_sum.party-name  = gi_data_bus.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_bus_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_bus_sum.
        ASSIGN 
            gi_data_bus_sum.YearMonthFN = gi_data_bus.YearMonthFN
            gi_data_bus_sum.YearMonth = gi_data_bus.YearMonth

               gi_data_bus_sum.alias-name  = gi_data_bus.alias-name 
               gi_data_bus_sum.party-name  = gi_data_bus.party-name 
               gi_data_bus_sum.bus-sum-cons = pcons
            .
    END.

    ASSIGN 
        gi_data_bus_sum.Amount        = gi_data_bus_sum.Amount        + gi_data_bus.Amount      
        gi_data_bus_sum.ServiceCharge = gi_data_bus_sum.ServiceCharge + gi_data_bus.ServiceCharge.      

        .


    ASSIGN 
        /*gi_data_bus_sum.SellingPrice     = gi_data_bus_sum.SellingPrice     + gi_data_bus.SellingPrice     
        gi_data_bus_sum.MarkUpAmount     = gi_data_bus_sum.MarkUpAmount     + gi_data_bus.MarkUpAmount       */
        gi_data_bus_sum.GrossAmount      = gi_data_bus_sum.GrossAmount      + gi_data_bus.GrossAmount      
        gi_data_bus_sum.AgentComm        = gi_data_bus_sum.AgentComm        + gi_data_bus.AgentComm        
        gi_data_bus_sum.CollectFromAgent = gi_data_bus_sum.CollectFromAgent + gi_data_bus.CollectFromAgent 
        gi_data_bus_sum.Payable          = gi_data_bus_sum.Payable          + gi_data_bus.Payable          
        gi_data_bus_sum.Profit           = gi_data_bus_sum.Profit           + gi_data_bus.Profit           
        /*gi_data_bus_sum.CourierCharges   = gi_data_bus_sum.CourierCharges   + gi_data_bus.CourierCharges   */
        /*gi_data_bus_sum.Penalty          = gi_data_bus_sum.Penalty          + gi_data_bus.Penalty          */
        .

    ASSIGN 
      gi_data_bus_sum.GrossAmount1     = gi_data_bus_sum.GrossAmount1      + gi_data_bus.GrossAmount1    
      gi_data_bus_sum.AgentComm1       = gi_data_bus_sum.AgentComm1        + gi_data_bus.AgentComm1      
      gi_data_bus_sum.InputVat         = gi_data_bus_sum.InputVat          + gi_data_bus.InputVat        
      gi_data_bus_sum.Payable1         = gi_data_bus_sum.Payable1          + gi_data_bus.Payable1        
      gi_data_bus_sum.comm-income1     = gi_data_bus_sum.comm-income1      + gi_data_bus.comm-income1     
      gi_data_bus_sum.OutputVat        = gi_data_bus_sum.OutputVat         + gi_data_bus.OutputVat       
      gi_data_bus_sum.total-db         = gi_data_bus_sum.total-db          + gi_data_bus.total-db        
      gi_data_bus_sum.total-cr         = gi_data_bus_sum.total-cr          + gi_data_bus.total-cr        
      gi_data_bus_sum.total-db-cr-diff = gi_data_bus_sum.total-db-cr-diff  + gi_data_bus.total-db-cr-diff
        .

END. /* FOR EACH gi_data_bus */
