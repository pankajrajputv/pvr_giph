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

DEF NEW SHARED VAR ppackages-sum-cons LIKE gi_data_packages_sum.packages-sum-cons.

DEF VAR pYearMonthFN LIKE gi_data_packages_sum.YearMonthFN. 
DEF VAR pparty-name LIKE gi_data_packages_sum.party-name.

DEF BUFFER b_gi_data_packages_sum FOR gi_data_packages_sum.

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
&Scoped-define INTERNAL-TABLES gi_data_packages_sum gi_data_packages ~
gi_acc_det gi_acc_hea

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_data_packages_sum.YearMonthFN ~
gi_data_packages_sum.packages-sum-cons gi_data_packages_sum.LastVchId ~
gi_data_packages_sum.party-name gi_data_packages_sum.alias-name ~
gi_data_packages_sum.SellingPrice gi_data_packages_sum.VatCollectable ~
gi_data_packages_sum.Markup gi_data_packages_sum.TotalCollectable ~
gi_data_packages_sum.TotalPayable gi_data_packages_sum.VATPayable ~
gi_data_packages_sum.Payable gi_data_packages_sum.AgentComm ~
gi_data_packages_sum.MTagentComm gi_data_packages_sum.Profit ~
gi_data_packages_sum.db-ControlAgent gi_data_packages_sum.total-db ~
gi_data_packages_sum.cr-PackagesSales ~
gi_data_packages_sum.cr-PackagesPurchases gi_data_packages_sum.total-cr ~
gi_data_packages_sum.total-db-cr-diff gi_data_packages_sum.AutoGP ~
gi_data_packages_sum.DiffGP 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_packages_sum ~
      WHERE gi_data_packages_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_packages_sum.party-name MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_packages_sum ~
      WHERE gi_data_packages_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_packages_sum.party-name MATCHES wParty-Name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_data_packages_sum
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_data_packages_sum


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_data_packages.YearMonthFN ~
gi_data_packages.BookingType gi_data_packages.TransId ~
gi_data_packages.TravelAgentId gi_data_packages.TerminalId ~
gi_data_packages.PackageSupplier gi_data_packages.PackageType ~
gi_data_packages.PackageDescription gi_data_packages.BookingDate ~
gi_data_packages.SellingPrice gi_data_packages.VatCollectable ~
gi_data_packages.Markup gi_data_packages.TotalCollectable ~
gi_data_packages.TotalPayable gi_data_packages.VATPayable ~
gi_data_packages.AgentComm gi_data_packages.MTagentComm ~
gi_data_packages.Profit gi_data_packages.NoOfAdults ~
gi_data_packages.TravelDate gi_data_packages.BookedBy ~
gi_data_packages.date1 gi_data_packages.party-name ~
gi_data_packages.SellingPrice1 gi_data_packages.Payable1 ~
gi_data_packages.MarkUp1 gi_data_packages.OutputVat ~
gi_data_packages.total-db gi_data_packages.total-cr ~
gi_data_packages.total-db-cr-diff gi_data_packages.packages-cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_data_packages ~
      WHERE gi_data_packages.YearMonth = pYearMonthFN ~
 AND gi_data_packages.Party-name = pparty-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_data_packages ~
      WHERE gi_data_packages.YearMonth = pYearMonthFN ~
 AND gi_data_packages.Party-name = pparty-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_data_packages
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_data_packages


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
BtnValidate BtnExport BtnExportFinal BtnValidateNoVat wyearmonthfn ~
wParty-Name BtnSearch BROWSE-1 wtally-response BROWSE-2 BROWSE-3 
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
       MENU-ITEM m_Create_Packages_Journal_Ent LABEL "Create Packages Journal Entry"
       MENU-ITEM m_Create_Packages_Journal_Ent2 LABEL "Create Packages Journal Entry - Final"
       RULE
       MENU-ITEM m_View_XML     LABEL "View XML"      .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnExportFinal 
     LABEL "Export Final" 
     SIZE 16.86 BY .81.

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
     SIZE 19.86 BY .81 TOOLTIP "Validate Visa Data".

