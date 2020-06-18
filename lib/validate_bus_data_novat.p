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

    FIND gi_data_bus_sum WHERE gi_data_bus_sum.YearMonthFN = gi_data_bus.YearMonth
                            AND gi_data_bus_sum.party-name  = gi_data_bus.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_bus_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_bus_sum.
        ASSIGN 
            gi_data_bus_sum.YearMonthFN = gi_data_bus.YearMonth
            gi_data_bus_sum.YearMonth   = gi_data_bus.YearMonth

               gi_data_bus_sum.alias-name  = gi_data_bus.alias-name 
               gi_data_bus_sum.party-name  = gi_data_bus.party-name 
               gi_data_bus_sum.bus-sum-cons = pcons
            .
    END.

    ASSIGN gi_data_bus_sum.alias-name = "Bus Purchases".

    ASSIGN 
        gi_data_bus_sum.Amount        = gi_data_bus_sum.Amount            + gi_data_bus.Amount      
        gi_data_bus_sum.ServiceCharge = gi_data_bus_sum.ServiceCharge     + gi_data_bus.ServiceCharge      
        gi_data_bus_sum.GrossAmount   = gi_data_bus_sum.GrossAmount       + gi_data_bus.GrossAmount      
        gi_data_bus_sum.SupplierComm  = gi_data_bus_sum.SupplierComm      + gi_data_bus.SupplierComm        
        gi_data_bus_sum.AgentComm        = gi_data_bus_sum.AgentComm        + gi_data_bus.AgentComm        
        gi_data_bus_sum.CollectFromAgent = gi_data_bus_sum.CollectFromAgent + gi_data_bus.CollectFromAgent 
        gi_data_bus_sum.Payable          = gi_data_bus_sum.Payable          + gi_data_bus.Payable          
        gi_data_bus_sum.Profit           = gi_data_bus_sum.Profit           + gi_data_bus.Profit           
        .


    ASSIGN
        gi_data_Bus_sum.db-ControlAgent = gi_data_Bus_sum.CollectFromAgent 
        gi_data_Bus_sum.db-AgentComm    = gi_data_Bus_sum.AgentComm 
        gi_data_Bus_sum.cr-BusPurchases = gi_data_Bus_sum.Payable
        gi_data_Bus_sum.cr-BusSales     = gi_data_Bus_sum.CollectFromAgent + gi_data_Bus_sum.AgentComm - gi_data_Bus_sum.Payable        
        .

    ASSIGN 
        gi_data_Bus_sum.total-db         = gi_data_Bus_sum.db-AgentComm      + gi_data_Bus_sum.db-ControlAgent 
        gi_data_Bus_sum.total-cr         = gi_data_Bus_sum.cr-BusPurchases  + gi_data_Bus_sum.cr-BusSales       
        gi_data_Bus_sum.total-db-cr-diff = gi_data_Bus_sum.total-db  - gi_data_Bus_sum.total-cr
          .

    ASSIGN
        gi_data_Bus_sum.AutoGP = gi_data_Bus_sum.cr-BusSales  - gi_data_Bus_sum.db-AgentComm
          gi_data_Bus_sum.DiffGP = gi_data_Bus_sum.AutoGP  - gi_data_Bus_sum.Profit 
        .




END. /* FOR EACH gi_data_bus */
