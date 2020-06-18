DEF VAR pcons AS INT.
FOR EACH gi_data_ecpay_sum: DELETE gi_data_ecpay_sum. END. 
FOR EACH gi_data_ecpay:

    ASSIGN 
      gi_data_ecpay.CollectFromAgent = gi_data_ecpay.TotalAmount
      gi_data_ecpay.GrossAmount1 = gi_data_ecpay.CollectFromAgent - gi_data_ecpay.AgentComm
      gi_data_ecpay.AgentComm1   = gi_data_ecpay.AgentComm 
      gi_data_ecpay.InputVat     = 0
        .

    ASSIGN 
      gi_data_ecpay.Payable1     = gi_data_ecpay.PayableToOperator
      gi_data_ecpay.comm-income1 = (gi_data_ecpay.TotalAmount - gi_data_ecpay.PayableToOperator) 
      gi_data_ecpay.OutputVat    = 0
        .

    ASSIGN 
      gi_data_ecpay.total-db = gi_data_ecpay.GrossAmount1 + gi_data_ecpay.AgentComm1 + gi_data_ecpay.InputVat       
      gi_data_ecpay.total-cr = gi_data_ecpay.Payable1 + gi_data_ecpay.comm-income1 + gi_data_ecpay.OutputVat 
      gi_data_ecpay.total-db-cr-diff = gi_data_ecpay.total-db - gi_data_ecpay.total-cr
        .

    FIND gi_data_ecpay_sum WHERE gi_data_ecpay_sum.YearMonthFN = gi_data_ecpay.YearMonthFN
                            AND gi_data_ecpay_sum.party-name  = gi_data_ecpay.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_ecpay_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_ecpay_sum.
        ASSIGN 
            gi_data_ecpay_sum.YearMonth = gi_data_ecpay.YearMonth
            gi_data_ecpay_sum.YearMonthFN = gi_data_ecpay.YearMonthFN
               gi_data_ecpay_sum.alias-name  = gi_data_ecpay.alias-name 
               gi_data_ecpay_sum.party-name  = gi_data_ecpay.party-name 
               gi_data_ecpay_sum.ecpay-sum-cons = pcons
            .
    END.

    ASSIGN
        gi_data_ecpay_sum.CollectFromAgent  = gi_data_ecpay_sum.CollectFromAgent  + gi_data_ecpay.CollectFromAgent       
        gi_data_ecpay_sum.TotalAmount       = gi_data_ecpay_sum.TotalAmount       + gi_data_ecpay.TotalAmount       
        gi_data_ecpay_sum.ConvenienceFee    = gi_data_ecpay_sum.ConvenienceFee    + gi_data_ecpay.ConvenienceFee    
        gi_data_ecpay_sum.PayableToOperator = gi_data_ecpay_sum.PayableToOperator + gi_data_ecpay.PayableToOperator 
        gi_data_ecpay_sum.MtAgentComm       = gi_data_ecpay_sum.MtAgentComm       + gi_data_ecpay.MtAgentComm       
        .

    ASSIGN 
        gi_data_ecpay_sum.AgentComm        = gi_data_ecpay_sum.AgentComm        + gi_data_ecpay.AgentComm        
        /*gi_data_ecpay_sum.CollectFromAgent = gi_data_ecpay_sum.CollectFromAgent + gi_data_ecpay.CollectFromAgent */
        /*gi_data_ecpay_sum.Payable          = gi_data_ecpay_sum.Payable          + gi_data_ecpay.Payable          */
        gi_data_ecpay_sum.Profit           = gi_data_ecpay_sum.Profit           + gi_data_ecpay.Profit           
        .

    ASSIGN 
      gi_data_ecpay_sum.GrossAmount1     = gi_data_ecpay_sum.GrossAmount1      + gi_data_ecpay.GrossAmount1    
      gi_data_ecpay_sum.AgentComm1       = gi_data_ecpay_sum.AgentComm1        + gi_data_ecpay.AgentComm1      
      gi_data_ecpay_sum.InputVat         = gi_data_ecpay_sum.InputVat          + gi_data_ecpay.InputVat        
      gi_data_ecpay_sum.Payable1         = gi_data_ecpay_sum.Payable1          + gi_data_ecpay.Payable1        
      gi_data_ecpay_sum.comm-income1     = gi_data_ecpay_sum.comm-income1      + gi_data_ecpay.comm-income1     
      gi_data_ecpay_sum.OutputVat        = gi_data_ecpay_sum.OutputVat         + gi_data_ecpay.OutputVat       
      gi_data_ecpay_sum.total-db         = gi_data_ecpay_sum.total-db          + gi_data_ecpay.total-db        
      gi_data_ecpay_sum.total-cr         = gi_data_ecpay_sum.total-cr          + gi_data_ecpay.total-cr        
      gi_data_ecpay_sum.total-db-cr-diff = gi_data_ecpay_sum.total-db          - gi_data_ecpay_sum.total-cr 
        .

END. /* FOR EACH gi_data_ecpay */
