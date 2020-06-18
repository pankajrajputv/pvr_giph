DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\agent_account_statement.csv".
MESSAGE "Deleting agent data". PAUSE 0.
FOR EACH gi_agent: 
    DELETE gi_agent. 
END.

MESSAGE "Importing Agent". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    ASSIGN pcons = pcons + 1.
    CREATE gi_agent.
    IMPORT DELIMITER ","
        gi_agent.TravelAgentId
        gi_agent.CompanyName
        gi_agent.Datetime1
        gi_agent.Description
        gi_agent.TransactionId
        gi_agent.CreditAmount
        gi_agent.DebitAmount
        gi_agent.SmartRemaining
        gi_agent.Remarks
        gi_agent.Datetime2
        gi_agent.ODAmount
        gi_agent.EnteredBy
        gi_agent.TerminalName
        gi_agent.Productname
        gi_agent.Datetime11
        gi_agent.Datetime22
        gi_agent.YearMonth1
        gi_agent.YearMonth2
        NO-ERROR.
    ASSIGN gi_agent.cons = pcons.
    IF ERROR-STATUS:ERROR THEN DO:
        MESSAGE "error" pcons.
    END.

        .

END.
INPUT CLOSE.
MESSAGE "Finished agent data import". PAUSE 0.

RUN c:\pvr\giph\lib\sync_transaction_id.p.

