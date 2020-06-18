DEF VAR pcons AS INT.
FOR EACH gi_data_mobile_sum: DELETE gi_data_mobile_sum. END. 

FOR EACH gi_data_mobile:

    ASSIGN 
        gi_data_mobile.GrossAmount1 = gi_data_mobile.CollectFromAgent 
        .

    ASSIGN 
        gi_data_mobile.Payable1     = gi_data_mobile.Payable
        gi_data_mobile.comm-income1 = (gi_data_mobile.SupplierComm)  
        gi_data_mobile.OutputVat    = 0
        .

    ASSIGN 
        gi_data_mobile.total-db = gi_data_mobile.GrossAmount1 /*+ gi_data_mobile.AgentComm1 + gi_data_mobile.InputVat       */
        gi_data_mobile.total-cr = gi_data_mobile.Payable1 + gi_data_mobile.comm-income1 + gi_data_mobile.OutputVat 
        gi_data_mobile.total-db-cr-diff = gi_data_mobile.total-db - gi_data_mobile.total-cr
        .

    FIND gi_data_mobile_sum WHERE gi_data_mobile_sum.YearMonthFN = gi_data_mobile.YearMonthFN
                              AND gi_data_mobile_sum.party-name  = gi_data_mobile.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_mobile_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_mobile_sum.
        ASSIGN 
            gi_data_mobile_sum.YearMonth = gi_data_mobile.YearMonth
            gi_data_mobile_sum.YearMonthFN = gi_data_mobile.YearMonthFN
               gi_data_mobile_sum.alias-name  = gi_data_mobile.alias-name 
               gi_data_mobile_sum.party-name  = gi_data_mobile.party-name 
               gi_data_mobile_sum.mobile-sum-cons = pcons
            .
    END.

    ASSIGN 
        gi_data_mobile_sum.MrpValue          = gi_data_mobile_sum.MrpValue          + gi_data_mobile.MrpValue         
        gi_data_mobile_sum.SupplierComm      = gi_data_mobile_sum.SupplierComm      + gi_data_mobile.SupplierComm     
        gi_data_mobile_sum.CollectFromAgent1 = gi_data_mobile_sum.CollectFromAgent1 + gi_data_mobile.CollectFromAgent1
        gi_data_mobile_sum.TotalTssComm      = gi_data_mobile_sum.TotalTssComm      + gi_data_mobile.TotalTssComm     
        .

    ASSIGN 
        /*gi_data_mobile_sum.MarkUpAmount     = gi_data_mobile_sum.MarkUpAmount     + gi_data_mobile.MarkUpAmount       */
        gi_data_mobile_sum.AgentComm        = gi_data_mobile_sum.AgentComm        + gi_data_mobile.AgentComm        
        gi_data_mobile_sum.CollectFromAgent = gi_data_mobile_sum.CollectFromAgent + gi_data_mobile.CollectFromAgent 
        gi_data_mobile_sum.Payable          = gi_data_mobile_sum.Payable          + gi_data_mobile.Payable          
        gi_data_mobile_sum.Profit           = gi_data_mobile_sum.Profit           + gi_data_mobile.Profit           
        .

    ASSIGN 
        gi_data_mobile_sum.GrossAmount1     = gi_data_mobile_sum.GrossAmount1      + gi_data_mobile.GrossAmount1    
        gi_data_mobile_sum.AgentComm1       = gi_data_mobile_sum.AgentComm1        + gi_data_mobile.AgentComm1      
        gi_data_mobile_sum.InputVat         = gi_data_mobile_sum.InputVat          + gi_data_mobile.InputVat        
        gi_data_mobile_sum.Payable1         = gi_data_mobile_sum.Payable1          + gi_data_mobile.Payable1        
        gi_data_mobile_sum.comm-income1     = gi_data_mobile_sum.comm-income1      + gi_data_mobile.comm-income1     
        gi_data_mobile_sum.OutputVat        = gi_data_mobile_sum.OutputVat         + gi_data_mobile.OutputVat       
        gi_data_mobile_sum.total-db         = gi_data_mobile_sum.total-db          + gi_data_mobile.total-db        
        gi_data_mobile_sum.total-cr         = gi_data_mobile_sum.total-cr          + gi_data_mobile.total-cr   
        .
    ASSIGN
        gi_data_mobile_sum.total-db-cr-diff = gi_data_mobile_sum.total-db          - gi_data_mobile_sum.total-cr

        .


 

END. /* FOR EACH gi_data_mobile */
