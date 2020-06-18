DEF SHARED VAR pYearMonth AS CHAR. 

DEF BUFFER b_gi_acc_adj FOR gi_acc_adj.

DEF VAR pcons AS INT.
DEF VAR preg AS INT.

FIND LAST b_gi_acc_adj USE-INDEX idx NO-LOCK NO-ERROR.
IF AVAILABLE b_gi_acc_adj THEN DO:
    ASSIGN pcons = b_gi_acc_adj.cons + 1.
END.
ELSE pcons = 1.

FIND LAST b_gi_acc_adj WHERE b_gi_acc_adj.yearmonth = pyearmonth USE-INDEX idx1 NO-LOCK NO-ERROR.
IF AVAILABLE b_gi_acc_adj THEN DO:
    ASSIGN preg = b_gi_acc_adj.reg + 1.
END.
ELSE preg = 1.

CREATE gi_acc_adj.
ASSIGN gi_acc_adj.cons = pcons.
ASSIGN gi_acc_adj.reg = preg.
ASSIGN gi_acc_adj.vouchernumber = "Jrnl-" + STRING(pcons,"9999") + "-" + STRING(preg,"999").
ASSIGN gi_acc_adj.yearmonth = pyearmonth.

DEF VAR ptemp-date AS DATE.
ASSIGN ptemp-date = DATE(INT(SUBSTRING(pYearMonth,6,2)),1,INT(SUBSTRING(pYearMonth,1,4))).
RUN c:\pvr\giph\lib\monthend.p(INPUT ptemp-date, OUTPUT gi_acc_adj.refdate).


    /* 2019-01 */







