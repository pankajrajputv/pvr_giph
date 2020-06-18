DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-EcPay.csv".

MESSAGE "Deleting EcPay data". PAUSE 0.
FOR EACH gi_data_EcPay: 
    DELETE gi_data_EcPay. 
END.

MESSAGE "Importing EcPay Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    /*IMPORT UNFORMATTED ptext.*/
    CREATE gi_data_EcPay.
    IMPORT DELIMITER "," 
        gi_data_EcPay.YearMonth 
        gi_data_ecpay.ecpay-sr-no 
        gi_data_ecpay.TranDate-Txt 
        gi_data_ecpay.TravelAgentId 
        gi_data_ecpay.CompanyName 
        gi_data_ecpay.TraceNumber 
        gi_data_ecpay.CustomerId 
        gi_data_ecpay.BiyahekoPNR 
        gi_data_ecpay.TotalAmount 
        gi_data_ecpay.ConvenienceFee 
        gi_data_ecpay.PayableToOperator 
        gi_data_ecpay.AgentComm 
        gi_data_ecpay.MtAgentComm 
        gi_data_ecpay.Profit 
        gi_data_ecpay.date1 
        gi_data_ecpay.ecpay-cons 
        gi_data_ecpay.party-name 
        gi_data_ecpay.alias-name 


/*
gi_data_ecpay.ErrorTxt 
gi_data_ecpay.InputVat 
gi_data_ecpay.OutputVat 
gi_data_ecpay.total-cr 
gi_data_ecpay.total-db 
gi_data_ecpay.total-db-cr-diff 
gi_data_ecpay.YearMonth 
gi_data_ecpay.YearMonthFN
  */

        NO-ERROR.

    IF DAY(gi_data_EcPay.date1) >= 1 AND DAY(gi_data_EcPay.date1) <= 15 THEN DO:
        ASSIGN gi_data_EcPay.YearMonthFN = gi_data_EcPay.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_EcPay.date1) >= 16 AND DAY(gi_data_EcPay.date1) <= 31 THEN DO:
        ASSIGN gi_data_EcPay.YearMonthFN = gi_data_EcPay.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_EcPay.EcPay-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + gi_data_EcPay.PayableToOperator .
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_EcPay.YearMonthFN. 

END.
INPUT CLOSE.

MESSAGE "Finished EcPay data import". PAUSE 0.

FOR EACH gi_data_EcPay_sum: DELETE gi_data_EcPay_sum. END. 
FOR EACH gi_data_EcPay  NO-LOCK:
    FIND gi_data_EcPay_sum WHERE gi_data_EcPay_sum.YearMonthFN = gi_data_EcPay.YearMonthFN
                                 AND gi_data_EcPay_sum.party-name  = gi_data_EcPay.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_EcPay_sum THEN DO:
        CREATE gi_data_EcPay_sum.
        ASSIGN gi_data_EcPay_sum.YearMonthFN = gi_data_EcPay.YearMonthFN
               gi_data_EcPay_sum.party-name  = gi_data_EcPay.party-name 
            .
    END.
    ASSIGN 
        gi_data_ecpay_sum.TotalAmount       = gi_data_ecpay_sum.TotalAmount       + gi_data_ecpay.TotalAmount       
        gi_data_ecpay_sum.ConvenienceFee    = gi_data_ecpay_sum.ConvenienceFee    + gi_data_ecpay.ConvenienceFee    
        gi_data_ecpay_sum.PayableToOperator = gi_data_ecpay_sum.PayableToOperator + gi_data_ecpay.PayableToOperator 
        gi_data_ecpay_sum.AgentComm         = gi_data_ecpay_sum.AgentComm         + gi_data_ecpay.AgentComm         
        gi_data_ecpay_sum.MtAgentComm       = gi_data_ecpay_sum.MtAgentComm       + gi_data_ecpay.MtAgentComm       
        gi_data_ecpay_sum.Profit            = gi_data_ecpay_sum.Profit            + gi_data_ecpay.Profit            

        .

    ASSIGN 
        gi_data_EcPay_sum.InputVat         = gi_data_EcPay_sum.InputVat         + gi_data_EcPay.InputVat        
        gi_data_EcPay_sum.OutputVat        = gi_data_EcPay_sum.OutputVat        + gi_data_EcPay.OutputVat       
        gi_data_EcPay_sum.total-cr         = gi_data_EcPay_sum.total-cr         + gi_data_EcPay.total-cr        
        gi_data_EcPay_sum.total-db         = gi_data_EcPay_sum.total-db         + gi_data_EcPay.total-db        
        gi_data_EcPay_sum.total-db-cr-diff = gi_data_EcPay_sum.total-db-cr-diff + gi_data_EcPay.total-db-cr-diff

        .

END. /* FOR EACH gi_data_EcPay */



OUTPUT TO VALUE("c:\temp\data_EcPay_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_EcPay_error.txt"). 


