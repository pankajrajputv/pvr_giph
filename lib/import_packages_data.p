DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 
DEF VAR ptext1 AS CHAR EXTENT 10.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-packages.csv".

MESSAGE "Deleting packages data". PAUSE 0.
FOR EACH gi_data_packages: 
    DELETE gi_data_packages. 
END.

MESSAGE "Importing packages Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IF pcons = 1 THEN DO:
        IMPORT UNFORMATTED ptext.
        NEXT.
    END.
    CREATE gi_data_packages.
    /*ASSIGN gi_data_packages.packages-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_packages.YearMonth                                
        gi_data_packages.BookingType 
        gi_data_packages.TransId 
        gi_data_packages.TravelAgentId 
        gi_data_packages.TerminalId 
        gi_data_packages.PackageSupplier 
        gi_data_packages.PackageType 
        gi_data_packages.PackageDescription 
        gi_data_packages.BookingDate-txt
        gi_data_packages.SellingPrice 
        gi_data_packages.VatCollectable 
        gi_data_packages.Markup 
        gi_data_packages.TotalCollectable 
        gi_data_packages.TotalPayable 
        gi_data_packages.VATPayable 
        gi_data_packages.AgentComm 
        gi_data_packages.MTagentComm 
        gi_data_packages.Profit
        gi_data_packages.NoOfAdults 
        gi_data_packages.TravelDate 
        gi_data_packages.BookedBy 
        gi_data_packages.date1 
        gi_data_packages.packages-cons 
        gi_data_packages.party-name 
        gi_data_packages.alias-name
        

        /*
        gi_data_packages.CollectFromAgent 
        gi_data_packages.ErrorTxt 
        gi_data_packages.InputVat 
        gi_data_packages.OutputVat 
        gi_data_packages.party-name 
        gi_data_packages.Payable 
        gi_data_packages.total-cr 
        gi_data_packages.total-db 
        gi_data_packages.total-db-cr-diff 
        gi_data_packages.TranDate-Txt 
        gi_data_packages.YearMonth 
        gi_data_packages.YearMonthFN
          */





        NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_packages.packages-cons).
        MESSAGE "import error" pcons. PAUSE.
    END.
    /*
    IF gi_data_packages.packages-cons = 0 THEN DO:
        DELETE gi_data_packages.
        NEXT.
    END.
      */

    
    /*RUN C:\pvr\giph\lib\convert-text-to-mdy.p(INPUT gi_data_packages.BookingDate, OUTPUT gi_data_packages.date1).*/
    
    IF DAY(gi_data_packages.date1) >= 1 AND DAY(gi_data_packages.date1) <= 15 THEN DO:
        ASSIGN gi_data_packages.YearMonthFN = gi_data_packages.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_packages.date1) >= 16 AND DAY(gi_data_packages.date1) <= 31 THEN DO:
        ASSIGN gi_data_packages.YearMonthFN = gi_data_packages.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_packages.packages-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + TotalPayable NO-ERROR.
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_packages.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished packages data import". PAUSE 0.
MESSAGE 1
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

FOR EACH gi_data_packages_sum: DELETE gi_data_packages_sum. END. 
FOR EACH gi_data_packages NO-LOCK:
    FIND gi_data_packages_sum WHERE gi_data_packages_sum.YearMonthFN = gi_data_packages.YearMonthFN
                                 AND gi_data_packages_sum.party-name  = gi_data_packages.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_packages_sum THEN DO:
        CREATE gi_data_packages_sum.
        ASSIGN gi_data_packages_sum.YearMonthFN = gi_data_packages.YearMonthFN
               gi_data_packages_sum.party-name  = gi_data_packages.party-name 
            .
    END.
    ASSIGN 
        gi_data_packages_sum.SellingPrice     = gi_data_packages_sum.SellingPrice     + gi_data_packages.SellingPrice     
        gi_data_packages_sum.VatCollectable   = gi_data_packages_sum.VatCollectable   + gi_data_packages.VatCollectable   
        gi_data_packages_sum.Markup           = gi_data_packages_sum.Markup           + gi_data_packages.Markup           
        gi_data_packages_sum.TotalCollectable = gi_data_packages_sum.TotalCollectable + gi_data_packages.TotalCollectable 
        gi_data_packages_sum.TotalPayable     = gi_data_packages_sum.TotalPayable     + gi_data_packages.TotalPayable     
        gi_data_packages_sum.VATPayable       = gi_data_packages_sum.VATPayable       + gi_data_packages.VATPayable       
        gi_data_packages_sum.AgentComm        = gi_data_packages_sum.AgentComm        + gi_data_packages.AgentComm        
        gi_data_packages_sum.MTagentComm      = gi_data_packages_sum.MTagentComm      + gi_data_packages.MTagentComm      
        gi_data_packages_sum.Profit           = gi_data_packages_sum.Profit           + gi_data_packages.Profit           

        .

    ASSIGN 
        gi_data_packages_sum.InputVat         = gi_data_packages_sum.InputVat         + gi_data_packages.InputVat        
        gi_data_packages_sum.OutputVat        = gi_data_packages_sum.OutputVat        + gi_data_packages.OutputVat       
        gi_data_packages_sum.total-cr         = gi_data_packages_sum.total-cr         + gi_data_packages.total-cr        
        gi_data_packages_sum.total-db         = gi_data_packages_sum.total-db         + gi_data_packages.total-db        
        gi_data_packages_sum.total-db-cr-diff = gi_data_packages_sum.total-db-cr-diff + gi_data_packages.total-db-cr-diff

        .

END. /* FOR EACH gi_data_packages */




OUTPUT TO VALUE("c:\temp\data_packages_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_packages_error.txt"). 




/*
DEF TEMP-TABLE det
    FIELD cons AS INT
    FIELD grossamount AS DEC
    INDEX idx AS PRIMARY UNIQUE cons.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-packages-temp.csv".
MESSAGE "Importing packages Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IMPORT UNFORMATTED ptext.
    CREATE gi_data_packages.
    /*ASSIGN gi_data_packages.packages-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_packages.YearMonth                
        gi_data_packages.packages-sr-no 
        .
END.
INPUT CLOSE.
  */
