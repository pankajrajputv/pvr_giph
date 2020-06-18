DEF VAR pcons AS INT.
FOR EACH gi_data_ferry_sum: DELETE gi_data_ferry_sum. END. 
FOR EACH gi_data_ferry:

    ASSIGN 
        /*
      gi_data_ferry.GrossAmount1 = (gi_data_ferry.VatableAmount + gi_data_ferry.Vat + gi_data_ferry.TransactionFee +
                                   gi_data_ferry.Penalty + gi_data_ferry.HandlingFee) - gi_data_ferry.AgentComm    
                                   */
      gi_data_ferry.GrossAmount1 = gi_data_ferry.CollectFromAgent - gi_data_ferry.AgentComm    
      gi_data_ferry.AgentComm1   = gi_data_ferry.AgentComm 
      gi_data_ferry.InputVat     = 0
        .

    ASSIGN 
      gi_data_ferry.Payable1     = gi_data_ferry.Payable
      gi_data_ferry.comm-income1 = (gi_data_ferry.CollectFromAgent - gi_data_ferry.Payable) 
      gi_data_ferry.OutputVat    = 0
        .

        .

    FIND gi_data_ferry_sum WHERE gi_data_ferry_sum.YearMonthFN = gi_data_ferry.YearMonth
                             AND gi_data_ferry_sum.party-name  = gi_data_ferry.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_ferry_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_ferry_sum.
        ASSIGN 
            gi_data_ferry_sum.YearMonth = gi_data_ferry.YearMonth
            gi_data_ferry_sum.YearMonthFN = gi_data_ferry.YearMonth
            gi_data_ferry_sum.alias-name  = gi_data_ferry.alias-name 
            gi_data_ferry_sum.party-name  = gi_data_ferry.party-name 
            gi_data_ferry_sum.ferry-sum-cons = pcons
            .
    END.

    ASSIGN
        gi_data_ferry_sum.NetFare          = gi_data_ferry_sum.NetFare           + gi_data_ferry.NetFare         
        gi_data_ferry_sum.ScDiscount       = gi_data_ferry_sum.ScDiscount        + gi_data_ferry.ScDiscount      
        gi_data_ferry_sum.DiscountFare     = gi_data_ferry_sum.DiscountFare      + gi_data_ferry.DiscountFare    
        gi_data_ferry_sum.Fuel             = gi_data_ferry_sum.Fuel              + gi_data_ferry.Fuel            
        gi_data_ferry_sum.SecurityFee      = gi_data_ferry_sum.SecurityFee       + gi_data_ferry.SecurityFee     
        gi_data_ferry_sum.TerminalFee      = gi_data_ferry_sum.TerminalFee       + gi_data_ferry.TerminalFee     
        gi_data_ferry_sum.Meal             = gi_data_ferry_sum.Meal              + gi_data_ferry.Meal            
        gi_data_ferry_sum.Insurance        = gi_data_ferry_sum.Insurance         + gi_data_ferry.Insurance       
        gi_data_ferry_sum.Linen            = gi_data_ferry_sum.Linen             + gi_data_ferry.Linen           
        gi_data_ferry_sum.VatableAmount    = gi_data_ferry_sum.VatableAmount     + gi_data_ferry.VatableAmount   
        gi_data_ferry_sum.Vat              = gi_data_ferry_sum.Vat               + gi_data_ferry.Vat             
        gi_data_ferry_sum.VatExempt        = gi_data_ferry_sum.VatExempt         + gi_data_ferry.VatExempt       
        gi_data_ferry_sum.ZeroVat          = gi_data_ferry_sum.ZeroVat           + gi_data_ferry.ZeroVat         
        gi_data_ferry_sum.TransactionFee   = gi_data_ferry_sum.TransactionFee    + gi_data_ferry.TransactionFee  
        gi_data_ferry_sum.Penalty          = gi_data_ferry_sum.Penalty           + gi_data_ferry.Penalty         
        gi_data_ferry_sum.HandlingFee      = gi_data_ferry_sum.HandlingFee       + gi_data_ferry.HandlingFee     
        gi_data_ferry_sum.SupplierComm     = gi_data_ferry_sum.SupplierComm      + gi_data_ferry.SupplierComm    
        .


    ASSIGN 
       /* gi_data_ferry_sum.GrossAmount      = gi_data_ferry_sum.GrossAmount      + gi_data_ferry.GrossAmount      */
        gi_data_ferry_sum.AgentComm        = gi_data_ferry_sum.AgentComm        + gi_data_ferry.AgentComm        
        gi_data_ferry_sum.CollectFromAgent = gi_data_ferry_sum.CollectFromAgent + gi_data_ferry.CollectFromAgent 
        gi_data_ferry_sum.Payable          = gi_data_ferry_sum.Payable          + gi_data_ferry.Payable          
        gi_data_ferry_sum.Profit           = gi_data_ferry_sum.Profit           + gi_data_ferry.Profit           
        .




    ASSIGN
        gi_data_ferry_sum.db-ControlAgent     = gi_data_ferry_sum.VatableAmount  + gi_data_ferry_sum.Vat     +      
                                             gi_data_ferry_sum.VatExempt      + gi_data_ferry_sum.ZeroVat +      
                                             gi_data_ferry_sum.TransactionFee + gi_data_ferry_sum.Penalty +      
                                             gi_data_ferry_sum.HandlingFee   - gi_data_ferry_sum.AgentComm 


        gi_data_ferry_sum.db-AgentComm      = gi_data_ferry_sum.AgentComm 
        gi_data_ferry_sum.cr-ferryPurchases = gi_data_ferry_sum.Payable
        gi_data_ferry_sum.cr-ferrySales     = gi_data_ferry_sum.TransactionFee  + gi_data_ferry_sum.Penalty       
        .


    ASSIGN 
      gi_data_ferry_sum.total-db         = gi_data_ferry_sum.db-AgentComm      + gi_data_ferry_sum.db-ControlAgent 
      gi_data_ferry_sum.total-cr         = gi_data_ferry_sum.cr-ferryPurchases  + gi_data_ferry_sum.cr-ferrySales       
      gi_data_ferry_sum.total-db-cr-diff = gi_data_ferry_sum.total-db  - gi_data_ferry_sum.total-cr
        .

    ASSIGN
        gi_data_ferry_sum.AutoGP = gi_data_ferry_sum.cr-ferrySales  - gi_data_ferry_sum.db-AgentComm
          gi_data_ferry_sum.DiffGP = gi_data_ferry_sum.AutoGP  - gi_data_ferry_sum.Profit 
        .



END. /* FOR EACH gi_data_ferry */
