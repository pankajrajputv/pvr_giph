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
DEF NEW SHARED VAR pferry-sum-cons LIKE gi_data_ferry_sum.ferry-sum-cons.

DEF VAR pYearMonthFN LIKE gi_data_ferry_sum.YearMonthFN. 
DEF VAR pparty-name LIKE gi_data_ferry_sum.party-name.

DEF BUFFER b_gi_data_ferry_sum FOR gi_data_ferry_sum.

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
&Scoped-define INTERNAL-TABLES gi_data_ferry_sum gi_data_ferry gi_acc_det ~
gi_acc_hea

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_data_ferry_sum.ferry-sum-cons ~
gi_data_ferry_sum.YearMonthFN gi_data_ferry_sum.LastVchId ~
gi_data_ferry_sum.party-name gi_data_ferry_sum.alias-name ~
gi_data_ferry_sum.NetFare gi_data_ferry_sum.ScDiscount ~
gi_data_ferry_sum.DiscountFare gi_data_ferry_sum.Fuel ~
gi_data_ferry_sum.SecurityFee gi_data_ferry_sum.TerminalFee ~
gi_data_ferry_sum.Meal gi_data_ferry_sum.Insurance gi_data_ferry_sum.Linen ~
gi_data_ferry_sum.VatableAmount gi_data_ferry_sum.Vat ~
gi_data_ferry_sum.VatExempt gi_data_ferry_sum.ZeroVat ~
gi_data_ferry_sum.TransactionFee gi_data_ferry_sum.Penalty ~
gi_data_ferry_sum.HandlingFee gi_data_ferry_sum.CollectFromAgent ~
gi_data_ferry_sum.Payable gi_data_ferry_sum.Profit ~
gi_data_ferry_sum.SupplierComm gi_data_ferry_sum.AgentComm ~
gi_data_ferry_sum.db-ControlAgent gi_data_ferry_sum.db-AgentComm ~
gi_data_ferry_sum.total-db gi_data_ferry_sum.cr-FerrySales ~
gi_data_ferry_sum.cr-FerryPurchases gi_data_ferry_sum.total-cr ~
gi_data_ferry_sum.total-db-cr-diff gi_data_ferry_sum.AutoGP ~
gi_data_ferry_sum.DiffGP 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_ferry_sum ~
      WHERE gi_data_ferry_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_ferry_sum.party-name MATCHES wParty-Name ~
 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_ferry_sum ~
      WHERE gi_data_ferry_sum.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_ferry_sum.party-name MATCHES wParty-Name ~
 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_data_ferry_sum
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_data_ferry_sum


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_data_ferry.YearMonthFN ~
gi_data_ferry.TravelAgentId gi_data_ferry.AgentName ~
gi_data_ferry.TerminalId gi_data_ferry.TerminalName ~
gi_data_ferry.ConfirmationNo gi_data_ferry.TranDate-Txt ~
gi_data_ferry.TravelType gi_data_ferry.TransType gi_data_ferry.NoOfSegment ~
gi_data_ferry.NetFare gi_data_ferry.ScDiscount gi_data_ferry.DiscountFare ~
gi_data_ferry.Fuel gi_data_ferry.SecurityFee gi_data_ferry.TerminalFee ~
gi_data_ferry.Meal gi_data_ferry.Insurance gi_data_ferry.Linen ~
gi_data_ferry.VatableAmount gi_data_ferry.Vat gi_data_ferry.VatExempt ~
gi_data_ferry.ZeroVat gi_data_ferry.TransactionFee gi_data_ferry.Penalty ~
gi_data_ferry.HandlingFee gi_data_ferry.CollectFromAgent ~
gi_data_ferry.Payable gi_data_ferry.Profit gi_data_ferry.SupplierComm ~
gi_data_ferry.AgentComm gi_data_ferry.Operator gi_data_ferry.date1 ~
gi_data_ferry.party-name gi_data_ferry.alias-name ~
gi_data_ferry.GrossAmount1 gi_data_ferry.AgentComm1 gi_data_ferry.InputVat ~
gi_data_ferry.Payable1 gi_data_ferry.comm-income1 gi_data_ferry.OutputVat ~
gi_data_ferry.total-db gi_data_ferry.total-cr ~
gi_data_ferry.total-db-cr-diff gi_data_ferry.YearMonth ~
gi_data_ferry.ferry-cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_data_ferry ~
      WHERE gi_data_ferry.YearMonth = pYearMonthFN ~
 AND gi_data_ferry.Party-name = pparty-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_data_ferry ~
      WHERE gi_data_ferry.YearMonth = pYearMonthFN ~
 AND gi_data_ferry.Party-name = pparty-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_data_ferry
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_data_ferry


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
&Scoped-Define ENABLED-OBJECTS wYearMonth1 MonthlyTotals BtnImport-2 ~
BtnValidate BtnExport BtnExportFinal BtnValidateNoVat wyearmonthfn ~
wParty-Name BtnSearch BROWSE-1 BROWSE-2 BROWSE-3 wtally-response 
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
       MENU-ITEM m_Create_Ferry_Journal_Entry LABEL "Create Ferry Journal Entry"
       MENU-ITEM m_Create_Ferry_Journal_Entry_ LABEL "Create Ferry Journal Entry Final"
       RULE
       MENU-ITEM m_View_XML     LABEL "View XML"      .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 7 BY .81.

