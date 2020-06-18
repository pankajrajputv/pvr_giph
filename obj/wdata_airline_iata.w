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
DEF VAR pparty-name LIKE gi_data_airline_sum.party-name.

DEF BUFFER b_gi_data_airline_sum FOR gi_data_airline_sum.

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
&Scoped-define INTERNAL-TABLES gi_data_airline_sum gi_data_airline ~
gi_acc_det gi_acc_hea

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 ~
gi_data_airline_sum.airline-sum-cons gi_data_airline_sum.YearMonthFN ~
gi_data_airline_sum.LastVchId gi_data_airline_sum.party-name ~
gi_data_airline_sum.alias-name gi_data_airline_sum.IATAStock ~
gi_data_airline_sum.BasicAmt gi_data_airline_sum.Tax ~
gi_data_airline_sum.TopUpAmt gi_data_airline_sum.MTAgentComm ~
gi_data_airline_sum.TransFee gi_data_airline_sum.Penalty ~
gi_data_airline_sum.AgentComm gi_data_airline_sum.CollectFromAgent ~
gi_data_airline_sum.SupplierComm gi_data_airline_sum.PayableToAirline ~
gi_data_airline_sum.SegmentFee gi_data_airline_sum.Profit ~
gi_data_airline_sum.YearMonth gi_data_airline_sum.db-AgentComm ~
gi_data_airline_sum.db-ControlAgent gi_data_airline_sum.total-db ~
gi_data_airline_sum.cr-TopUp gi_data_airline_sum.cr-MtAgentComm ~
gi_data_airline_sum.cr-TransFee gi_data_airline_sum.cr-SupplierComm ~
gi_data_airline_sum.cr-PayableToAirline gi_data_airline_sum.total-cr ~
gi_data_airline_sum.total-db-cr-diff gi_data_airline_sum.AutoGP ~
gi_data_airline_sum.DiffGP 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_airline_sum ~
      WHERE gi_data_airline_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_airline_sum.IATAStock MATCHES wIATAStock NO-LOCK ~
    BY gi_data_airline_sum.airline-sum-cons INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_airline_sum ~
      WHERE gi_data_airline_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_airline_sum.IATAStock MATCHES wIATAStock NO-LOCK ~
    BY gi_data_airline_sum.airline-sum-cons INDEXED-REPOSITION.
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
gi_data_airline.TravelAgentId gi_data_airline.party-name ~
gi_data_airline.alias-name 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_data_airline ~
      WHERE gi_data_airline.YearMonthFN = pYearMonthFN ~
 AND gi_data_airline.IATAStock = pIataStock ~
/* AND gi_data_airline.total-db-cr-diff <> 0*/ ~
/* AND gi_data_airline.airline-cons = 499588*/ NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_data_airline ~
      WHERE gi_data_airline.YearMonthFN = pYearMonthFN ~
 AND gi_data_airline.IATAStock = pIataStock ~
/* AND gi_data_airline.total-db-cr-diff <> 0*/ ~
/* AND gi_data_airline.airline-cons = 499588*/ NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_data_airline
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_data_airline


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
&Scoped-Define ENABLED-OBJECTS wYearMonth1 MonthlyTotals BtnImport ~
BtnValidateImport BtnExport BtnValidateImportNoVat wyearmonth-from ~
wyearmonthfn wIataStock BtnSearch BtnExporFinal BtnExportNoVat BROWSE-1 ~
BROWSE-2 BROWSE-3 wtally-response 
&Scoped-Define DISPLAYED-OBJECTS wYearMonth1 wyearmonth-from wyearmonthfn ~
wIataStock wtally-response 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Airline_Journal_Entr LABEL "Create Airline Journal Entry"
       MENU-ITEM m_Create_Airline_Journal_Entr2 LABEL "Create Airline Journal Entry - NO VAT"
       MENU-ITEM m_Create_Airline_Journal_Entr3 LABEL "Create Airline Journal Entry - Final".


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExporFinal 
     LABEL "Export Final" 
     SIZE 17 BY .81.

DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnExportNoVat 
     LABEL "Export No Vat" 
     SIZE 17 BY .81.

DEFINE BUTTON BtnImport 
     LABEL "Import" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnSearch 
     LABEL "Search" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnValidateImport 
     LABEL "Validate" 
     SIZE 8.72 BY .81 TOOLTIP "Validate Import".

