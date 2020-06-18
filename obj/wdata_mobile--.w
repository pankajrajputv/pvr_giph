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
/*DEF NEW SHARED VAR pmobile-sum-cons LIKE gi_data_mobile_sum.mobile-sum-cons.*/

DEF NEW SHARED VAR pmobile-sum-cons LIKE gi_data_mobile_sum.mobile-sum-cons.

DEF VAR pYearMonthFN LIKE gi_data_mobile_sum.YearMonthFN. 
DEF VAR pYearMonthFN1 LIKE gi_data_mobile_sum.YearMonthFN. 
DEF VAR pparty-name LIKE gi_data_mobile_sum.party-name.

DEF BUFFER b_gi_data_mobile_sum FOR gi_data_mobile_sum.

DEF VAR poutput-filename AS CHAR.
ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt".

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
&Scoped-define INTERNAL-TABLES gi_data_mobile_sum gi_data_mobile gi_acc_det ~
gi_acc_hea

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_data_mobile_sum.YearMonthFN ~
gi_data_mobile_sum.party-name gi_data_mobile_sum.alias-name ~
gi_data_mobile_sum.MrpValue gi_data_mobile_sum.SupplierComm ~
gi_data_mobile_sum.Payable gi_data_mobile_sum.AgentComm ~
gi_data_mobile_sum.CollectFromAgent1 gi_data_mobile_sum.TotalTssComm ~
gi_data_mobile_sum.Profit gi_data_mobile_sum.GrossAmount1 ~
gi_data_mobile_sum.Payable1 gi_data_mobile_sum.comm-income1 ~
gi_data_mobile_sum.OutputVat gi_data_mobile_sum.total-db ~
gi_data_mobile_sum.total-cr gi_data_mobile_sum.total-db-cr-diff ~
gi_data_mobile_sum.Collectable 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_mobile_sum ~
      WHERE gi_data_mobile_sum.YearMonthFN MATCHES wYearMonthFN ~
 AND gi_data_mobile_sum.party-name MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_mobile_sum ~
      WHERE gi_data_mobile_sum.YearMonthFN MATCHES wYearMonthFN ~
 AND gi_data_mobile_sum.party-name MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_data_mobile_sum
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_data_mobile_sum


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_data_mobile.YearMonthFN ~
gi_data_mobile.mobile-cons gi_data_mobile.AgentName ~
gi_data_mobile.GroupDesc gi_data_mobile.ItemDesc gi_data_mobile.TransNo ~
gi_data_mobile.MobileNo gi_data_mobile.RechargeDateTxt ~
gi_data_mobile.MrpValue gi_data_mobile.SupplierComm gi_data_mobile.Payable ~
gi_data_mobile.AgentComm gi_data_mobile.CollectFromAgent1 ~
gi_data_mobile.TotalTssComm gi_data_mobile.Profit gi_data_mobile.party-name ~
gi_data_mobile.date1 gi_data_mobile.GrossAmount1 gi_data_mobile.Payable1 ~
gi_data_mobile.comm-income1 gi_data_mobile.OutputVat ~
gi_data_mobile.total-db gi_data_mobile.total-cr ~
gi_data_mobile.total-db-cr-diff gi_data_mobile.AgentComm1 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_data_mobile ~
      WHERE gi_data_mobile.YearMonthFN MATCHES pYearMonthFN1 ~
 AND gi_data_mobile.AgentName MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_data_mobile ~
      WHERE gi_data_mobile.YearMonthFN MATCHES pYearMonthFN1 ~
 AND gi_data_mobile.AgentName MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_data_mobile
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_data_mobile


