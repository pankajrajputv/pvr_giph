DEF VAR pcons AS INT.
FOR EACH gi_data_insurance_sum: 
    MESSAGE gi_data_insurance_sum.InputVat gi_data_insurance_sum.OutputVat. PAUSE 0.
    DELETE gi_data_insurance_sum. 
END. 
FOR EACH gi_data_insurance /*WHERE gi_data_insurance.insurance-cons = 1849*/:
    ASSIGN gi_data_insurance.payable = gi_data_insurance.payabletosupplier.

    ASSIGN 
      gi_data_insurance.GrossAmount1  = gi_data_insurance.CollectFromAgent
      gi_data_insurance.AgentComm1    = gi_data_insurance.AgentComm 
      gi_data_insurance.InputVat      = 0
        .

    ASSIGN 
      gi_data_insurance.Payable1     = gi_data_insurance.Payable
      gi_data_insurance.comm-income1 = (gi_data_insurance.TotalPremiumAmount - gi_data_insurance.payable) 
      gi_data_insurance.OutputVat    = 0
        .



    FIND gi_data_insurance_sum WHERE gi_data_insurance_sum.YearMonthFN = gi_data_insurance.YearMonth
                                 AND gi_data_insurance_sum.party-name  = gi_data_insurance.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_insurance_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_insurance_sum.
        ASSIGN 
            gi_data_insurance_sum.YearMonth = gi_data_insurance.YearMonth
            gi_data_insurance_sum.YearMonthFN = gi_data_insurance.YearMonth
               gi_data_insurance_sum.alias-name  = gi_data_insurance.alias-name 
               gi_data_insurance_sum.party-name  = gi_data_insurance.party-name 
               gi_data_insurance_sum.insurance-sum-cons = pcons
            .
    END.




    ASSIGN 
        gi_data_insurance_sum.TotalPremiumAmount = gi_data_insurance_sum.TotalPremiumAmount + gi_data_insurance.TotalPremiumAmount
        gi_data_insurance_sum.SupplierComm       = gi_data_insurance_sum.SupplierComm       + gi_data_insurance.SupplierComm      
        gi_data_insurance_sum.AgentComm          = gi_data_insurance_sum.AgentComm          + gi_data_insurance.AgentComm         
        gi_data_insurance_sum.CollectFromAgent   = gi_data_insurance_sum.CollectFromAgent   + gi_data_insurance.CollectFromAgent  
        gi_data_insurance_sum.PayableToSupplier  = gi_data_insurance_sum.PayableToSupplier  + gi_data_insurance.PayableToSupplier         
        gi_data_insurance_sum.PremiumComm        = gi_data_insurance_sum.PremiumComm        + gi_data_insurance.PremiumComm
        gi_data_insurance_sum.wht                = gi_data_insurance_sum.wht                + gi_data_insurance.wht               
        gi_data_insurance_sum.TotalComm          = gi_data_insurance_sum.TotalComm          + gi_data_insurance.TotalComm         
        gi_data_insurance_sum.vat                = gi_data_insurance_sum.vat                + gi_data_insurance.vat               
        gi_data_insurance_sum.GrossAgentComm     = gi_data_insurance_sum.GrossAgentComm     + gi_data_insurance.GrossAgentComm    
        gi_data_insurance_sum.AgentCommTds       = gi_data_insurance_sum.AgentCommTds       + gi_data_insurance.AgentCommTds      
        gi_data_insurance_sum.Profit             = gi_data_insurance_sum.Profit             + gi_data_insurance.Profit            
        .

    ASSIGN
        gi_data_Insurance_sum.db-ControlAgent       = gi_data_insurance_sum.CollectFromAgent 
        gi_data_Insurance_sum.db-AgentComm          = gi_data_Insurance_sum.AgentComm 
        gi_data_Insurance_sum.cr-InsurancePurchases = gi_data_insurance_sum.PayableToSupplier
        gi_data_Insurance_sum.cr-InsuranceSales     = gi_data_insurance_sum.CollectFromAgent + gi_data_insurance_sum.AgentComm - gi_data_insurance_sum.PayableToSupplier        
        .



    ASSIGN 
        gi_data_Insurance_sum.total-db         = gi_data_Insurance_sum.db-AgentComm      + gi_data_Insurance_sum.db-ControlAgent 
        gi_data_Insurance_sum.total-cr         = gi_data_Insurance_sum.cr-InsurancePurchases  + gi_data_Insurance_sum.cr-InsuranceSales       
        gi_data_Insurance_sum.total-db-cr-diff = gi_data_Insurance_sum.total-db  - gi_data_Insurance_sum.total-cr
          .

    ASSIGN
        gi_data_Insurance_sum.AutoGP = gi_data_Insurance_sum.cr-InsuranceSales  - gi_data_Insurance_sum.db-AgentComm
          gi_data_Insurance_sum.DiffGP = gi_data_Insurance_sum.AutoGP  - gi_data_Insurance_sum.Profit 
        .


END. /* FOR EACH gi_data_insurance */