DEFINE BUTTON BtnExportFinal 
     LABEL "Export Final" 
     SIZE 19 BY .81.

DEFINE BUTTON BtnImport-2 
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
     SIZE 17.29 BY .81 TOOLTIP "Validate Visa Data".

DEFINE BUTTON MonthlyTotals 
     LABEL "Monthly Totals" 
     SIZE 15.43 BY .81.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 38.86 BY 10.15
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
      gi_data_ferry_sum SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_data_ferry SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_ferry_sum.ferry-sum-cons FORMAT "->>>>>>9":U
      gi_data_ferry_sum.YearMonthFN COLUMN-LABEL "Year !MonthFN" FORMAT "x(12)":U
            WIDTH 6.86
      gi_data_ferry_sum.LastVchId FORMAT "->>>>>>9":U
      gi_data_ferry_sum.party-name COLUMN-LABEL "Party !Name" FORMAT "x(100)":U
            WIDTH 28
      gi_data_ferry_sum.alias-name FORMAT "x(100)":U WIDTH 15
      gi_data_ferry_sum.NetFare COLUMN-LABEL "Net !Fare" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.14
      gi_data_ferry_sum.ScDiscount COLUMN-LABEL "SC !Discount" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29
      gi_data_ferry_sum.DiscountFare COLUMN-LABEL "Discount !Fare" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.14
      gi_data_ferry_sum.Fuel FORMAT "->,>>>,>>>,>>9.99":U WIDTH 9.57
      gi_data_ferry_sum.SecurityFee COLUMN-LABEL "Security! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.57
      gi_data_ferry_sum.TerminalFee COLUMN-LABEL "Terminal! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6.43
      gi_data_ferry_sum.Meal FORMAT "->,>>>,>>>,>>9.99":U WIDTH 7.86
      gi_data_ferry_sum.Insurance COLUMN-LABEL "Insurance" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6.86
      gi_data_ferry_sum.Linen COLUMN-LABEL "Linen" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.29
      gi_data_ferry_sum.VatableAmount COLUMN-LABEL "Vatable !Amount" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.72
      gi_data_ferry_sum.Vat FORMAT "->,>>>,>>>,>>9.99":U WIDTH 10.29
      gi_data_ferry_sum.VatExempt COLUMN-LABEL "Vat! Exempt" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 5.57
      gi_data_ferry_sum.ZeroVat COLUMN-LABEL "Zero !Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6
      gi_data_ferry_sum.TransactionFee COLUMN-LABEL "Transac! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.86
      gi_data_ferry_sum.Penalty FORMAT "->,>>>,>>>,>>9.99":U WIDTH 9
      gi_data_ferry_sum.HandlingFee COLUMN-LABEL "Handling! Fee" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.14
      gi_data_ferry_sum.CollectFromAgent COLUMN-LABEL "Coll From !Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.14
      gi_data_ferry_sum.Payable FORMAT "->,>>>,>>>,>>9.99":U WIDTH 9.86
      gi_data_ferry_sum.Profit FORMAT "->,>>>,>>>,>>9.99":U WIDTH 10.14
      gi_data_ferry_sum.SupplierComm COLUMN-LABEL "Supplier !Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.86
      gi_data_ferry_sum.AgentComm COLUMN-LABEL "Agent !Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.72
      gi_data_ferry_sum.db-ControlAgent COLUMN-LABEL "Db!Control Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12.72
      gi_data_ferry_sum.db-AgentComm COLUMN-LABEL "Db !Agent Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11.72
      gi_data_ferry_sum.total-db COLUMN-LABEL "Total !Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.57 COLUMN-BGCOLOR 21
      gi_data_ferry_sum.cr-FerrySales COLUMN-LABEL "Cr !Ferry Sales" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.72
      gi_data_ferry_sum.cr-FerryPurchases COLUMN-LABEL "Cr! Ferry Purc." FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.57
      gi_data_ferry_sum.total-cr COLUMN-LABEL "Total! Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10.29 COLUMN-BGCOLOR 21
      gi_data_ferry_sum.total-db-cr-diff COLUMN-LABEL "Db Cr!Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 10 COLUMN-BGCOLOR 21
      gi_data_ferry_sum.AutoGP COLUMN-LABEL "Auto !GP" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.72
      gi_data_ferry_sum.DiffGP COLUMN-LABEL "Diff !GP" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.43
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 8.81
         FONT 4
         TITLE "Summary Ferry Data" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_data_ferry.YearMonthFN COLUMN-LABEL "Year Mon!FN" FORMAT "x(12)":U
            WIDTH 9.43
      gi_data_ferry.TravelAgentId COLUMN-LABEL "Travel !Agent ID" FORMAT "x(20)":U
      gi_data_ferry.AgentName COLUMN-LABEL "Agent! Name" FORMAT "x(50)":U
            WIDTH 15.86
      gi_data_ferry.TerminalId COLUMN-LABEL "Terminal!Id" FORMAT "x(20)":U
      gi_data_ferry.TerminalName COLUMN-LABEL "Terminal! Name" FORMAT "x(50)":U
            WIDTH 20
      gi_data_ferry.ConfirmationNo COLUMN-LABEL "Confirmation! No" FORMAT "x(20)":U
            WIDTH 11.86
      gi_data_ferry.TranDate-Txt COLUMN-LABEL "Issued !Date - Txt" FORMAT "x(15)":U
            WIDTH 13.86
      gi_data_ferry.TravelType COLUMN-LABEL "Travel! Type" FORMAT "x(8)":U
            WIDTH 5
      gi_data_ferry.TransType COLUMN-LABEL "Trans! Type" FORMAT "x(8)":U
            WIDTH 4.43
      gi_data_ferry.NoOfSegment COLUMN-LABEL "No of! Segment" FORMAT "->,>>>,>>9":U
            WIDTH 6.14
      gi_data_ferry.NetFare COLUMN-LABEL "Net! Fare" FORMAT "->>,>>9.99":U
            WIDTH 6.43
      gi_data_ferry.ScDiscount COLUMN-LABEL "SC !Discount" FORMAT "->>,>>9.99":U
            WIDTH 8.29
      gi_data_ferry.DiscountFare COLUMN-LABEL "Discount! Fare" FORMAT "->>,>>9.99":U
            WIDTH 8.29
      gi_data_ferry.Fuel FORMAT "->>,>>9.99":U
      gi_data_ferry.SecurityFee COLUMN-LABEL "Security !Fee" FORMAT "->>,>>9.99":U
      gi_data_ferry.TerminalFee COLUMN-LABEL "Terminal !Fee" FORMAT "->>,>>9.99":U
      gi_data_ferry.Meal FORMAT "->>,>>9.99":U
      gi_data_ferry.Insurance COLUMN-LABEL "Insurance" FORMAT "->>,>>9.99":U
      gi_data_ferry.Linen COLUMN-LABEL "Linen" FORMAT "->>,>>9.99":U
      gi_data_ferry.VatableAmount COLUMN-LABEL "Vatable !Amount" FORMAT "->>,>>9.99":U
      gi_data_ferry.Vat FORMAT "->>,>>9.99":U
      gi_data_ferry.VatExempt COLUMN-LABEL "Vat !Exempt" FORMAT "->>,>>9.99":U
      gi_data_ferry.ZeroVat COLUMN-LABEL "Zero! Vat" FORMAT "->>,>>9.99":U
            WIDTH 6
      gi_data_ferry.TransactionFee COLUMN-LABEL "Transaction!Fee" FORMAT "->>,>>9.99":U
            WIDTH 9.43
      gi_data_ferry.Penalty FORMAT "->>,>>9.99":U WIDTH 6.43
      gi_data_ferry.HandlingFee COLUMN-LABEL "Handling! Fee" FORMAT "->>,>>9.99":U
            WIDTH 6.43
      gi_data_ferry.CollectFromAgent COLUMN-LABEL "Coll From !Agent" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.43
      gi_data_ferry.Payable FORMAT "->>,>>9.99":U WIDTH 6
      gi_data_ferry.Profit FORMAT "->>,>>9.99":U WIDTH 6.43
      gi_data_ferry.SupplierComm COLUMN-LABEL "Supplier! Comm" FORMAT "->>,>>9.99":U
            WIDTH 7
      gi_data_ferry.AgentComm COLUMN-LABEL "Agent! Comm" FORMAT "->>,>>9.99":U
            WIDTH 5.72
      gi_data_ferry.Operator FORMAT "x(50)":U WIDTH 11.29
      gi_data_ferry.date1 FORMAT "99/99/9999":U
      gi_data_ferry.party-name COLUMN-LABEL "Party Name" FORMAT "x(100)":U
            WIDTH 20
      gi_data_ferry.alias-name FORMAT "x(100)":U WIDTH 15
      gi_data_ferry.GrossAmount1 COLUMN-LABEL "Db Gross!Amount" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.86 COLUMN-BGCOLOR 19
      gi_data_ferry.AgentComm1 COLUMN-LABEL "Db Agent!Comm" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 11 COLUMN-BGCOLOR 19
      gi_data_ferry.InputVat COLUMN-LABEL "Db Input! Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29 COLUMN-BGCOLOR 19
      gi_data_ferry.Payable1 COLUMN-LABEL "Cr !Payable" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 8.29 COLUMN-BGCOLOR 20
      gi_data_ferry.comm-income1 COLUMN-LABEL "Cr Comm.!Income" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 9.14 COLUMN-BGCOLOR 20
      gi_data_ferry.OutputVat COLUMN-LABEL "Cr Output!Vat" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29 COLUMN-BGCOLOR 20
      gi_data_ferry.total-db COLUMN-LABEL "Total!Debit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 6.43 COLUMN-BGCOLOR 21
      gi_data_ferry.total-cr COLUMN-LABEL "Total !Credit" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7 COLUMN-BGCOLOR 21
      gi_data_ferry.total-db-cr-diff COLUMN-LABEL "Db Cr! Diff" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 7.29 COLUMN-BGCOLOR 21
      gi_data_ferry.YearMonth COLUMN-LABEL "Year! Month" FORMAT "x(8)":U
            WIDTH 6.57
      gi_data_ferry.ferry-cons FORMAT "->>>>>>9":U WIDTH 7.29
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96.29 BY 10.19
         FONT 4
         TITLE "Ferry Data" FIT-LAST-COLUMN.

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 37.29 BY 10.19
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wYearMonth1 AT ROW 1.19 COL 2.14 NO-LABEL WIDGET-ID 64
     MonthlyTotals AT ROW 1.54 COL 134.57 WIDGET-ID 82
     BtnImport-2 AT ROW 1.54 COL 150.29 WIDGET-ID 14
     BtnValidate AT ROW 1.54 COL 159.14 WIDGET-ID 26
     BtnExport AT ROW 1.54 COL 168 WIDGET-ID 86
     BtnExportFinal AT ROW 2.46 COL 138.86 WIDGET-ID 88
     BtnValidateNoVat AT ROW 2.46 COL 157.86 WIDGET-ID 84
     wyearmonthfn AT ROW 2.58 COL 13.72 COLON-ALIGNED WIDGET-ID 2
     wParty-Name AT ROW 2.58 COL 44.43 COLON-ALIGNED WIDGET-ID 8
     BtnSearch AT ROW 2.58 COL 72.86 WIDGET-ID 6
     BROWSE-1 AT ROW 3.96 COL 2 WIDGET-ID 200
     BROWSE-2 AT ROW 12.92 COL 2 WIDGET-ID 300
     BROWSE-3 AT ROW 12.92 COL 99.14 WIDGET-ID 400
     wtally-response AT ROW 12.92 COL 137.14 NO-LABEL WIDGET-ID 28
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.29 BY 25.04 WIDGET-ID 100.


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
         TITLE              = "Summary Ferry"
         HEIGHT             = 25.04
         WIDTH              = 176.29
         MAX-HEIGHT         = 29.31
         MAX-WIDTH          = 176.29
         VIRTUAL-HEIGHT     = 29.31
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
     _TblList          = "giph.gi_data_ferry_sum"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_ferry_sum.YearMonthFN MATCHES wYearMonthFn
 AND giph.gi_data_ferry_sum.party-name MATCHES wParty-Name