DEFINE BUTTON BtnValidateImportNoVat 
     LABEL "Validate No Vat" 
     SIZE 17.86 BY .81 TOOLTIP "Validate Import".

DEFINE BUTTON MonthlyTotals 
     LABEL "Monthly Totals" 
     SIZE 15.43 BY .81.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 37.43 BY 10.19
     FONT 4 NO-UNDO.

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

DEFINE VARIABLE wYearMonth1 AS CHARACTER INITIAL "2019" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Jan", "2019-01",
"Feb", "2019-02",
"Mar", "2019-03",
"Apr", "2019-04",
"May", "2019-05",
"Jun", "2019-06",
"Jul", "2019-07",
"Aug", "2019-08",
"Sep", "2019-09",
"Oct", "2019-10",
"Nov", "2019-11",
"Dec", "2019-12",
"All", "2019"
     SIZE 70.57 BY .69
     FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_data_airline_sum SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_data_airline SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_airline_sum.airline-sum-cons FORMAT "->>>>>>9":U
            WIDTH 4.86
      gi_data_airline_sum.YearMonthFN COLUMN-LABEL "YearMonFN" FORMAT "x(12)":U
            WIDTH 11
      gi_data_airline_sum.LastVchId COLUMN-LABEL "VchId" FORMAT "->>>>>>9":U
            WIDTH 6.72 COLUMN-FGCOLOR 9
      gi_data_airline_sum.party-name COLUMN-LABEL "Party Name" FORMAT "x(100)":U
            WIDTH 9.72
      gi_data_airline_sum.alias-name FORMAT "x(100)":U WIDTH 20
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
      gi_data_airline_sum.YearMonth FORMAT "x(8)":U
      gi_data_airline_sum.db-AgentComm COLUMN-LABEL "Db !AgentComm" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.db-ControlAgent COLUMN-LABEL "Db! Control Agent" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.total-db COLUMN-LABEL "Total!Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.57 COLUMN-BGCOLOR 21
      gi_data_airline_sum.cr-TopUp COLUMN-LABEL "Cr !Top Up" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.cr-MtAgentComm COLUMN-LABEL "Cr! MtAgent Comm" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.cr-TransFee COLUMN-LABEL "Cr !Trans Fee" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.cr-SupplierComm COLUMN-LABEL "Cr! Supp Comm" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.cr-PayableToAirline COLUMN-LABEL "Cr !PayToAirline" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.total-cr COLUMN-LABEL "Total!Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13.72 COLUMN-BGCOLOR 21
      gi_data_airline_sum.total-db-cr-diff COLUMN-LABEL "Debit Credit! Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13 COLUMN-BGCOLOR 21
      gi_data_airline_sum.AutoGP COLUMN-LABEL "Auto! GP" FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_airline_sum.DiffGP COLUMN-LABEL "Diff! GP" FORMAT "->,>>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 7.19
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
      gi_data_airline.party-name FORMAT "x(100)":U
      gi_data_airline.alias-name FORMAT "x(100)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96.29 BY 10.19
         FONT 4
         TITLE "Airline Data" FIT-LAST-COLUMN.

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 38.29 BY 10.19
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wYearMonth1 AT ROW 1.19 COL 2.14 NO-LABEL WIDGET-ID 64
     MonthlyTotals AT ROW 1.5 COL 132.72 WIDGET-ID 82
     BtnImport AT ROW 1.5 COL 148.72 WIDGET-ID 12
     BtnValidateImport AT ROW 1.5 COL 157.86 WIDGET-ID 16
     BtnExport AT ROW 1.5 COL 167 WIDGET-ID 14
     BtnValidateImportNoVat AT ROW 2.42 COL 157.86 WIDGET-ID 84
     wyearmonth-from AT ROW 2.5 COL 109 COLON-ALIGNED WIDGET-ID 10
     wyearmonthfn AT ROW 2.58 COL 13.86 COLON-ALIGNED WIDGET-ID 2
     wIataStock AT ROW 2.58 COL 40.14 COLON-ALIGNED WIDGET-ID 8
     BtnSearch AT ROW 2.58 COL 68.57 WIDGET-ID 6
     BtnExporFinal AT ROW 3.31 COL 140.29 WIDGET-ID 88
     BtnExportNoVat AT ROW 3.31 COL 158.29 WIDGET-ID 86
     BROWSE-1 AT ROW 4.23 COL 2 WIDGET-ID 300
     BROWSE-2 AT ROW 11.62 COL 2 WIDGET-ID 200
     BROWSE-3 AT ROW 11.62 COL 99.14 WIDGET-ID 400
     wtally-response AT ROW 11.62 COL 138.57 NO-LABEL WIDGET-ID 24
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.29 BY 24 WIDGET-ID 100.


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
         HEIGHT             = 24
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
/* BROWSE-TAB BROWSE-1 BtnExportNoVat fMain */
/* BROWSE-TAB BROWSE-2 BROWSE-1 fMain */
/* BROWSE-TAB BROWSE-3 BROWSE-2 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-2:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
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
     _TblList          = "giph.gi_data_airline_sum"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "giph.gi_data_airline_sum.airline-sum-cons|yes"
     _Where[1]         = "giph.gi_data_airline_sum.YearMonthFN MATCHES wYearMonthFn
 AND giph.gi_data_airline_sum.IATAStock MATCHES wIATAStock"
     _FldNameList[1]   > giph.gi_data_airline_sum.airline-sum-cons
"airline-sum-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "4.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_airline_sum.YearMonthFN
"YearMonthFN" "YearMonFN" ? "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_airline_sum.LastVchId
"LastVchId" "VchId" ? "integer" ? 9 ? ? ? ? no ? no no "6.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_airline_sum.party-name
"party-name" "Party Name" ? "character" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_airline_sum.alias-name
"alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = giph.gi_data_airline_sum.IATAStock
     _FldNameList[7]   > giph.gi_data_airline_sum.BasicAmt
"BasicAmt" "Basic !Amt" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_airline_sum.Tax
"Tax" ? ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_airline_sum.TopUpAmt
"TopUpAmt" "TopUp!Amt" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_airline_sum.MTAgentComm
"MTAgentComm" "MT Agent !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_airline_sum.TransFee
"TransFee" "Trans! Fee" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_airline_sum.Penalty
"Penalty" ? ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_airline_sum.AgentComm
"AgentComm" "Agent!Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_airline_sum.CollectFromAgent
"CollectFromAgent" "Coll From!Agent" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_airline_sum.SupplierComm
"SupplierComm" "Supplier!Comm" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_airline_sum.PayableToAirline
"PayableToAirline" "Payable!to Airline" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_airline_sum.SegmentFee
"SegmentFee" "Segment!Fee" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_airline_sum.Profit
"Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   = giph.gi_data_airline_sum.YearMonth
     _FldNameList[20]   > giph.gi_data_airline_sum.db-AgentComm
"db-AgentComm" "Db !AgentComm" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_airline_sum.db-ControlAgent
"db-ControlAgent" "Db! Control Agent" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_airline_sum.total-db
"total-db" "Total!Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_airline_sum.cr-TopUp
"cr-TopUp" "Cr !Top Up" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_airline_sum.cr-MtAgentComm
"cr-MtAgentComm" "Cr! MtAgent Comm" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_airline_sum.cr-TransFee
"cr-TransFee" "Cr !Trans Fee" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_airline_sum.cr-SupplierComm
"cr-SupplierComm" "Cr! Supp Comm" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_airline_sum.cr-PayableToAirline
"cr-PayableToAirline" "Cr !PayToAirline" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_airline_sum.total-cr
"total-cr" "Total!Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "13.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_airline_sum.total-db-cr-diff
"total-db-cr-diff" "Debit Credit! Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_airline_sum.AutoGP
"AutoGP" "Auto! GP" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   > giph.gi_data_airline_sum.DiffGP
"DiffGP" "Diff! GP" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_data_airline"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_airline.YearMonthFN = pYearMonthFN
 AND giph.gi_data_airline.IATAStock = pIataStock
/* AND giph.gi_data_airline.total-db-cr-diff <> 0*/
/* AND gi_data_airline.airline-cons = 499588*/"
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
     _FldNameList[33]   = giph.gi_data_airline.party-name
     _FldNameList[34]   = giph.gi_data_airline.alias-name
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
        ASSIGN pparty-name = gi_data_airline_sum.party-name.
        ASSIGN 
            pYearMonthFN = gi_data_airline_sum.YearMonthFN 
            pIataStock   = gi_data_airline_sum.IataStock.   
        ASSIGN wtally-response:SCREEN-VALUE = gi_data_airline_sum.tally-response.
    END.
    ELSE DO:
        ASSIGN 
            pYearMonthFN = ? 
            pIataStock   = ?.   
        ASSIGN wtally-response:SCREEN-VALUE = "".
    END.
    {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2.  
    {&OPEN-QUERY-BROWSE-3}
    APPLY "Value-Changed" TO BROWSE-3.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 wWin
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME fMain /* Airline Data */
DO:
        IF AVAILABLE gi_data_airline THEN DO:
        ASSIGN pparty-name = gi_data_airline.airlinesname.
    END.
    ELSE DO:
    END.
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
      /*
      ASSIGN pparty-name = gi_acc_det.partyname.
      */
      /*
      ASSIGN wparticulars:SCREEN-VALUE = gi_acc_det.particulars.
      ASSIGN pacc-led-name = gi_acc_det.acc-led-name.
      */
        
  END.
  ELSE DO:
      /*
      ASSIGN pparty-name = ?.
      */

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


&Scoped-define SELF-NAME BtnExporFinal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExporFinal wWin
ON CHOOSE OF BtnExporFinal IN FRAME fMain /* Export Final */
DO:
  DEF VAR n AS INT.

  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Export data to Tally?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
  END.
  ELSE DO:
      RETURN NO-APPLY.
  END.

  IF wYearMonth-from:SCREEN-VALUE = "" THEN DO:
      MESSAGE "Please input the year month data "
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN NO-APPLY.
  END.

  ASSIGN wYearMonth-from = "*" + wYearMonth-from:SCREEN-VALUE + "*".

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
  FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.YearMonth MATCHES  wYearMonth-from
                                   /*AND b_gi_data_airline_sum.LastVchId = ""                               */
      /*
                                   AND b_gi_data_airline_sum.YearMonthFn <= wYearMonthFN-to*/ 
      BREAK BY b_gi_data_airline_sum.YearMonthfn:
      n = n + 1.
      IF n = 5 THEN DO:
          PAUSE 1.
          ASSIGN n = 0.
      END.
      ASSIGN pairline-sum-cons = b_gi_data_airline_sum.airline-sum-cons.
      OS-DELETE SILENT VALUE(poutput-filename) NO-ERROR.
      /*
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.
      */
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname_final.p.

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


&Scoped-define SELF-NAME BtnExport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExport wWin
ON CHOOSE OF BtnExport IN FRAME fMain /* Export */
DO:
  DEF VAR n AS INT.

  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Export data to Tally?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
  END.
  ELSE DO:
      RETURN NO-APPLY.
  END.

  IF wYearMonth-from:SCREEN-VALUE = "" THEN DO:
      MESSAGE "Please input the year month data "
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN NO-APPLY.
  END.

  ASSIGN wYearMonth-from = "*" + wYearMonth-from:SCREEN-VALUE + "*".

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
  FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.YearMonth MATCHES  wYearMonth-from
                                   /*AND b_gi_data_airline_sum.LastVchId = ""                               */
      /*
                                   AND b_gi_data_airline_sum.YearMonthFn <= wYearMonthFN-to*/ 
      BREAK BY b_gi_data_airline_sum.YearMonthfn:
      n = n + 1.
      IF n = 5 THEN DO:
          PAUSE 1.
          ASSIGN n = 0.
      END.
      ASSIGN pairline-sum-cons = b_gi_data_airline_sum.airline-sum-cons.
      OS-DELETE SILENT VALUE(poutput-filename) NO-ERROR.
      /*
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.
      */
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.

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


&Scoped-define SELF-NAME BtnExportNoVat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExportNoVat wWin
ON CHOOSE OF BtnExportNoVat IN FRAME fMain /* Export No Vat */
DO:
  DEF VAR n AS INT.

  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Export data to Tally?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
  END.
  ELSE DO:
      RETURN NO-APPLY.
  END.

  IF wYearMonth-from:SCREEN-VALUE = "" THEN DO:
      MESSAGE "Please input the year month data "
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN NO-APPLY.
  END.

  ASSIGN wYearMonth-from = "*" + wYearMonth-from:SCREEN-VALUE + "*".

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
  FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.YearMonth MATCHES  wYearMonth-from
                                   /*AND b_gi_data_airline_sum.LastVchId = ""                               */
      /*
                                   AND b_gi_data_airline_sum.YearMonthFn <= wYearMonthFN-to*/ 
      BREAK BY b_gi_data_airline_sum.YearMonthfn:
      n = n + 1.
      IF n = 5 THEN DO:
          PAUSE 1.
          ASSIGN n = 0.
      END.
      ASSIGN pairline-sum-cons = b_gi_data_airline_sum.airline-sum-cons.
      OS-DELETE SILENT VALUE(poutput-filename) NO-ERROR.
      /*
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.
      */
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname_novat.p.

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


&Scoped-define SELF-NAME BtnImport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnImport wWin
ON CHOOSE OF BtnImport IN FRAME fMain /* Import */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Import the data?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\import_airlines_tickets_details.p.
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


&Scoped-define SELF-NAME BtnValidateImport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnValidateImport wWin
ON CHOOSE OF BtnValidateImport IN FRAME fMain /* Validate */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").

  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Validate the data?"            
  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
  TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\validate_airline_data.p.
  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnValidateImportNoVat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnValidateImportNoVat wWin
ON CHOOSE OF BtnValidateImportNoVat IN FRAME fMain /* Validate No Vat */
DO:

  MESSAGE "Validate the data?"            
  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
  TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      SESSION:SET-WAIT-STATE("GENERAL").
      RUN c:\pvr\giph\lib\validate_airline_data_novat.p.
      SESSION:SET-WAIT-STATE("").
  END.
  APPLY "Choose" TO BtnSearch.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME MonthlyTotals
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL MonthlyTotals wWin
ON CHOOSE OF MonthlyTotals IN FRAME fMain /* Monthly Totals */
DO:
  
DEF VAR pfilename AS CHAR.
DEF VAR ptotal-PayableToAirline AS DEC COLUMN-LABEL "Tot PayableToAirline" FORMAT "-z,zzz,zzz,zzz,zz9.99".
DEF VAR ptotal-Profit AS DEC COLUMN-LABEL "Tot Profit" FORMAT "-z,zzz,zzz,zzz,zz9.99".
DEF VAR ptotal-PayableToAirline-fn AS DEC COLUMN-LABEL "Tot PayableToAirlineFN" FORMAT "-z,zzz,zzz,zzz,zz9.99".

ASSIGN pfilename = "c:\temp\gi_data_airline_sum_total.txt".

FORM
    b_gi_data_airline_sum.yearmonth
    ptotal-PayableToAirline 
    ptotal-Profit
    WITH FRAME a DOWN TITLE "Year" STREAM-IO.


FORM
    b_gi_data_airline_sum.yearmonth
    b_gi_data_airline_sum.yearmonthfn
    ptotal-PayableToAirline-fn 
    WITH FRAME b DOWN TITLE "YearFN" STREAM-IO.

OUTPUT TO VALUE(pfilename).

    FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.yearmonth BEGINS "2019"  NO-LOCK
        BREAK BY b_gi_data_airline_sum.yearmonth WITH FRAME a DOWN:
    
        IF FIRST-OF(b_gi_data_airline_sum.yearmonth) THEN DO:
            ASSIGN ptotal-PayableToAirline = 0 .
            ASSIGN ptotal-Profit = 0 .
        END.
        ASSIGN ptotal-PayableToAirline = ptotal-PayableToAirline + b_gi_data_airline_sum.PayableToAirline.
        ASSIGN ptotal-Profit = ptotal-Profit + b_gi_data_airline_sum.Profit.
        ACCUMULATE b_gi_data_airline_sum.PayableToAirline(TOTAL).
        ACCUMULATE b_gi_data_airline_sum.Profit(TOTAL).
    
        IF LAST-OF(b_gi_data_airline_sum.yearmonth) THEN DO:
            DISPLAY 
                b_gi_data_airline_sum.yearmonth
                ptotal-PayableToAirline 
                ptotal-Profit
                WITH FRAME a STREAM-IO.
            DOWN WITH FRAME a.
        END.
    END.
    DISPLAY 
        ACCUM TOTAL b_gi_data_airline_sum.PayableToAirline FORMAT "-z,zzz,zzz,zzz,zz9.99" 
        ACCUM TOTAL b_gi_data_airline_sum.Profit FORMAT "-z,zzz,zzz,zzz,zz9.99" 
        WITH FRAME a1.


    /*
    FOR EACH b_gi_data_airline_sum WHERE b_gi_data_airline_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_airline_sum.yearmonthfn WITH FRAME b DOWN:
    
        IF FIRST-OF(b_gi_data_airline_sum.yearmonthfn) THEN DO:
            ASSIGN ptotal-PayableToAirline-fn = 0.
        END.
        ASSIGN ptotal-PayableToAirline-fn = ptotal-PayableToAirline-fn + b_gi_data_airline_sum.PayableToAirline.
    

        IF LAST-OF(b_gi_data_airline_sum.yearmonthfn) THEN DO:
            DISPLAY 
                b_gi_data_airline_sum.yearmonth
                b_gi_data_airline_sum.yearmonthfn
                ptotal-PayableToAirline-fn 
                WITH FRAME b STREAM-IO.
            DOWN WITH FRAME b.
        END.
    END.
      */

OUTPUT CLOSE.
OS-COMMAND NO-WAIT VALUE(pfilename).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Airline_Journal_Entr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Airline_Journal_Entr wWin
ON CHOOSE OF MENU-ITEM m_Create_Airline_Journal_Entr /* Create Airline Journal Entry */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
    IF AVAILABLE gi_data_airline_sum THEN DO:
        ASSIGN pairline-sum-cons = gi_data_airline_sum.airline-sum-cons.
    END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  FIND b_gi_data_airline_sum WHERE b_gi_data_airline_sum.airline-sum-cons = pairline-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_airline_sum THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_airline_sum.LastVchId, OUTPUT b_gi_data_airline_sum.tally-response).
      APPLY "Value-Changed" TO BROWSE-1. 
  END.
  SESSION:SET-WAIT-STATE("").


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Airline_Journal_Entr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Airline_Journal_Entr2 wWin
ON CHOOSE OF MENU-ITEM m_Create_Airline_Journal_Entr2 /* Create Airline Journal Entry - NO VAT */
DO:
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname_novat.p.

    DO WITH FRAME {&FRAME-NAME}:
        
    END.
    IF AVAILABLE gi_data_airline_sum THEN DO:
        ASSIGN pairline-sum-cons = gi_data_airline_sum.airline-sum-cons.
    END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.*/
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname_novat.p.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  FIND b_gi_data_airline_sum WHERE b_gi_data_airline_sum.airline-sum-cons = pairline-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_airline_sum THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_airline_sum.LastVchId, OUTPUT b_gi_data_airline_sum.tally-response).
      APPLY "Value-Changed" TO BROWSE-1. 
  END.
  SESSION:SET-WAIT-STATE("").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Airline_Journal_Entr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Airline_Journal_Entr3 wWin