DEFINE BUTTON MonthlyTotals 
     LABEL "Monthly Totals" 
     SIZE 15.43 BY 1.04.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 39.86 BY 11.04
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
      gi_data_packages_sum SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_data_packages SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_packages_sum.YearMonthFN COLUMN-LABEL "Year !MonthFN" FORMAT "x(12)":U
            WIDTH 9.72
      gi_data_packages_sum.packages-sum-cons FORMAT "->>>>>>9":U
      gi_data_packages_sum.LastVchId FORMAT "->>>>>>9":U COLUMN-FGCOLOR 9
      gi_data_packages_sum.party-name COLUMN-LABEL "Party ! Name" FORMAT "x(100)":U
            WIDTH 29.86
      gi_data_packages_sum.alias-name FORMAT "x(100)":U WIDTH 15
      gi_data_packages_sum.SellingPrice COLUMN-LABEL "Selling !Price" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 9.14
      gi_data_packages_sum.VatCollectable COLUMN-LABEL "Vat !Collectable" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.29
      gi_data_packages_sum.Markup FORMAT "->>>,>>>,>>9.99":U WIDTH 10
      gi_data_packages_sum.TotalCollectable COLUMN-LABEL "Total !Collectable" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 9.72
      gi_data_packages_sum.TotalPayable COLUMN-LABEL "Total !Payable" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 10
      gi_data_packages_sum.VATPayable COLUMN-LABEL "VAT! Payable" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.43
      gi_data_packages_sum.Payable FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_packages_sum.AgentComm COLUMN-LABEL "Agent! Comm" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.43
      gi_data_packages_sum.MTagentComm COLUMN-LABEL "MTagent !Comm" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.57
      gi_data_packages_sum.Profit FORMAT "->>>,>>>,>>9.99":U WIDTH 9.86
      gi_data_packages_sum.db-ControlAgent COLUMN-LABEL "Db! Control Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13.57
      gi_data_packages_sum.total-db COLUMN-LABEL "Total !Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.57 COLUMN-BGCOLOR 21
      gi_data_packages_sum.cr-PackagesSales COLUMN-LABEL "Cr !Pack. Sales" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12.14
      gi_data_packages_sum.cr-PackagesPurchases COLUMN-LABEL "Cr !Pack. Purch." FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13.14
      gi_data_packages_sum.total-cr COLUMN-LABEL "Total !Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.57 COLUMN-BGCOLOR 21
      gi_data_packages_sum.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.29 COLUMN-BGCOLOR 21
      gi_data_packages_sum.AutoGP COLUMN-LABEL "Auto! GP" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.43
      gi_data_packages_sum.DiffGP COLUMN-LABEL "Diff !GP" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.43
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 9
         FONT 4
         TITLE "Summary Packages Data" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_data_packages.YearMonthFN COLUMN-LABEL "Year !MonFN" FORMAT "x(12)":U
            WIDTH 9.72
      gi_data_packages.BookingType COLUMN-LABEL "Booking! Type" FORMAT "x(8)":U
            WIDTH 5.86
      gi_data_packages.TransId COLUMN-LABEL "Trans! Id" FORMAT "x(15)":U
            WIDTH 6.43
      gi_data_packages.TravelAgentId COLUMN-LABEL "Travel !Agent ID" FORMAT "x(50)":U
            WIDTH 33.57
      gi_data_packages.TerminalId COLUMN-LABEL "Terminal! Id" FORMAT "x(50)":U
            WIDTH 24.43
      gi_data_packages.PackageSupplier COLUMN-LABEL "Package !Supplier" FORMAT "x(50)":U
            WIDTH 23.72
      gi_data_packages.PackageType COLUMN-LABEL "Package !Type" FORMAT "x(8)":U
            WIDTH 8.14
      gi_data_packages.PackageDescription COLUMN-LABEL "Pakage! Discription" FORMAT "x(8)":U
            WIDTH 8.14
      gi_data_packages.BookingDate COLUMN-LABEL "Booking !Date" FORMAT "99/99/99":U
            WIDTH 6.72
      gi_data_packages.SellingPrice COLUMN-LABEL "Selling! Price" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 10
      gi_data_packages.VatCollectable COLUMN-LABEL "Vat !Collect." FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.57
      gi_data_packages.Markup FORMAT "->>>,>>>,>>9.99":U WIDTH 8.14
      gi_data_packages.TotalCollectable COLUMN-LABEL "Total !Collect." FORMAT "->>>,>>>,>>9.99":U
            WIDTH 10.72
      gi_data_packages.TotalPayable COLUMN-LABEL "Total !Payable" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 9.43
      gi_data_packages.VATPayable COLUMN-LABEL "VAT! Payable" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8
      gi_data_packages.AgentComm COLUMN-LABEL "Agent! Comm" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.43
      gi_data_packages.MTagentComm COLUMN-LABEL "MTagent !Comm" FORMAT "->>>,>>>,>>9.99":U
      gi_data_packages.Profit FORMAT "->>>,>>>,>>9.99":U
      gi_data_packages.NoOfAdults COLUMN-LABEL "No of !Adults" FORMAT "->,>>>,>>9":U
            WIDTH 5.72
      gi_data_packages.TravelDate COLUMN-LABEL "Travel !Date" FORMAT "99/99/9999":U
            WIDTH 8.86
      gi_data_packages.BookedBy COLUMN-LABEL "Booked !BY" FORMAT "x(20)":U
            WIDTH 6.86
      gi_data_packages.date1 FORMAT "99/99/9999":U
      gi_data_packages.party-name COLUMN-LABEL "Party !Name" FORMAT "x(100)":U
            WIDTH 26.57
      gi_data_packages.SellingPrice1 COLUMN-LABEL "Db Selling!Price" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.72 COLUMN-BGCOLOR 19
      gi_data_packages.Payable1 COLUMN-LABEL "Cr!Payable" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9 COLUMN-BGCOLOR 20
      gi_data_packages.MarkUp1 COLUMN-LABEL "Cr!Mark Up" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.29 COLUMN-BGCOLOR 20
      gi_data_packages.OutputVat COLUMN-LABEL "Cr Output !Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9 COLUMN-BGCOLOR 20
      gi_data_packages.total-db COLUMN-LABEL "Total !Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.14 COLUMN-BGCOLOR 21
      gi_data_packages.total-cr COLUMN-LABEL "Total !Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12.14 COLUMN-BGCOLOR 21
      gi_data_packages.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11 COLUMN-BGCOLOR 21
      gi_data_packages.packages-cons FORMAT "->>>>>>9":U WIDTH 5.29
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96.72 BY 11
         FONT 4
         TITLE "Packages Data" FIT-LAST-COLUMN.

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 36.29 BY 11
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wYearMonth1 AT ROW 1.19 COL 2.14 NO-LABEL WIDGET-ID 64
     MonthlyTotals AT ROW 1.42 COL 132.72 WIDGET-ID 82
     BtnImport AT ROW 1.42 COL 148.57 WIDGET-ID 16
     BtnValidate AT ROW 1.42 COL 157.57 WIDGET-ID 26
     BtnExport AT ROW 1.42 COL 166.57 WIDGET-ID 14
     BtnExportFinal AT ROW 2.46 COL 138.29 WIDGET-ID 86
     BtnValidateNoVat AT ROW 2.46 COL 155.14 WIDGET-ID 84
     wyearmonthfn AT ROW 2.5 COL 13.86 COLON-ALIGNED WIDGET-ID 2
     wParty-Name AT ROW 2.5 COL 44.57 COLON-ALIGNED WIDGET-ID 8
     BtnSearch AT ROW 2.5 COL 73 WIDGET-ID 6
     BROWSE-1 AT ROW 3.77 COL 2 WIDGET-ID 200
     wtally-response AT ROW 12.96 COL 136 NO-LABEL WIDGET-ID 28
     BROWSE-2 AT ROW 13 COL 2 WIDGET-ID 300
     BROWSE-3 AT ROW 13 COL 99.14 WIDGET-ID 400
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176 BY 26.08 WIDGET-ID 100.


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
         TITLE              = "Summary packages"
         HEIGHT             = 26.08
         WIDTH              = 176
         MAX-HEIGHT         = 31.85
         MAX-WIDTH          = 228.57
         VIRTUAL-HEIGHT     = 31.85
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
/* BROWSE-TAB BROWSE-1 BtnSearch fMain */
/* BROWSE-TAB BROWSE-2 wtally-response fMain */
/* BROWSE-TAB BROWSE-3 BROWSE-2 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME fMain     = 5
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
     _TblList          = "giph.gi_data_packages_sum"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_packages_sum.YearMonthFN MATCHES wYearMonthFn
 AND giph.gi_data_packages_sum.party-name MATCHES wParty-Name"
     _FldNameList[1]   > giph.gi_data_packages_sum.YearMonthFN
"gi_data_packages_sum.YearMonthFN" "Year !MonthFN" ? "character" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = giph.gi_data_packages_sum.packages-sum-cons
     _FldNameList[3]   > giph.gi_data_packages_sum.LastVchId
"gi_data_packages_sum.LastVchId" ? ? "integer" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_packages_sum.party-name
"gi_data_packages_sum.party-name" "Party ! Name" ? "character" ? ? ? ? ? ? no ? no no "29.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_packages_sum.alias-name
"gi_data_packages_sum.alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_packages_sum.SellingPrice
"gi_data_packages_sum.SellingPrice" "Selling !Price" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_packages_sum.VatCollectable
"gi_data_packages_sum.VatCollectable" "Vat !Collectable" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_packages_sum.Markup
"gi_data_packages_sum.Markup" ? "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_packages_sum.TotalCollectable
"gi_data_packages_sum.TotalCollectable" "Total !Collectable" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_packages_sum.TotalPayable
"gi_data_packages_sum.TotalPayable" "Total !Payable" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_packages_sum.VATPayable
"gi_data_packages_sum.VATPayable" "VAT! Payable" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   = giph.gi_data_packages_sum.Payable
     _FldNameList[13]   > giph.gi_data_packages_sum.AgentComm
"gi_data_packages_sum.AgentComm" "Agent! Comm" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_packages_sum.MTagentComm
"gi_data_packages_sum.MTagentComm" "MTagent !Comm" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_packages_sum.Profit
"gi_data_packages_sum.Profit" ? "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_packages_sum.db-ControlAgent
"gi_data_packages_sum.db-ControlAgent" "Db! Control Agent" ? "decimal" ? ? ? ? ? ? no ? no no "13.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_packages_sum.total-db
"gi_data_packages_sum.total-db" "Total !Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_packages_sum.cr-PackagesSales
"gi_data_packages_sum.cr-PackagesSales" "Cr !Pack. Sales" ? "decimal" ? ? ? ? ? ? no ? no no "12.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_packages_sum.cr-PackagesPurchases
"gi_data_packages_sum.cr-PackagesPurchases" "Cr !Pack. Purch." "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "13.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_packages_sum.total-cr
"gi_data_packages_sum.total-cr" "Total !Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "10.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_packages_sum.total-db-cr-diff
"gi_data_packages_sum.total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "10.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_packages_sum.AutoGP
"gi_data_packages_sum.AutoGP" "Auto! GP" ? "decimal" ? ? ? ? ? ? no ? no no "11.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_packages_sum.DiffGP
"gi_data_packages_sum.DiffGP" "Diff !GP" ? "decimal" ? ? ? ? ? ? no ? no no "11.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_data_packages"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_packages.YearMonth = pYearMonthFN
 AND giph.gi_data_packages.Party-name = pparty-name"
     _FldNameList[1]   > giph.gi_data_packages.YearMonthFN
"gi_data_packages.YearMonthFN" "Year !MonFN" ? "character" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_packages.BookingType
"gi_data_packages.BookingType" "Booking! Type" ? "character" ? ? ? ? ? ? no ? no no "5.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_packages.TransId
"gi_data_packages.TransId" "Trans! Id" ? "character" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_packages.TravelAgentId
"gi_data_packages.TravelAgentId" "Travel !Agent ID" ? "character" ? ? ? ? ? ? no ? no no "33.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_packages.TerminalId
"gi_data_packages.TerminalId" "Terminal! Id" ? "character" ? ? ? ? ? ? no ? no no "24.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_packages.PackageSupplier
"gi_data_packages.PackageSupplier" "Package !Supplier" ? "character" ? ? ? ? ? ? no ? no no "23.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_packages.PackageType
"gi_data_packages.PackageType" "Package !Type" ? "character" ? ? ? ? ? ? no ? no no "8.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_packages.PackageDescription
"gi_data_packages.PackageDescription" "Pakage! Discription" ? "character" ? ? ? ? ? ? no ? no no "8.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_packages.BookingDate
"gi_data_packages.BookingDate" "Booking !Date" ? "date" ? ? ? ? ? ? no ? no no "6.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_packages.SellingPrice
"gi_data_packages.SellingPrice" "Selling! Price" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_packages.VatCollectable
"gi_data_packages.VatCollectable" "Vat !Collect." "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_packages.Markup
"gi_data_packages.Markup" ? "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_packages.TotalCollectable
"gi_data_packages.TotalCollectable" "Total !Collect." "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_packages.TotalPayable
"gi_data_packages.TotalPayable" "Total !Payable" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_packages.VATPayable
"gi_data_packages.VATPayable" "VAT! Payable" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_packages.AgentComm
"gi_data_packages.AgentComm" "Agent! Comm" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_packages.MTagentComm
"gi_data_packages.MTagentComm" "MTagent !Comm" "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_packages.Profit
"gi_data_packages.Profit" ? "->>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_packages.NoOfAdults
"gi_data_packages.NoOfAdults" "No of !Adults" ? "integer" ? ? ? ? ? ? no ? no no "5.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_packages.TravelDate
"gi_data_packages.TravelDate" "Travel !Date" ? "date" ? ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_packages.BookedBy
"gi_data_packages.BookedBy" "Booked !BY" ? "character" ? ? ? ? ? ? no ? no no "6.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   = giph.gi_data_packages.date1
     _FldNameList[23]   > giph.gi_data_packages.party-name
"gi_data_packages.party-name" "Party !Name" ? "character" ? ? ? ? ? ? no ? no no "26.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_packages.SellingPrice1
"gi_data_packages.SellingPrice1" "Db Selling!Price" ? "decimal" 19 ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_packages.Payable1
"gi_data_packages.Payable1" "Cr!Payable" ? "decimal" 20 ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_packages.MarkUp1
"gi_data_packages.MarkUp1" "Cr!Mark Up" ? "decimal" 20 ? ? ? ? ? no ? no no "11.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_packages.OutputVat
"gi_data_packages.OutputVat" "Cr Output !Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_packages.total-db
"gi_data_packages.total-db" "Total !Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "11.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_packages.total-cr
"gi_data_packages.total-cr" "Total !Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "12.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_packages.total-db-cr-diff
"gi_data_packages.total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   > giph.gi_data_packages.packages-cons
"gi_data_packages.packages-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "5.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
ON END-ERROR OF wWin /* Summary packages */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Summary packages */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Summary Packages Data */
DO:
    IF AVAILABLE gi_data_packages_sum THEN DO:
        ASSIGN pparty-name = gi_data_packages_sum.party-name
               pyearmonthfn = gi_data_packages_sum.yearmonthfn
            .

        ASSIGN wtally-response:SCREEN-VALUE = gi_data_packages_sum.tally-response.



    END.
    ELSE DO:
        ASSIGN pparty-name = ?
               pyearmonthfn = ?
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
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_packages.p.*/

      FOR EACH b_gi_data_packages_sum WHERE b_gi_data_packages_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_packages_sum.packages-sum-cons > 0
          BREAK BY b_gi_data_packages_sum.YearMonth
                BY b_gi_data_packages_sum.packages-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN ppackages-sum-cons = b_gi_data_packages_sum.packages-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_packages_partyname.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_packages_sum.LastVchId, OUTPUT b_gi_data_packages_sum.tally-response).

          
          MESSAGE b_gi_data_packages_sum.packages-sum-cons 
              b_gi_data_packages_sum.YearMonthFn
              "VchID" b_gi_data_packages_sum.LastVchId. PAUSE 0.
          
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
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_packages.p.*/

      FOR EACH b_gi_data_packages_sum WHERE b_gi_data_packages_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_packages_sum.packages-sum-cons > 0
          BREAK BY b_gi_data_packages_sum.YearMonth
                BY b_gi_data_packages_sum.packages-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN ppackages-sum-cons = b_gi_data_packages_sum.packages-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_packages_partyname_final.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_packages_sum.LastVchId, OUTPUT b_gi_data_packages_sum.tally-response).

          
          MESSAGE b_gi_data_packages_sum.packages-sum-cons 
              b_gi_data_packages_sum.YearMonthFn
              "VchID" b_gi_data_packages_sum.LastVchId. PAUSE 0.
          
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
      RUN c:\pvr\giph\lib\import_packages_data.p.
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
      RUN c:\pvr\giph\lib\VALIDATE_packages_data.p.
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
      RUN c:\pvr\giph\lib\VALIDATE_packages_data_novat.p.
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
DEF VAR ptotal-TotalCollectable AS DEC COLUMN-LABEL "Tot TotalCollectable" FORMAT "-z,zzz,zzz,zzz,zz9.99".
DEF VAR ptotal-profit AS DEC COLUMN-LABEL "Profit" FORMAT "-z,zzz,zzz,zzz,zz9.99".
DEF VAR ptotal-TotalCollectable-fn AS DEC COLUMN-LABEL "Tot TotalCollectableFN" FORMAT "-z,zzz,zzz,zzz,zz9.99".