"
     _FldNameList[1]   = giph.gi_data_ferry_sum.ferry-sum-cons
     _FldNameList[2]   > giph.gi_data_ferry_sum.YearMonthFN
"gi_data_ferry_sum.YearMonthFN" "Year !MonthFN" ? "character" ? ? ? ? ? ? no ? no no "6.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = giph.gi_data_ferry_sum.LastVchId
     _FldNameList[4]   > giph.gi_data_ferry_sum.party-name
"gi_data_ferry_sum.party-name" "Party !Name" ? "character" ? ? ? ? ? ? no ? no no "28" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_ferry_sum.alias-name
"gi_data_ferry_sum.alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_ferry_sum.NetFare
"gi_data_ferry_sum.NetFare" "Net !Fare" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_ferry_sum.ScDiscount
"gi_data_ferry_sum.ScDiscount" "SC !Discount" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_ferry_sum.DiscountFare
"gi_data_ferry_sum.DiscountFare" "Discount !Fare" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_ferry_sum.Fuel
"gi_data_ferry_sum.Fuel" ? "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_ferry_sum.SecurityFee
"gi_data_ferry_sum.SecurityFee" "Security! Fee" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_ferry_sum.TerminalFee
"gi_data_ferry_sum.TerminalFee" "Terminal! Fee" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_ferry_sum.Meal
"gi_data_ferry_sum.Meal" ? "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "7.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_ferry_sum.Insurance
"gi_data_ferry_sum.Insurance" "Insurance" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "6.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_ferry_sum.Linen
"gi_data_ferry_sum.Linen" "Linen" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_ferry_sum.VatableAmount
"gi_data_ferry_sum.VatableAmount" "Vatable !Amount" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_ferry_sum.Vat
"gi_data_ferry_sum.Vat" ? "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_ferry_sum.VatExempt
"gi_data_ferry_sum.VatExempt" "Vat! Exempt" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "5.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_ferry_sum.ZeroVat
"gi_data_ferry_sum.ZeroVat" "Zero !Vat" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_ferry_sum.TransactionFee
"gi_data_ferry_sum.TransactionFee" "Transac! Fee" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_ferry_sum.Penalty
"gi_data_ferry_sum.Penalty" ? "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_ferry_sum.HandlingFee
"gi_data_ferry_sum.HandlingFee" "Handling! Fee" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > giph.gi_data_ferry_sum.CollectFromAgent
"gi_data_ferry_sum.CollectFromAgent" "Coll From !Agent" ? "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_ferry_sum.Payable
"gi_data_ferry_sum.Payable" ? "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_ferry_sum.Profit
"gi_data_ferry_sum.Profit" ? "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_ferry_sum.SupplierComm
"gi_data_ferry_sum.SupplierComm" "Supplier !Comm" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "7.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_ferry_sum.AgentComm
"gi_data_ferry_sum.AgentComm" "Agent !Comm" "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_ferry_sum.db-ControlAgent
"gi_data_ferry_sum.db-ControlAgent" "Db!Control Agent" ? "decimal" ? ? ? ? ? ? no ? no no "12.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_ferry_sum.db-AgentComm
"gi_data_ferry_sum.db-AgentComm" "Db !Agent Comm" ? "decimal" ? ? ? ? ? ? no ? no no "11.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_ferry_sum.total-db
"gi_data_ferry_sum.total-db" "Total !Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "9.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_ferry_sum.cr-FerrySales
"gi_data_ferry_sum.cr-FerrySales" "Cr !Ferry Sales" ? "decimal" ? ? ? ? ? ? no ? no no "10.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   > giph.gi_data_ferry_sum.cr-FerryPurchases
"gi_data_ferry_sum.cr-FerryPurchases" "Cr! Ferry Purc." "->,>>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "10.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[32]   > giph.gi_data_ferry_sum.total-cr
"gi_data_ferry_sum.total-cr" "Total! Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "10.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[33]   > giph.gi_data_ferry_sum.total-db-cr-diff
"gi_data_ferry_sum.total-db-cr-diff" "Db Cr!Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[34]   > giph.gi_data_ferry_sum.AutoGP
"gi_data_ferry_sum.AutoGP" "Auto !GP" ? "decimal" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[35]   > giph.gi_data_ferry_sum.DiffGP
"gi_data_ferry_sum.DiffGP" "Diff !GP" ? "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_data_ferry"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_ferry.YearMonth = pYearMonthFN
 AND giph.gi_data_ferry.Party-name = pparty-name"
     _FldNameList[1]   > giph.gi_data_ferry.YearMonthFN
