&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          giph             PROGRESS
*/
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{src/adm2/widgetprto.i}

DEF NEW SHARED VAR prefnum1 LIKE gi_acc_det.refnum1.
DEF VAR pacc-led-name LIKE gi_acc_det.acc-led-name.
DEF VAR pacc-grp-name LIKE gi_acc_grp.acc-grp-name.

DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.
DEF NEW SHARED VAR poutput-filename AS CHAR.
DEF NEW SHARED VAR pLastVchId LIKE gi_acc_hea.LastVchId.
DEF NEW SHARED VAR pVoucherType LIKE gi_acc_hea.VoucherType.
DEF NEW SHARED VAR pparty-name LIKE gi_acc_det.party-name.


  ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucher-response.txt".

  DEF NEW SHARED VAR psearchrefdate1 AS DATE.
  DEF NEW SHARED VAR psearchrefdate2 AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES gi_acc_det gi_acc_hea

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_acc_det.reg ~
gi_acc_hea.vouchertype gi_acc_hea.LastVchId gi_acc_det.refdate ~
gi_acc_hea.refnum1 gi_acc_det.acc-led-name gi_acc_det.partyname ~
gi_acc_det.debit gi_acc_det.credit gi_acc_det.cheque-num ~
gi_acc_det.currency gi_acc_det.forex-rate gi_acc_det.runbal1 ~
gi_acc_det.runbal2 gi_acc_det.amount gi_acc_det.refnum1 ~
gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_acc_det.acc-led-name ~
gi_acc_det.partyname 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_acc_det
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_acc_det
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_acc_det ~
      WHERE (giph.gi_acc_det.partyname MATCHES wparty-name or  ~
giph.gi_acc_det.party-name MATCHES wparty-name) NO-LOCK, ~
      EACH gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_acc_det.refnum1 ~
      AND (giph.gi_acc_hea.refnum1 MATCHES wsearchref ~
 OR gi_acc_hea.refnum2 MATCHES wsearchref)  ~
 and ~
(INT(wLastVchId) > 0 AND gi_acc_hea.lastVchId = INT(wlastVchId) ~
 OR INT(wLastVchId) = 0 AND gi_acc_hea.lastVchId = 0 ~
 OR INT(wLastVchId) = ? and gi_acc_hea.lastVchId <> ? ~
)  ~
 ~
 AND gi_acc_hea.refdate >= wsearchrefdate1 ~
 AND gi_acc_hea.refdate <= wsearchrefdate2 ~
 AND gi_acc_hea.particulars MATCHES wsearchparticular ~
 AND ( ~
(wvouchertype <> "All" AND gi_acc_hea.vouchertype = wvouchertype)  ~
OR (wvouchertype = "All") ~
) ~
AND  ~
((werror = True and (giph.gi_acc_hea.dbcr-diff > 0  ~
                   or gi_acc_hea.vouchertype = "" ~
 ) ~
  OR werror = false)) ~
 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_acc_det ~
      WHERE (giph.gi_acc_det.partyname MATCHES wparty-name or  ~
giph.gi_acc_det.party-name MATCHES wparty-name) NO-LOCK, ~
      EACH gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_acc_det.refnum1 ~
      AND (giph.gi_acc_hea.refnum1 MATCHES wsearchref ~
 OR gi_acc_hea.refnum2 MATCHES wsearchref)  ~
 and ~
(INT(wLastVchId) > 0 AND gi_acc_hea.lastVchId = INT(wlastVchId) ~
 OR INT(wLastVchId) = 0 AND gi_acc_hea.lastVchId = 0 ~
 OR INT(wLastVchId) = ? and gi_acc_hea.lastVchId <> ? ~
)  ~
 ~
 AND gi_acc_hea.refdate >= wsearchrefdate1 ~
 AND gi_acc_hea.refdate <= wsearchrefdate2 ~
 AND gi_acc_hea.particulars MATCHES wsearchparticular ~
 AND ( ~
(wvouchertype <> "All" AND gi_acc_hea.vouchertype = wvouchertype)  ~
OR (wvouchertype = "All") ~
) ~
AND  ~
((werror = True and (giph.gi_acc_hea.dbcr-diff > 0  ~
                   or gi_acc_hea.vouchertype = "" ~
 ) ~
  OR werror = false)) ~
 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_acc_det gi_acc_hea
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_acc_det
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 gi_acc_hea


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.refnum1 gi_acc_det.reg ~
gi_acc_det.refdate gi_acc_det.debit gi_acc_det.credit gi_acc_det.cheque-num ~
gi_acc_det.runbal1 gi_acc_det.runbal2 gi_acc_det.amount ~
gi_acc_det.particulars gi_acc_det.cons gi_acc_det.currency ~
gi_acc_det.forex-rate gi_acc_det.partyname 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.partyname = pparty-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.partyname = pparty-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_acc_det


