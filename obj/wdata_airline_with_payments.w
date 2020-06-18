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
DEF NEW SHARED VAR pairline-sum-cons LIKE gi_data_airline_sum.airline-sum-cons.

DEF VAR pYearMonthFN LIKE gi_data_airline_sum.YearMonthFN. 
DEF VAR pIataStock LIKE gi_data_airline_sum.IataStock.

DEF BUFFER b_gi_data_airline_sum FOR gi_data_airline_sum.

    DEF VAR poutput-filename AS CHAR.
    ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt".

DEF VAR pparty-name LIKE gi_data_airline_sum.party-name.

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
&Scoped-define INTERNAL-TABLES gi_data_airline_sum gi_data_airline ~
gi_acc_det

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 ~
gi_data_airline_sum.airline-sum-cons gi_data_airline_sum.YearMonthFN ~
gi_data_airline_sum.LastVchId gi_data_airline_sum.party-name ~
gi_data_airline_sum.IATAStock gi_data_airline_sum.BasicAmt ~
gi_data_airline_sum.Tax gi_data_airline_sum.TopUpAmt ~
gi_data_airline_sum.MTAgentComm gi_data_airline_sum.TransFee ~
gi_data_airline_sum.Penalty gi_data_airline_sum.AgentComm ~
gi_data_airline_sum.CollectFromAgent gi_data_airline_sum.SupplierComm ~
gi_data_airline_sum.PayableToAirline gi_data_airline_sum.SegmentFee ~
gi_data_airline_sum.Profit gi_data_airline_sum.AgentComm1 ~
gi_data_airline_sum.CollectFromAgent1 gi_data_airline_sum.InputVat ~
gi_data_airline_sum.TopUpAmt1 gi_data_airline_sum.MTAgentComm1 ~
gi_data_airline_sum.TransFee1 gi_data_airline_sum.SupplierComm1 ~
gi_data_airline_sum.PayableToAirline1 gi_data_airline_sum.OutputVat ~
gi_data_airline_sum.total-db gi_data_airline_sum.total-cr ~
gi_data_airline_sum.total-db-cr-diff gi_data_airline_sum.SegmentFee1 ~
gi_data_airline_sum.YearMonth 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_airline_sum ~
      WHERE gi_data_airline_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_airline_sum.IATAStock MATCHES wIATAStock NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_airline_sum ~
      WHERE gi_data_airline_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_airline_sum.IATAStock MATCHES wIATAStock NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_data_airline_sum
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_data_airline_sum


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_data_airline.airline-cons ~
gi_data_airline.AgentName gi_data_airline.AirlinesName ~
gi_data_airline.IssuedDate gi_data_airline.YearMonthFN ~
gi_data_airline.IATAStock gi_data_airline.BasicAmt gi_data_airline.Tax ~
gi_data_airline.TopUpAmt gi_data_airline.MTAgentComm ~
gi_data_airline.TransFee gi_data_airline.Penalty gi_data_airline.AgentComm ~
gi_data_airline.CollectFromAgent gi_data_airline.SupplierComm ~
gi_data_airline.PayableToAirline gi_data_airline.SegmentFee ~
gi_data_airline.Profit gi_data_airline.AgentComm1 ~
gi_data_airline.CollectFromAgent1 gi_data_airline.InputVat ~
gi_data_airline.TopUpAmt1 gi_data_airline.MTAgentComm1 ~
gi_data_airline.TransFee1 gi_data_airline.SupplierComm1 ~
gi_data_airline.PayableToAirline1 gi_data_airline.OutputVat ~
gi_data_airline.total-db gi_data_airline.total-cr ~
gi_data_airline.total-db-cr-diff gi_data_airline.YearMonth ~
gi_data_airline.TravelAgentId 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_data_airline ~
      WHERE gi_data_airline.YearMonthFN = pYearMonthFN ~
 AND gi_data_airline.IATAStock = pIataStock ~
/* AND gi_data_airline.total-db-cr-diff <> 0*/ NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_data_airline ~
      WHERE gi_data_airline.YearMonthFN = pYearMonthFN ~
 AND gi_data_airline.IATAStock = pIataStock ~
/* AND gi_data_airline.total-db-cr-diff <> 0*/ NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_data_airline
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_data_airline