"gi_data_ferry.YearMonthFN" "Year Mon!FN" ? "character" ? ? ? ? ? ? no ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_data_ferry.TravelAgentId
"gi_data_ferry.TravelAgentId" "Travel !Agent ID" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_data_ferry.AgentName
"gi_data_ferry.AgentName" "Agent! Name" ? "character" ? ? ? ? ? ? no ? no no "15.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_data_ferry.TerminalId
"gi_data_ferry.TerminalId" "Terminal!Id" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_data_ferry.TerminalName
"gi_data_ferry.TerminalName" "Terminal! Name" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_data_ferry.ConfirmationNo
"gi_data_ferry.ConfirmationNo" "Confirmation! No" ? "character" ? ? ? ? ? ? no ? no no "11.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_data_ferry.TranDate-Txt
"gi_data_ferry.TranDate-Txt" "Issued !Date - Txt" ? "character" ? ? ? ? ? ? no ? no no "13.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_data_ferry.TravelType
"gi_data_ferry.TravelType" "Travel! Type" ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_ferry.TransType
"gi_data_ferry.TransType" "Trans! Type" ? "character" ? ? ? ? ? ? no ? no no "4.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_ferry.NoOfSegment
"gi_data_ferry.NoOfSegment" "No of! Segment" ? "integer" ? ? ? ? ? ? no ? no no "6.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_ferry.NetFare
"gi_data_ferry.NetFare" "Net! Fare" ? "decimal" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_ferry.ScDiscount
"gi_data_ferry.ScDiscount" "SC !Discount" ? "decimal" ? ? ? ? ? ? no ? no no "8.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_ferry.DiscountFare
"gi_data_ferry.DiscountFare" "Discount! Fare" ? "decimal" ? ? ? ? ? ? no ? no no "8.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   = giph.gi_data_ferry.Fuel
     _FldNameList[15]   > giph.gi_data_ferry.SecurityFee
