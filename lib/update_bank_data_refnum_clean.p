FOR EACH gi_data_banks : 
    ASSIGN gi_data_banks.refnum1-clean = REPLACE(gi_data_banks.refnum1," ","").
END.