/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 gi_acc_det.reg ~
gi_acc_hea.vouchertype gi_acc_det.refdate gi_acc_det.acc-led-name ~
gi_acc_det.partyname gi_acc_det.debit gi_acc_det.credit ~
gi_acc_det.cheque-num gi_acc_det.currency gi_acc_det.forex-rate ~
gi_acc_det.runbal1 gi_acc_det.runbal2 gi_acc_det.amount gi_acc_det.refnum1 ~
gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 gi_acc_det.acc-led-name ~
gi_acc_det.partyname 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH gi_acc_det ~
      WHERE (giph.gi_acc_det.partyname = pparty-name) NO-LOCK, ~
      EACH gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_acc_det.refnum1 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH gi_acc_det ~
      WHERE (giph.gi_acc_det.partyname = pparty-name) NO-LOCK, ~
      EACH gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_acc_det.refnum1 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 gi_acc_det gi_acc_hea
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-3 gi_acc_hea


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BtnImport BtnValidate BtnExport wyearmonthfn ~
wParty-Name BtnSearch BROWSE-1 BROWSE-2 BROWSE-3 wtally-response 
&Scoped-Define DISPLAYED-OBJECTS wyearmonthfn wParty-Name wtally-response 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Mobile_Journal_Entry LABEL "Create Mobile Journal Entry"
       RULE
       MENU-ITEM m_View_XML     LABEL "View XML"      .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnImport 
     LABEL "Import" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnSearch 
     LABEL "Search" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnValidate 
     LABEL "Validate" 
     SIZE 8.72 BY .81 TOOLTIP "Validate Visa Data".

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 174.14 BY 2.69
     FONT 4 NO-UNDO.

DEFINE VARIABLE wParty-Name AS CHARACTER FORMAT "X(256)":U 
     LABEL "Party Name" 
     VIEW-AS FILL-IN 
     SIZE 25.57 BY .81 NO-UNDO.

