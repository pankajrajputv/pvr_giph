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
DEF NEW SHARED VAR pinsurance-sum-cons LIKE gi_data_insurance_sum.insurance-sum-cons.

DEF VAR pYearMonthFN LIKE gi_data_insurance_sum.YearMonthFN. 
DEF VAR pYearMonthFN1 LIKE gi_data_insurance_sum.YearMonthFN. 
DEF VAR pparty-name LIKE gi_data_insurance_sum.party-name.

DEF BUFFER b_gi_data_insurance_sum FOR gi_data_insurance_sum.

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
&Scoped-define INTERNAL-TABLES gi_data_insurance_sum gi_data_insurance ~
gi_acc_det gi_acc_hea

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 ~
gi_data_insurance_sum.insurance-sum-cons gi_data_insurance_sum.YearMonthFN ~
gi_data_insurance_sum.LastVchId gi_data_insurance_sum.party-name ~
gi_data_insurance_sum.alias-name gi_data_insurance_sum.TotalPremiumAmount ~
gi_data_insurance_sum.SupplierComm gi_data_insurance_sum.AgentComm ~
gi_data_insurance_sum.CollectFromAgent ~
gi_data_insurance_sum.PayableToSupplier gi_data_insurance_sum.Payable ~
gi_data_insurance_sum.Profit gi_data_insurance_sum.db-ControlAgent ~
gi_data_insurance_sum.db-AgentComm gi_data_insurance_sum.total-db ~
gi_data_insurance_sum.cr-InsuranceSales ~
gi_data_insurance_sum.cr-InsurancePurchases gi_data_insurance_sum.total-cr ~
gi_data_insurance_sum.total-db-cr-diff gi_data_insurance_sum.AutoGP ~
gi_data_insurance_sum.DiffGP 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_insurance_sum ~
      WHERE gi_data_insurance_sum.YearMonthFN MATCHES wYearMonthFN ~
AND  ~
giph.gi_data_insurance_sum.Party-Name MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_insurance_sum ~
      WHERE gi_data_insurance_sum.YearMonthFN MATCHES wYearMonthFN ~
AND  ~
giph.gi_data_insurance_sum.Party-Name MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_data_insurance_sum
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_data_insurance_sum


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_data_insurance.YearMonthFN ~
gi_data_insurance.insurance-cons gi_data_insurance.TravelAgentId ~
gi_data_insurance.AgentName gi_data_insurance.TerminalId ~
gi_data_insurance.TerminalName gi_data_insurance.PolicyNo ~
gi_data_insurance.PassengerName gi_data_insurance.BkPnr ~
gi_data_insurance.TranDate-Txt gi_data_insurance.TotalPremiumAmount ~
gi_data_insurance.SupplierComm gi_data_insurance.AgentComm ~
gi_data_insurance.CollectFromAgent gi_data_insurance.PayableToSupplier ~
gi_data_insurance.Payable gi_data_insurance.Profit gi_data_insurance.date1 ~
gi_data_insurance.party-name gi_data_insurance.GrossAmount1 ~
gi_data_insurance.AgentComm1 gi_data_insurance.InputVat ~
gi_data_insurance.Payable1 gi_data_insurance.comm-income1 ~
gi_data_insurance.OutputVat gi_data_insurance.total-db ~
gi_data_insurance.total-cr gi_data_insurance.total-db-cr-diff 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_data_insurance ~
      WHERE gi_data_insurance.YearMonthFN MATCHES pYearMonthFN1 AND ~
/*giph.gi_data_insurance.AgentName MATCHES wAgentName AND*/ ~
giph.gi_data_insurance.Party-Name MATCHES pParty-Name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_data_insurance ~
      WHERE gi_data_insurance.YearMonthFN MATCHES pYearMonthFN1 AND ~
