DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR pissueddate-txt AS CHAR.
DEF VAR perror AS CHAR FORMAT "x(500)".

DEF TEMP-TABLE tt_gi_data_airline LIKE gi_data_airline.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\AirlinewiseTicketDetails.csv".
MESSAGE "Deleting agent data". PAUSE 0.

FOR EACH gi_data_airline: 
    DELETE gi_data_airline. 
END.
FOR EACH gi_data_airline_sum: 
    DELETE gi_data_airline_sum. 
END.

DEF VAR ptotal-amount AS DEC.


MESSAGE "Importing Agent". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    CREATE tt_gi_data_airline.
    IMPORT DELIMITER ","

        tt_gi_data_airline.YearMonth
        tt_gi_data_airline.TrnsType	
        tt_gi_data_airline.AirlinesName	
        tt_gi_data_airline.AgentName	
        tt_gi_data_airline.TravelAgentId	
        tt_gi_data_airline.IATAStock	
        tt_gi_data_airline.BKPNR	
        tt_gi_data_airline.AirlinePNR	
        tt_gi_data_airline.CRSPNR	
        tt_gi_data_airline.TicketNumber	
        tt_gi_data_airline.TravelType	
        tt_gi_data_airline.MTAgentName	
        tt_gi_data_airline.SalesPersonName	
        tt_gi_data_airline.IssuedDate-txt
        tt_gi_data_airline.NoOfSegments	
        tt_gi_data_airline.Segments	
        tt_gi_data_airline.BasicAmt	
        tt_gi_data_airline.Tax	
        tt_gi_data_airline.TopUpAmt	
        tt_gi_data_airline.MtagentComm
        tt_gi_data_airline.TransFee	
        tt_gi_data_airline.Penalty	
        tt_gi_data_airline.AgentComm
        tt_gi_data_airline.CollectFromAgent	
        tt_gi_data_airline.SupplierComm
        tt_gi_data_airline.PayableToAirline	
        tt_gi_data_airline.SegmentFee	
        tt_gi_data_airline.Profit
        tt_gi_data_airline.ClassCode
        tt_gi_data_airline.IssuedDate	
        tt_gi_data_airline.Airline-Cons
        tt_gi_data_airline.party-name
        tt_gi_data_airline.alias-name


    NO-ERROR.
    /*ASSIGN tt_gi_data_airline.airline-cons = pcons.*/
    IF ERROR-STATUS:ERROR THEN DO:
        MESSAGE "error" pcons.
        ASSIGN perror = perror + "," + STRING(pcons).
        /*
        ASSIGN tt_gi_data_airline.errortxt = STRING(pcons) + "-"  + 
            STRING(tt_gi_data_airline.Airline-Cons).
            */
    END.
    ELSE DO:
        ASSIGN ptotal-amount = ptotal-amount + tt_gi_data_airline.topupamt.
        IF tt_gi_data_airline.airline-cons > 0 THEN DO:
            FIND gi_data_airline WHERE gi_data_airline.airline-cons = tt_gi_data_airline.airline-cons NO-ERROR.
            IF NOT AVAILABLE gi_data_airline THEN DO:
                CREATE gi_data_airline.
                BUFFER-COPY tt_gi_data_airline TO gi_data_airline.
                /*ASSIGN ptotal-amount = ptotal-amount + gi_data_airline.topupamt.*/
            END.
        END.
    END.
    DELETE tt_gi_data_airline.
    RELEASE gi_data_airline.
END.
INPUT CLOSE.

/****VALIDATE DATA ******/
/*
RUN c:\pvr\giph\lib\validate_airline_data.p.
  */
MESSAGE "total topup" ptotal-amount
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
MESSAGE "Finished agent data import". PAUSE 0.



OUTPUT TO VALUE("c:\temp\data_airline_error.txt").
PUT  UNFORMATTED perror.
OS-COMMAND NO-WAIT VALUE("c:\temp\data_airline_error.txt"). 


/*
RUN c:\pvr\giph\lib\sync_transaction_id.p.
  */
