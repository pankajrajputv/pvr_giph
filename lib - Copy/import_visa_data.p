DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 
DEF VAR ptext1 AS CHAR EXTENT 10.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-visa.csv".

MESSAGE "Deleting visa data". PAUSE 0.
FOR EACH gi_data_visa: 
    DELETE gi_data_visa. 
END.

MESSAGE "Importing visa Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IF pcons = 1 THEN DO:
        IMPORT UNFORMATTED ptext.
        NEXT.
    END.
    CREATE gi_data_visa.
    /*ASSIGN gi_data_visa.visa-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_visa.YearMonth                                
        gi_data_visa.visa-sr-no 
        gi_data_visa.TravelAgentId 
        gi_data_visa.AgentName 
        gi_data_visa.TerminalId 
        gi_data_visa.TerminalName
        gi_data_visa.TransactionId 
        gi_data_visa.TypeOfVisa 
        gi_data_visa.TranDate-Txt 
        gi_data_visa.EnteredBy 
        gi_data_visa.Country 
        gi_data_visa.Supplier 
        gi_data_visa.SellingPrice 
        gi_data_visa.MarkUpAmount 
        gi_data_visa.GrossAmount 
        gi_data_visa.AgentComm 
        gi_data_visa.CollectFromAgent 
        gi_data_visa.Payable 
        gi_data_visa.Profit 
        gi_data_visa.CourierCharges 
        gi_data_visa.Penalty 
        gi_data_visa.date1 
        gi_data_visa.visa-cons 
        gi_data_visa.party-name 
        gi_data_visa.alias-name 

        /*
        gi_data_visa.ErrorTxt 
        gi_data_visa.InputVat 
        gi_data_visa.OutputVat 
        gi_data_visa.total-cr 
        gi_data_visa.total-db 
        gi_data_visa.total-db-cr-diff 
        gi_data_visa.YearMonth 
        gi_data_visa.YearMonthFN
        */

        NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_visa.visa-cons).
        MESSAGE "import error" pcons. PAUSE.
    END.
    /*
    IF gi_data_visa.visa-cons = 0 THEN DO:
        DELETE gi_data_visa.
        NEXT.
    END.
      */

    RUN C:\pvr\giph\lib\convert-text-to-mdy.p(INPUT gi_data_visa.TranDate-Txt, OUTPUT gi_data_visa.date1).

    IF DAY(gi_data_visa.date1) >= 1 AND DAY(gi_data_visa.date1) <= 15 THEN DO:
        ASSIGN gi_data_visa.YearMonthFN = gi_data_visa.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_visa.date1) >= 16 AND DAY(gi_data_visa.date1) <= 31 THEN DO:
        ASSIGN gi_data_visa.YearMonthFN = gi_data_visa.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_visa.visa-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + grossamount NO-ERROR.
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_visa.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished visa data import". PAUSE 0.


RUN c:\pvr\giph\lib\VALIDATE_visa_data.p.
MESSAGE "Finished validate visa data". PAUSE 0.

OUTPUT TO VALUE("c:\temp\data_visa_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_visa_error.txt"). 




/*
DEF TEMP-TABLE det
    FIELD cons AS INT
    FIELD grossamount AS DEC
    INDEX idx AS PRIMARY UNIQUE cons.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-visa-temp.csv".
MESSAGE "Importing visa Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IMPORT UNFORMATTED ptext.
    CREATE gi_data_visa.
    /*ASSIGN gi_data_visa.visa-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_visa.YearMonth                
        gi_data_visa.visa-sr-no 
        .
END.
INPUT CLOSE.
  */