/*giph.gi_data_insurance.AgentName MATCHES wAgentName AND*/ ~
giph.gi_data_insurance.Party-Name MATCHES pParty-Name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_data_insurance
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_data_insurance


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
&Scoped-Define ENABLED-OBJECTS wYearMonth1 BtnValidateNoVat BtnImport ~
BtnValidate BtnExport BtnExportFinal MonthlyTotals wyearmonthfn wParty-Name ~
BtnSearch BROWSE-1 BROWSE-2 BROWSE-3 wtally-response 
&Scoped-Define DISPLAYED-OBJECTS wYearMonth1 wyearmonthfn wParty-Name ~
wtally-response 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Insurance_Journal_En LABEL "Create Insurance Journal Entry"
       MENU-ITEM m_Create_Insurance_Journal_En2 LABEL "Create Insurance Journal Entry - Final"
       RULE
       MENU-ITEM m_View_XML     LABEL "View XML"      .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnExportFinal 
     LABEL "Export Final" 
     SIZE 16.43 BY .81.

DEFINE BUTTON BtnImport 
     LABEL "Import" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnSearch 
     LABEL "Search" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnValidate 
     LABEL "Validate" 
     SIZE 8.72 BY .81 TOOLTIP "Validate Visa Data".

DEFINE BUTTON BtnValidateNoVat 
     LABEL "Validate No Vat" 
     SIZE 22 BY .81 TOOLTIP "Validate Visa Data - No Vat".

DEFINE BUTTON MonthlyTotals 
     LABEL "Monthly Totals" 
     SIZE 15.43 BY .81.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 37.14 BY 10.19
     FONT 4 NO-UNDO.

