DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 
DEF VAR ptext1 AS CHAR EXTENT 10.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-insurance.csv".

MESSAGE "Deleting insurance data". PAUSE 0.
FOR EACH gi_data_insurance: 
    DELETE gi_data_insurance. 
END.

MESSAGE "Importing insurance Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IF pcons = 1 THEN DO:
        IMPORT UNFORMATTED ptext.
        NEXT.
    END.
    CREATE gi_data_insurance.
    /*ASSIGN gi_data_insurance.insurance-cons = pcons.*/

    IMPORT DELIMITER "," 

        gi_data_insurance.YearMonth                                
        gi_data_insurance.TravelAgentId 
        gi_data_insurance.AgentName 
        gi_data_insurance.TerminalId 
        gi_data_insurance.TerminalName 
        gi_data_insurance.PolicyNo 
        gi_data_insurance.PassengerName 
        gi_data_insurance.TransactionId
        gi_data_insurance.TranDate-Txt 

        gi_data_insurance.TotalPremiumAmount 
        gi_data_insurance.SupplierComm 
        gi_data_insurance.AgentComm 
        gi_data_insurance.CollectFromAgent 
        gi_data_insurance.PayableToSupplier             
        gi_data_insurance.TranDate-Txt
        gi_data_insurance.TotalPremiumAmount 
        gi_data_insurance.wht
        gi_data_insurance.TotalComm
        gi_data_insurance.vat
        gi_data_insurance.GrossAgentComm
        gi_data_insurance.AgentCommTds
        gi_data_insurance.Profit 
        gi_data_insurance.currency
        gi_data_insurance.PayerName
        gi_data_insurance.TransType
        gi_data_insurance.date1 
        gi_data_insurance.insurance-cons 
        gi_data_insurance.party-name 
        gi_data_insurance.alias-name 
                                                          
        /*
        gi_data_insurance.YearMonth                                
        gi_data_insurance.TravelAgentId 
        gi_data_insurance.AgentName 
        gi_data_insurance.TerminalId 
        gi_data_insurance.TerminalName 
        gi_data_insurance.PolicyNo 
        gi_data_insurance.PassengerName 
        gi_data_insurance.BkPnr 
        gi_data_insurance.TranDate-Txt 
        gi_data_insurance.TotalPremiumAmount 
        gi_data_insurance.SupplierComm 
        gi_data_insurance.AgentComm 
        gi_data_insurance.CollectFromAgent 
        gi_data_insurance.PayableToSupplier 
        gi_data_insurance.Profit 
        gi_data_insurance.date1 
        gi_data_insurance.insurance-cons 
        gi_data_insurance.party-name 
        gi_data_insurance.alias-name 
          */

        /*
          gi_data_insurance.AgentComm 
          gi_data_insurance.AgentComm1 
          gi_data_insurance.AgentName 
          gi_data_insurance.alias-name 
          gi_data_insurance.BkPnr 
          gi_data_insurance.CollectFromAgent 
          gi_data_insurance.comm-income1 
          gi_data_insurance.date1 
          gi_data_insurance.ErrorTxt 
          gi_data_insurance.GrossAmount1 
          gi_data_insurance.InputVat 
          gi_data_insurance.insurance-cons 
          gi_data_insurance.OutputVat 
          gi_data_insurance.party-name 
          gi_data_insurance.PassengerName 
          gi_data_insurance.Payable 
          gi_data_insurance.Payable1 
          gi_data_insurance.PayableToSupplier 
          gi_data_insurance.PolicyNo 
          gi_data_insurance.Profit 
          gi_data_insurance.SupplierComm 
          gi_data_insurance.TerminalId 
          gi_data_insurance.TerminalName 
          gi_data_insurance.total-cr 
          gi_data_insurance.total-db 
          gi_data_insurance.total-db-cr-diff 
          gi_data_insurance.TotalPremiumAmount 
           
          gi_data_insurance.TravelAgentId 
          gi_data_insurance.YearMonth 
          gi_data_insurance.YearMonthFN
          */
        /*
    gi_data_insurance.ErrorTxt 
    gi_data_insurance.InputVat 
    gi_data_insurance.OutputVat 
    gi_data_insurance.total-cr 
    gi_data_insurance.total-db 
    gi_data_insurance.total-db-cr-diff 
    gi_data_insurance.YearMonth 
    gi_data_insurance.YearMonthFN
    */

        NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_insurance.insurance-cons).
        MESSAGE "import error" pcons. PAUSE.
    END.
    /*
    IF gi_data_insurance.insurance-cons = 0 THEN DO:
        DELETE gi_data_insurance.
        NEXT.
    END.
      */

    
    /*RUN C:\pvr\giph\lib\convert-text-to-mdy.p(INPUT gi_data_insurance.RechargeDateTxt, OUTPUT gi_data_insurance.date1).*/

    IF DAY(gi_data_insurance.date1) >= 1 AND DAY(gi_data_insurance.date1) <= 15 THEN DO:
        ASSIGN gi_data_insurance.YearMonthFN = gi_data_insurance.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_insurance.date1) >= 16 AND DAY(gi_data_insurance.date1) <= 31 THEN DO:
        ASSIGN gi_data_insurance.YearMonthFN = gi_data_insurance.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_insurance.insurance-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + AgentComm NO-ERROR.
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_insurance.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished insurance data import". PAUSE 0.