"gi_data_ferry.SecurityFee" "Security !Fee" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_ferry.TerminalFee
"gi_data_ferry.TerminalFee" "Terminal !Fee" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   = giph.gi_data_ferry.Meal
     _FldNameList[18]   > giph.gi_data_ferry.Insurance
"gi_data_ferry.Insurance" "Insurance" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_ferry.Linen
"gi_data_ferry.Linen" "Linen" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_ferry.VatableAmount
"gi_data_ferry.VatableAmount" "Vatable !Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   = giph.gi_data_ferry.Vat
     _FldNameList[22]   > giph.gi_data_ferry.VatExempt
"gi_data_ferry.VatExempt" "Vat !Exempt" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[23]   > giph.gi_data_ferry.ZeroVat
"gi_data_ferry.ZeroVat" "Zero! Vat" ? "decimal" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_ferry.TransactionFee
"gi_data_ferry.TransactionFee" "Transaction!Fee" ? "decimal" ? ? ? ? ? ? no ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_ferry.Penalty
"gi_data_ferry.Penalty" ? ? "decimal" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   > giph.gi_data_ferry.HandlingFee
"gi_data_ferry.HandlingFee" "Handling! Fee" ? "decimal" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_ferry.CollectFromAgent
"gi_data_ferry.CollectFromAgent" "Coll From !Agent" ? "decimal" ? ? ? ? ? ? no ? no no "8.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_ferry.Payable
"gi_data_ferry.Payable" ? ? "decimal" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_ferry.Profit
"gi_data_ferry.Profit" ? ? "decimal" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_ferry.SupplierComm
"gi_data_ferry.SupplierComm" "Supplier! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   > giph.gi_data_ferry.AgentComm
"gi_data_ferry.AgentComm" "Agent! Comm" ? "decimal" ? ? ? ? ? ? no ? no no "5.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[32]   > giph.gi_data_ferry.Operator
"gi_data_ferry.Operator" ? ? "character" ? ? ? ? ? ? no ? no no "11.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[33]   = giph.gi_data_ferry.date1
     _FldNameList[34]   > giph.gi_data_ferry.party-name