DEFINE VARIABLE wParty-Name AS CHARACTER FORMAT "X(256)":U 
     LABEL "Party Name" 
     VIEW-AS FILL-IN 
     SIZE 25.57 BY .81 NO-UNDO.

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
      gi_data_insurance_sum SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_data_insurance SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_insurance_sum.insurance-sum-cons FORMAT "->>>>>>9":U
      gi_data_insurance_sum.YearMonthFN COLUMN-LABEL "Year Month!FN" FORMAT "x(12)":U
            WIDTH 8.29
      gi_data_insurance_sum.LastVchId FORMAT "->>>>>>9":U
      gi_data_insurance_sum.party-name COLUMN-LABEL "Party! Name" FORMAT "x(100)":U
            WIDTH 32.29
      gi_data_insurance_sum.alias-name FORMAT "x(100)":U WIDTH 15
      gi_data_insurance_sum.TotalPremiumAmount COLUMN-LABEL "Tot Premium! Amt" FORMAT "->>,>>9.99":U
            WIDTH 8.72
      gi_data_insurance_sum.SupplierComm COLUMN-LABEL "Supplier! Comm" FORMAT "->>,>>9.99":U
            WIDTH 8.86
      gi_data_insurance_sum.AgentComm COLUMN-LABEL "Agent !Comm" FORMAT "->>,>>9.99":U
            WIDTH 8.86
      gi_data_insurance_sum.CollectFromAgent COLUMN-LABEL "Coll From !Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_insurance_sum.PayableToSupplier COLUMN-LABEL "Payable to! Airline" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.14
      gi_data_insurance_sum.Payable FORMAT "->>,>>9.99":U
      gi_data_insurance_sum.Profit FORMAT "->>,>>9.99":U
      gi_data_insurance_sum.db-ControlAgent COLUMN-LABEL "Db ! Control Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12.57
      gi_data_insurance_sum.db-AgentComm COLUMN-LABEL "Db ! Agent Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13
      gi_data_insurance_sum.total-db COLUMN-LABEL "Total! Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.29 COLUMN-BGCOLOR 21
      gi_data_insurance_sum.cr-InsuranceSales COLUMN-LABEL "Cr ! Insur. Sales" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12.86
      gi_data_insurance_sum.cr-InsurancePurchases COLUMN-LABEL "Cr ! Insur. Purch." FORMAT "->>,>>9.99":U
            WIDTH 13.72
      gi_data_insurance_sum.total-cr COLUMN-LABEL "Total !Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9 COLUMN-BGCOLOR 21
      gi_data_insurance_sum.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.72 COLUMN-BGCOLOR 21
      gi_data_insurance_sum.AutoGP COLUMN-LABEL "Auto ! GP" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.14
      gi_data_insurance_sum.DiffGP COLUMN-LABEL "Diff ! GP" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 9.12
         FONT 4
         TITLE "Insurance Data" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_data_insurance.YearMonthFN COLUMN-LABEL "Year Mon!FN" FORMAT "x(12)":U
            WIDTH 9.14
      gi_data_insurance.insurance-cons FORMAT "->>>>>>9":U WIDTH 6
      gi_data_insurance.TravelAgentId COLUMN-LABEL "Travel !Agent ID" FORMAT "x(20)":U
            WIDTH 12.72
      gi_data_insurance.AgentName COLUMN-LABEL "Agent!Name" FORMAT "x(100)":U
            WIDTH 20.57
      gi_data_insurance.TerminalId COLUMN-LABEL "Terminal! Id" FORMAT "x(50)":U
            WIDTH 11.14
      gi_data_insurance.TerminalName FORMAT "x(50)":U WIDTH 9.57
      gi_data_insurance.PolicyNo COLUMN-LABEL "Policy! No" FORMAT "x(20)":U
            WIDTH 10.86
      gi_data_insurance.PassengerName COLUMN-LABEL "Passenger! Name" FORMAT "x(50)":U
            WIDTH 10
      gi_data_insurance.BkPnr COLUMN-LABEL "Bk !Pnr" FORMAT "x(15)":U
            WIDTH 8.72
      gi_data_insurance.TranDate-Txt COLUMN-LABEL "Tran Date! - Txt" FORMAT "x(15)":U
      gi_data_insurance.TotalPremiumAmount COLUMN-LABEL "Tot Premium! Amt" FORMAT "->>,>>9.99":U
            WIDTH 8.86
      gi_data_insurance.SupplierComm COLUMN-LABEL "Supplier !Comm" FORMAT "->>,>>9.99":U
            WIDTH 7.43
      gi_data_insurance.AgentComm COLUMN-LABEL "Agent !Comm" FORMAT "->>,>>9.99":U
            WIDTH 7
      gi_data_insurance.CollectFromAgent COLUMN-LABEL "Coll From! Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.43
      gi_data_insurance.PayableToSupplier COLUMN-LABEL "Payable to! Airline" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8
      gi_data_insurance.Payable FORMAT "->>,>>9.99":U
      gi_data_insurance.Profit FORMAT "->>,>>9.99":U WIDTH 5.57
      gi_data_insurance.date1 FORMAT "99/99/9999":U WIDTH 9.72
      gi_data_insurance.party-name COLUMN-LABEL "Party! Name" FORMAT "x(100)":U
            WIDTH 26.43
      gi_data_insurance.GrossAmount1 COLUMN-LABEL "Db.Gross !Amount" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 19
      gi_data_insurance.AgentComm1 COLUMN-LABEL "Db Agent !Comm" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 19
      gi_data_insurance.InputVat COLUMN-LABEL "Db Input !Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8 COLUMN-BGCOLOR 19
      gi_data_insurance.Payable1 COLUMN-LABEL "Cr!Payable" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 20
      gi_data_insurance.comm-income1 COLUMN-LABEL "Cr Comm.! Income" FORMAT "->,>>>,>>>,>>9.99":U
            COLUMN-BGCOLOR 20
      gi_data_insurance.OutputVat COLUMN-LABEL "Cr Output! Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9 COLUMN-BGCOLOR 20
      gi_data_insurance.total-db COLUMN-LABEL "Total !Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.43 COLUMN-BGCOLOR 21
      gi_data_insurance.total-cr COLUMN-LABEL "Total !Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10 COLUMN-BGCOLOR 21
      gi_data_insurance.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.14 COLUMN-BGCOLOR 21
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96.43 BY 10.19
         FONT 4
         TITLE "Insurance Data" FIT-LAST-COLUMN.

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 39.57 BY 10.19
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wYearMonth1 AT ROW 1.19 COL 2.14 NO-LABEL WIDGET-ID 64
     BtnValidateNoVat AT ROW 1.42 COL 125.86 WIDGET-ID 84
     BtnImport AT ROW 1.42 COL 148 WIDGET-ID 16
     BtnValidate AT ROW 1.42 COL 157.14 WIDGET-ID 26
     BtnExport AT ROW 1.42 COL 166.57 WIDGET-ID 14
     BtnExportFinal AT ROW 2.27 COL 143.43 WIDGET-ID 86
     MonthlyTotals AT ROW 2.27 COL 160 WIDGET-ID 82
     wyearmonthfn AT ROW 2.5 COL 13.86 COLON-ALIGNED WIDGET-ID 2
     wParty-Name AT ROW 2.5 COL 43.14 COLON-ALIGNED WIDGET-ID 10
     BtnSearch AT ROW 2.5 COL 71.43 WIDGET-ID 6
     BROWSE-1 AT ROW 3.58 COL 2.29 WIDGET-ID 300
     BROWSE-2 AT ROW 12.92 COL 2.29 WIDGET-ID 200
     BROWSE-3 AT ROW 12.92 COL 99.29 WIDGET-ID 400
     wtally-response AT ROW 12.92 COL 139.57 NO-LABEL WIDGET-ID 28
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.57 BY 25.12 WIDGET-ID 100.


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
         TITLE              = "Summary insurance"
         HEIGHT             = 25.12
         WIDTH              = 176.57
         MAX-HEIGHT         = 31.85
         MAX-WIDTH          = 176.57
         VIRTUAL-HEIGHT     = 31.85
         VIRTUAL-WIDTH      = 176.57
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
     _TblList          = "giph.gi_data_insurance_sum"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_insurance_sum.YearMonthFN MATCHES wYearMonthFN
