DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 
DEF VAR ptext1 AS CHAR EXTENT 10.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-mobile.csv".

MESSAGE "Deleting mobile data". PAUSE 0.
FOR EACH gi_data_mobile: 
    DELETE gi_data_mobile. 
END.

MESSAGE "Importing mobile Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IF pcons = 1 THEN DO:
        IMPORT UNFORMATTED ptext.
        NEXT.
    END.
    CREATE gi_data_mobile.
    /*ASSIGN gi_data_mobile.mobile-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_mobile.YearMonth                                
        gi_data_mobile.AgentName 
        gi_data_mobile.GroupDesc 
        gi_data_mobile.ItemDesc 
        gi_data_mobile.TransNo 
        gi_data_mobile.MobileNo 
        gi_data_mobile.RechargeDateTxt 
        gi_data_mobile.MrpValue 
        gi_data_mobile.SupplierComm 
        gi_data_mobile.Payable 
        gi_data_mobile.AgentComm 
        gi_data_mobile.Collectable
        gi_data_mobile.TotalTssComm 
        gi_data_mobile.Profit 
        pdate1 /*gi_data_mobile.date1 */
        gi_data_mobile.mobile-cons 
        gi_data_mobile.party-name 
        gi_data_mobile.alias-name 
        
        /*
        gi_data_mobile.ErrorTxt 
        gi_data_mobile.InputVat 
        gi_data_mobile.OutputVat 
        gi_data_mobile.total-cr 
        gi_data_mobile.total-db 
        gi_data_mobile.total-db-cr-diff 
        gi_data_mobile.TranDate-Txt 
        gi_data_mobile.YearMonth 
        gi_data_mobile.YearMonthFN
        */

        NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_mobile.mobile-cons).
        MESSAGE "import error" pcons. PAUSE.
    END.
    /*
    IF gi_data_mobile.mobile-cons = 0 THEN DO:
        DELETE gi_data_mobile.
        NEXT.
    END.
      */

    
    RUN C:\pvr\giph\lib\convert-text-to-mdy.p(INPUT gi_data_mobile.RechargeDateTxt, OUTPUT gi_data_mobile.date1).

    IF DAY(gi_data_mobile.date1) >= 1 AND DAY(gi_data_mobile.date1) <= 15 THEN DO:
        ASSIGN gi_data_mobile.YearMonthFN = gi_data_mobile.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_mobile.date1) >= 16 AND DAY(gi_data_mobile.date1) <= 31 THEN DO:
        ASSIGN gi_data_mobile.YearMonthFN = gi_data_mobile.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_mobile.mobile-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + CollectFromAgent1 NO-ERROR.
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_mobile.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished mobile data import". PAUSE 0.

FOR EACH gi_data_mobile_sum: DELETE gi_data_mobile_sum. END. 
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
        gi_data_mobile_sum.Collectable        =  gi_data_mobile_sum.Collectable        + gi_data_mobile.Collectable
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




OUTPUT TO VALUE("c:\temp\data_mobile_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_mobile_error.txt"). 




/*
DEF TEMP-TABLE det
    FIELD cons AS INT
    FIELD grossamount AS DEC
    INDEX idx AS PRIMARY UNIQUE cons.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-mobile-temp.csv".
MESSAGE "Importing mobile Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IMPORT UNFORMATTED ptext.
    CREATE gi_data_mobile.
    /*ASSIGN gi_data_mobile.mobile-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_mobile.YearMonth                
        gi_data_mobile.mobile-sr-no 
        .
END.
INPUT CLOSE.
  */