"gi_data_ferry.party-name" "Party Name" ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[35]   > giph.gi_data_ferry.alias-name
"gi_data_ferry.alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[36]   > giph.gi_data_ferry.GrossAmount1
"gi_data_ferry.GrossAmount1" "Db Gross!Amount" ? "decimal" 19 ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[37]   > giph.gi_data_ferry.AgentComm1
"gi_data_ferry.AgentComm1" "Db Agent!Comm" ? "decimal" 19 ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[38]   > giph.gi_data_ferry.InputVat
"gi_data_ferry.InputVat" "Db Input! Vat" ? "decimal" 19 ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[39]   > giph.gi_data_ferry.Payable1
"gi_data_ferry.Payable1" "Cr !Payable" ? "decimal" 20 ? ? ? ? ? no ? no no "8.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[40]   > giph.gi_data_ferry.comm-income1
"gi_data_ferry.comm-income1" "Cr Comm.!Income" ? "decimal" 20 ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[41]   > giph.gi_data_ferry.OutputVat
"gi_data_ferry.OutputVat" "Cr Output!Vat" ? "decimal" 20 ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[42]   > giph.gi_data_ferry.total-db
"gi_data_ferry.total-db" "Total!Debit" ? "decimal" 21 ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[43]   > giph.gi_data_ferry.total-cr
"gi_data_ferry.total-cr" "Total !Credit" ? "decimal" 21 ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[44]   > giph.gi_data_ferry.total-db-cr-diff
"gi_data_ferry.total-db-cr-diff" "Db Cr! Diff" ? "decimal" 21 ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[45]   > giph.gi_data_ferry.YearMonth
"gi_data_ferry.YearMonth" "Year! Month" ? "character" ? ? ? ? ? ? no ? no no "6.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[46]   > giph.gi_data_ferry.ferry-cons
"gi_data_ferry.ferry-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "7.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
ON END-ERROR OF wWin /* Summary Ferry */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Summary Ferry */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Summary Ferry Data */
DO:
      IF AVAILABLE gi_data_ferry_sum THEN DO:
        ASSIGN pparty-name = gi_data_ferry_sum.party-name
               pyearmonthfn = gi_data_ferry_sum.yearmonthfn
            .

        ASSIGN wtally-response:SCREEN-VALUE = gi_data_ferry_sum.tally-response.



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
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_ferry.p.*/

      FOR EACH b_gi_data_ferry_sum WHERE b_gi_data_ferry_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_ferry_sum.ferry-sum-cons > 0
          BREAK BY b_gi_data_ferry_sum.YearMonth
                BY b_gi_data_ferry_sum.ferry-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN pferry-sum-cons = b_gi_data_ferry_sum.ferry-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_ferry_partyname.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_ferry_sum.LastVchId, OUTPUT b_gi_data_ferry_sum.tally-response).

          
          MESSAGE b_gi_data_ferry_sum.ferry-sum-cons 
              b_gi_data_ferry_sum.YearMonthFn
              "VchID" b_gi_data_ferry_sum.LastVchId. PAUSE 0.
          
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
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_ferry.p.*/

      FOR EACH b_gi_data_ferry_sum WHERE b_gi_data_ferry_sum.YearMonthFn MATCHES wYearMonthFn
                                   AND b_gi_data_ferry_sum.ferry-sum-cons > 0
          BREAK BY b_gi_data_ferry_sum.YearMonth
                BY b_gi_data_ferry_sum.ferry-sum-cons:
          ASSIGN n = n + 1.
          ASSIGN pferry-sum-cons = b_gi_data_ferry_sum.ferry-sum-cons.
          RUN C:\pvr\giph\lib\create_tally_voucher_journal_ferry_partyname_Final.p.
          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_ferry_sum.LastVchId, OUTPUT b_gi_data_ferry_sum.tally-response).

          
          MESSAGE b_gi_data_ferry_sum.ferry-sum-cons 
              b_gi_data_ferry_sum.YearMonthFn
              "VchID" b_gi_data_ferry_sum.LastVchId. PAUSE 0.
          
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