AND 
giph.gi_data_insurance_sum.Party-Name MATCHES wParty-Name"
     _FldNameList[1]   = giph.gi_data_insurance_sum.insurance-sum-cons
     _FldNameList[2]   > giph.gi_data_insurance_sum.YearMonthFN
"YearMonthFN" "Year Month!FN" ? "character" ? ? ? ? ? ? no ? no no "8.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = giph.gi_data_insurance_sum.LastVchId
     _FldNameList[4]   > giph.gi_data_insurance_sum.party-name
"party-name" "Party! Name" ? "character" ? ? ? ? ? ? no ? no no "32.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_insurance_sum.alias-name
"alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_insurance_sum.TotalPremiumAmount
"TotalPremiumAmount" "Tot Premium! Amt" ? "decimal" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_insurance_sum.SupplierComm
"SupplierComm" "Supplier! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_insurance_sum.AgentComm
"AgentComm" "Agent !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_insurance_sum.CollectFromAgent
"CollectFromAgent" "Coll From !Agent" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_insurance_sum.PayableToSupplier
"PayableToSupplier" "Payable to! Airline" ? "decimal" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   = giph.gi_data_insurance_sum.Payable
     _FldNameList[12]   = giph.gi_data_insurance_sum.Profit
     _FldNameList[13]   > giph.gi_data_insurance_sum.db-ControlAgent
"db-ControlAgent" "Db ! Control Agent" ? "decimal" ? ? ? ? ? ? no ? no no "12.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_insurance_sum.db-AgentComm
"db-AgentComm" "Db ! Agent Comm" ? "decimal" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_insurance_sum.total-db
"total-db" "Total! Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "9.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_insurance_sum.cr-InsuranceSales
"cr-InsuranceSales" "Cr ! Insur. Sales" ? "decimal" ? ? ? ? ? ? no ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_insurance_sum.cr-InsurancePurchases
"cr-InsurancePurchases" "Cr ! Insur. Purch." ? "decimal" ? ? ? ? ? ? no ? no no "13.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_insurance_sum.total-cr
"total-cr" "Total !Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_insurance_sum.total-db-cr-diff
"total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_insurance_sum.AutoGP
"AutoGP" "Auto ! GP" ? "decimal" ? ? ? ? ? ? no ? no no "11.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_insurance_sum.DiffGP
"DiffGP" "Diff ! GP" ? "decimal" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_data_insurance"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_insurance.YearMonthFN MATCHES pYearMonthFN1 AND
/*giph.gi_data_insurance.AgentName MATCHES wAgentName AND*/
giph.gi_data_insurance.Party-Name MATCHES pParty-Name"
     _FldNameList[1]   > giph.gi_data_insurance.YearMonthFN