/* Definitions for FRAME fMain                                          */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fMain ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wExport wsearchref wparty-name ~
wsearchrefdate1 wsearchrefdate2 wlastVchId wvouchertype wError BtnSearchRef ~
BtnSearchRef-2 BROWSE-1 BROWSE-2 wsearchparticular 
&Scoped-Define DISPLAYED-OBJECTS wsearchref wparty-name wsearchrefdate1 ~
wsearchrefdate2 wlastVchId wvouchertype wError wsearchparticular 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnSearchRef 
     LABEL "<S>" 
     SIZE 4.86 BY .81 TOOLTIP "Search Reference"
     FONT 4.

DEFINE BUTTON BtnSearchRef-2 
     LABEL "<X>" 
     SIZE 4.86 BY .81 TOOLTIP "Cancel Search Reference"
     FONT 4.

DEFINE BUTTON wExport 
     LABEL "Export" 
     SIZE 6.72 BY .88
     FONT 4.

DEFINE VARIABLE wvouchertype AS CHARACTER FORMAT "X(256)":U 
     LABEL "Vou. Type" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "All","Contra","Receipt","Payment","Journal","Sales","Purchase" 
     DROP-DOWN-LIST
     SIZE 13.29 BY 1 TOOLTIP "Voucher Type"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wlastVchId AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Vch Id" 
     VIEW-AS FILL-IN 
     SIZE 15.57 BY .81 TOOLTIP "Voucher ID"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wparty-name AS CHARACTER FORMAT "X(256)":U 
     LABEL "Party" 
     VIEW-AS FILL-IN 
     SIZE 17.57 BY .81 TOOLTIP "Search Party"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchparticular AS CHARACTER FORMAT "X(256)":U 
     LABEL "Particular" 
     VIEW-AS FILL-IN 
     SIZE 17.57 BY .81 TOOLTIP "Search Particular"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchref AS CHARACTER FORMAT "X(256)":U 
     LABEL "Ref." 
     VIEW-AS FILL-IN 
     SIZE 15.57 BY .81 TOOLTIP "Search Reference"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchrefdate1 AS DATE FORMAT "99/99/9999":U 
     LABEL "Date From" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY .81 TOOLTIP "Search date"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchrefdate2 AS DATE FORMAT "99/99/9999":U 
     LABEL "To" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY .81 TOOLTIP "Search date"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wError AS LOGICAL INITIAL no 
     LABEL "Error" 
     VIEW-AS TOGGLE-BOX
     SIZE 6.29 BY .77
     FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_acc_det SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
      gi_acc_hea.vouchertype FORMAT "x(8)":U
      gi_acc_hea.LastVchId FORMAT "->>>>>>9":U COLUMN-FGCOLOR 9
      gi_acc_det.refdate COLUMN-LABEL "Date" FORMAT "99/99/99":U
      gi_acc_hea.refnum1 COLUMN-LABEL "Ref Num1" FORMAT "x(50)":U
            WIDTH 19.14
      gi_acc_det.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(100)":U
            WIDTH 20.29
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 20.57
      gi_acc_det.debit COLUMN-LABEL "Debit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 12.86
      gi_acc_det.credit COLUMN-LABEL "Credit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.57
      gi_acc_det.cheque-num FORMAT "x(20)":U WIDTH 12.29
      gi_acc_det.currency FORMAT "x(8)":U WIDTH 4.57
      gi_acc_det.forex-rate FORMAT "->>,>>9.99":U WIDTH 8
      gi_acc_det.runbal1 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.runbal2 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.refnum1 COLUMN-LABEL "Ref" FORMAT "x(50)":U WIDTH 8.72
      gi_acc_det.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 50
      gi_acc_det.cons COLUMN-LABEL "Cons" FORMAT "->>>>>>9":U
  ENABLE
      gi_acc_det.acc-led-name
      gi_acc_det.partyname
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 116.57 BY 14.5
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_acc_det.refnum1 COLUMN-LABEL "Ref" FORMAT "x(50)":U WIDTH 8.72
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U WIDTH 3
      gi_acc_det.refdate COLUMN-LABEL "RefDate" FORMAT "99/99/99":U
      gi_acc_det.debit COLUMN-LABEL "Debit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.29
      gi_acc_det.credit COLUMN-LABEL "Credit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 12.57
      gi_acc_det.cheque-num FORMAT "x(20)":U WIDTH 8.72
      gi_acc_det.runbal1 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.runbal2 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 50
      gi_acc_det.cons COLUMN-LABEL "Cons" FORMAT "->>>>>>9":U
      gi_acc_det.currency FORMAT "x(8)":U WIDTH 6.43
      gi_acc_det.forex-rate FORMAT "->>,>>9.99":U WIDTH 5.72
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 23
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 56.43 BY 14.5
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wExport AT ROW 1.31 COL 159.57 WIDGET-ID 22
     wsearchref AT ROW 1.35 COL 4.72 COLON-ALIGNED WIDGET-ID 2
     wparty-name AT ROW 1.35 COL 29.72 COLON-ALIGNED WIDGET-ID 28
     wsearchrefdate1 AT ROW 1.35 COL 59.57 COLON-ALIGNED WIDGET-ID 10
     wsearchrefdate2 AT ROW 1.35 COL 76.14 COLON-ALIGNED WIDGET-ID 12
     wlastVchId AT ROW 1.35 COL 96.29 COLON-ALIGNED WIDGET-ID 26
     wvouchertype AT ROW 1.35 COL 126.72 COLON-ALIGNED WIDGET-ID 20
     wError AT ROW 1.35 COL 143.14 WIDGET-ID 18
     BtnSearchRef AT ROW 1.35 COL 150 WIDGET-ID 4
     BtnSearchRef-2 AT ROW 1.35 COL 154.72 WIDGET-ID 6
     BROWSE-1 AT ROW 2.54 COL 2.29 WIDGET-ID 300
     BROWSE-2 AT ROW 2.54 COL 119.43 WIDGET-ID 600
     wsearchparticular AT ROW 17.23 COL 156 COLON-ALIGNED WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.43 BY 17.42 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "View Transactions by Party Name"
         HEIGHT             = 17.42
         WIDTH              = 176.43
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 176.43
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 176.43
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 BtnSearchRef-2 fMain */
/* BROWSE-TAB BROWSE-2 BROWSE-1 fMain */
ASSIGN 
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_det.acc-led-name:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_acc_det.partyname:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