&Scoped-define SELF-NAME BtnImport-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnImport-2 wWin
ON CHOOSE OF BtnImport-2 IN FRAME fMain /* Import */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Import the data?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\import_ferry_data.p.
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
      RUN c:\pvr\giph\lib\VALIDATE_ferry_data.p.
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
      RUN c:\pvr\giph\lib\VALIDATE_ferry_data_novat.p.
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
DEF VAR ptotal-payable AS DEC COLUMN-LABEL "Tot Payable" FORMAT "-z,zzz,zzz,zzz,zz9.99".
DEF VAR ptotal-profit AS DEC COLUMN-LABEL "Tot Profit" FORMAT "-z,zzz,zzz,zzz,zz9.99".
DEF VAR ptotal-payable-fn AS DEC COLUMN-LABEL "Tot PayableFN" FORMAT "-z,zzz,zzz,zzz,zz9.99".

ASSIGN pfilename = "c:\temp\gi_data_ferry_sum_total.txt".

FORM
    b_gi_data_ferry_sum.yearmonth
    ptotal-payable 
    ptotal-profit
    WITH FRAME a DOWN TITLE "Year" STREAM-IO.


FORM
    b_gi_data_ferry_sum.yearmonth
    b_gi_data_ferry_sum.yearmonthfn
    ptotal-payable-fn 
    WITH FRAME b DOWN TITLE "YearFN" STREAM-IO.

