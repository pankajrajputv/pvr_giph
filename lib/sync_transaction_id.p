
FOR EACH gi_agent:
    IF DAY(gi_agent.Datetime11) >= 1 AND DAY(gi_agent.Datetime11) <= 15 THEN DO:
        ASSIGN gi_agent.YearMonth1FN = gi_agent.YearMonth1 + "-" + "01".
    END.
    IF DAY(gi_agent.Datetime11) >= 16 AND DAY(gi_agent.Datetime11) <= 31 THEN DO:
        ASSIGN gi_agent.YearMonth1FN = gi_agent.YearMonth1 + "-" + "02".
    END.

    IF DAY(gi_agent.Datetime11) >= 1 AND DAY(gi_agent.Datetime11) <= 7 THEN DO:
        ASSIGN gi_agent.YearMonth1Week = gi_agent.YearMonth1 + "-" + "01".
    END.
    IF DAY(gi_agent.Datetime11) >= 8 AND DAY(gi_agent.Datetime11) <= 14 THEN DO:
        ASSIGN gi_agent.YearMonth1Week = gi_agent.YearMonth1 + "-" + "02".
    END.
    IF DAY(gi_agent.Datetime11) >= 15 AND DAY(gi_agent.Datetime11) <= 21 THEN DO:
        ASSIGN gi_agent.YearMonth1Week = gi_agent.YearMonth1 + "-" + "03".
    END.
    IF DAY(gi_agent.Datetime11) >= 22 AND DAY(gi_agent.Datetime11) <= 28 THEN DO:
        ASSIGN gi_agent.YearMonth1Week = gi_agent.YearMonth1 + "-" + "04".
    END.
    IF DAY(gi_agent.Datetime11) >= 29 AND DAY(gi_agent.Datetime11) <= 31 THEN DO:
        ASSIGN gi_agent.YearMonth1Week = gi_agent.YearMonth1 + "-" + "05".
    END.



    FIND gi_transaction_id WHERE gi_transaction_id.transactionid = gi_agent.transactionid NO-LOCK NO-ERROR.
    IF NOT AVAILABLE gi_transaction_id THEN DO:
        CREATE gi_transaction_id.
        ASSIGN gi_transaction_id.transactionid = gi_agent.transactionid.
    END.
END.

FOR EACH gi_mt_agent:

    IF DAY(gi_mt_agent.Datetime11) >= 1 AND DAY(gi_mt_agent.Datetime11) <= 15 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1FN = gi_mt_agent.YearMonth1 + "-" + "01".
    END.
    IF DAY(gi_mt_agent.Datetime11) >= 16 AND DAY(gi_mt_agent.Datetime11) <= 31 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1FN = gi_mt_agent.YearMonth1 + "-" + "02".
    END.

    IF DAY(gi_mt_agent.Datetime11) >= 1 AND DAY(gi_mt_agent.Datetime11) <= 7 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1Week = gi_mt_agent.YearMonth1 + "-" + "01".
    END.
    IF DAY(gi_mt_agent.Datetime11) >= 8 AND DAY(gi_mt_agent.Datetime11) <= 14 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1Week = gi_mt_agent.YearMonth1 + "-" + "02".
    END.
    IF DAY(gi_mt_agent.Datetime11) >= 15 AND DAY(gi_mt_agent.Datetime11) <= 21 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1Week = gi_mt_agent.YearMonth1 + "-" + "03".
    END.
    IF DAY(gi_mt_agent.Datetime11) >= 22 AND DAY(gi_mt_agent.Datetime11) <= 28 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1Week = gi_mt_agent.YearMonth1 + "-" + "04".
    END.
    IF DAY(gi_mt_agent.Datetime11) >= 29 AND DAY(gi_mt_agent.Datetime11) <= 31 THEN DO:
        ASSIGN gi_mt_agent.YearMonth1Week = gi_mt_agent.YearMonth1 + "-" + "05".
    END.


    FIND gi_transaction_id WHERE gi_transaction_id.transactionid = gi_mt_agent.transactionid NO-LOCK NO-ERROR.
    IF NOT AVAILABLE gi_transaction_id THEN DO:
        CREATE gi_transaction_id.
        ASSIGN gi_transaction_id.transactionid = gi_mt_agent.transactionid.
    END.
END.
MESSAGE "process ended"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.