"gi_data_insurance.YearMonthFN" "Year Mon!FN" ? "character" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_insurance.insurance-cons
"gi_data_insurance.insurance-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_insurance.TravelAgentId
"gi_data_insurance.TravelAgentId" "Travel !Agent ID" ? "character" ? ? ? ? ? ? no ? no no "12.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_insurance.AgentName
"gi_data_insurance.AgentName" "Agent!Name" ? "character" ? ? ? ? ? ? no ? no no "20.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_insurance.TerminalId
"gi_data_insurance.TerminalId" "Terminal! Id" ? "character" ? ? ? ? ? ? no ? no no "11.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_insurance.TerminalName
"gi_data_insurance.TerminalName" ? ? "character" ? ? ? ? ? ? no ? no no "9.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_insurance.PolicyNo
"gi_data_insurance.PolicyNo" "Policy! No" ? "character" ? ? ? ? ? ? no ? no no "10.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_insurance.PassengerName
"gi_data_insurance.PassengerName" "Passenger! Name" ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_insurance.BkPnr
"gi_data_insurance.BkPnr" "Bk !Pnr" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_insurance.TranDate-Txt
"gi_data_insurance.TranDate-Txt" "Tran Date! - Txt" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_insurance.TotalPremiumAmount
"gi_data_insurance.TotalPremiumAmount" "Tot Premium! Amt" ? "decimal" ? ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_insurance.SupplierComm
"gi_data_insurance.SupplierComm" "Supplier !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "7.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_insurance.AgentComm
"gi_data_insurance.AgentComm" "Agent !Comm" ? "decimal" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_insurance.CollectFromAgent
"gi_data_insurance.CollectFromAgent" "Coll From! Agent" ? "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_insurance.PayableToSupplier
"gi_data_insurance.PayableToSupplier" "Payable to! Airline" ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   = giph.gi_data_insurance.Payable
     _FldNameList[17]   > giph.gi_data_insurance.Profit
"gi_data_insurance.Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "5.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_insurance.date1
"gi_data_insurance.date1" ? ? "date" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_insurance.party-name
"gi_data_insurance.party-name" "Party! Name" ? "character" ? ? ? ? ? ? no ? no no "26.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_insurance.GrossAmount1
"gi_data_insurance.GrossAmount1" "Db.Gross !Amount" ? "decimal" 19 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_insurance.AgentComm1
"gi_data_insurance.AgentComm1" "Db Agent !Comm" ? "decimal" 19 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_insurance.InputVat
"gi_data_insurance.InputVat" "Db Input !Vat" ? "decimal" 19 ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_insurance.Payable1
"gi_data_insurance.Payable1" "Cr!Payable" ? "decimal" 20 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_insurance.comm-income1
"gi_data_insurance.comm-income1" "Cr Comm.! Income" ? "decimal" 20 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_insurance.OutputVat
"gi_data_insurance.OutputVat" "Cr Output! Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_insurance.total-db
"gi_data_insurance.total-db" "Total !Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_insurance.total-cr
"gi_data_insurance.total-cr" "Total !Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_insurance.total-db-cr-diff
"gi_data_insurance.total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "8.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
ON END-ERROR OF wWin /* Summary insurance */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Summary insurance */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Insurance Data */
DO:
  IF AVAILABLE gi_data_insurance_sum THEN DO:
      ASSIGN pYearMonthFN1 = gi_data_insurance_sum.YearMonthFN. 
      ASSIGN pparty-name = gi_data_insurance_sum.party-name
          .
      ASSIGN wtally-response:SCREEN-VALUE = gi_data_insurance_sum.tally-response.



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
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_insurance.p.*/

      FOR EACH b_gi_data_insurance_sum WHERE b_gi_data_insurance_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_insurance_sum.insurance-sum-cons > 0
          BREAK BY b_gi_data_insurance_sum.YearMonth
                BY b_gi_data_insurance_sum.insurance-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN pinsurance-sum-cons = b_gi_data_insurance_sum.insurance-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_insurance_partyname.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_insurance_sum.LastVchId, OUTPUT b_gi_data_insurance_sum.tally-response).

          
          MESSAGE b_gi_data_insurance_sum.insurance-sum-cons 
              b_gi_data_insurance_sum.YearMonthFn
              "VchID" b_gi_data_insurance_sum.LastVchId. PAUSE 0.
          
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


