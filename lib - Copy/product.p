FOR EACH gi_agent:
    FIND gi_product WHERE gi_product.productname = gi_agent.productname NO-ERROR.
    IF NOT AVAILABLE gi_product THEN DO:
        CREATE gi_product.
        ASSIGN gi_product.productname = gi_agent.productname.
    END.

END.