/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 gi_acc_det.reg ~
gi_acc_det.acc-led-name gi_acc_det.partyname gi_acc_det.debit ~
gi_acc_det.credit gi_acc_det.cheque-num gi_acc_det.currency ~
gi_acc_det.forex-rate gi_acc_det.runbal1 gi_acc_det.runbal2 ~
gi_acc_det.amount gi_acc_det.refnum1 gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 gi_acc_det.acc-led-name ~
gi_acc_det.partyname 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.partyname = pparty-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.partyname = pparty-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 gi_acc_det


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wyearmonthfn wIataStock BtnSearch ~
wyearmonth-from BtnExport BROWSE-1 BROWSE-2 BROWSE-3 
&Scoped-Define DISPLAYED-OBJECTS wyearmonthfn wIataStock wyearmonth-from 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Airline_Journal_Entr LABEL "Create Airline Journal Entry".


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnSearch 
     LABEL "Search" 
     SIZE 8.72 BY .81.

DEFINE VARIABLE wIataStock AS CHARACTER FORMAT "X(256)":U 
     LABEL "IATA Stock" 
     VIEW-AS FILL-IN 
     SIZE 25.57 BY .81 NO-UNDO.

DEFINE VARIABLE wyearmonth-from AS CHARACTER FORMAT "X(256)":U 
     LABEL "Year Month From" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81 NO-UNDO.

