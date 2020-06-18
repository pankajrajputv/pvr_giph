DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".
DEF VAR pdate1 AS CHAR FORMAT "x(20)".
DEF VAR ptotal-amount AS DEC. 

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\Data-Bus.csv".

MESSAGE "Deleting bus data". PAUSE 0.
FOR EACH gi_data_bus: 
    DELETE gi_data_bus. 
END.

MESSAGE "Importing Bus Data". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IMPORT UNFORMATTED ptext.
    CREATE gi_data_bus.
    /*ASSIGN gi_data_bus.bus-cons = pcons.*/

    IMPORT DELIMITER "," 
        gi_data_bus.YearMonth                            
        gi_data_bus.bus-sr-no                            
        gi_data_bus.TravelAgentId                        
        gi_data_bus.CompanyName                          
        gi_data_bus.TerminalId                           
        gi_data_bus.TerminalName                         
        gi_data_bus.TransType                            
        gi_data_bus.TransactionId                        
        gi_data_bus.TransportPnr                         
        gi_data_bus.TranDate-Txt                         
        gi_data_bus.Amount                               
        gi_data_bus.ServiceCharge                        
        gi_data_bus.GrossAmount                          
        gi_data_bus.SupplierComm                         
        gi_data_bus.AgentComm                            
        gi_data_bus.CollectFromAgent                     
        gi_data_bus.Payable                              
        gi_data_bus.Profit                               
        gi_data_bus.date1                                
        gi_data_bus.bus-cons                             
        gi_data_bus.party-name                           
        gi_data_bus.alias-name                           
                                                                             

        /*
        gi_data_bus.ErrorTxt 
        gi_data_bus.InputVat 
        gi_data_bus.OutputVat 
        gi_data_bus.total-cr 
        gi_data_bus.total-db 
        gi_data_bus.total-db-cr-diff 
        gi_data_bus.YearMonthFN
          */
        NO-ERROR.

    IF DAY(gi_data_bus.date1) >= 1 AND DAY(gi_data_bus.date1) <= 15 THEN DO:
        ASSIGN gi_data_bus.YearMonthFN = gi_data_bus.YearMonth + "-" + "01".
    END.
    IF DAY(gi_data_bus.date1) >= 16 AND DAY(gi_data_bus.date1) <= 31 THEN DO:
        ASSIGN gi_data_bus.YearMonthFN = gi_data_bus.YearMonth + "-" + "02".
    END.


    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(gi_data_bus.bus-cons).
        MESSAGE "error" pcons.
    END.
    ELSE DO:
    END.
    */
    ASSIGN ptotal-amount = ptotal-amount + gi_data_bus.servicecharge.
    /*IF pcons = 159 THEN LEAVE.*/
    
    
    MESSAGE pcons gi_data_bus.YearMonthFN. 

END.
INPUT CLOSE.
MESSAGE "Finished bus data import". PAUSE 0.

FOR EACH gi_data_bus_sum: DELETE gi_data_bus_sum. END. 
FOR EACH gi_data_bus NO-LOCK:
    FIND gi_data_bus_sum WHERE gi_data_bus_sum.YearMonthFN = gi_data_bus.YearMonthFN
                                 AND gi_data_bus_sum.party-name  = gi_data_bus.party-name NO-ERROR.
    IF NOT AVAILABLE gi_data_bus_sum THEN DO:
        CREATE gi_data_bus_sum.
        ASSIGN gi_data_bus_sum.YearMonthFN = gi_data_bus.YearMonthFN
               gi_data_bus_sum.party-name  = gi_data_bus.party-name 
            .
    END.
    ASSIGN 
        gi_data_bus_sum.Amount             = gi_data_bus_sum.Amount           + gi_data_bus.Amount                            
        gi_data_bus_sum.ServiceCharge      = gi_data_bus_sum.ServiceCharge    + gi_data_bus.ServiceCharge                  
        gi_data_bus_sum.GrossAmount        = gi_data_bus_sum.GrossAmount      + gi_data_bus.GrossAmount                    
        gi_data_bus_sum.SupplierComm       = gi_data_bus_sum.SupplierComm     + gi_data_bus.SupplierComm                   
        gi_data_bus_sum.AgentComm          = gi_data_bus_sum.AgentComm        + gi_data_bus.AgentComm                      
        gi_data_bus_sum.CollectFromAgent   = gi_data_bus_sum.CollectFromAgent + gi_data_bus.CollectFromAgent               
        gi_data_bus_sum.Payable            = gi_data_bus_sum.Payable          + gi_data_bus.Payable                        
        gi_data_bus_sum.Profit             = gi_data_bus_sum.Profit           + gi_data_bus.Profit                         

        .

    ASSIGN 
        gi_data_bus_sum.InputVat         = gi_data_bus_sum.InputVat         + gi_data_bus.InputVat        
        gi_data_bus_sum.OutputVat        = gi_data_bus_sum.OutputVat        + gi_data_bus.OutputVat       
        gi_data_bus_sum.total-cr         = gi_data_bus_sum.total-cr         + gi_data_bus.total-cr        
        gi_data_bus_sum.total-db         = gi_data_bus_sum.total-db         + gi_data_bus.total-db        
        gi_data_bus_sum.total-db-cr-diff = gi_data_bus_sum.total-db-cr-diff + gi_data_bus.total-db-cr-diff

        .

END. /* FOR EACH gi_data_bus */



OUTPUT TO VALUE("c:\temp\data_bus_error.txt").
PUT  UNFORMATTED "Error: " perror      SKIP 1. 
PUT  UNFORMATTED "Total: " ptotal-amount.
OUTPUT CLOSE.


OS-COMMAND NO-WAIT VALUE("c:\temp\data_bus_error.txt"). 