FOR EACH gi_data_insurance_sum: DELETE gi_data_insurance_sum. END. 
FOR EACH gi_data_insurance NO-LOCK:
    FIND gi_data_insurance_sum WHERE gi_data_insurance_sum.YearMonthFN = gi_data_insurance.YearMonthFN
                                 AND gi_data_insurance_sum.party-name  = gi_data_insurance.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_insurance_sum THEN DO:
        CREATE gi_data_insurance_sum.
        ASSIGN gi_data_insurance_sum.YearMonthFN = gi_data_insurance.YearMonthFN
               gi_data_insurance_sum.party-name  = gi_data_insurance.party-name 
            .
    END.
    ASSIGN 
        gi_data_insurance_sum.TotalPremiumAmount = gi_data_insurance_sum.TotalPremiumAmount + gi_data_insurance.TotalPremiumAmount
        gi_data_insurance_sum.SupplierComm       = gi_data_insurance_sum.SupplierComm       + gi_data_insurance.SupplierComm      
        gi_data_insurance_sum.AgentComm          = gi_data_insurance_sum.AgentComm          + gi_data_insurance.AgentComm         
        gi_data_insurance_sum.CollectFromAgent   = gi_data_insurance_sum.CollectFromAgent   + gi_data_insurance.CollectFromAgent  
        gi_data_insurance_sum.PayableToSupplier  = gi_data_insurance_sum.PayableToSupplier  + gi_data_insurance.PayableToSupplier 
        gi_data_insurance_sum.Profit             = gi_data_insurance_sum.Profit             + gi_data_insurance.Profit            

        .

    ASSIGN 
        gi_data_insurance_sum.InputVat         = gi_data_insurance_sum.InputVat         + gi_data_insurance.InputVat        
        gi_data_insurance_sum.OutputVat        = gi_data_insurance_sum.OutputVat        + gi_data_insurance.OutputVat       
        gi_data_insurance_sum.total-cr         = gi_data_insurance_sum.total-cr         + gi_data_insurance.total-cr        
        gi_data_insurance_sum.total-db         = gi_data_insurance_sum.total-db         + gi_data_insurance.total-db        
        gi_data_insurance_sum.total-db-cr-diff = gi_data_insurance_sum.total-db-cr-diff + gi_data_insurance.total-db-cr-diff

        .

END. /* FOR EACH gi_data_insurance */




OUTPUT TO VALUE("c:\temp\data_insurance_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_insurance_error.txt"). 




/*
DEF TEMP-TABLE det
    FIELD cons AS INT
    FIELD grossamount AS DEC
    INDEX idx AS PRIMARY UNIQUE cons.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-insurance-temp.csv".
MESSAGE "Importing insurance Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IMPORT UNFORMATTED ptext.
    CREATE gi_data_insurance.
    /*ASSIGN gi_data_insurance.insurance-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_insurance.YearMonth                
        gi_data_insurance.insurance-sr-no 
        .
END.
INPUT CLOSE.
  */
