DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-Hotel.csv".

MESSAGE "Deleting Hotel data". PAUSE 0.
FOR EACH gi_data_Hotel: 
    DELETE gi_data_Hotel. 
END.

MESSAGE "Importing Hotel Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    /*IMPORT UNFORMATTED ptext.*/
    CREATE gi_data_Hotel.
    IMPORT DELIMITER "," 
        gi_data_Hotel.YearMonth 
        gi_data_hotel.TransType 
        gi_data_hotel.TransactionId 
        gi_data_hotel.TerminalId 
        gi_data_hotel.CompanyName 
        gi_data_hotel.HotelName 
        gi_data_hotel.OperatorName 
        gi_data_hotel.TranDate-Txt 
        gi_data_hotel.CollectFromAgent 
        gi_data_hotel.AgentComm 
        gi_data_hotel.PayableToOperate 
        gi_data_hotel.Profit 
        gi_data_hotel.MTAgentComm 
        gi_data_hotel.date1 
        gi_data_hotel.hotel-cons 
        gi_data_hotel.party-name 
        gi_data_hotel.alias-name


/*
gi_data_hotel.ErrorTxt 
gi_data_hotel.InputVat 
gi_data_hotel.OutputVat 
gi_data_hotel.total-cr 
gi_data_hotel.total-db 
gi_data_hotel.total-db-cr-diff 
gi_data_hotel.YearMonthFN
  */

        NO-ERROR.

    IF DAY(gi_data_Hotel.date1) >= 1 AND DAY(gi_data_Hotel.date1) <= 15 THEN DO:
        ASSIGN gi_data_Hotel.YearMonthFN = gi_data_Hotel.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_Hotel.date1) >= 16 AND DAY(gi_data_Hotel.date1) <= 31 THEN DO:
        ASSIGN gi_data_Hotel.YearMonthFN = gi_data_Hotel.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_Hotel.Hotel-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + gi_data_Hotel.PayableToOperate .
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_Hotel.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished Hotel data import". PAUSE 0.

/*
FOR EACH gi_data_hotel_sum: DELETE gi_data_hotel_sum. END. 
FOR EACH gi_data_hotel NO-LOCK:
    FIND gi_data_hotel_sum WHERE gi_data_hotel_sum.YearMonthFN = gi_data_hotel.YearMonthFN
                             AND gi_data_hotel_sum.party-name  = gi_data_hotel.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_hotel_sum THEN DO:
        CREATE gi_data_hotel_sum.
        ASSIGN gi_data_hotel_sum.YearMonthFN = gi_data_hotel.YearMonthFN
               gi_data_hotel_sum.party-name  = gi_data_hotel.party-name 
            .
    END.
    ASSIGN 
        gi_data_hotel_sum.CollectFromAgent = gi_data_hotel_sum.CollectFromAgent  + gi_data_hotel.CollectFromAgent
        gi_data_hotel_sum.AgentComm        = gi_data_hotel_sum.AgentComm         + gi_data_hotel.AgentComm       
        gi_data_hotel_sum.PayableToOperate = gi_data_hotel_sum.PayableToOperate  + gi_data_hotel.PayableToOperate
        gi_data_hotel_sum.Profit           = gi_data_hotel_sum.Profit            + gi_data_hotel.Profit          
        gi_data_hotel_sum.MTAgentComm      = gi_data_hotel_sum.MTAgentComm       + gi_data_hotel.MTAgentComm     

        .

    ASSIGN 
        gi_data_hotel_sum.InputVat         = gi_data_hotel_sum.InputVat         + gi_data_hotel.InputVat        
        gi_data_hotel_sum.OutputVat        = gi_data_hotel_sum.OutputVat        + gi_data_hotel.OutputVat       
        gi_data_hotel_sum.total-cr         = gi_data_hotel_sum.total-cr         + gi_data_hotel.total-cr        
        gi_data_hotel_sum.total-db         = gi_data_hotel_sum.total-db         + gi_data_hotel.total-db        
        gi_data_hotel_sum.total-db-cr-diff = gi_data_hotel_sum.total-db-cr-diff + gi_data_hotel.total-db-cr-diff

        .

END. /* FOR EACH gi_data_hotel */
  */

RUN c:\pvr\giph\lib\VALIDATE_hotel_data.p.

OUTPUT TO VALUE("c:\temp\data_Hotel_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.

OS-COMMAND NO-WAIT VALUE("c:\temp\data_Hotel_error.txt"). 