ON CHOOSE OF MENU-ITEM m_Create_Airline_Journal_Entr3 /* Create Airline Journal Entry - Final */
DO:
    /*
    RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname_novat.p.
      */
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
    IF AVAILABLE gi_data_airline_sum THEN DO:
        ASSIGN pairline-sum-cons = gi_data_airline_sum.airline-sum-cons.
    END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.*/
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname.p.*/
      RUN C:\pvr\giph\lib\create_tally_voucher_journal_airlines_partyname_final.p.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  FIND b_gi_data_airline_sum WHERE b_gi_data_airline_sum.airline-sum-cons = pairline-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_airline_sum THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_airline_sum.LastVchId, OUTPUT b_gi_data_airline_sum.tally-response).
      APPLY "Value-Changed" TO BROWSE-1. 
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


&Scoped-define SELF-NAME wYearMonth1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wYearMonth1 wWin
ON VALUE-CHANGED OF wYearMonth1 IN FRAME fMain
DO:
  ASSIGN wyearmonthfn:SCREEN-VALUE = SELF:SCREEN-VALUE.

  IF SELF:SCREEN-VALUE = "2019" THEN DO:
     ASSIGN wYearMonthFn:SCREEN-VALUE = SELF:SCREEN-VALUE.

  END.
  ELSE
    ASSIGN wYearMonthFn = "2019*".
   
  APPLY "Leave" TO wYearMonthfn.
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
  DISPLAY wYearMonth1 wyearmonth-from wyearmonthfn wIataStock wtally-response 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wYearMonth1 MonthlyTotals BtnImport BtnValidateImport BtnExport 
         BtnValidateImportNoVat wyearmonth-from wyearmonthfn wIataStock 
         BtnSearch BtnExporFinal BtnExportNoVat BROWSE-1 BROWSE-2 BROWSE-3 
         wtally-response 
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
  ASSIGN wYearMonthFn:SCREEN-VALUE = "All".
  ASSIGN wYearMonthFn = "*All*".

  ASSIGN wYearMonthFn:SCREEN-VALUE = "2019-01".
  ASSIGN wYearMonthFn = "*2019*".
  wYearMonth1:SCREEN-VALUE = "2019-01".


  ASSIGN wIATAStock:SCREEN-VALUE = "".
  ASSIGN wIATAStock = "*".

  

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

