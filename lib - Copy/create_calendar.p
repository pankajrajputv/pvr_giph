DEF VAR pdate AS DATE.
FOR EACH gi_calendar: DELETE gi_calendar. END.

DO pdate = 1/1/19 TO 12/31/19:
    CREATE gi_calendar.
    ASSIGN gi_calendar.pdate = pdate.
    ASSIGN gi_calendar.YearMonth = STRING(YEAR(pdate),"9999") + "-" + STRING(MONTH(pdate),"99").

    IF DAY(gi_calendar.pdate) >= 1 AND DAY(gi_calendar.pdate) <= 15 THEN DO:
        ASSIGN gi_calendar.YearMonthFN = gi_calendar.YearMonth + "-" + "01".
    END.
    IF DAY(gi_calendar.pdate) >= 16 AND DAY(gi_calendar.pdate) <= 31 THEN DO:
        ASSIGN gi_calendar.YearMonthFN = gi_calendar.YearMonth + "-" + "02".
    END.


END.





