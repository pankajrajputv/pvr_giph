DEF VAR ptext AS CHAR FORMAT "x(500)".
DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.
DEF VAR perror AS CHAR FORMAT "x(500)".

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\MTagent_account_statement.csv".

DEF VAR pMONTH AS CHAR FORMAT "x(20)".               
DEF VAR pMTAgentName  AS CHAR FORMAT "x(20)".        
DEF VAR pDateTime1  AS CHAR FORMAT "x(20)".          
DEF VAR pDescription  AS CHAR FORMAT "x(20)".        
DEF VAR pTransactionId  AS CHAR FORMAT "x(20)".      
DEF VAR pCreditAmount  AS CHAR FORMAT "x(20)".       
DEF VAR pDebitAmount  AS CHAR FORMAT "x(20)".        
DEF VAR pMtAgentRemaining  AS CHAR FORMAT "x(20)".   
DEF VAR pRemarks  AS CHAR FORMAT "x(20)".            
DEF VAR pODAmount  AS CHAR FORMAT "x(20)".           
DEF VAR pProduct  AS CHAR FORMAT "x(20)".            
DEF VAR pEnteredby  AS CHAR FORMAT "x(20)".          
DEF VAR pDateTime11  AS CHAR FORMAT "x(20)".         
DEF VAR pYearMonth  AS CHAR FORMAT "x(20)".          


/*
MESSAGE "Deleting agent data". PAUSE 0.
FOR EACH gi_mt_agent: 
    DELETE gi_mt_agent. 
END.


MESSAGE "Importing MTagent". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    IMPORT UNFORMATTED ptext.
    CREATE gi_mt_agent.
    /*ASSIGN gi_mt_agent.cons = pcons.*/
    IMPORT DELIMITER ","
        
        gi_mt_agent.MONTH                  
        gi_mt_agent.MTAgentName            
        gi_mt_agent.DateTime1              
        gi_mt_agent.Description            
        gi_mt_agent.TransactionId          
        gi_mt_agent.CreditAmount-txt           
        gi_mt_agent.DebitAmount-txt            
        gi_mt_agent.MtAgentRemaining-txt       
        gi_mt_agent.Remarks                
        /*
        pODAmount
        */
        
        gi_mt_agent.ODAmount-txt 

        gi_mt_agent.Product                
        gi_mt_agent.Enteredby              
        gi_mt_agent.DateTime11             
        gi_mt_agent.YearMonth1  
        gi_mt_agent.cons
        NO-ERROR.
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(pcons).
        MESSAGE "error" pcons.
    END.
    /*IF pcons = 159 THEN LEAVE.*/


END.
INPUT CLOSE.
MESSAGE "Finished MTagent data import". PAUSE 0.
  */

FOR EACH gi_mt_agent:
    ASSIGN pcons = gi_mt_agent.cons.
    MESSAGE "error" gi_mt_agent.cons "=" gi_mt_agent.CreditAmount-txt 
       /* " = " gi_mt_agent.Description */  . 
    ASSIGN 
        gi_mt_agent.CreditAmount         = DEC(gi_mt_agent.CreditAmount-txt)        
        /*
        gi_mt_agent.DebitAmount          = DEC(gi_mt_agent.DebitAmount-txt)         
        gi_mt_agent.MtAgentRemaining     = DEC(gi_mt_agent.MtAgentRemaining-txt)    
        gi_mt_agent.ODAmount             = DEC(gi_mt_agent.ODAmount-txt)         
        gi_mt_agent.DateTime11           = DATE(gi_mt_agent.DateTime11)           
        */
   /* NO-ERROR */.

    /*
    IF ERROR-STATUS:ERROR THEN DO:
        ASSIGN perror = perror + "," + STRING(pcons).
        MESSAGE "error" pcons.
        LEAVE.
    END.
      */

END.

OUTPUT TO VALUE("c:\temp\mt_error.txt").
PUT  UNFORMATTED perror.
OS-COMMAND NO-WAIT VALUE("c:\temp\mt_error.txt"). 


RUN c:\pvr\giph\lib\sync_transaction_id.p.