DEFINE VARIABLE wyearmonthfn AS CHARACTER FORMAT "X(256)":U 
     LABEL "Year Month" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_data_airline_sum SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_data_airline SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_airline_sum.airline-sum-cons FORMAT "->>>>>>9":U
            WIDTH 4.86
      gi_data_airline_sum.YearMonthFN COLUMN-LABEL "YearMonFN" FORMAT "x(12)":U
            WIDTH 11
      gi_data_airline_sum.LastVchId COLUMN-LABEL "LastVchId" FORMAT "->>>>>>9":U
            WIDTH 7.57
      gi_data_airline_sum.party-name COLUMN-LABEL "Party Name" FORMAT "x(100)":U
            WIDTH 9.72
      gi_data_airline_sum.IATAStock FORMAT "x(20)":U
      gi_data_airline_sum.BasicAmt COLUMN-LABEL "Basic !Amt" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.Tax FORMAT "->,>>>,>>>,>>9.99":U WIDTH 10.14
      gi_data_airline_sum.TopUpAmt COLUMN-LABEL "TopUp!Amt" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.MTAgentComm COLUMN-LABEL "MT Agent !Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.TransFee COLUMN-LABEL "Trans! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.Penalty FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.AgentComm COLUMN-LABEL "Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.CollectFromAgent COLUMN-LABEL "Coll From!Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.SupplierComm COLUMN-LABEL "Supplier!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.PayableToAirline COLUMN-LABEL "Payable!to Airline" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.SegmentFee COLUMN-LABEL "Segment!Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.Profit FORMAT "->,>>>,>>>,>>9.99":U WIDTH 8.57
      gi_data_airline_sum.AgentComm1 COLUMN-LABEL "Db Agent! Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 19
      gi_data_airline_sum.CollectFromAgent1 COLUMN-LABEL "Db Coll !From Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 19
      gi_data_airline_sum.InputVat COLUMN-LABEL "Db Input! Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 19
      gi_data_airline_sum.TopUpAmt1 COLUMN-LABEL "Cr Top Up!Amt" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 20
      gi_data_airline_sum.MTAgentComm1 COLUMN-LABEL "Cr MT Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 20
      gi_data_airline_sum.TransFee1 COLUMN-LABEL "Cr Trans!Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 20
      gi_data_airline_sum.SupplierComm1 COLUMN-LABEL "Cr Supplier!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 20
      gi_data_airline_sum.PayableToAirline1 COLUMN-LABEL "Cr Payable!to Airline" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 20
      gi_data_airline_sum.OutputVat COLUMN-LABEL "Cr Output! Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14 COLUMN-BGCOLOR 20
      gi_data_airline_sum.total-db COLUMN-LABEL "Total!Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.57 COLUMN-BGCOLOR 21
      gi_data_airline_sum.total-cr COLUMN-LABEL "Total!Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13.72 COLUMN-BGCOLOR 21
      gi_data_airline_sum.total-db-cr-diff COLUMN-LABEL "Debit Credit! Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13 COLUMN-BGCOLOR 21
      gi_data_airline_sum.SegmentFee1 COLUMN-LABEL "Segment!Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline_sum.YearMonth FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 11.54
         FONT 4
         TITLE "Airline Data Summary" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_data_airline.airline-cons FORMAT "->>>>>>9":U
      gi_data_airline.AgentName FORMAT "x(100)":U WIDTH 29
      gi_data_airline.AirlinesName FORMAT "x(20)":U
      gi_data_airline.IssuedDate FORMAT "99/99/9999":U
      gi_data_airline.YearMonthFN COLUMN-LABEL "YearMonFN" FORMAT "x(12)":U
      gi_data_airline.IATAStock FORMAT "x(20)":U
      gi_data_airline.BasicAmt COLUMN-LABEL "Basic!Amt" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.57
      gi_data_airline.Tax FORMAT "->,>>>,>>>,>>9.99":U WIDTH 8.43
      gi_data_airline.TopUpAmt COLUMN-LABEL "TopUp!Amt" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.57
      gi_data_airline.MTAgentComm COLUMN-LABEL "MT Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.86
      gi_data_airline.TransFee COLUMN-LABEL "Trans! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29
      gi_data_airline.Penalty FORMAT "->,>>>,>>>,>>9.99":U WIDTH 7.57
      gi_data_airline.AgentComm COLUMN-LABEL "Agent !Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_airline.CollectFromAgent COLUMN-LABEL "Coll From !Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.72
      gi_data_airline.SupplierComm COLUMN-LABEL "Supplier! Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.72
      gi_data_airline.PayableToAirline COLUMN-LABEL "Payable !to Airline" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10
      gi_data_airline.SegmentFee COLUMN-LABEL "Segment! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29
      gi_data_airline.Profit FORMAT "->,>>>,>>>,>>9.99":U WIDTH 8
      gi_data_airline.AgentComm1 COLUMN-LABEL "Db Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.29 COLUMN-BGCOLOR 19
      gi_data_airline.CollectFromAgent1 COLUMN-LABEL "Db Coll!From Agent" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 19
      gi_data_airline.InputVat COLUMN-LABEL "Db Input!Vat" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 19
      gi_data_airline.TopUpAmt1 COLUMN-LABEL "Cr Top Up! Amt" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 20
      gi_data_airline.MTAgentComm1 COLUMN-LABEL "Cr MT Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11 COLUMN-BGCOLOR 20
      gi_data_airline.TransFee1 COLUMN-LABEL "Cr Trans!Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.72 COLUMN-BGCOLOR 20
      gi_data_airline.SupplierComm1 COLUMN-LABEL "Cr Supplier!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.14 COLUMN-BGCOLOR 20
      gi_data_airline.PayableToAirline1 COLUMN-LABEL "Cr Payable!to Airline" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.29 COLUMN-BGCOLOR 20
      gi_data_airline.OutputVat COLUMN-LABEL "Cr Output!Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29 COLUMN-BGCOLOR 20
      gi_data_airline.total-db COLUMN-LABEL "Total!Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.72 COLUMN-BGCOLOR 21
      gi_data_airline.total-cr COLUMN-LABEL "Total!Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.14 COLUMN-BGCOLOR 21
      gi_data_airline.total-db-cr-diff COLUMN-LABEL "Debit Credit!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.29 COLUMN-BGCOLOR 21
      gi_data_airline.YearMonth FORMAT "x(8)":U
      gi_data_airline.TravelAgentId FORMAT "x(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 51.72 BY 10.19
         FONT 4
         TITLE "Airline Data" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 wWin _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 119 BY 8.77
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wyearmonthfn AT ROW 1.5 COL 13.86 COLON-ALIGNED WIDGET-ID 2
     wIataStock AT ROW 1.5 COL 40.14 COLON-ALIGNED WIDGET-ID 8
     BtnSearch AT ROW 1.5 COL 68.57 WIDGET-ID 6
     wyearmonth-from AT ROW 1.5 COL 109 COLON-ALIGNED WIDGET-ID 10
     BtnExport AT ROW 1.5 COL 144.57 WIDGET-ID 14
     BROWSE-1 AT ROW 2.58 COL 2 WIDGET-ID 300
     BROWSE-2 AT ROW 14.31 COL 124.29 WIDGET-ID 200
     BROWSE-3 AT ROW 14.58 COL 2.57 WIDGET-ID 400
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.29 BY 23.69 WIDGET-ID 100.


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
         TITLE              = "Summary Airlines - IATA"
         HEIGHT             = 23.69
         WIDTH              = 176.29
         MAX-HEIGHT         = 30.81
         MAX-WIDTH          = 228.57
         VIRTUAL-HEIGHT     = 30.81
         VIRTUAL-WIDTH      = 228.57
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
/* BROWSE-TAB BROWSE-1 BtnExport fMain */
/* BROWSE-TAB BROWSE-2 BROWSE-1 fMain */
/* BROWSE-TAB BROWSE-3 BROWSE-2 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-3:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-3:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-3:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_det.acc-led-name:COLUMN-READ-ONLY IN BROWSE BROWSE-3 = TRUE
       gi_acc_det.partyname:COLUMN-READ-ONLY IN BROWSE BROWSE-3 = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_data_airline_sum"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_airline_sum.YearMonthFN MATCHES wYearMonthFn
 AND giph.gi_data_airline_sum.IATAStock MATCHES wIATAStock"
     _FldNameList[1]   > giph.gi_data_airline_sum.airline-sum-cons
"gi_data_airline_sum.airline-sum-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "4.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_airline_sum.YearMonthFN
"gi_data_airline_sum.YearMonthFN" "YearMonFN" ? "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_airline_sum.LastVchId
"gi_data_airline_sum.LastVchId" "LastVchId" ? "character" ? ? ? ? ? ? no ? no no "7.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_airline_sum.party-name
"gi_data_airline_sum.party-name" "Party Name" ? "character" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = giph.gi_data_airline_sum.IATAStock
     _FldNameList[6]   > giph.gi_data_airline_sum.BasicAmt
"gi_data_airline_sum.BasicAmt" "Basic !Amt" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_airline_sum.Tax
"gi_data_airline_sum.Tax" ? ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_airline_sum.TopUpAmt
"gi_data_airline_sum.TopUpAmt" "TopUp!Amt" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_airline_sum.MTAgentComm
"gi_data_airline_sum.MTAgentComm" "MT Agent !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_airline_sum.TransFee
"gi_data_airline_sum.TransFee" "Trans! Fee" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_airline_sum.Penalty
"gi_data_airline_sum.Penalty" ? ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_airline_sum.AgentComm
"gi_data_airline_sum.AgentComm" "Agent!Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_airline_sum.CollectFromAgent
"gi_data_airline_sum.CollectFromAgent" "Coll From!Agent" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_airline_sum.SupplierComm
"gi_data_airline_sum.SupplierComm" "Supplier!Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_airline_sum.PayableToAirline
"gi_data_airline_sum.PayableToAirline" "Payable!to Airline" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_airline_sum.SegmentFee
"gi_data_airline_sum.SegmentFee" "Segment!Fee" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_airline_sum.Profit
"gi_data_airline_sum.Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_airline_sum.AgentComm1
"gi_data_airline_sum.AgentComm1" "Db Agent! Comm" ? "decimal" 19 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_airline_sum.CollectFromAgent1
"gi_data_airline_sum.CollectFromAgent1" "Db Coll !From Agent" ? "decimal" 19 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_airline_sum.InputVat
"gi_data_airline_sum.InputVat" "Db Input! Vat" ? "decimal" 19 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_airline_sum.TopUpAmt1
"gi_data_airline_sum.TopUpAmt1" "Cr Top Up!Amt" ? "decimal" 20 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_airline_sum.MTAgentComm1
"gi_data_airline_sum.MTAgentComm1" "Cr MT Agent!Comm" ? "decimal" 20 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_airline_sum.TransFee1
"gi_data_airline_sum.TransFee1" "Cr Trans!Fee" ? "decimal" 20 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_airline_sum.SupplierComm1
"gi_data_airline_sum.SupplierComm1" "Cr Supplier!Comm" ? "decimal" 20 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_airline_sum.PayableToAirline1
"gi_data_airline_sum.PayableToAirline1" "Cr Payable!to Airline" ? "decimal" 20 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_airline_sum.OutputVat
"gi_data_airline_sum.OutputVat" "Cr Output! Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_airline_sum.total-db
"gi_data_airline_sum.total-db" "Total!Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_airline_sum.total-cr
"gi_data_airline_sum.total-cr" "Total!Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "13.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_airline_sum.total-db-cr-diff
"gi_data_airline_sum.total-db-cr-diff" "Debit Credit! Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_airline_sum.SegmentFee1
"gi_data_airline_sum.SegmentFee1" "Segment!Fee" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   = giph.gi_data_airline_sum.YearMonth
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_data_airline"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_airline.YearMonthFN = pYearMonthFN
 AND giph.gi_data_airline.IATAStock = pIataStock
/* AND giph.gi_data_airline.total-db-cr-diff <> 0*/"
     _FldNameList[1]   = giph.gi_data_airline.airline-cons
     _FldNameList[2]   > giph.gi_data_airline.AgentName