&Scoped-define SELF-NAME BtnExportFinal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnExportFinal wWin
ON CHOOSE OF BtnExportFinal IN FRAME fMain /* Export Final */
DO:
    DEF VAR n AS INT.
  SESSION:SET-WAIT-STATE("GENERAL").
  APPLY "Choose" TO BtnSearch.

  MESSAGE "Export the data to Tally?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_insurance.p.*/

      FOR EACH b_gi_data_insurance_sum WHERE b_gi_data_insurance_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_insurance_sum.insurance-sum-cons > 0
          BREAK BY b_gi_data_insurance_sum.YearMonth
                BY b_gi_data_insurance_sum.insurance-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN pinsurance-sum-cons = b_gi_data_insurance_sum.insurance-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_insurance_partyname_final.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_insurance_sum.LastVchId, OUTPUT b_gi_data_insurance_sum.tally-response).

          
          MESSAGE b_gi_data_insurance_sum.insurance-sum-cons 
              b_gi_data_insurance_sum.YearMonthFn
              "VchID" b_gi_data_insurance_sum.LastVchId. PAUSE 0.
          
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
      RUN c:\pvr\giph\lib\import_insurance_data.p.
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
  /*ASSIGN wAgentName   = "*" +  wAgentName:SCREEN-VALUE   + "*".*/
  ASSIGN wParty-Name  = "*" +  wParty-Name:SCREEN-VALUE  + "*".

  {&OPEN-QUERY-BROWSE-1}
  APPLY "Value-Changed" TO BROWSE-1.  
  /*
  {&OPEN-QUERY-BROWSE-2}
  APPLY "Value-Changed" TO BROWSE-2.  
    */



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
      RUN c:\pvr\giph\lib\VALIDATE_insurance_data.p.
  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnValidateNoVat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnValidateNoVat wWin
ON CHOOSE OF BtnValidateNoVat IN FRAME fMain /* Validate No Vat */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Validate the data?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\VALIDATE_insurance_data_novat.p.
  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME MonthlyTotals
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL MonthlyTotals wWin
ON CHOOSE OF MonthlyTotals IN FRAME fMain /* Monthly Totals */
DO:
  
DEF VAR pfilename AS CHAR.
DEF VAR ptotal-PayableToSupplier AS DEC COLUMN-LABEL "Tot PayableToSupplier" FORMAT "-zz,zzz,zzz,zz9.99".
DEF VAR ptotal-profit AS DEC COLUMN-LABEL "Tot profit" FORMAT "-zz,zzz,zzz,zz9.99".
DEF VAR ptotal-PayableToSupplier-fn AS DEC COLUMN-LABEL "Tot PayableToSupplierFN" FORMAT "-zz,zzz,zzz,zz9.99".

ASSIGN pfilename = "c:\temp\gi_data_insurance_sum_total.txt".

FORM
    b_gi_data_insurance_sum.yearmonth
    ptotal-PayableToSupplier 
    ptotal-profit 
    WITH FRAME a DOWN TITLE "Year" STREAM-IO.


FORM
    b_gi_data_insurance_sum.yearmonth
    b_gi_data_insurance_sum.yearmonthfn
    ptotal-PayableToSupplier-fn 
    ptotal-profit
    WITH FRAME b DOWN TITLE "YearFN" STREAM-IO.

