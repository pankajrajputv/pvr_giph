FOR EACH gi_data_mobile NO-LOCK:
    FIND gi_data_mobile_sum WHERE gi_data_mobile_sum.YearMonthFN = gi_data_mobile.YearMonthFN
                                 AND gi_data_mobile_sum.party-name  = gi_data_mobile.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_mobile_sum THEN DO:
        CREATE gi_data_mobile_sum.
        ASSIGN gi_data_mobile_sum.YearMonthFN = gi_data_mobile.YearMonthFN
               gi_data_mobile_sum.party-name  = gi_data_mobile.party-name 
            .
    END.
    ASSIGN 
        gi_data_mobile_sum.MrpValue           =  gi_data_mobile_sum.MrpValue           + gi_data_mobile.MrpValue           
        gi_data_mobile_sum.SupplierComm       =  gi_data_mobile_sum.SupplierComm       + gi_data_mobile.SupplierComm       
        gi_data_mobile_sum.Payable            =  gi_data_mobile_sum.Payable            + gi_data_mobile.Payable            
        gi_data_mobile_sum.AgentComm          =  gi_data_mobile_sum.AgentComm          + gi_data_mobile.AgentComm          
        gi_data_mobile_sum.CollectFromAgent1  =  gi_data_mobile_sum.CollectFromAgent1  + gi_data_mobile.CollectFromAgent1  
        gi_data_mobile_sum.TotalTssComm       =  gi_data_mobile_sum.TotalTssComm       + gi_data_mobile.TotalTssComm       
        gi_data_mobile_sum.Profit             =  gi_data_mobile_sum.Profit             + gi_data_mobile.Profit             

        .

    ASSIGN 
        gi_data_mobile_sum.InputVat         = gi_data_mobile_sum.InputVat         + gi_data_mobile.InputVat        
        gi_data_mobile_sum.OutputVat        = gi_data_mobile_sum.OutputVat        + gi_data_mobile.OutputVat       
        gi_data_mobile_sum.total-cr         = gi_data_mobile_sum.total-cr         + gi_data_mobile.total-cr        
        gi_data_mobile_sum.total-db         = gi_data_mobile_sum.total-db         + gi_data_mobile.total-db        
        gi_data_mobile_sum.total-db-cr-diff = gi_data_mobile_sum.total-db-cr-diff + gi_data_mobile.total-db-cr-diff

        .

END. /* FOR EACH gi_data_mobile */
