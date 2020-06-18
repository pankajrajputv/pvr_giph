DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-ferry.csv".

MESSAGE "Deleting ferry data". PAUSE 0.
FOR EACH gi_data_ferry: 
    DELETE gi_data_ferry. 
END.

MESSAGE "Importing ferry Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    /*IMPORT UNFORMATTED ptext.*/
    CREATE gi_data_ferry.
    IMPORT DELIMITER "," 
        gi_data_ferry.YearMonth 
        gi_data_ferry.TravelAgentId
        gi_data_ferry.AgentName
        gi_data_ferry.TerminalId 
        gi_data_ferry.TerminalName 
        gi_data_ferry.ConfirmationNo 
        gi_data_ferry.TranDate-Txt 
        gi_data_ferry.TravelType 
        gi_data_ferry.TransType 
        gi_data_ferry.NoOfSegment 
        gi_data_ferry.NetFare 
        gi_data_ferry.ScDiscount 
        gi_data_ferry.DiscountFare 
        gi_data_ferry.Fuel 
        gi_data_ferry.SecurityFee 
        gi_data_ferry.TerminalFee 
        gi_data_ferry.Meal 
        gi_data_ferry.Insurance 
        gi_data_ferry.Linen 
        gi_data_ferry.VatableAmount 
        gi_data_ferry.Vat 
        gi_data_ferry.VatExempt 
        gi_data_ferry.ZeroVat
        gi_data_ferry.TransactionFee 
        gi_data_ferry.Penalty 
        gi_data_ferry.HandlingFee 
        gi_data_ferry.CollectFromAgent 
        gi_data_ferry.Payable 
        gi_data_ferry.Profit 
        gi_data_ferry.SupplierComm 
        gi_data_ferry.AgentComm 
        gi_data_ferry.MTAgentComm 
        gi_data_ferry.Operator 
        gi_data_ferry.date1 
        gi_data_ferry.ferry-cons 
        gi_data_ferry.party-name 
        gi_data_ferry.alias-name 

            /*
        gi_data_ferry.ErrorTxt 
        gi_data_ferry.InputVat 
        gi_data_ferry.OutputVat 
        gi_data_ferry.total-cr 
        gi_data_ferry.total-db 
        gi_data_ferry.total-db-cr-diff 
        gi_data_ferry.YearMonthFN 
              */

    /*ASSIGN gi_data_ferry.ferry-cons = pcons.*/

        NO-ERROR.

    IF DAY(gi_data_ferry.date1) >= 1 AND DAY(gi_data_ferry.date1) <= 15 THEN DO:
        ASSIGN gi_data_ferry.YearMonthFN = gi_data_ferry.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_ferry.date1) >= 16 AND DAY(gi_data_ferry.date1) <= 31 THEN DO:
        ASSIGN gi_data_ferry.YearMonthFN = gi_data_ferry.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_ferry.ferry-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + gi_data_ferry.CollectFromAgent.
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_ferry.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished ferry data import". PAUSE 0.

FOR EACH gi_data_ferry_sum: DELETE gi_data_ferry_sum. END. 
FOR EACH gi_data_ferry NO-LOCK:
    FIND gi_data_ferry_sum WHERE gi_data_ferry_sum.YearMonthFN = gi_data_ferry.YearMonthFN
                                 AND gi_data_ferry_sum.party-name  = gi_data_ferry.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_ferry_sum THEN DO:
        CREATE gi_data_ferry_sum.
        ASSIGN gi_data_ferry_sum.YearMonthFN = gi_data_ferry.YearMonthFN
               gi_data_ferry_sum.party-name  = gi_data_ferry.party-name 
            .
    END.
    ASSIGN 
        gi_data_ferry_sum.NetFare          = gi_data_ferry_sum.NetFare          + gi_data_ferry.NetFare           
        gi_data_ferry_sum.ScDiscount       = gi_data_ferry_sum.ScDiscount       + gi_data_ferry.ScDiscount      
        gi_data_ferry_sum.DiscountFare     = gi_data_ferry_sum.DiscountFare     + gi_data_ferry.DiscountFare    
        gi_data_ferry_sum.Fuel             = gi_data_ferry_sum.Fuel             + gi_data_ferry.Fuel            
        gi_data_ferry_sum.SecurityFee      = gi_data_ferry_sum.SecurityFee      + gi_data_ferry.SecurityFee     
        gi_data_ferry_sum.TerminalFee      = gi_data_ferry_sum.TerminalFee      + gi_data_ferry.TerminalFee     
        gi_data_ferry_sum.Meal             = gi_data_ferry_sum.Meal             + gi_data_ferry.Meal            
        gi_data_ferry_sum.Insurance        = gi_data_ferry_sum.Insurance        + gi_data_ferry.Insurance       
        gi_data_ferry_sum.Linen            = gi_data_ferry_sum.Linen            + gi_data_ferry.Linen           
        gi_data_ferry_sum.VatableAmount    = gi_data_ferry_sum.VatableAmount    + gi_data_ferry.VatableAmount   
        gi_data_ferry_sum.Vat              = gi_data_ferry_sum.Vat              + gi_data_ferry.Vat             
        gi_data_ferry_sum.VatExempt        = gi_data_ferry_sum.VatExempt        + gi_data_ferry.VatExempt       
        gi_data_ferry_sum.ZeroVat          = gi_data_ferry_sum.ZeroVat          + gi_data_ferry.ZeroVat         
        gi_data_ferry_sum.TransactionFee   = gi_data_ferry_sum.TransactionFee   + gi_data_ferry.TransactionFee  
        gi_data_ferry_sum.Penalty          = gi_data_ferry_sum.Penalty          + gi_data_ferry.Penalty         
        gi_data_ferry_sum.HandlingFee      = gi_data_ferry_sum.HandlingFee      + gi_data_ferry.HandlingFee     
        gi_data_ferry_sum.CollectFromAgent = gi_data_ferry_sum.CollectFromAgent + gi_data_ferry.CollectFromAgent
        gi_data_ferry_sum.Payable          = gi_data_ferry_sum.Payable          + gi_data_ferry.Payable         
        gi_data_ferry_sum.Profit           = gi_data_ferry_sum.Profit           + gi_data_ferry.Profit          
        gi_data_ferry_sum.SupplierComm     = gi_data_ferry_sum.SupplierComm     + gi_data_ferry.SupplierComm    
        gi_data_ferry_sum.AgentComm        = gi_data_ferry_sum.AgentComm        + gi_data_ferry.AgentComm       
        gi_data_ferry_sum.MTAgentComm      = gi_data_ferry_sum.MTAgentComm      + gi_data_ferry.MTAgentComm       
        gi_data_ferry_sum.Operator         = gi_data_ferry_sum.Operator         + gi_data_ferry.Operator        

        .

    ASSIGN 
        gi_data_ferry_sum.InputVat         = gi_data_ferry_sum.InputVat         + gi_data_ferry.InputVat        
        gi_data_ferry_sum.OutputVat        = gi_data_ferry_sum.OutputVat        + gi_data_ferry.OutputVat       
        gi_data_ferry_sum.total-cr         = gi_data_ferry_sum.total-cr         + gi_data_ferry.total-cr        
        gi_data_ferry_sum.total-db         = gi_data_ferry_sum.total-db         + gi_data_ferry.total-db        
        gi_data_ferry_sum.total-db-cr-diff = gi_data_ferry_sum.total-db-cr-diff + gi_data_ferry.total-db-cr-diff

        .

END. /* FOR EACH gi_data_ferry */

OUTPUT TO VALUE("c:\temp\data_ferry_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_ferry_error.txt"). 


