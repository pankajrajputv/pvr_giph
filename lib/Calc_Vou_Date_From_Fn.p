DEF INPUT PARAMETER pYearMonthFn AS CHAR.
DEF OUTPUT PARAMETER pdate AS DATE FORMAT "99/99/9999".

DEF VAR pyear AS INT.
DEF VAR pmon AS INT.
DEF VAR pday AS INT.
/*
ASSIGN pYearMonthFn = "2019-10-02".
  */
/*
ASSIGN pyear = INT(SUBSTRING(pYearMonth,1,4)).
ASSIGN pmon  = INT(SUBSTRING(pYearMonth,6,2)).
ASSIGN pday  = INT(SUBSTRING(pYearMonthFn,9,2)).

ASSIGN pdate = DATE(pmon,pday,pyear).
  */
/*
IF pYearMonthFn = "2019-01-01" THEN ASSIGN pdate = 01/15/2019.
IF pYearMonthFn = "2019-02-01" THEN ASSIGN pdate = 02/15/2019.
IF pYearMonthFn = "2019-03-01" THEN ASSIGN pdate = 03/15/2019.
IF pYearMonthFn = "2019-04-01" THEN ASSIGN pdate = 04/15/2019.
IF pYearMonthFn = "2019-05-01" THEN ASSIGN pdate = 05/15/2019.
IF pYearMonthFn = "2019-06-01" THEN ASSIGN pdate = 06/15/2019.
IF pYearMonthFn = "2019-07-01" THEN ASSIGN pdate = 07/15/2019.
IF pYearMonthFn = "2019-08-01" THEN ASSIGN pdate = 08/15/2019.
IF pYearMonthFn = "2019-09-01" THEN ASSIGN pdate = 09/15/2019.
IF pYearMonthFn = "2019-10-01" THEN ASSIGN pdate = 10/15/2019.
IF pYearMonthFn = "2019-11-01" THEN ASSIGN pdate = 11/15/2019.
IF pYearMonthFn = "2019-12-01" THEN ASSIGN pdate = 12/15/2019.
  */

IF pYearMonthFn = "2019-01" THEN ASSIGN pdate = 01/31/2019.
IF pYearMonthFn = "2019-02" THEN ASSIGN pdate = 02/28/2019.
IF pYearMonthFn = "2019-03" THEN ASSIGN pdate = 03/31/2019.
IF pYearMonthFn = "2019-04" THEN ASSIGN pdate = 04/30/2019.
IF pYearMonthFn = "2019-05" THEN ASSIGN pdate = 05/31/2019.
IF pYearMonthFn = "2019-06" THEN ASSIGN pdate = 06/30/2019.
IF pYearMonthFn = "2019-07" THEN ASSIGN pdate = 07/31/2019.
IF pYearMonthFn = "2019-08" THEN ASSIGN pdate = 08/31/2019.
IF pYearMonthFn = "2019-09" THEN ASSIGN pdate = 09/30/2019.
IF pYearMonthFn = "2019-10" THEN ASSIGN pdate = 10/31/2019.
IF pYearMonthFn = "2019-11" THEN ASSIGN pdate = 11/30/2019.
IF pYearMonthFn = "2019-12" THEN ASSIGN pdate = 12/31/2019.


/*
IF pday = 1 THEN DO:
    ASSIGN pdate = DATE(pmon,15,pyear).
END.
IF pday = 2 THEN DO:
    RUN C:\pvr\giph\lib\MonthEnd.p(INPUT pdate,OUTPUT pdate).
END.
*/
    /*
MESSAGE pdate
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
    */
