DEF VAR ptotal AS DEC

.
FOR EACH gi_data_hotel 
    WHERE /*gi_data_hotel.date1 >= 10/1/19 
      AND gi_data_hotel.date1 >= 10/31/19*/
    /*gi_data_hotel.yearmonth = "2019-10"*/
    hotel-cons = 123
    BREAK BY hotel-cons:
    ASSIGN ptotal = ptotal + collectfromagent.
    DISPLAY 
        hotel-cons
        yearmonth yearmonthfn date1 
        collectfromagent
        /*trandate-txt*/
        
        .


END.
MESSAGE ptotal
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
