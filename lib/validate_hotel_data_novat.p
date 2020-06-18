DEF VAR pcons AS INT.
FOR EACH gi_data_hotel_sum: DELETE gi_data_hotel_sum. END. 
FOR EACH gi_data_hotel:

    ASSIGN 
        gi_data_hotel.GrossAmount1 = gi_data_hotel.CollectFromAgent 
        gi_data_hotel.AgentComm1   = gi_data_hotel.AgentComm 
        gi_data_hotel.InputVat     = 0
        gi_data_hotel.MTAgentComm1 = gi_data_hotel.MTAgentComm

        .

    ASSIGN 
        gi_data_hotel.MTAgentComm2 = gi_data_hotel.MTAgentComm
        gi_data_hotel.Payable1     = gi_data_hotel.PayableToOperate
        gi_data_hotel.comm-income1 = (gi_data_hotel.CollectFromAgent + gi_data_hotel.AgentComm - gi_data_hotel.PayableToOperate) 
        gi_data_hotel.OutputVat    = 0
        .

    ASSIGN 
        gi_data_hotel.total-db = gi_data_hotel.GrossAmount1 + gi_data_hotel.AgentComm1 + gi_data_hotel.InputVat     + gi_data_hotel.MTAgentComm1
        gi_data_hotel.total-cr = gi_data_hotel.MTAgentComm2 + gi_data_hotel.Payable1   + gi_data_hotel.comm-income1 + gi_data_hotel.OutputVat   
        gi_data_hotel.total-db-cr-diff = gi_data_hotel.total-db - gi_data_hotel.total-cr
        .

    FIND gi_data_hotel_sum WHERE gi_data_hotel_sum.YearMonthFN = gi_data_hotel.YearMonth
                             AND gi_data_hotel_sum.party-name  = gi_data_hotel.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_hotel_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_hotel_sum.
        ASSIGN 
            gi_data_hotel_sum.YearMonth   = gi_data_hotel.YearMonth
            gi_data_hotel_sum.YearMonthFN = gi_data_hotel.YearMonth
               gi_data_hotel_sum.alias-name  = gi_data_hotel.alias-name 
               gi_data_hotel_sum.party-name  = gi_data_hotel.party-name 
               gi_data_hotel_sum.hotel-sum-cons = pcons
            .
    END.
    FIND gi_data_hotel_sum WHERE gi_data_hotel_sum.YearMonthFN = gi_data_hotel.YearMonth
                             AND gi_data_hotel_sum.party-name  = gi_data_hotel.party-name NO-ERROR.


    ASSIGN
        gi_data_hotel_sum.CollectFromAgent = gi_data_hotel_sum.CollectFromAgent + gi_data_hotel.CollectFromAgent
        gi_data_hotel_sum.AgentComm        = gi_data_hotel_sum.AgentComm        + gi_data_hotel.AgentComm        
        gi_data_hotel_sum.PayableToOperate = gi_data_hotel_sum.PayableToOperate + gi_data_hotel.PayableToOperate
        gi_data_hotel_sum.Profit           = gi_data_hotel_sum.Profit           + gi_data_hotel.Profit           
        gi_data_hotel_sum.MTAgentComm      = gi_data_hotel_sum.MTAgentComm      + gi_data_hotel.MTAgentComm     

        .

    ASSIGN
        gi_data_hotel_sum.db-ControlAgent   = gi_data_hotel_sum.CollectFromAgent
        gi_data_hotel_sum.db-AgentComm      = gi_data_hotel_sum.AgentComm + gi_data_hotel_sum.MTAgentComm

        gi_data_hotel_sum.cr-hotelPurchases = gi_data_hotel_sum.PayableToOperate  
        gi_data_hotel_sum.cr-MasterSuperStockist = gi_data_hotel_sum.MTAgentComm
        gi_data_hotel_sum.cr-hotelSales     = gi_data_hotel_sum.CollectFromAgent + gi_data_hotel_sum.AgentComm - gi_data_hotel_sum.PayableToOperate      
        .

    ASSIGN 
        gi_data_hotel_sum.total-db         = gi_data_hotel_sum.db-ControlAgent + gi_data_hotel_sum.db-AgentComm
        gi_data_hotel_sum.total-cr         = gi_data_hotel_sum.cr-hotelPurchases + gi_data_hotel_sum.cr-hotelSales + gi_data_hotel_sum.cr-MasterSuperStockist        
        gi_data_hotel_sum.total-db-cr-diff = gi_data_hotel_sum.total-db  - gi_data_hotel_sum.total-cr
        .

    ASSIGN
        gi_data_hotel_sum.AutoGP = gi_data_hotel_sum.cr-hotelSales - gi_data_hotel_sum.db-AgentComm
        gi_data_hotel_sum.DiffGP = gi_data_hotel_sum.AutoGP  - gi_data_hotel_sum.Profit 
        .


END. /* FOR EACH gi_data_hotel */