ASSIGN pfilename = "c:\temp\gi_data_packages_sum_total.txt".

FORM
    b_gi_data_packages_sum.yearmonth
    ptotal-TotalCollectable 
    ptotal-profit
    WITH FRAME a DOWN TITLE "Year" STREAM-IO.


FORM
    b_gi_data_packages_sum.yearmonth
    b_gi_data_packages_sum.yearmonthfn
    ptotal-TotalCollectable-fn 
    WITH FRAME b DOWN TITLE "YearFN" STREAM-IO.

OUTPUT TO VALUE(pfilename).

    FOR EACH b_gi_data_packages_sum WHERE b_gi_data_packages_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_packages_sum.yearmonth WITH FRAME a DOWN:
    
        IF FIRST-OF(b_gi_data_packages_sum.yearmonth) THEN DO:
            ASSIGN ptotal-TotalCollectable = 0 .
            ASSIGN ptotal-profit = 0 .
        END.
        ASSIGN ptotal-TotalCollectable = ptotal-TotalCollectable + b_gi_data_packages_sum.TotalCollectable.
        ASSIGN ptotal-profit = ptotal-profit + b_gi_data_packages_sum.profit.
        ACCUMULATE b_gi_data_packages_sum.TotalCollectable(TOTAL).
        ACCUMULATE b_gi_data_packages_sum.profit(TOTAL).
    
        IF LAST-OF(b_gi_data_packages_sum.yearmonth) THEN DO:
            DISPLAY 
                b_gi_data_packages_sum.yearmonth
                ptotal-TotalCollectable 
                ptotal-profit
                WITH FRAME a STREAM-IO.
            DOWN WITH FRAME a.
        END.
    END.
    DISPLAY 
        ACCUM TOTAL b_gi_data_packages_sum.TotalCollectable FORMAT "-z,zzz,zzz,zzz,zz9.99" 
        ACCUM TOTAL b_gi_data_packages_sum.profit FORMAT "-z,zzz,zzz,zzz,zz9.99" 
        WITH FRAME a1.

    /*

    FOR EACH b_gi_data_packages_sum WHERE b_gi_data_packages_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_packages_sum.yearmonthfn WITH FRAME b DOWN:
    
        IF FIRST-OF(b_gi_data_packages_sum.yearmonthfn) THEN DO:
            ASSIGN ptotal-TotalCollectable-fn = 0.
        END.
        ASSIGN ptotal-TotalCollectable-fn = ptotal-TotalCollectable-fn + b_gi_data_packages_sum.TotalCollectable.
    

        IF LAST-OF(b_gi_data_packages_sum.yearmonthfn) THEN DO:
            DISPLAY 
                b_gi_data_packages_sum.yearmonth
                b_gi_data_packages_sum.yearmonthfn
                ptotal-TotalCollectable-fn 
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


&Scoped-define SELF-NAME m_Create_Packages_Journal_Ent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Packages_Journal_Ent wWin
ON CHOOSE OF MENU-ITEM m_Create_Packages_Journal_Ent /* Create Packages Journal Entry */
DO:
  
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_packages_sum THEN DO:
     ASSIGN ppackages-sum-cons = gi_data_packages_sum.packages-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_packages.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_packages_partyname.p.

  FIND b_gi_data_packages_sum WHERE b_gi_data_packages_sum.packages-sum-cons = ppackages-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_packages_sum THEN DO:
      
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_packages_sum.LastVchId, OUTPUT b_gi_data_packages_sum.tally-response).
  END.
  APPLY "Value-Changed" TO BROWSE-1.  
  SESSION:SET-WAIT-STATE("").


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Packages_Journal_Ent2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Packages_Journal_Ent2 wWin
ON CHOOSE OF MENU-ITEM m_Create_Packages_Journal_Ent2 /* Create Packages Journal Entry - Final */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_packages_sum THEN DO:
     ASSIGN ppackages-sum-cons = gi_data_packages_sum.packages-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_packages.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_packages_partyname_final.p.

  FIND b_gi_data_packages_sum WHERE b_gi_data_packages_sum.packages-sum-cons = ppackages-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_packages_sum THEN DO:
      
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_packages_sum.LastVchId, OUTPUT b_gi_data_packages_sum.tally-response).
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
  ENABLE wYearMonth1 MonthlyTotals BtnImport BtnValidate BtnExport 
         BtnExportFinal BtnValidateNoVat wyearmonthfn wParty-Name BtnSearch 
         BROWSE-1 wtally-response BROWSE-2 BROWSE-3 
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