DEFINE VARIABLE wyearmonthfn AS CHARACTER FORMAT "X(256)":U 
     LABEL "Year Month" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_data_mobile_sum SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_data_mobile SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_mobile_sum.YearMonthFN COLUMN-LABEL "Year Month!FN" FORMAT "x(12)":U
      gi_data_mobile_sum.party-name COLUMN-LABEL "Party !Name" FORMAT "x(100)":U
            WIDTH 30.86
      gi_data_mobile_sum.alias-name FORMAT "x(100)":U WIDTH 20
      gi_data_mobile_sum.MrpValue COLUMN-LABEL "MRP !Value" FORMAT "->>,>>9.99":U
      gi_data_mobile_sum.SupplierComm COLUMN-LABEL "Supplier! Comm" FORMAT "->>,>>9.99":U
            WIDTH 7.86
      gi_data_mobile_sum.Payable FORMAT "->>,>>9.99":U WIDTH 9.14
      gi_data_mobile_sum.AgentComm COLUMN-LABEL "Agent! Comm" FORMAT "->>,>>9.99":U
            WIDTH 9.29
      gi_data_mobile_sum.CollectFromAgent1 COLUMN-LABEL "Coll From! Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.72
      gi_data_mobile_sum.TotalTssComm COLUMN-LABEL "Total TSS! Comm" FORMAT "->>,>>9.99":U
            WIDTH 8.57
      gi_data_mobile_sum.Profit FORMAT "->>,>>9.99":U WIDTH 7.72
      gi_data_mobile_sum.GrossAmount1 COLUMN-LABEL "Db Gross!Amount" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12 COLUMN-BGCOLOR 19
      gi_data_mobile_sum.Payable1 COLUMN-LABEL "Cr!Payable" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.86 COLUMN-BGCOLOR 20
      gi_data_mobile_sum.comm-income1 COLUMN-LABEL "Cr Comm.!Income" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.72 COLUMN-BGCOLOR 20
      gi_data_mobile_sum.OutputVat COLUMN-LABEL "Cr Output! Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.57 COLUMN-BGCOLOR 20
      gi_data_mobile_sum.total-db COLUMN-LABEL "Total !Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.57 COLUMN-BGCOLOR 21
      gi_data_mobile_sum.total-cr COLUMN-LABEL "Total! Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.14 COLUMN-BGCOLOR 21
      gi_data_mobile_sum.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.86 COLUMN-BGCOLOR 21
      gi_data_mobile_sum.Collectable FORMAT "->>,>>9.99":U WIDTH 11.72
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 10.19
         FONT 4
         TITLE "Mobile Data" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_data_mobile.YearMonthFN COLUMN-LABEL "Year Mon!FN" FORMAT "x(12)":U
            WIDTH 9.14
      gi_data_mobile.mobile-cons FORMAT "->>>>>>9":U WIDTH 7.43
      gi_data_mobile.AgentName COLUMN-LABEL "Agent!Name" FORMAT "x(50)":U
            WIDTH 14.43
      gi_data_mobile.GroupDesc COLUMN-LABEL "Group !Desc" FORMAT "x(50)":U
            WIDTH 12.57
      gi_data_mobile.ItemDesc COLUMN-LABEL "Item !Desc" FORMAT "x(50)":U
            WIDTH 13.57
      gi_data_mobile.TransNo COLUMN-LABEL "Trans !No" FORMAT "x(20)":U
            WIDTH 7.72
      gi_data_mobile.MobileNo COLUMN-LABEL "Mobile! No" FORMAT "x(20)":U
      gi_data_mobile.RechargeDateTxt COLUMN-LABEL "Recharge! Date" FORMAT "x(15)":U
            WIDTH 12.43
      gi_data_mobile.MrpValue COLUMN-LABEL "MRP !Value" FORMAT "->>,>>9.99":U
            WIDTH 6.57
      gi_data_mobile.SupplierComm COLUMN-LABEL "Supplier !Comm" FORMAT "->>,>>9.99":U
            WIDTH 7
      gi_data_mobile.Payable FORMAT "->>,>>9.99":U WIDTH 5.72
      gi_data_mobile.AgentComm COLUMN-LABEL "Agent !Comm" FORMAT "->>,>>9.99":U
            WIDTH 6.57
      gi_data_mobile.CollectFromAgent1 COLUMN-LABEL "Coll From !Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6.86
      gi_data_mobile.TotalTssComm COLUMN-LABEL "Total TSS !Comm" FORMAT "->>,>>9.99":U
            WIDTH 7.72
      gi_data_mobile.Profit FORMAT "->>,>>9.99":U WIDTH 7.43
      gi_data_mobile.party-name COLUMN-LABEL "Party !Name" FORMAT "x(100)":U
            WIDTH 25.57
      gi_data_mobile.date1 FORMAT "99/99/9999":U
      gi_data_mobile.GrossAmount1 COLUMN-LABEL "Db Gross! Amount" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.14 COLUMN-BGCOLOR 19
      gi_data_mobile.Payable1 COLUMN-LABEL "Cr!Payable" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6 COLUMN-BGCOLOR 20
      gi_data_mobile.comm-income1 COLUMN-LABEL "Cr Comm.!Income" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6.57 COLUMN-BGCOLOR 20
      gi_data_mobile.OutputVat COLUMN-LABEL "Cr Output!Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6.86 COLUMN-BGCOLOR 20
      gi_data_mobile.total-db COLUMN-LABEL "Total !Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.14 COLUMN-BGCOLOR 21
      gi_data_mobile.total-cr COLUMN-LABEL "Total !Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.14 COLUMN-BGCOLOR 21
      gi_data_mobile.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.86 COLUMN-BGCOLOR 21
      gi_data_mobile.AgentComm1 COLUMN-LABEL "Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.57
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96.43 BY 10.19
         FONT 4
         TITLE "Mobile Data" ROW-HEIGHT-CHARS .58 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 wWin _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
      gi_acc_hea.vouchertype FORMAT "x(8)":U
      gi_acc_det.refdate COLUMN-LABEL "Date" FORMAT "99/99/99":U
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 76.86 BY 10.19
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BtnImport AT ROW 1.42 COL 149.14 WIDGET-ID 16
     BtnValidate AT ROW 1.42 COL 158 WIDGET-ID 26
     BtnExport AT ROW 1.42 COL 166.57 WIDGET-ID 14
     wyearmonthfn AT ROW 1.5 COL 13.86 COLON-ALIGNED WIDGET-ID 2
     wParty-Name AT ROW 1.5 COL 44.57 COLON-ALIGNED WIDGET-ID 8
     BtnSearch AT ROW 1.5 COL 73 WIDGET-ID 6
     BROWSE-1 AT ROW 2.5 COL 1.86 WIDGET-ID 300
     BROWSE-2 AT ROW 12.92 COL 1.86 WIDGET-ID 200
     BROWSE-3 AT ROW 12.92 COL 99.14 WIDGET-ID 400
     wtally-response AT ROW 23.38 COL 1.86 NO-LABEL WIDGET-ID 28
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.29 BY 25.31 WIDGET-ID 100.


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
         TITLE              = "Summary Mobile"
         HEIGHT             = 25.31
         WIDTH              = 176.29
         MAX-HEIGHT         = 31.85
         MAX-WIDTH          = 176.29
         VIRTUAL-HEIGHT     = 31.85
         VIRTUAL-WIDTH      = 176.29
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = yes
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
/* BROWSE-TAB BROWSE-1 BtnSearch fMain */
/* BROWSE-TAB BROWSE-2 BROWSE-1 fMain */
/* BROWSE-TAB BROWSE-3 BROWSE-2 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME fMain     = 4
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-2:NUM-LOCKED-COLUMNS IN FRAME fMain     = 4
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-3:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-3:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-3:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_det.acc-led-name:COLUMN-READ-ONLY IN BROWSE BROWSE-3 = TRUE
       gi_acc_det.partyname:COLUMN-READ-ONLY IN BROWSE BROWSE-3 = TRUE.

ASSIGN 
       wtally-response:RETURN-INSERTED IN FRAME fMain  = TRUE
       wtally-response:READ-ONLY IN FRAME fMain        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_data_mobile_sum"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_mobile_sum.YearMonthFN MATCHES wYearMonthFN
 AND giph.gi_data_mobile_sum.party-name MATCHES wParty-Name"
     _FldNameList[1]   > giph.gi_data_mobile_sum.YearMonthFN
"YearMonthFN" "Year Month!FN" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_mobile_sum.party-name
"party-name" "Party !Name" ? "character" ? ? ? ? ? ? no ? no no "30.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_mobile_sum.alias-name
"alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_mobile_sum.MrpValue
"MrpValue" "MRP !Value" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_mobile_sum.SupplierComm
"SupplierComm" "Supplier! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "7.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_mobile_sum.Payable
"Payable" ? ? "decimal" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_mobile_sum.AgentComm
"AgentComm" "Agent! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "9.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_mobile_sum.CollectFromAgent1
"CollectFromAgent1" "Coll From! Agent" ? "decimal" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_mobile_sum.TotalTssComm
"TotalTssComm" "Total TSS! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_mobile_sum.Profit
"Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "7.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_mobile_sum.GrossAmount1
"GrossAmount1" "Db Gross!Amount" ? "decimal" 19 ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_mobile_sum.Payable1
"Payable1" "Cr!Payable" ? "decimal" 20 ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_mobile_sum.comm-income1
"comm-income1" "Cr Comm.!Income" ? "decimal" 20 ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_mobile_sum.OutputVat
"OutputVat" "Cr Output! Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_mobile_sum.total-db
"total-db" "Total !Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_mobile_sum.total-cr
"total-cr" "Total! Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "8.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_mobile_sum.total-db-cr-diff
"total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_mobile_sum.Collectable
"Collectable" ? ? "decimal" ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_data_mobile"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_mobile.YearMonthFN MATCHES pYearMonthFN1
 AND giph.gi_data_mobile.AgentName MATCHES wParty-Name"
     _FldNameList[1]   > giph.gi_data_mobile.YearMonthFN
"gi_data_mobile.YearMonthFN" "Year Mon!FN" ? "character" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_mobile.mobile-cons
"gi_data_mobile.mobile-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "7.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_mobile.AgentName
"gi_data_mobile.AgentName" "Agent!Name" ? "character" ? ? ? ? ? ? no ? no no "14.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_mobile.GroupDesc
"gi_data_mobile.GroupDesc" "Group !Desc" ? "character" ? ? ? ? ? ? no ? no no "12.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_mobile.ItemDesc
"gi_data_mobile.ItemDesc" "Item !Desc" ? "character" ? ? ? ? ? ? no ? no no "13.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_mobile.TransNo
"gi_data_mobile.TransNo" "Trans !No" ? "character" ? ? ? ? ? ? no ? no no "7.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_mobile.MobileNo
"gi_data_mobile.MobileNo" "Mobile! No" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_mobile.RechargeDateTxt
"gi_data_mobile.RechargeDateTxt" "Recharge! Date" ? "character" ? ? ? ? ? ? no ? no no "12.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_mobile.MrpValue
"gi_data_mobile.MrpValue" "MRP !Value" ? "decimal" ? ? ? ? ? ? no ? no no "6.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_mobile.SupplierComm
"gi_data_mobile.SupplierComm" "Supplier !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_mobile.Payable
"gi_data_mobile.Payable" ? ? "decimal" ? ? ? ? ? ? no ? no no "5.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_mobile.AgentComm
"gi_data_mobile.AgentComm" "Agent !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "6.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_mobile.CollectFromAgent1
"gi_data_mobile.CollectFromAgent1" "Coll From !Agent" ? "decimal" ? ? ? ? ? ? no ? no no "6.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_mobile.TotalTssComm
"gi_data_mobile.TotalTssComm" "Total TSS !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "7.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_mobile.Profit
"gi_data_mobile.Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "7.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_mobile.party-name
"gi_data_mobile.party-name" "Party !Name" ? "character" ? ? ? ? ? ? no ? no no "25.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   = giph.gi_data_mobile.date1
     _FldNameList[18]   > giph.gi_data_mobile.GrossAmount1
"gi_data_mobile.GrossAmount1" "Db Gross! Amount" ? "decimal" 19 ? ? ? ? ? no ? no no "7.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_mobile.Payable1
"gi_data_mobile.Payable1" "Cr!Payable" ? "decimal" 20 ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_mobile.comm-income1
"gi_data_mobile.comm-income1" "Cr Comm.!Income" ? "decimal" 20 ? ? ? ? ? no ? no no "6.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_mobile.OutputVat
"gi_data_mobile.OutputVat" "Cr Output!Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "6.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_mobile.total-db
"gi_data_mobile.total-db" "Total !Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "7.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_mobile.total-cr
"gi_data_mobile.total-cr" "Total !Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "7.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_mobile.total-db-cr-diff
"gi_data_mobile.total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "7.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_mobile.AgentComm1
"gi_data_mobile.AgentComm1" "Agent!Comm" ? "decimal" ? ? ? ? ? ? no ? no no "9.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "giph.gi_acc_det,giph.gi_acc_hea WHERE giph.gi_acc_det ..."
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "(giph.gi_acc_det.partyname = pparty-name)"
     _JoinCode[2]      = "giph.gi_acc_hea.refnum1 = giph.gi_acc_det.refnum1"
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = giph.gi_acc_hea.vouchertype
     _FldNameList[3]   > giph.gi_acc_det.refdate
"gi_acc_det.refdate" "Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? yes ? no no "20.29" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? yes ? no no "20.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Summary Mobile */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Summary Mobile */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Mobile Data */
DO:
  IF AVAILABLE gi_data_mobile_sum THEN DO:
      ASSIGN pYearMonthFN1 = gi_data_mobile_sum.YearMonthFN. 
      ASSIGN pparty-name = gi_data_mobile_sum.party-name
          .

      ASSIGN wtally-response:SCREEN-VALUE = gi_data_mobile_sum.tally-response.
  END.
  ELSE DO:
      ASSIGN pparty-name = ?
          .

      ASSIGN wtally-response:SCREEN-VALUE = "".
  END.

  {&OPEN-QUERY-BROWSE-2}
  APPLY "Value-Changed" TO BROWSE-2.  
  {&OPEN-QUERY-BROWSE-3}
  APPLY "Value-Changed" TO BROWSE-3.  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