OUTPUT TO VALUE(pfilename).

    FOR EACH b_gi_data_ferry_sum WHERE b_gi_data_ferry_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_ferry_sum.yearmonth WITH FRAME a DOWN:
    
        IF FIRST-OF(b_gi_data_ferry_sum.yearmonth) THEN DO:
            ASSIGN ptotal-payable = 0 ptotal-profit = 0.
        END.
        ASSIGN ptotal-payable = ptotal-payable + b_gi_data_ferry_sum.payable.
        ASSIGN ptotal-profit = ptotal-profit + b_gi_data_ferry_sum.profit.
        ACCUMULATE b_gi_data_ferry_sum.payable(TOTAL).
        ACCUMULATE b_gi_data_ferry_sum.profit(TOTAL).
    
        IF LAST-OF(b_gi_data_ferry_sum.yearmonth) THEN DO:
            DISPLAY 
                b_gi_data_ferry_sum.yearmonth
                ptotal-payable 
                ptotal-profit
                WITH FRAME a STREAM-IO.
            DOWN WITH FRAME a.
        END.
    END.
    DISPLAY 
        ACCUM TOTAL b_gi_data_ferry_sum.payable FORMAT "-z,zzz,zzz,zzz,zz9.99" 
        ACCUM TOTAL b_gi_data_ferry_sum.profit FORMAT "-z,zzz,zzz,zzz,zz9.99" 
        WITH FRAME a1.


    /*
    FOR EACH b_gi_data_ferry_sum WHERE b_gi_data_ferry_sum.yearmonth <> ""  NO-LOCK
        BREAK BY b_gi_data_ferry_sum.yearmonthfn WITH FRAME b DOWN:
    
        IF FIRST-OF(b_gi_data_ferry_sum.yearmonthfn) THEN DO:
            ASSIGN ptotal-payable-fn = 0.
        END.
        ASSIGN ptotal-payable-fn = ptotal-payable-fn + b_gi_data_ferry_sum.payable.
    

        IF LAST-OF(b_gi_data_ferry_sum.yearmonthfn) THEN DO:
            DISPLAY 
                b_gi_data_ferry_sum.yearmonth
                b_gi_data_ferry_sum.yearmonthfn
                ptotal-payable-fn 
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


&Scoped-define SELF-NAME m_Create_Ferry_Journal_Entry
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Ferry_Journal_Entry wWin
ON CHOOSE OF MENU-ITEM m_Create_Ferry_Journal_Entry /* Create Ferry Journal Entry */
DO:
  
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_ferry_sum THEN DO:
     ASSIGN pferry-sum-cons = gi_data_ferry_sum.ferry-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_ferry.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_ferry_partyname.p.

  FIND b_gi_data_ferry_sum WHERE b_gi_data_ferry_sum.ferry-sum-cons = pferry-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_ferry_sum THEN DO:
      
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_ferry_sum.LastVchId, OUTPUT b_gi_data_ferry_sum.tally-response).
  END.
  APPLY "Value-Changed" TO BROWSE-1.  
  SESSION:SET-WAIT-STATE("").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Ferry_Journal_Entry_
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Ferry_Journal_Entry_ wWin
ON CHOOSE OF MENU-ITEM m_Create_Ferry_Journal_Entry_ /* Create Ferry Journal Entry Final */
DO:
      DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_ferry_sum THEN DO:
     ASSIGN pferry-sum-cons = gi_data_ferry_sum.ferry-sum-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  /*RUN c:\pvr\giph\lib\create_tally_voucher_journal_ferry.p.*/
  RUN C:\pvr\giph\lib\create_tally_voucher_journal_ferry_partyname_Final.p.

  FIND b_gi_data_ferry_sum WHERE b_gi_data_ferry_sum.ferry-sum-cons = pferry-sum-cons NO-ERROR.
  IF AVAILABLE b_gi_data_ferry_sum THEN DO:
      
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_ferry_sum.LastVchId, OUTPUT b_gi_data_ferry_sum.tally-response).
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
  ENABLE wYearMonth1 MonthlyTotals BtnImport-2 BtnValidate BtnExport 
         BtnExportFinal BtnValidateNoVat wyearmonthfn wParty-Name BtnSearch 
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