"gi_data_airline.AgentName" ? ? "character" ? ? ? ? ? ? no ? no no "29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = giph.gi_data_airline.AirlinesName
     _FldNameList[4]   = giph.gi_data_airline.IssuedDate
     _FldNameList[5]   > giph.gi_data_airline.YearMonthFN
"gi_data_airline.YearMonthFN" "YearMonFN" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = giph.gi_data_airline.IATAStock
     _FldNameList[7]   > giph.gi_data_airline.BasicAmt
"gi_data_airline.BasicAmt" "Basic!Amt" ? "decimal" ? ? ? ? ? ? no ? no no "10.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_airline.Tax
"gi_data_airline.Tax" ? ? "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_airline.TopUpAmt
"gi_data_airline.TopUpAmt" "TopUp!Amt" ? "decimal" ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_airline.MTAgentComm
"gi_data_airline.MTAgentComm" "MT Agent!Comm" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_airline.TransFee
"gi_data_airline.TransFee" "Trans! Fee" ? "decimal" ? ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_airline.Penalty
"gi_data_airline.Penalty" ? ? "decimal" ? ? ? ? ? ? no ? no no "7.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_airline.AgentComm
"gi_data_airline.AgentComm" "Agent !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_airline.CollectFromAgent
"gi_data_airline.CollectFromAgent" "Coll From !Agent" ? "decimal" ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_airline.SupplierComm
"gi_data_airline.SupplierComm" "Supplier! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_airline.PayableToAirline
"gi_data_airline.PayableToAirline" "Payable !to Airline" ? "decimal" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_airline.SegmentFee
"gi_data_airline.SegmentFee" "Segment! Fee" ? "decimal" ? ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_airline.Profit
"gi_data_airline.Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_airline.AgentComm1
"gi_data_airline.AgentComm1" "Db Agent!Comm" ? "decimal" 19 ? ? ? ? ? no ? no no "10.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_airline.CollectFromAgent1
"gi_data_airline.CollectFromAgent1" "Db Coll!From Agent" ? "decimal" 19 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_airline.InputVat
"gi_data_airline.InputVat" "Db Input!Vat" ? "decimal" 19 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_airline.TopUpAmt1
"gi_data_airline.TopUpAmt1" "Cr Top Up! Amt" ? "decimal" 20 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_airline.MTAgentComm1
"gi_data_airline.MTAgentComm1" "Cr MT Agent!Comm" "->,>>>,>>>,>>9.99" "decimal" 20 ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_airline.TransFee1
"gi_data_airline.TransFee1" "Cr Trans!Fee" ? "decimal" 20 ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_airline.SupplierComm1
"gi_data_airline.SupplierComm1" "Cr Supplier!Comm" ? "decimal" 20 ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_airline.PayableToAirline1
"gi_data_airline.PayableToAirline1" "Cr Payable!to Airline" ? "decimal" 20 ? ? ? ? ? no ? no no "9.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_airline.OutputVat
"gi_data_airline.OutputVat" "Cr Output!Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_airline.total-db
"gi_data_airline.total-db" "Total!Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "7.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_airline.total-cr
"gi_data_airline.total-cr" "Total!Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "7.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_airline.total-db-cr-diff
"gi_data_airline.total-db-cr-diff" "Debit Credit!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "8.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   = giph.gi_data_airline.YearMonth
     _FldNameList[32]   = giph.gi_data_airline.TravelAgentId
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_det.partyname = pparty-name"
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? yes ? no no "20.29" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? yes ? no no "20.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Summary Airlines - IATA */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Summary Airlines - IATA */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Airline Data Summary */
DO:
    IF AVAILABLE gi_data_airline_sum THEN DO:
        ASSIGN 
            pYearMonthFN = gi_data_airline_sum.YearMonthFN 
            pIataStock   = gi_data_airline_sum.IataStock.   
        ASSIGN pparty-name = gi_data_airline_sum.party-name.
    END.
    ELSE DO:
        ASSIGN 
            pYearMonthFN = ? 
            pIataStock   = ?.   
        ASSIGN 
            pparty-name = ?.
    END.
    {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
&Scoped-define SELF-NAME BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 wWin
ON VALUE-CHANGED OF BROWSE-3 IN FRAME fMain /* Transaction Details */
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
  IF wYearMonth-from:SCREEN-VALUE = "" THEN DO:
      MESSAGE "Please input the year month data "
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN NO-APPLY.
  END.

  ASSIGN wYearMonth-from = wYearMonth-from:SCREEN-VALUE.

  SESSION:SET-WAIT-STATE("GENERAL").
  /*
  FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.YearMonthFn >= wYearMonthFN-from
                                   AND b_gi_data_airline_sum.YearMonthFn <= wYearMonthFN-to NO-LOCK:
      MESSAGE b_gi_data_airline_sum.airline-sum-cons b_gi_data_airline_sum.YearMonthFn. PAUSE 0.
      ASSIGN pairline-sum-cons = gi_data_airline_sum.airline-sum-cons.
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.
  END.
    */
  n = 0. 
  FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.YearMonth =  wYearMonth-from
                                   /*AND b_gi_data_airline_sum.LastVchId = ""                               */
      /*
                                   AND b_gi_data_airline_sum.YearMonthFn <= wYearMonthFN-to*/ :
      n = n + 1.
      IF n = 5 THEN DO:
          PAUSE 1.
          ASSIGN n = 0.
      END.
      ASSIGN pairline-sum-cons = b_gi_data_airline_sum.airline-sum-cons.
      OS-DELETE SILENT VALUE(poutput-filename) NO-ERROR.
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.

      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_airline_sum.LastVchId, OUTPUT b_gi_data_airline_sum.tally-response).
      MESSAGE b_gi_data_airline_sum.airline-sum-cons 
          b_gi_data_airline_sum.YearMonthFn
          "VchID" b_gi_data_airline_sum.LastVchId. PAUSE 0.
      /*
      ASSIGN b_gi_data_airline_sum.LastVchId = pLastVchId.
      */
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
  ASSIGN wIATAStock = "*" +  wIATAStock:SCREEN-VALUE + "*".
      {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Airline_Journal_Entr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Airline_Journal_Entr wWin
ON CHOOSE OF MENU-ITEM m_Create_Airline_Journal_Entr /* Create Airline Journal Entry */
DO:
    IF AVAILABLE gi_data_airline_sum THEN DO:
        ASSIGN pairline-sum-cons = gi_data_airline_sum.airline-sum-cons.
    END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_partyname.p.

  FIND b_gi_data_airline_sum WHERE b_gi_data_airline_sum.airline-sum-cons = pairline-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_airline_sum THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_airline_sum.LastVchId, OUTPUT b_gi_data_airline_sum.tally-response).

  END.
  SESSION:SET-WAIT-STATE("").


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wIataStock
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wIataStock wWin
ON ANY-PRINTABLE OF wIataStock IN FRAME fMain /* IATA Stock */
OR "Backspace" OF wIataStock DO:

    ASSIGN wIataStock = "*" + wIataStock:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").
    APPLY LAST-EVENT:LABEL TO SELF.
    RETURN NO-APPLY.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wIataStock wWin
ON LEAVE OF wIataStock IN FRAME fMain /* IATA Stock */
DO:
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wyearmonth-from
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wyearmonth-from wWin
ON LEAVE OF wyearmonth-from IN FRAME fMain /* Year Month From */
DO:
  /*APPLY "Choose" TO BtnSearch.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wyearmonthfn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wyearmonthfn wWin
ON ANY-PRINTABLE OF wyearmonthfn IN FRAME fMain /* Year Month */
OR "Backspace" OF wyearmonthfn DO:

    ASSIGN wyearmonthfn = "*" + wyearmonthfn:SCREEN-VALUE + "*".

    ASSIGN wyearmonth-from:SCREEN-VALUE = SELF:SCREEN-VALUE.
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
    ASSIGN wyearmonth-from:SCREEN-VALUE = SELF:SCREEN-VALUE.

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
  DISPLAY wyearmonthfn wIataStock wyearmonth-from 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wyearmonthfn wIataStock BtnSearch wyearmonth-from BtnExport BROWSE-1 
         BROWSE-2 BROWSE-3 
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


  ASSIGN wIATAStock:SCREEN-VALUE = "".
  ASSIGN wIATAStock = "*".

  

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