&Scoped-define SELF-NAME BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 wWin
ON VALUE-CHANGED OF BROWSE-3 IN FRAME fMain /* Transaction Details */
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
  /*
  {&OPEN-QUERY-BROWSE-2}
  APPLY "Value-Changed" TO BROWSE-2.  
  */

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


&Scoped-define SELF-NAME BtnExport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExport wWin
ON CHOOSE OF BtnExport IN FRAME fMain /* Export */
DO:
    DEF VAR n AS INT.
  SESSION:SET-WAIT-STATE("GENERAL").
  APPLY "Choose" TO BtnSearch.

  MESSAGE "Export the data to Tally?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_mobile.p.*/

      FOR EACH b_gi_data_mobile_sum WHERE b_gi_data_mobile_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_mobile_sum.mobile-sum-cons > 0
          BREAK BY b_gi_data_mobile_sum.YearMonth
                BY b_gi_data_mobile_sum.mobile-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN pmobile-sum-cons = b_gi_data_mobile_sum.mobile-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_mobile_partyname.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_mobile_sum.LastVchId, OUTPUT b_gi_data_mobile_sum.tally-response).

          
          MESSAGE b_gi_data_mobile_sum.mobile-sum-cons 
              b_gi_data_mobile_sum.YearMonthFn
              "VchID" b_gi_data_mobile_sum.LastVchId. PAUSE 0.
          
      END.
  END.
  IF n = 0 THEN DO:
      MESSAGE "No data found". PAUSE 1.
  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnImport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnImport wWin