OUTPUT TO VALUE(pfilename).

    FOR EACH b_gi_data_insurance_sum WHERE b_gi_data_insurance_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_insurance_sum.yearmonth WITH FRAME a DOWN:
    
        IF FIRST-OF(b_gi_data_insurance_sum.yearmonth) THEN DO:
            ASSIGN ptotal-PayableToSupplier = 0 .
            ASSIGN ptotal-profit = 0 .
        END.
        ASSIGN ptotal-PayableToSupplier = ptotal-PayableToSupplier + b_gi_data_insurance_sum.PayableToSupplier.
        ASSIGN ptotal-profit = ptotal-profit + b_gi_data_insurance_sum.profit.
        ACCUMULATE b_gi_data_insurance_sum.PayableToSupplier(TOTAL).
        ACCUMULATE b_gi_data_insurance_sum.profit(TOTAL).
    
        IF LAST-OF(b_gi_data_insurance_sum.yearmonth) THEN DO:
            DISPLAY 
                b_gi_data_insurance_sum.yearmonth
                ptotal-PayableToSupplier 
                ptotal-profit 
                WITH FRAME a STREAM-IO.
            DOWN WITH FRAME a.
        END.
    END.
    DISPLAY 
        ACCUM TOTAL b_gi_data_insurance_sum.PayableToSupplier 
        ACCUM TOTAL b_gi_data_insurance_sum.profit
        WITH FRAME a1.


    /*
    FOR EACH b_gi_data_insurance_sum WHERE b_gi_data_insurance_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_insurance_sum.yearmonthfn WITH FRAME b DOWN:
    
        IF FIRST-OF(b_gi_data_insurance_sum.yearmonthfn) THEN DO:
            ASSIGN ptotal-PayableToSupplier-fn = 0.
        END.
        ASSIGN ptotal-PayableToSupplier-fn = ptotal-PayableToSupplier-fn + b_gi_data_insurance_sum.PayableToSupplier.
    

        IF LAST-OF(b_gi_data_insurance_sum.yearmonthfn) THEN DO:
            DISPLAY 
                b_gi_data_insurance_sum.yearmonth
                b_gi_data_insurance_sum.yearmonthfn
                ptotal-PayableToSupplier-fn 
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


&Scoped-define SELF-NAME m_Create_Insurance_Journal_En
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Insurance_Journal_En wWin
ON CHOOSE OF MENU-ITEM m_Create_Insurance_Journal_En /* Create Insurance Journal Entry */
DO:
  
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_insurance_sum THEN DO:
     ASSIGN pinsurance-sum-cons = gi_data_insurance_sum.insurance-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_insurance.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_insurance_partyname.p.

  FIND b_gi_data_insurance_sum WHERE b_gi_data_insurance_sum.insurance-sum-cons = pinsurance-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_insurance_sum THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_insurance_sum.LastVchId, OUTPUT b_gi_data_insurance_sum.tally-response).
  END.
  APPLY "Value-Changed" TO BROWSE-1.  
  SESSION:SET-WAIT-STATE("").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Insurance_Journal_En2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Insurance_Journal_En2 wWin
ON CHOOSE OF MENU-ITEM m_Create_Insurance_Journal_En2 /* Create Insurance Journal Entry - Final */
DO:
  
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_insurance_sum THEN DO:
     ASSIGN pinsurance-sum-cons = gi_data_insurance_sum.insurance-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_insurance.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_insurance_partyname_final.p.

  FIND b_gi_data_insurance_sum WHERE b_gi_data_insurance_sum.insurance-sum-cons = pinsurance-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_insurance_sum THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_insurance_sum.LastVchId, OUTPUT b_gi_data_insurance_sum.tally-response).
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
  ASSIGN pcom-name = "Start notepad.exe" + " C:\pvr\giph\tallylib\CreateVoucher.XML".
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
  DISPLAY wYearMonth1 wyearmonthfn wParty-Name wtally-response 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wYearMonth1 BtnValidateNoVat BtnImport BtnValidate BtnExport 
         BtnExportFinal MonthlyTotals wyearmonthfn wParty-Name BtnSearch 
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
  
  /*
  ASSIGN wAgentName:SCREEN-VALUE = "".
  ASSIGN wAgentName = "*".
    */
  ASSIGN wParty-Name:SCREEN-VALUE = "".
  ASSIGN wParty-Name = "*".
  

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  

    /*
    {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2.  
      */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

