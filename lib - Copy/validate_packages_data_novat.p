DEF VAR pcons AS INT.
FOR EACH gi_data_packages_sum: DELETE gi_data_packages_sum. END. 
FOR EACH gi_data_packages:

    ASSIGN gi_data_packages.party-name = gi_data_packages.packagesupplier.
    ASSIGN gi_data_packages.Payable    = gi_data_packages.TotalPayable.

    ASSIGN 
        /*gi_data_packages.SellingPrice1 = gi_data_packages.CollectFromAgent*/
        gi_data_packages.SellingPrice1 = gi_data_packages.SellingPrice
        gi_data_packages.Payable1      = gi_data_packages.Payable
        gi_data_packages.MarkUp1       = gi_data_packages.MarkUp 
        gi_data_packages.OutputVat     = 0
        .

    ASSIGN 
      gi_data_packages.total-db         = gi_data_packages.SellingPrice1      
      gi_data_packages.total-cr         =  gi_data_packages.Payable1 + gi_data_packages.MarkUp1 + gi_data_packages.OutputVat 
      gi_data_packages.total-db-cr-diff = gi_data_packages.total-db - gi_data_packages.total-cr
        .

    FIND gi_data_packages_sum WHERE gi_data_packages_sum.YearMonthFN = gi_data_packages.YearMonthFN
                                AND gi_data_packages_sum.party-name  = gi_data_packages.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_packages_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_packages_sum.
        ASSIGN 
            gi_data_packages_sum.YearMonth        = gi_data_packages.YearMonth
            gi_data_packages_sum.YearMonthFN       = gi_data_packages.YearMonthFN
               gi_data_packages_sum.alias-name        = gi_data_packages.alias-name 
               gi_data_packages_sum.party-name        = gi_data_packages.party-name 
               gi_data_packages_sum.packages-sum-cons = pcons
            .
    END.

    ASSIGN 
        gi_data_packages_sum.SellingPrice     = gi_data_packages_sum.SellingPrice     + gi_data_packages.SellingPrice     
        gi_data_packages_sum.MarkUp           = gi_data_packages_sum.MarkUp           + gi_data_packages.MarkUp      
        gi_data_packages_sum.AgentComm        = gi_data_packages_sum.AgentComm        + gi_data_packages.AgentComm        
        gi_data_packages_sum.CollectFromAgent = gi_data_packages_sum.CollectFromAgent + gi_data_packages.CollectFromAgent 
        gi_data_packages_sum.Payable          = gi_data_packages_sum.Payable          + gi_data_packages.Payable          
        gi_data_packages_sum.Profit           = gi_data_packages_sum.Profit           + gi_data_packages.Profit           
        /*gi_data_packages_sum.CourierCharges   = gi_data_packages_sum.CourierCharges   + gi_data_packages.CourierCharges   */
        /*gi_data_packages_sum.Penalty          = gi_data_packages_sum.Penalty          + gi_data_packages.Penalty          */
        .

    ASSIGN 
      gi_data_packages_sum.MarkUp1          = gi_data_packages_sum.MarkUp1           + gi_data_packages.MarkUp1    
      gi_data_packages_sum.Payable1         = gi_data_packages_sum.Payable1          + gi_data_packages.Payable1        
      gi_data_packages_sum.SellingPrice1    = gi_data_packages_sum.SellingPrice1     + gi_data_packages.SellingPrice1     
      gi_data_packages_sum.OutputVat        = gi_data_packages_sum.OutputVat         + gi_data_packages.OutputVat       

      gi_data_packages_sum.total-db         = gi_data_packages_sum.total-db          + gi_data_packages.total-db        
      gi_data_packages_sum.total-cr         = gi_data_packages_sum.total-cr          + gi_data_packages.total-cr        
      gi_data_packages_sum.total-db-cr-diff = gi_data_packages_sum.total-db-cr-diff  + gi_data_packages.total-db-cr-diff
        .

END. /* FOR EACH gi_data_packages */