ASSIGN 
       BROWSE-2:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_acc_det,giph.gi_acc_hea WHERE giph.gi_acc_det ..."
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "(giph.gi_acc_det.partyname MATCHES wparty-name or 
giph.gi_acc_det.party-name MATCHES wparty-name)"
     _JoinCode[2]      = "giph.gi_acc_hea.refnum1 = giph.gi_acc_det.refnum1"
     _Where[2]         = "(giph.gi_acc_hea.refnum1 MATCHES wsearchref
 OR giph.gi_acc_hea.refnum2 MATCHES wsearchref) 
 and
(INT(wLastVchId) > 0 AND giph.gi_acc_hea.lastVchId = INT(wlastVchId)
 OR INT(wLastVchId) = 0 AND giph.gi_acc_hea.lastVchId = 0
 OR INT(wLastVchId) = ? and giph.gi_acc_hea.lastVchId <> ?
) 

 AND giph.gi_acc_hea.refdate >= wsearchrefdate1
 AND giph.gi_acc_hea.refdate <= wsearchrefdate2
 AND giph.gi_acc_hea.particulars MATCHES wsearchparticular
 AND (
(wvouchertype <> ""All"" AND giph.gi_acc_hea.vouchertype = wvouchertype) 
OR (wvouchertype = ""All"")
)
AND 
((werror = True and (giph.gi_acc_hea.dbcr-diff > 0 
                   or giph.gi_acc_hea.vouchertype = """"
 )
  OR werror = false))
"
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = giph.gi_acc_hea.vouchertype
     _FldNameList[3]   > giph.gi_acc_hea.LastVchId
"gi_acc_hea.LastVchId" ? ? "integer" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.refdate
"gi_acc_det.refdate" "Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_hea.refnum1
"gi_acc_hea.refnum1" "Ref Num1" ? "character" ? ? ? ? ? ? no ? no no "19.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? yes ? no no "20.29" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? yes ? no no "20.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_det.partyname = pparty-name"
     _FldNameList[1]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.refdate
"gi_acc_det.refdate" "RefDate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "11.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "12.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "5.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? no ? no no "23" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* View Transactions by Party Name */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* View Transactions by Party Name */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 wWin
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Transaction Details */
DO:
  
  IF AVAILABLE gi_acc_det THEN DO:
      ASSIGN pparty-name = gi_acc_det.partyname.
      /*
      ASSIGN wparticulars:SCREEN-VALUE = gi_acc_det.particulars.
      ASSIGN pacc-led-name = gi_acc_det.acc-led-name.
      */
        
  END.
  ELSE DO:
      ASSIGN pparty-name = ?.

  END.
  {&OPEN-QUERY-BROWSE-2}
  APPLY "Value-Changed" TO BROWSE-2.  

  /*
  ASSIGN wparticulars:SCREEN-VALUE = ""
         pacc-led-name = "".
  {&OPEN-QUERY-BROWSE-5}
  APPLY "Value-Changed" TO BROWSE-5.  
  ASSIGN browse-5:TITLE = pacc-led-name.
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 wWin
ON VALUE-CHANGED OF BROWSE-2 IN FRAME fMain /* Transaction Details */
DO:
    /*
  IF AVAILABLE gi_acc_det THEN DO:
      ASSIGN wparticulars:SCREEN-VALUE = gi_acc_det.particulars.
      ASSIGN pacc-led-name = gi_acc_det.acc-led-name.

  END.
  ELSE 
  ASSIGN wparticulars:SCREEN-VALUE = ""
         pacc-led-name = "".

  {&OPEN-QUERY-BROWSE-3}
  APPLY "Value-Changed" TO BROWSE-3.  
      */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearchRef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearchRef wWin
ON CHOOSE OF BtnSearchRef IN FRAME fMain /* <S> */
DO:
    ASSIGN wsearchref = "*" + wsearchref:SCREEN-VALUE + "*".
    /*
    IF wlastVchId:SCREEN-VALUE = "" THEN DO:
        ASSIGN wlastVchId = ?.
    END.
    ELSE DO:
        ASSIGN wlastVchId = (wlastVchId:SCREEN-VALUE).
    END.
    */
    ASSIGN wsearchparticular = "*" + wsearchparticular:SCREEN-VALUE + "*".
    ASSIGN wparty-name = "*" + wparty-name:SCREEN-VALUE + "*".
    ASSIGN wsearchrefdate1 = DATE(wsearchrefdate1:SCREEN-VALUE).
    ASSIGN wsearchrefdate2 = DATE(wsearchrefdate2:SCREEN-VALUE).
    ASSIGN pvouchertype = wvouchertype:SCREEN-VALUE.

    /*
    ASSIGN wLastVchId = wLastVchId:SCREEN-VALUE.
    ASSIGN pLastVchId = wLastVchId.
      */
    ASSIGN psearchrefdate1 = wsearchrefdate1.
    ASSIGN psearchrefdate2 = wsearchrefdate2.
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearchRef-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearchRef-2 wWin
ON CHOOSE OF BtnSearchRef-2 IN FRAME fMain /* <X> */
DO:
    ASSIGN wsearchref = "*".
    ASSIGN wsearchref:SCREEN-VALUE = "".
    ASSIGN wsearchparticular = "*".
    /*
    ASSIGN wLastVchId:SCREEN-VALUE = "".
    ASSIGN pLastVchId = "".
    */
    ASSIGN wsearchparticular:SCREEN-VALUE = "".
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wError
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wError wWin
ON VALUE-CHANGED OF wError IN FRAME fMain /* Error */
DO:
  IF SELF:SCREEN-VALUE = "Yes" THEN DO:
      ASSIGN werror = TRUE.
  END.
  ELSE DO:
      ASSIGN werror = FALSE.
  END.
    APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wExport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wExport wWin
ON CHOOSE OF wExport IN FRAME fMain /* Export */
DO:
    DEF VAR n AS INT.
    APPLY "Choose" TO BtnSearchRef.

    RUN c:\pvr\giph\lib\PROCESS_vouchers.p NO-ERROR.

  /*
  SESSION:SET-WAIT-STATE("GENERAL").
  SESSION:SET-WAIT-STATE("").
    */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wlastVchId
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wlastVchId wWin
ON ANY-PRINTABLE OF wlastVchId IN FRAME fMain /* Vch Id */
OR "Backspace" OF wlastVchId DO:
  /*
    ASSIGN wlastVchId = "*" + wlastVchId:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wlastVchId wWin
ON LEAVE OF wlastVchId IN FRAME fMain /* Vch Id */
DO:
  APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wparty-name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wparty-name wWin
ON ANY-PRINTABLE OF wparty-name IN FRAME fMain /* Party */
OR "Backspace" OF wparty-name DO:

    ASSIGN wparty-name = "*" + wparty-name:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wparty-name wWin
ON LEAVE OF wparty-name IN FRAME fMain /* Party */
DO:
  APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearchparticular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchparticular wWin
ON ANY-PRINTABLE OF wsearchparticular IN FRAME fMain /* Particular */
OR "Backspace" OF wsearchparticular DO:

    ASSIGN wsearchparticular = "*" + wsearchparticular:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchparticular wWin
ON LEAVE OF wsearchparticular IN FRAME fMain /* Particular */
DO:
  APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearchref
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchref wWin
ON ANY-PRINTABLE OF wsearchref IN FRAME fMain /* Ref. */
OR "Backspace" OF wsearchref DO:

    ASSIGN wsearchref = "*" + wsearchref:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchref wWin
ON LEAVE OF wsearchref IN FRAME fMain /* Ref. */
DO:
  APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearchrefdate1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchrefdate1 wWin
ON LEAVE OF wsearchrefdate1 IN FRAME fMain /* Date From */
DO:
  APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearchrefdate2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchrefdate2 wWin
ON LEAVE OF wsearchrefdate2 IN FRAME fMain /* To */
DO:
  APPLY "Choose" TO BtnSearchRef.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wvouchertype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wvouchertype wWin
ON VALUE-CHANGED OF wvouchertype IN FRAME fMain /* Vou. Type */
DO:
    ASSIGN wvouchertype = SELF:SCREEN-VALUE.
    ASSIGN pvouchertype = wvouchertype:SCREEN-VALUE.
    APPLY "Choose" TO BtnSearchRef.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY wsearchref wparty-name wsearchrefdate1 wsearchrefdate2 wlastVchId 
          wvouchertype wError wsearchparticular 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wExport wsearchref wparty-name wsearchrefdate1 wsearchrefdate2 
         wlastVchId wvouchertype wError BtnSearchRef BtnSearchRef-2 BROWSE-1 
         BROWSE-2 wsearchparticular 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject wWin 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     Super Override
  Parameters:  
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  RUN SUPER.

  /* Code placed here will execute AFTER standard behavior.    */
  DO WITH FRAME {&FRAME-NAME}:
      
  END.
  ASSIGN wsearchref = "*".
  ASSIGN wsearchref:SCREEN-VALUE = "".
  ASSIGN wlastVchId = ?.
  ASSIGN wlastVchId:SCREEN-VALUE = "".
  ASSIGN wsearchparticular = "*".
  ASSIGN wsearchparticular:SCREEN-VALUE = "".

  ASSIGN wsearchrefdate1 = 10/1/19
         wsearchrefdate2 = 10/31/19.
  ASSIGN wsearchrefdate1:SCREEN-VALUE = STRING(wsearchrefdate1).
  ASSIGN wsearchrefdate2:SCREEN-VALUE = STRING(wsearchrefdate2).
  ASSIGN werror = FALSE.
  ASSIGN werror:SCREEN-VALUE = STRING(werror).
  ASSIGN wvouchertype = "All".
  ASSIGN wvouchertype:SCREEN-VALUE = wvouchertype.



 {&OPEN-QUERY-BROWSE-1}
 APPLY "Value-Changed" TO BROWSE-1.  



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