ON CHOOSE OF BtnImport IN FRAME fMain /* Import */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Import the data?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\import_mobile_data.p.
  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch wWin
ON CHOOSE OF BtnSearch IN FRAME fMain /* Search */
DO:
  ASSIGN wYearMonthFN = "*" +  wYearMonthFN:SCREEN-VALUE + "*".
  ASSIGN wParty-Name = "*" +  wParty-Name:SCREEN-VALUE + "*".
      {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnValidate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnValidate wWin
ON CHOOSE OF BtnValidate IN FRAME fMain /* Validate */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Validate the data?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\VALIDATE_mobile_data.p.
  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Mobile_Journal_Entry
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Mobile_Journal_Entry wWin
ON CHOOSE OF MENU-ITEM m_Create_Mobile_Journal_Entry /* Create Mobile Journal Entry */
DO:
  
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_mobile_sum THEN DO:
     ASSIGN pmobile-sum-cons = gi_data_mobile_sum.mobile-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_mobile.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_mobile_partyname.p.

  FIND b_gi_data_mobile_sum WHERE b_gi_data_mobile_sum.mobile-sum-cons = pmobile-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_mobile_sum THEN DO:
      
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_mobile_sum.LastVchId, OUTPUT b_gi_data_mobile_sum.tally-response).
  END.
  APPLY "Value-Changed" TO BROWSE-1.  
  SESSION:SET-WAIT-STATE("").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_View_XML
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_View_XML wWin
ON CHOOSE OF MENU-ITEM m_View_XML /* View XML */
DO:
          DEF VAR pcom-name AS CHAR.
  ASSIGN pcom-name = "Start notepad.exe" + " C:\pvr\giph\tallylib\CreateVoucherJournal.XML".
  OS-COMMAND SILENT VALUE(pcom-name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wParty-Name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wParty-Name wWin
ON ANY-PRINTABLE OF wParty-Name IN FRAME fMain /* Party Name */
OR "Backspace" OF wParty-Name DO:

    ASSIGN wParty-Name = "*" + wParty-Name:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").

    APPLY LAST-EVENT:LABEL TO SELF.
    RETURN NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wParty-Name wWin
ON LEAVE OF wParty-Name IN FRAME fMain /* Party Name */
DO:
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wyearmonthfn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wyearmonthfn wWin
ON ANY-PRINTABLE OF wyearmonthfn IN FRAME fMain /* Year Month */
OR "Backspace" OF wyearmonthfn DO:

    ASSIGN wyearmonthfn = "*" + wyearmonthfn:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").

    APPLY LAST-EVENT:LABEL TO SELF.
    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wyearmonthfn wWin
ON LEAVE OF wyearmonthfn IN FRAME fMain /* Year Month */
DO:
  APPLY "Choose" TO BtnSearch.
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
  DISPLAY wyearmonthfn wParty-Name wtally-response 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE BtnImport BtnValidate BtnExport wyearmonthfn wParty-Name BtnSearch 
         BROWSE-1 BROWSE-2 BROWSE-3 wtally-response 
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
  /*
  ASSIGN wYearMonthFn:SCREEN-VALUE = "2019-10".
  ASSIGN wYearMonthFn = "*".
    */
  ASSIGN wYearMonthFn:SCREEN-VALUE = "2019-10".
  ASSIGN wYearMonthFn = "*2019-10*".


  ASSIGN wParty-Name:SCREEN-VALUE = "".
  ASSIGN wParty-Name = "*".

  

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

