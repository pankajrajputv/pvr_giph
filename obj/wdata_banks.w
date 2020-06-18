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
/*DEF NEW SHARED VAR pbank-cons LIKE gi_data_banks.bank-cons.*/

DEF NEW SHARED VAR pbank-cons LIKE gi_data_banks.bank-cons. 
DEF NEW SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF NEW SHARED VAR pbank-des LIKE gi_data_banks.bank-des.
DEF NEW SHARED VAR pYearMonth LIKE gi_data_banks.YearMonth. 
DEF NEW SHARED VAR pYearMonth1 LIKE gi_data_banks.YearMonth. 

DEF VAR pYearMonthFN LIKE gi_data_banks.YearMonthFN. 
DEF VAR pparty-name LIKE gi_data_banks.party-name.

DEF BUFFER b_gi_data_banks FOR gi_data_banks.

DEF VAR poutput-filename AS CHAR.
/*ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal-response.txt".*/
ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucher-response.txt".


DEF VAR prefnum1-clean LIKE gi_acc_hea.refnum1-clean.
DEF VAR prefnum1 LIKE gi_acc_hea.refnum1.
DEF VAR ptran-refnum1 LIKE gi_data_banks.tran-refnum1.

DEF VAR pdate-cleared AS DATE.
DEF VAR pdate-issue AS DATE.
DEF VAR ptran-amount AS DEC.

DEF NEW SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF NEW SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 

DEF VAR prefnum1-a LIKE gi_acc_hea.refnum1.

DEF BUFFER b_gi_acc_hea FOR gi_acc_hea.
DEF BUFFER b_gi_acc_det FOR gi_acc_det.

DEF VAR pshowtrans AS INT INIT 0.
DEF VAR ptallystatus AS INT INIT 0.

DEF NEW SHARED VAR preport-type AS INT.

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
&Scoped-define INTERNAL-TABLES gi_data_banks gi_acc_det gi_acc_hea ~
gi_banks_diff

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_data_banks.bank-reg ~
gi_data_banks.bank-cons gi_data_banks.date-cleared gi_data_banks.has-tran ~
gi_data_banks.tran-refnum1 gi_data_banks.LastVchId gi_data_banks.date-issue ~
gi_data_banks.amt-db gi_data_banks.amt-cr gi_data_banks.amt-bal ~
gi_data_banks.other-account gi_data_banks.remarks gi_data_banks.remarks1 ~
gi_data_banks.ch-num gi_data_banks.refnum1 gi_data_banks.refnum1a ~
gi_data_banks.acc-origin gi_data_banks.acc-destination ~
gi_data_banks.acc-receiver gi_data_banks.acc-payer gi_data_banks.narration ~
gi_data_banks.YearMonthFN gi_data_banks.YearMonth ~
gi_data_banks.rate-exchange gi_data_banks.conv-val gi_data_banks.ledger-db ~
gi_data_banks.ledger-cr gi_data_banks.party-name gi_data_banks.alias-name ~
gi_data_banks.usd-amt-db gi_data_banks.usd-amt-cr gi_data_banks.branch ~
gi_data_banks.description 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_data_banks.acc-receiver ~
gi_data_banks.acc-payer 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_data_banks
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_data_banks
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_data_banks ~
      WHERE gi_data_banks.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_banks.party-name MATCHES wParty-Name ~
 AND gi_data_banks.bank-code MATCHES pbank-code ~
 AND (wbank-cons > 0 and gi_data_banks.bank-cons = wbank-cons OR ~
      wbank-cons = 0 and gi_data_banks.bank-cons > 0) ~
 AND ( ~
(wHasTransaction = 1 and gi_data_banks.tran-refnum1 <> "") OR ~
(wHasTransaction = 2 and gi_data_banks.tran-refnum1 = "") OR ~
(wHasTransaction = 9 )  ~
) ~
 AND gi_data_banks.tran-refnum1 MATCHES wtran-refnum1 ~
        AND gi_data_banks.date-cleared >= wdate-ini ~
        AND gi_data_banks.date-cleared <= wdate-fin ~
       ~
 ~
 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_data_banks ~
      WHERE gi_data_banks.YearMonthFN MATCHES wYearMonthFn ~
 AND gi_data_banks.party-name MATCHES wParty-Name ~
 AND gi_data_banks.bank-code MATCHES pbank-code ~
 AND (wbank-cons > 0 and gi_data_banks.bank-cons = wbank-cons OR ~
      wbank-cons = 0 and gi_data_banks.bank-cons > 0) ~
 AND ( ~
(wHasTransaction = 1 and gi_data_banks.tran-refnum1 <> "") OR ~
(wHasTransaction = 2 and gi_data_banks.tran-refnum1 = "") OR ~
(wHasTransaction = 9 )  ~
) ~
 AND gi_data_banks.tran-refnum1 MATCHES wtran-refnum1 ~
        AND gi_data_banks.date-cleared >= wdate-ini ~
        AND gi_data_banks.date-cleared <= wdate-fin ~
       ~
 ~
 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_data_banks
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_data_banks


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.reg ~
gi_acc_hea.vouchertype gi_acc_det.refnum1 gi_acc_det.refdate ~
gi_acc_det.bank-cons gi_acc_det.partyname gi_acc_det.alias-name ~
gi_acc_det.debit gi_acc_det.credit gi_acc_det.cheque-num ~
gi_acc_det.currency gi_acc_det.forex-rate gi_acc_det.acc-led-name ~
gi_acc_det.runbal1 gi_acc_det.runbal2 gi_acc_det.amount ~
gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.refnum1 ~
gi_acc_det.partyname gi_acc_det.alias-name gi_acc_det.acc-led-name 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refdate = pdate-cleared ~
 AND gi_acc_det.acc-led-name = pbank-des ~
/* AND gi_acc_det.amount = ptran-amount*/ ~
 AND ( ~
(wRefNumType = 1 and gi_acc_det.refnum1 = prefnum1) OR ~
(wRefNumType = 2 and gi_acc_det.refnum1 = ptran-refnum1) OR ~
(wRefNumType = 3) ~
) NO-LOCK, ~
      EACH gi_acc_hea OF gi_acc_det NO-LOCK ~
    BY gi_acc_det.refdate INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refdate = pdate-cleared ~
 AND gi_acc_det.acc-led-name = pbank-des ~
/* AND gi_acc_det.amount = ptran-amount*/ ~
 AND ( ~
(wRefNumType = 1 and gi_acc_det.refnum1 = prefnum1) OR ~
(wRefNumType = 2 and gi_acc_det.refnum1 = ptran-refnum1) OR ~
(wRefNumType = 3) ~
) NO-LOCK, ~
      EACH gi_acc_hea OF gi_acc_det NO-LOCK ~
    BY gi_acc_det.refdate INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_acc_det gi_acc_hea
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 gi_acc_hea


/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 gi_acc_det.reg ~
gi_acc_det.acc-led-name gi_acc_det.debit gi_acc_det.credit ~
gi_acc_det.cheque-num gi_acc_det.partyname gi_acc_det.alias-name ~
gi_acc_det.currency gi_acc_det.forex-rate gi_acc_det.runbal1 ~
gi_acc_det.runbal2 gi_acc_det.amount gi_acc_det.refnum1 ~
gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refnum1 = prefnum1-a NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refnum1 = prefnum1-a NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 gi_acc_det
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 gi_acc_det


/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 gi_banks_diff.bank-code ~
gi_banks_diff.date-cleared gi_banks_diff.amt-db gi_banks_diff.credit ~
gi_banks_diff.diff-debit gi_banks_diff.amt-cr gi_banks_diff.debit ~
gi_banks_diff.diff-credit 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4 
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH gi_banks_diff ~
      WHERE gi_banks_diff.bank-code = pbank-code ~
 AND gi_banks_diff.date-cleared = pdate-cleared NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY BROWSE-4 FOR EACH gi_banks_diff ~
      WHERE gi_banks_diff.bank-code = pbank-code ~
 AND gi_banks_diff.date-cleared = pdate-cleared NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 gi_banks_diff
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 gi_banks_diff


/* Definitions for BROWSE BROWSE-5                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-5 gi_acc_det.reg ~
gi_acc_hea.vouchertype gi_acc_det.refnum1 gi_acc_det.refdate ~
gi_acc_det.bank-cons gi_acc_det.partyname gi_acc_det.alias-name ~
gi_acc_det.debit gi_acc_det.credit gi_acc_det.cheque-num ~
gi_acc_det.currency gi_acc_det.forex-rate gi_acc_det.acc-led-name ~
gi_acc_det.runbal1 gi_acc_det.runbal2 gi_acc_det.amount ~
gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-5 
&Scoped-define QUERY-STRING-BROWSE-5 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.acc-led-name = pbank-des ~
 AND gi_acc_det.amount = ptran-amount ~
 NO-LOCK, ~
      EACH gi_acc_hea OF gi_acc_det NO-LOCK ~
    BY gi_acc_det.refdate INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-5 OPEN QUERY BROWSE-5 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.acc-led-name = pbank-des ~
 AND gi_acc_det.amount = ptran-amount ~
 NO-LOCK, ~
      EACH gi_acc_hea OF gi_acc_det NO-LOCK ~
    BY gi_acc_det.refdate INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-5 gi_acc_det gi_acc_hea
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-5 gi_acc_det
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-5 gi_acc_hea


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wdate-ini wdate-fin BUTTON-1 wTallyStatus ~
wShowTransaction wYearMonth1 BtnSearch wyearmonthfn wbank-cons wParty-Name ~
wtran-refnum1 BtnImport BtnValidate BtnExport wHasTransaction wbank-code ~
wTransactions BtnOpenExcelFile BROWSE-1 wRefNumType BROWSE-2 BROWSE-5 ~
BROWSE-3 BROWSE-4 BtnReportDiffSummaryAll BtnProcessDiffSummarySelected ~
BtnProcessDiffSummaryAll BtnReportDiffSummarySelected 
&Scoped-Define DISPLAYED-OBJECTS wdate-ini wdate-fin wYearMonth1 ~
wyearmonthfn wbank-cons wParty-Name wtran-refnum1 wHasTransaction ~
wbank-code wbank-des wtrans-amt-txt wtot-amt-diff wtot-amt-db wtot-amt-cr ~
wcount wRefNumType wtally-response wamt-db wamt-cr wamt-db-cr-diff wcredit ~
wdebit wdebit-credit-diff wdiff-db wdiff-cr 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Bank_Transaction LABEL "Create Bank Transaction"
       RULE
       MENU-ITEM m_Validata_Bank_Data LABEL "Validata Bank Data"
       MENU-ITEM m_View_XML     LABEL "View XML"      .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnExport 
     LABEL "Export" 
     SIZE 6.43 BY .81
     FONT 4.

DEFINE BUTTON BtnImport 
     LABEL "Import" 
     SIZE 8.72 BY .81
     FONT 4.

DEFINE BUTTON BtnOpenExcelFile 
     LABEL "Open Excel" 
     SIZE 9.72 BY .81
     FONT 4.

DEFINE BUTTON BtnProcessDiffSummaryAll 
     LABEL "Process Diff Sum (All)" 
     SIZE 19.57 BY .81
     FONT 4.

DEFINE BUTTON BtnProcessDiffSummarySelected 
     LABEL "Process Diff Sum (Selected)" 
     SIZE 21.29 BY .81
     FONT 4.

DEFINE BUTTON BtnReportDiffSummaryAll 
     LABEL "Report Diff Summary All" 
     SIZE 18.86 BY .81
     FONT 4.

DEFINE BUTTON BtnReportDiffSummarySelected 
     LABEL "Report Diff Summary Selected" 
     SIZE 22.57 BY .81
     FONT 4.

DEFINE BUTTON BtnSearch 
     LABEL "Search" 
     SIZE 8.72 BY .81.

DEFINE BUTTON BtnValidate 
     LABEL "Validate" 
     SIZE 7.14 BY .81 TOOLTIP "Validate Bank Data"
     FONT 4.

DEFINE BUTTON BUTTON-1 
     LABEL "Auto Assign" 
     SIZE 15 BY .81 TOOLTIP "Auto Assign Bank Deposits".

DEFINE BUTTON wShowTransaction 
     LABEL "Show/Hide Trans" 
     SIZE 14.14 BY .81
     FONT 4.

DEFINE BUTTON wTallyStatus 
     LABEL "Tally Status" 
     SIZE 14.14 BY .81
     FONT 4.

DEFINE BUTTON wTransactions 
     LABEL "Transactions" 
     SIZE 11.29 BY .81
     FONT 4.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 34.72 BY 10.46
     FONT 4 NO-UNDO.

DEFINE VARIABLE wamt-cr AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Credit" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wamt-db AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Bank Debit" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wamt-db-cr-diff AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Diff" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wbank-cons AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "Cons" 
     VIEW-AS FILL-IN 
     SIZE 10.29 BY .81 NO-UNDO.

DEFINE VARIABLE wbank-des AS CHARACTER FORMAT "X(256)":U 
     LABEL "Bank" 
     VIEW-AS FILL-IN 
     SIZE 29 BY .77
     FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE wcount AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Count" 
     VIEW-AS FILL-IN 
     SIZE 9.86 BY 1
     BGCOLOR 16 FONT 4 NO-UNDO.

DEFINE VARIABLE wcredit AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Transaction Credit" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wdate-fin AS DATE FORMAT "99/99/9999":U 
     LABEL "To" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY .81 TOOLTIP "Search date"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wdate-ini AS DATE FORMAT "99/99/9999":U 
     LABEL "Date From" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY .81 TOOLTIP "Search date"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wdebit AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Debit" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wdebit-credit-diff AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Diff" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wdiff-cr AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Credit" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wdiff-db AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Diff Debit" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wParty-Name AS CHARACTER FORMAT "X(256)":U 
     LABEL "Party Name" 
     VIEW-AS FILL-IN 
     SIZE 25.57 BY .81 NO-UNDO.

DEFINE VARIABLE wtot-amt-cr AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total Cr" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 20 FONT 4 NO-UNDO.

DEFINE VARIABLE wtot-amt-db AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total Db" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 19 FONT 4 NO-UNDO.

DEFINE VARIABLE wtot-amt-diff AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total Diff" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FONT 4 NO-UNDO.

DEFINE VARIABLE wtran-refnum1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tran Refnum1" 
     VIEW-AS FILL-IN 
     SIZE 17.14 BY .81 NO-UNDO.

DEFINE VARIABLE wtrans-amt-txt AS CHARACTER FORMAT "X(256)":U 
     LABEL "Trans. Amt." 
     VIEW-AS FILL-IN 
     SIZE 25.14 BY 1
     FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE wyearmonthfn AS CHARACTER FORMAT "X(256)":U 
     LABEL "Year Month" 
     VIEW-AS FILL-IN 
     SIZE 9.72 BY .81 NO-UNDO.

DEFINE VARIABLE wbank-code AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "AUB", "AUB",
"BDO_DIS", "BDO_DISBURSEMENT",
"BDO_USD", "BDO_DOLLAR",
"BDO_TOPUP", "BDO_TOPUP",
"BPI", "BPI",
"METROBANK", "METROBANK",
"PNB", "PNB",
"SECURITY", "SECURITY",
"UCPB_DIS", "UCPB_DISBURSEMENT",
"UCPB_RECON", "UCPB_RECON",
"UCPB_TOPUP", "UCPB_TOPUP",
"ALL", "ALL"
     SIZE 114.43 BY .77
     BGCOLOR 19 FONT 4 NO-UNDO.

DEFINE VARIABLE wHasTransaction AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"All", 9
     SIZE 15.29 BY .69
     FONT 4 NO-UNDO.

DEFINE VARIABLE wRefNumType AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Refnum1", 1,
"TranRefnum", 2,
"All", 3
     SIZE 28.14 BY .73
     FONT 4 NO-UNDO.

DEFINE VARIABLE wYearMonth1 AS CHARACTER 
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
     SIZE 65.43 BY .69
     FONT 2 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_data_banks SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_acc_det SCROLLING.

DEFINE QUERY BROWSE-4 FOR 
      gi_banks_diff SCROLLING.

DEFINE QUERY BROWSE-5 FOR 
      gi_acc_det, 
      gi_acc_hea SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_data_banks.bank-reg FORMAT "->>>>>>9":U
      gi_data_banks.bank-cons FORMAT "->>>>>>9":U
      gi_data_banks.date-cleared FORMAT "99/99/9999":U
      gi_data_banks.has-tran FORMAT "yes/no":U
      gi_data_banks.tran-refnum1 FORMAT "x(20)":U
      gi_data_banks.LastVchId FORMAT "->>>>>>9":U
      gi_data_banks.date-issue FORMAT "99/99/9999":U
      gi_data_banks.amt-db FORMAT "->,>>>,>>>,>>>.99":U COLUMN-FGCOLOR 12
      gi_data_banks.amt-cr FORMAT "->,>>>,>>>,>>>.99":U COLUMN-FGCOLOR 9
      gi_data_banks.amt-bal FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_banks.other-account FORMAT "x(100)":U WIDTH 20
      gi_data_banks.remarks FORMAT "x(50)":U WIDTH 13.86
      gi_data_banks.remarks1 FORMAT "x(50)":U WIDTH 20
      gi_data_banks.ch-num FORMAT "x(20)":U WIDTH 12.72
      gi_data_banks.refnum1 FORMAT "x(20)":U WIDTH 8.72
      gi_data_banks.refnum1a FORMAT "x(20)":U WIDTH 10
      gi_data_banks.acc-origin FORMAT "x(100)":U WIDTH 28.86
      gi_data_banks.acc-destination FORMAT "x(100)":U WIDTH 31.86
      gi_data_banks.acc-receiver FORMAT "x(100)":U WIDTH 24.57
      gi_data_banks.acc-payer FORMAT "x(100)":U WIDTH 26.57
      gi_data_banks.narration FORMAT "x(200)":U WIDTH 35.57
      gi_data_banks.YearMonthFN FORMAT "x(12)":U
      gi_data_banks.YearMonth FORMAT "x(8)":U
      gi_data_banks.rate-exchange FORMAT "->>,>>9.9999":U
      gi_data_banks.conv-val FORMAT "->>>,>>>,>>9.99":U
      gi_data_banks.ledger-db FORMAT "x(100)":U WIDTH 30
      gi_data_banks.ledger-cr FORMAT "x(100)":U WIDTH 30
      gi_data_banks.party-name FORMAT "x(100)":U WIDTH 20
      gi_data_banks.alias-name FORMAT "x(100)":U WIDTH 24.86
      gi_data_banks.usd-amt-db FORMAT "->,>>>,>>>,>>9.99":U COLUMN-FGCOLOR 9
      gi_data_banks.usd-amt-cr FORMAT "->,>>>,>>>,>>9.99":U COLUMN-FGCOLOR 9
      gi_data_banks.branch FORMAT "x(50)":U WIDTH 10.14
      gi_data_banks.description FORMAT "x(50)":U WIDTH 15.86
  ENABLE
      gi_data_banks.acc-receiver
      gi_data_banks.acc-payer
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 174 BY 8.77
         FONT 4
         TITLE "Bank Statement" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
      gi_acc_hea.vouchertype FORMAT "x(8)":U WIDTH 4.86
      gi_acc_det.refnum1 COLUMN-LABEL "Ref" FORMAT "x(50)":U WIDTH 8.72
      gi_acc_det.refdate COLUMN-LABEL "Refdate" FORMAT "99/99/99":U
      gi_acc_det.bank-cons COLUMN-LABEL "BankCons" FORMAT "->>>>>>9":U
            WIDTH 7.43
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 10.14
      gi_acc_det.alias-name FORMAT "x(100)":U WIDTH 6.57
      gi_acc_det.debit COLUMN-LABEL "Debit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.14
      gi_acc_det.credit COLUMN-LABEL "Credit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.57
      gi_acc_det.cheque-num FORMAT "x(20)":U WIDTH 12.29
      gi_acc_det.currency FORMAT "x(8)":U WIDTH 4.57
      gi_acc_det.forex-rate FORMAT "->>,>>9.99":U WIDTH 8
      gi_acc_det.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(100)":U
            WIDTH 19.72
      gi_acc_det.runbal1 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.runbal2 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 50
      gi_acc_det.cons COLUMN-LABEL "Cons" FORMAT "->>>>>>9":U
  ENABLE
      gi_acc_det.refnum1
      gi_acc_det.partyname
      gi_acc_det.alias-name
      gi_acc_det.acc-led-name
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 81.72 BY 10.46
         FONT 4
         TITLE "Transaction Details" ROW-HEIGHT-CHARS .69 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 wWin _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
      gi_acc_det.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(100)":U
            WIDTH 20.29
      gi_acc_det.debit COLUMN-LABEL "Debit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 12.86
      gi_acc_det.credit COLUMN-LABEL "Credit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.57
      gi_acc_det.cheque-num FORMAT "x(20)":U WIDTH 12.29
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 20.57
      gi_acc_det.alias-name FORMAT "x(100)":U WIDTH 15
      gi_acc_det.currency FORMAT "x(8)":U WIDTH 4.57
      gi_acc_det.forex-rate FORMAT "->>,>>9.99":U WIDTH 8
      gi_acc_det.runbal1 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.runbal2 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.refnum1 COLUMN-LABEL "Ref" FORMAT "x(50)":U WIDTH 8.72
      gi_acc_det.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 50
      gi_acc_det.cons COLUMN-LABEL "Cons" FORMAT "->>>>>>9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 91.57 BY 10.5
         BGCOLOR 8 FONT 4
         TITLE BGCOLOR 8 "Transaction Details" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 wWin _STRUCTURED
  QUERY BROWSE-4 NO-LOCK DISPLAY
      gi_banks_diff.bank-code FORMAT "x(20)":U WIDTH 8.86
      gi_banks_diff.date-cleared COLUMN-LABEL "Date" FORMAT "99/99/9999":U
            WIDTH 9.14
      gi_banks_diff.amt-db COLUMN-LABEL "Bank Db" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 12
      gi_banks_diff.credit COLUMN-LABEL "Trans Cr" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 12
      gi_banks_diff.diff-debit FORMAT "->>>,>>>,>>9.99":U WIDTH 12.29
      gi_banks_diff.amt-cr COLUMN-LABEL "Bank Cr" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 13.14
      gi_banks_diff.debit COLUMN-LABEL "Trans Db" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 12.29
      gi_banks_diff.diff-credit FORMAT "->>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 97.72 BY 4.5
         FONT 4
         TITLE "Bank Difference" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-5 wWin _STRUCTURED
  QUERY BROWSE-5 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
      gi_acc_hea.vouchertype FORMAT "x(8)":U WIDTH 4.86
      gi_acc_det.refnum1 COLUMN-LABEL "Ref" FORMAT "x(50)":U WIDTH 8.72
      gi_acc_det.refdate COLUMN-LABEL "Refdate" FORMAT "99/99/99":U
      gi_acc_det.bank-cons COLUMN-LABEL "BankCons" FORMAT "->>>>>>9":U
            WIDTH 7.43
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 10.14
      gi_acc_det.alias-name FORMAT "x(100)":U WIDTH 6.57
      gi_acc_det.debit COLUMN-LABEL "Debit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.14
      gi_acc_det.credit COLUMN-LABEL "Credit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 11.57
      gi_acc_det.cheque-num FORMAT "x(20)":U WIDTH 12.29
      gi_acc_det.currency FORMAT "x(8)":U WIDTH 4.57
      gi_acc_det.forex-rate FORMAT "->>,>>9.99":U WIDTH 8
      gi_acc_det.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(100)":U
            WIDTH 19.72
      gi_acc_det.runbal1 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.runbal2 COLUMN-LABEL "Run. Bal1" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
      gi_acc_det.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 50
      gi_acc_det.cons COLUMN-LABEL "Cons" FORMAT "->>>>>>9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 91.86 BY 10.46
         BGCOLOR 21 FONT 4
         TITLE BGCOLOR 21 "Transaction Details (Amount wise)" ROW-HEIGHT-CHARS .69 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wdate-ini AT ROW 1.31 COL 78.14 COLON-ALIGNED WIDGET-ID 10
     wdate-fin AT ROW 1.31 COL 94.72 COLON-ALIGNED WIDGET-ID 122
     BUTTON-1 AT ROW 1.31 COL 131.14 WIDGET-ID 120
     wTallyStatus AT ROW 1.31 COL 147.14 WIDGET-ID 118
     wShowTransaction AT ROW 1.31 COL 161.86 WIDGET-ID 116
     wYearMonth1 AT ROW 1.35 COL 2.14 NO-LABEL WIDGET-ID 64
     BtnSearch AT ROW 2.31 COL 144 WIDGET-ID 6
     wyearmonthfn AT ROW 2.35 COL 12 COLON-ALIGNED WIDGET-ID 2
     wbank-cons AT ROW 2.35 COL 30.57 COLON-ALIGNED WIDGET-ID 56
     wParty-Name AT ROW 2.35 COL 53.72 COLON-ALIGNED WIDGET-ID 8
     wtran-refnum1 AT ROW 2.35 COL 94.14 COLON-ALIGNED WIDGET-ID 82
     BtnImport AT ROW 2.35 COL 154.14 WIDGET-ID 12
     BtnValidate AT ROW 2.35 COL 162.72 WIDGET-ID 26
     BtnExport AT ROW 2.35 COL 170 WIDGET-ID 14
     wHasTransaction AT ROW 2.38 COL 126.14 NO-LABEL WIDGET-ID 108
     wbank-code AT ROW 3.35 COL 2.14 NO-LABEL WIDGET-ID 32
     wbank-des AT ROW 3.35 COL 121.72 COLON-ALIGNED WIDGET-ID 52
     wTransactions AT ROW 3.35 COL 155 WIDGET-ID 54
     BtnOpenExcelFile AT ROW 3.35 COL 166.86 WIDGET-ID 50
     BROWSE-1 AT ROW 4.38 COL 2.14 WIDGET-ID 200
     wtrans-amt-txt AT ROW 13.38 COL 43.57 COLON-ALIGNED WIDGET-ID 80
     wtot-amt-diff AT ROW 13.38 COL 78.86 COLON-ALIGNED WIDGET-ID 58
     wtot-amt-db AT ROW 13.38 COL 108.29 COLON-ALIGNED WIDGET-ID 46
     wtot-amt-cr AT ROW 13.38 COL 137.14 COLON-ALIGNED WIDGET-ID 48
     wcount AT ROW 13.38 COL 164 COLON-ALIGNED WIDGET-ID 124
     wRefNumType AT ROW 13.54 COL 2.14 NO-LABEL WIDGET-ID 60
     BROWSE-2 AT ROW 14.69 COL 2.14 WIDGET-ID 300
     BROWSE-5 AT ROW 14.69 COL 84.43 WIDGET-ID 600
     BROWSE-3 AT ROW 14.69 COL 84.72 WIDGET-ID 400
     wtally-response AT ROW 14.69 COL 141.14 NO-LABEL WIDGET-ID 28
     BROWSE-4 AT ROW 25.35 COL 78.57 WIDGET-ID 500
     wamt-db AT ROW 25.38 COL 18 COLON-ALIGNED WIDGET-ID 92
     wamt-cr AT ROW 25.38 COL 40.14 COLON-ALIGNED WIDGET-ID 90
     wamt-db-cr-diff AT ROW 25.38 COL 60.43 COLON-ALIGNED WIDGET-ID 94
     wcredit AT ROW 26.5 COL 18 COLON-ALIGNED WIDGET-ID 86
     wdebit AT ROW 26.5 COL 40.14 COLON-ALIGNED WIDGET-ID 84
     wdebit-credit-diff AT ROW 26.5 COL 60.43 COLON-ALIGNED WIDGET-ID 88
     wdiff-db AT ROW 27.65 COL 18 COLON-ALIGNED WIDGET-ID 98
     wdiff-cr AT ROW 27.65 COL 40.14 COLON-ALIGNED WIDGET-ID 100
     BtnReportDiffSummaryAll AT ROW 27.85 COL 58.72 WIDGET-ID 126
     BtnProcessDiffSummarySelected AT ROW 28.88 COL 2.57 WIDGET-ID 102
     BtnProcessDiffSummaryAll AT ROW 28.88 COL 23.86 WIDGET-ID 128
     BtnReportDiffSummarySelected AT ROW 28.88 COL 54.72 WIDGET-ID 104
     "Has Transaction" VIEW-AS TEXT
          SIZE 11.14 BY .69 AT ROW 2.38 COL 114.29 WIDGET-ID 112
          FONT 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 176.29 BY 29.04 WIDGET-ID 100.


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
         TITLE              = "Summary Banks"
         HEIGHT             = 29.04
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
/* BROWSE-TAB BROWSE-1 BtnOpenExcelFile fMain */
/* BROWSE-TAB BROWSE-2 wRefNumType fMain */
/* BROWSE-TAB BROWSE-5 BROWSE-2 fMain */
/* BROWSE-TAB BROWSE-3 BROWSE-5 fMain */
/* BROWSE-TAB BROWSE-4 wtally-response fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:NUM-LOCKED-COLUMNS IN FRAME fMain     = 9
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_data_banks.acc-receiver:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_data_banks.acc-payer:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

ASSIGN 
       BROWSE-2:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_det.refnum1:COLUMN-READ-ONLY IN BROWSE BROWSE-2 = TRUE
       gi_acc_det.partyname:COLUMN-READ-ONLY IN BROWSE BROWSE-2 = TRUE
       gi_acc_det.acc-led-name:COLUMN-READ-ONLY IN BROWSE BROWSE-2 = TRUE.

ASSIGN 
       BROWSE-3:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-3:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-3:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-4:NUM-LOCKED-COLUMNS IN FRAME fMain     = 2
       BROWSE-4:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-4:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-5:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-5:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-5:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

/* SETTINGS FOR FILL-IN wamt-cr IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wamt-db IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wamt-db-cr-diff IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wbank-des IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wcount IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wcredit IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wdebit IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wdebit-credit-diff IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wdiff-cr IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wdiff-db IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR wtally-response IN FRAME fMain
   NO-ENABLE                                                            */
ASSIGN 
       wtally-response:HIDDEN IN FRAME fMain           = TRUE
       wtally-response:RETURN-INSERTED IN FRAME fMain  = TRUE
       wtally-response:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN wtot-amt-cr IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-amt-db IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-amt-diff IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtrans-amt-txt IN FRAME fMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_data_banks"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_data_banks.YearMonthFN MATCHES wYearMonthFn
 AND giph.gi_data_banks.party-name MATCHES wParty-Name
 AND giph.gi_data_banks.bank-code MATCHES pbank-code
 AND (wbank-cons > 0 and giph.gi_data_banks.bank-cons = wbank-cons OR
      wbank-cons = 0 and giph.gi_data_banks.bank-cons > 0)
 AND (
(wHasTransaction = 1 and giph.gi_data_banks.tran-refnum1 <> """") OR
(wHasTransaction = 2 and giph.gi_data_banks.tran-refnum1 = """") OR
(wHasTransaction = 9 ) 
)
 AND giph.gi_data_banks.tran-refnum1 MATCHES wtran-refnum1
        AND giph.gi_data_banks.date-cleared >= wdate-ini
        AND giph.gi_data_banks.date-cleared <= wdate-fin
      

"
     _FldNameList[1]   = giph.gi_data_banks.bank-reg
     _FldNameList[2]   = giph.gi_data_banks.bank-cons
     _FldNameList[3]   = giph.gi_data_banks.date-cleared
     _FldNameList[4]   = giph.gi_data_banks.has-tran
     _FldNameList[5]   = giph.gi_data_banks.tran-refnum1
     _FldNameList[6]   = giph.gi_data_banks.LastVchId
     _FldNameList[7]   = giph.gi_data_banks.date-issue
     _FldNameList[8]   > giph.gi_data_banks.amt-db
"gi_data_banks.amt-db" ? "->,>>>,>>>,>>>.99" "decimal" ? 12 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_data_banks.amt-cr
"gi_data_banks.amt-cr" ? "->,>>>,>>>,>>>.99" "decimal" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   = giph.gi_data_banks.amt-bal
     _FldNameList[11]   > giph.gi_data_banks.other-account
"gi_data_banks.other-account" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_banks.remarks
"gi_data_banks.remarks" ? ? "character" ? ? ? ? ? ? no ? no no "13.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_banks.remarks1
"gi_data_banks.remarks1" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_banks.ch-num
"gi_data_banks.ch-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_banks.refnum1
"gi_data_banks.refnum1" ? ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_banks.refnum1a
"gi_data_banks.refnum1a" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_banks.acc-origin
"gi_data_banks.acc-origin" ? ? "character" ? ? ? ? ? ? no ? no no "28.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_banks.acc-destination
"gi_data_banks.acc-destination" ? ? "character" ? ? ? ? ? ? no ? no no "31.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_data_banks.acc-receiver
"gi_data_banks.acc-receiver" ? ? "character" ? ? ? ? ? ? yes ? no no "24.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_data_banks.acc-payer
"gi_data_banks.acc-payer" ? ? "character" ? ? ? ? ? ? yes ? no no "26.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > giph.gi_data_banks.narration
"gi_data_banks.narration" ? ? "character" ? ? ? ? ? ? no ? no no "35.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   = giph.gi_data_banks.YearMonthFN
     _FldNameList[23]   = giph.gi_data_banks.YearMonth
     _FldNameList[24]   = giph.gi_data_banks.rate-exchange
     _FldNameList[25]   = giph.gi_data_banks.conv-val
     _FldNameList[26]   > giph.gi_data_banks.ledger-db
"gi_data_banks.ledger-db" ? ? "character" ? ? ? ? ? ? no ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[27]   > giph.gi_data_banks.ledger-cr
"gi_data_banks.ledger-cr" ? ? "character" ? ? ? ? ? ? no ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_banks.party-name
"gi_data_banks.party-name" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_banks.alias-name
"gi_data_banks.alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "24.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_banks.usd-amt-db
"gi_data_banks.usd-amt-db" ? ? "decimal" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   > giph.gi_data_banks.usd-amt-cr
"gi_data_banks.usd-amt-cr" ? ? "decimal" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[32]   > giph.gi_data_banks.branch
"gi_data_banks.branch" ? ? "character" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[33]   > giph.gi_data_banks.description
"gi_data_banks.description" ? ? "character" ? ? ? ? ? ? no ? no no "15.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_acc_det,giph.gi_acc_hea OF giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "giph.gi_acc_det.refdate|yes"
     _Where[1]         = "giph.gi_acc_det.refdate = pdate-cleared
 AND gi_acc_det.acc-led-name = pbank-des
/* AND gi_acc_det.amount = ptran-amount*/
 AND (
(wRefNumType = 1 and giph.gi_acc_det.refnum1 = prefnum1) OR
(wRefNumType = 2 and giph.gi_acc_det.refnum1 = ptran-refnum1) OR
(wRefNumType = 3)
)"
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_hea.vouchertype
"gi_acc_hea.vouchertype" ? ? "character" ? ? ? ? ? ? no ? no no "4.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? yes ? no no "8.72" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.refdate
"gi_acc_det.refdate" "Refdate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.bank-cons
"gi_acc_det.bank-cons" "BankCons" ? "integer" ? ? ? ? ? ? no ? no no "7.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? yes ? no no "10.14" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.alias-name
"gi_acc_det.alias-name" ? ? "character" ? ? ? ? ? ? yes ? no no "6.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "11.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? yes ? no no "19.72" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_det.refnum1 = prefnum1-a"
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? no ? no no "20.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? no ? no no "20.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.alias-name
"gi_acc_det.alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _TblList          = "giph.gi_banks_diff"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "gi_banks_diff.bank-code = pbank-code
 AND gi_banks_diff.date-cleared = pdate-cleared"
     _FldNameList[1]   > giph.gi_banks_diff.bank-code
"gi_banks_diff.bank-code" ? ? "character" ? ? ? ? ? ? no ? no no "8.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_banks_diff.date-cleared
"gi_banks_diff.date-cleared" "Date" ? "date" ? ? ? ? ? ? no ? no no "9.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_banks_diff.amt-db
"gi_banks_diff.amt-db" "Bank Db" ? "decimal" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_banks_diff.credit
"gi_banks_diff.credit" "Trans Cr" ? "decimal" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_banks_diff.diff-debit
"gi_banks_diff.diff-debit" ? ? "decimal" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_banks_diff.amt-cr
"gi_banks_diff.amt-cr" "Bank Cr" ? "decimal" ? ? ? ? ? ? no ? no no "13.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_banks_diff.debit
"gi_banks_diff.debit" "Trans Db" ? "decimal" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   = giph.gi_banks_diff.diff-credit
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-5
/* Query rebuild information for BROWSE BROWSE-5
     _TblList          = "giph.gi_acc_det,giph.gi_acc_hea OF giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "giph.gi_acc_det.refdate|yes"
     _Where[1]         = "gi_acc_det.acc-led-name = pbank-des
 AND gi_acc_det.amount = ptran-amount
"
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_hea.vouchertype
"gi_acc_hea.vouchertype" ? ? "character" ? ? ? ? ? ? no ? no no "4.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.refdate
"gi_acc_det.refdate" "Refdate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.bank-cons
"gi_acc_det.bank-cons" "BankCons" ? "integer" ? ? ? ? ? ? no ? no no "7.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.alias-name
"gi_acc_det.alias-name" ? ? "character" ? ? ? ? ? ? no ? no no "6.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "11.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? no ? no no "19.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-5 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Summary Banks */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Summary Banks */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Bank Statement */
DO:
      IF AVAILABLE gi_data_banks THEN DO:
          ASSIGN pbank-cons = gi_data_banks.bank-cons.
        ASSIGN pparty-name = gi_data_banks.party-name
               pyearmonthfn = gi_data_banks.yearmonthfn
               pyearmonth = gi_data_banks.yearmonth
               pbank-des = gi_data_banks.bank-des
               ptran-refnum1 = gi_data_banks.tran-refnum1
               prefnum1 = gi_data_banks.refnum1
               pdate-cleared = gi_data_banks.date-cleared
               pdate-issue = gi_data_banks.date-issue
               ptran-amount = gi_data_banks.amt-db + gi_data_banks.amt-cr
               
            .
        ASSIGN wtally-response:SCREEN-VALUE = gi_data_banks.tally-response.
        IF pbank-code = "BDO_Dollar" THEN DO:
            ASSIGN ptran-amount = gi_data_banks.conv-val.
        END.
        ASSIGN wtally-response:SCREEN-VALUE = gi_data_banks.tally-response.

    END.
    ELSE DO:
        ASSIGN pparty-name = ?
               pyearmonthfn = ?
               pbank-des = ?
               pdate-cleared = ?
               pdate-issue = ?
               pbank-des = ?
               pyearmonth = ?
            .
        ASSIGN pbank-cons = 0.
        ASSIGN wtally-response:SCREEN-VALUE = "".
    END.
 

    DEF VAR ptrans-refnum1-amt AS DEC.
    ASSIGN ptrans-refnum1-amt = 0.

    FOR EACH b_gi_data_banks WHERE b_gi_data_banks.bank-code = pbank-code
                               AND b_gi_data_banks.tran-refnum1 = ptran-refnum1 NO-LOCK:
            ASSIGN ptrans-refnum1-amt = ptrans-refnum1-amt - b_gi_data_banks.amt-cr.
    END.
    ASSIGN wtrans-amt-txt:SCREEN-VALUE = ptran-refnum1 + " " + STRING(ptrans-refnum1-amt,"->>,>>>,>>>,>>9.99").


    /*ASSIGN BROWSE-2:TITLE = "Transaction : " + pbank-des. */
    {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2.  

    {&OPEN-QUERY-BROWSE-4}
    APPLY "Value-Changed" TO BROWSE-4.  
                             
    {&OPEN-QUERY-BROWSE-5}
    APPLY "Value-Changed" TO BROWSE-5.  
                             

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 wWin
ON VALUE-CHANGED OF BROWSE-2 IN FRAME fMain /* Transaction Details */
DO:
  
  IF AVAILABLE gi_acc_det THEN DO:
        ASSIGN prefnum1-a = gi_acc_det.refnum1.      
        
  END.
  ELSE DO: 
      ASSIGN prefnum1-a = ?.      
  END.

  {&OPEN-QUERY-BROWSE-3}
  APPLY "Value-Changed" TO BROWSE-3.  
  /*
  {&OPEN-QUERY-BROWSE-5}
  APPLY "Value-Changed" TO BROWSE-5.  
  ASSIGN browse-5:TITLE = pacc-led-name.
      */
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


&Scoped-define BROWSE-NAME BROWSE-5
&Scoped-define SELF-NAME BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-5 wWin
ON VALUE-CHANGED OF BROWSE-5 IN FRAME fMain /* Transaction Details (Amount wise) */
DO:
  
  IF AVAILABLE gi_acc_det THEN DO:
        ASSIGN prefnum1-a = gi_acc_det.refnum1.      
        
  END.
  ELSE DO: 
      ASSIGN prefnum1-a = ?.      
  END.

  {&OPEN-QUERY-BROWSE-3}
  APPLY "Value-Changed" TO BROWSE-3.  
  /*
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
  DEF VAR r AS INT.
  SESSION:SET-WAIT-STATE("GENERAL").
  APPLY "Choose" TO BtnSearch.

  MESSAGE "Export the data to Tally?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  
  ASSIGN r = 0 n = 0.
  IF choice THEN DO:
     /* RUN c:\pvr\giph\lib\create_tally_voucher_journal_bus.p.*/

      FOR EACH b_gi_data_banks WHERE b_gi_data_banks.YearMonthFn MATCHES wYearMonthFn
                                 AND b_gi_data_banks.tran-refnum1 = ""
                                 AND b_gi_data_banks.bank-cons > 0
                                 AND b_gi_data_banks.bank-code = pbank-code
                                 AND b_gi_data_banks.lastvchid = 0
          BREAK BY b_gi_data_banks.YearMonth
                BY b_gi_data_banks.bank-cons:
          ASSIGN n = n + 1.
          ASSIGN r = r + 1.
          ASSIGN pbank-cons = b_gi_data_banks.bank-cons.


          RUN c:\pvr\giph\lib\create_tally_voucher_bank_statements.p.

          RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_banks.LastVchId, OUTPUT b_gi_data_banks.tally-response).

          MESSAGE b_gi_data_banks.bank-cons 
              b_gi_data_banks.YearMonthFn
              "VchID" b_gi_data_banks.LastVchId. PAUSE 0.
          
              /*
          IF r = 5 THEN DO:
              LEAVE.
          END.
          */
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
      IF pbank-code = "Aub" THEN RUN c:\pvr\giph\lib\import_bank_data_aub.p.
      IF pbank-code = "BDO_Disbursement" THEN RUN c:\pvr\giph\lib\import_bank_data_bdo_dis.p.
      IF pbank-code = "BDO_Dollar" THEN RUN c:\pvr\giph\lib\import_bank_data_bdo_dollar.p.
      IF pbank-code = "BDO_TopUp" THEN RUN c:\pvr\giph\lib\import_bank_data_bdo_topup.p.
      IF pbank-code = "BPI" THEN RUN c:\pvr\giph\lib\import_bank_data_bpi.p.
      IF pbank-code = "Metrobank" THEN RUN c:\pvr\giph\lib\import_bank_data_metrobank.p.
      IF pbank-code = "PNB" THEN RUN c:\pvr\giph\lib\import_bank_data_pnb.p.
      IF pbank-code = "Security" THEN RUN c:\pvr\giph\lib\import_bank_data_security.p.
      IF pbank-code = "UCPB_Disbursement" THEN RUN c:\pvr\giph\lib\import_bank_data_ucpb_dis.p.
      IF pbank-code = "UCPB_Recon" THEN RUN c:\pvr\giph\lib\import_bank_data_ucpb_recon.p.
      IF pbank-code = "UCPB_TopUp" THEN RUN c:\pvr\giph\lib\import_bank_data_ucpb_topup.p.

  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnOpenExcelFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnOpenExcelFile wWin
ON CHOOSE OF BtnOpenExcelFile IN FRAME fMain /* Open Excel */
DO:

    DEF VAR pcom-name AS CHAR.

      IF pbank-code = "Aub"                 THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\aub_bank.xlsm".
      IF pbank-code = "BDO_Disbursement"    THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\bdo_disbursement.xlsm".
      IF pbank-code = "BDO_Dollar"          THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\bdo_dollar.xlsm".
      IF pbank-code = "BDO_TopUp"           THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\bdo_topup.xlsm".
      IF pbank-code = "BPI"                 THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\bpi.xlsm".
      IF pbank-code = "Metrobank"           THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\metrobank.xlsm".
      IF pbank-code = "PNB"                 THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\pnb.xlsm".
      IF pbank-code = "Security"            THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\security.xlsm".
      IF pbank-code = "UCPB_Disbursement"   THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\ucpb_disbursement.xlsm".
      IF pbank-code = "UCPB_Recon"          THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\ucpb_recon.xlsm".
      IF pbank-code = "UCPB_TopUp"          THEN pcom-name = "Start excel.exe" + " C:\pvr\giph\RawData-BankStatements\ucpb_topup.xlsm".

      OS-COMMAND NO-WAIT VALUE(pcom-name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnProcessDiffSummaryAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnProcessDiffSummaryAll wWin
ON CHOOSE OF BtnProcessDiffSummaryAll IN FRAME fMain /* Process Diff Sum (All) */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  /*ASSIGN pyearmonth = pyearmonthfn.*/
  ASSIGN preport-type = 9.

  RUN c:\pvr\giph\lib\bank_diff.p.
  SESSION:SET-WAIT-STATE("").
  APPLY "Value-Changed" TO BROWSE-1.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnProcessDiffSummarySelected
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnProcessDiffSummarySelected wWin
ON CHOOSE OF BtnProcessDiffSummarySelected IN FRAME fMain /* Process Diff Sum (Selected) */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  /*ASSIGN pyearmonth = pyearmonthfn.*/
  ASSIGN preport-type = 1.

  RUN c:\pvr\giph\lib\bank_diff.p.
  SESSION:SET-WAIT-STATE("").
  APPLY "Value-Changed" TO BROWSE-1.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnReportDiffSummaryAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnReportDiffSummaryAll wWin
ON CHOOSE OF BtnReportDiffSummaryAll IN FRAME fMain /* Report Diff Summary All */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  ASSIGN preport-type = 9.
  RUN c:\pvr\giph\rpt\Report-BankDiff.p.
  SESSION:SET-WAIT-STATE("").
  APPLY "Value-Changed" TO BROWSE-1.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnReportDiffSummarySelected
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnReportDiffSummarySelected wWin
ON CHOOSE OF BtnReportDiffSummarySelected IN FRAME fMain /* Report Diff Summary Selected */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  ASSIGN preport-type = 1.
  RUN c:\pvr\giph\rpt\Report-BankDiff.p.
  SESSION:SET-WAIT-STATE("").
  APPLY "Value-Changed" TO BROWSE-1.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearch wWin
ON CHOOSE OF BtnSearch IN FRAME fMain /* Search */
DO:
  ASSIGN wYearMonthFN = "*" +  wYearMonthFN:SCREEN-VALUE + "*".
  ASSIGN wParty-Name = "*" +  wParty-Name:SCREEN-VALUE + "*".
  ASSIGN wtran-refnum1 = "*" +  wtran-refnum1:SCREEN-VALUE + "*".
  ASSIGN wbank-cons = INT(wbank-cons:SCREEN-VALUE).
  ASSIGN wdate-ini = DATE(wdate-ini:SCREEN-VALUE).
  ASSIGN wdate-fin = DATE(wdate-fin:SCREEN-VALUE).


  IF pbank-code = "Aub" THEN wbank-des:SCREEN-VALUE = "AUB 542-01-000011-3".
  IF pbank-code = "BDO_Disbursement" THEN wbank-des:SCREEN-VALUE = "BDO S/A PHP 260116895".
  IF pbank-code = "BDO_Dollar" THEN wbank-des:SCREEN-VALUE = "BDO S/A USD" .
  IF pbank-code = "BDO_TopUp" THEN wbank-des:SCREEN-VALUE = "BDO C/A PHP 2620105923" .
  IF pbank-code = "BPI" THEN wbank-des:SCREEN-VALUE = "BPI C/A 3793-0388-19" .
  IF pbank-code = "Metrobank" THEN wbank-des:SCREEN-VALUE = "MBTC S/A PHP 7019516004" .
  IF pbank-code = "PNB" THEN wbank-des:SCREEN-VALUE = "PNB S/A PHP" .
  IF pbank-code = "Security" THEN wbank-des:SCREEN-VALUE = "Security Bank C/A Php" .
  IF pbank-code = "UCPB_Disbursement" THEN wbank-des:SCREEN-VALUE = "UCPB C/A PHP 201120001328" .
  IF pbank-code = "UCPB_Recon" THEN wbank-des:SCREEN-VALUE = "" .
  IF pbank-code = "UCPB_TopUp" THEN wbank-des:SCREEN-VALUE = "UCPB S/A PHP 101120011925" .


  RUN Calculate_Total.
  ASSIGN browse-1:TITLE = "Bank Statement of: " + pbank-code + " From " + STRING(wdate-ini) + " To: " + STRING(wdate-fin) .
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

    ASSIGN 
        pbank-cons-ini = 1
        pbank-cons-fin = 999999999.

      IF pbank-code = "Aub" THEN RUN c:\pvr\giph\lib\validate_bank_data_aub.p.
      IF pbank-code = "BDO_Disbursement" THEN RUN c:\pvr\giph\lib\validate_bank_data_bdo_dis.p.
      IF pbank-code = "BDO_Dollar" THEN RUN c:\pvr\giph\lib\validate_bank_data_bdo_dollar.p.
      IF pbank-code = "BDO_TopUp" THEN RUN c:\pvr\giph\lib\validate_bank_data_bdo_topup.p.
      IF pbank-code = "BPI" THEN RUN c:\pvr\giph\lib\validate_bank_data_bpi.p.
      IF pbank-code = "Metrobank" THEN RUN c:\pvr\giph\lib\validate_bank_data_metrobank.p.
      IF pbank-code = "PNB" THEN RUN c:\pvr\giph\lib\validate_bank_data_pnb.p.
     IF pbank-code = "Security" THEN RUN c:\pvr\giph\lib\validate_bank_data_security.p.
      /*IF pbank-code = "Security" THEN RUN c:\pvr\giph\lib\validate_bank_data_security-testing.p.*/
      IF pbank-code = "UCPB_Disbursement" THEN RUN c:\pvr\giph\lib\validate_bank_data_ucpb_dis.p.
      IF pbank-code = "UCPB_Recon" THEN RUN c:\pvr\giph\lib\validate_bank_data_ucpb_recon.p.
      IF pbank-code = "UCPB_TopUp" THEN RUN c:\pvr\giph\lib\validate_bank_data_ucpb_topup.p.

  END.
  SESSION:SET-WAIT-STATE("").
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 wWin
ON CHOOSE OF BUTTON-1 IN FRAME fMain /* Auto Assign */
DO:
  RUN c:\pvr\giph\lib\auto_assign_bank_deposits.p.
    APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Bank_Transaction
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Bank_Transaction wWin
ON CHOOSE OF MENU-ITEM m_Create_Bank_Transaction /* Create Bank Transaction */
DO:
      DO WITH FRAME {&FRAME-NAME}:
        
    END.
  
  IF AVAILABLE gi_data_banks THEN DO:
     ASSIGN pbank-cons = gi_data_banks.bank-cons.
  END.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_iata.p.*/

  SESSION:SET-WAIT-STATE("GENERAL").
  RUN c:\pvr\giph\lib\create_tally_voucher_bank_statements.p.
  /*RUN C:\pvr\giph\lib\create_tally_voucher_journal_bus_partyname.p.*/

  FIND b_gi_data_banks WHERE b_gi_data_banks.bank-cons = pbank-cons NO-ERROR.
  IF AVAILABLE b_gi_data_banks THEN DO:
      RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_data_banks.LastVchId, OUTPUT b_gi_data_banks.tally-response).
  END.

  APPLY "Value-Changed" TO BROWSE-1.  
  SESSION:SET-WAIT-STATE("").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Validata_Bank_Data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Validata_Bank_Data wWin
ON CHOOSE OF MENU-ITEM m_Validata_Bank_Data /* Validata Bank Data */
DO:
    ASSIGN 
        pbank-cons-ini = pbank-cons
        pbank-cons-fin = pbank-cons.
           
  IF pbank-code = "Aub" THEN RUN c:\pvr\giph\lib\validate_bank_data_aub.p.
  IF pbank-code = "BDO_Disbursement" THEN RUN c:\pvr\giph\lib\validate_bank_data_bdo_dis.p.
  IF pbank-code = "BDO_Dollar" THEN RUN c:\pvr\giph\lib\validate_bank_data_bdo_dollar.p.
  IF pbank-code = "BDO_TopUp" THEN RUN c:\pvr\giph\lib\validate_bank_data_bdo_topup.p.
  IF pbank-code = "BPI" THEN RUN c:\pvr\giph\lib\validate_bank_data_bpi.p.
  IF pbank-code = "Metrobank" THEN RUN c:\pvr\giph\lib\validate_bank_data_metrobank.p.
  IF pbank-code = "PNB" THEN RUN c:\pvr\giph\lib\validate_bank_data_pnb.p.
  IF pbank-code = "Security" THEN RUN c:\pvr\giph\lib\validate_bank_data_security.p.
  IF pbank-code = "UCPB_Disbursement" THEN RUN c:\pvr\giph\lib\validate_bank_data_ucpb_dis.p.
  IF pbank-code = "UCPB_Recon" THEN RUN c:\pvr\giph\lib\validate_bank_data_ucpb_recon.p.
  IF pbank-code = "UCPB_TopUp" THEN RUN c:\pvr\giph\lib\validate_bank_data_ucpb_topup.p.

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


&Scoped-define SELF-NAME wbank-code
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wbank-code wWin
ON VALUE-CHANGED OF wbank-code IN FRAME fMain
DO:
  ASSIGN pbank-code = wbank-code:SCREEN-VALUE.
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wbank-cons
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wbank-cons wWin
ON LEAVE OF wbank-cons IN FRAME fMain /* Cons */
DO:
    APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wdate-fin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wdate-fin wWin
ON LEAVE OF wdate-fin IN FRAME fMain /* To */
DO:
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wdate-ini
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wdate-ini wWin
ON LEAVE OF wdate-ini IN FRAME fMain /* Date From */
DO:
  APPLY "Choose" TO BtnSearch.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wHasTransaction
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wHasTransaction wWin
ON VALUE-CHANGED OF wHasTransaction IN FRAME fMain
DO:
    ASSIGN wHasTransaction = INT(SELF:SCREEN-VALUE).
  

  APPLY "Choose" TO BtnSearch.
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


&Scoped-define SELF-NAME wRefNumType
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wRefNumType wWin
ON VALUE-CHANGED OF wRefNumType IN FRAME fMain
DO:
  ASSIGN wRefNumType = INT(SELF:SCREEN-VALUE).
  {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2. 
  /*
      APPLY "Choose" TO BtnSearch.
      */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wShowTransaction
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wShowTransaction wWin
ON CHOOSE OF wShowTransaction IN FRAME fMain /* Show/Hide Trans */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        
    END.

    IF pshowtrans = 1 THEN DO:
        BROWSE-5:HIDDEN = TRUE.
        browse-5:MOVE-TO-BOTTOM().
        pshowtrans = 0.
    END.
    ELSE DO:
        pshowtrans = 1.
        BROWSE-5:HIDDEN = FALSE.
        browse-5:MOVE-TO-TOP().
        

    
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wTallyStatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wTallyStatus wWin
ON CHOOSE OF wTallyStatus IN FRAME fMain /* Tally Status */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        
    END.

    IF ptallystatus = 1 THEN DO:
        
        wtally-response:HIDDEN = TRUE.
        wtally-response:MOVE-TO-BOTTOM().
        ptallystatus = 0.
    END.
    ELSE DO:
        ptallystatus = 1.
        wtally-response:HIDDEN = FALSE.
        wtally-response:MOVE-TO-TOP().
        

    
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wtran-refnum1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wtran-refnum1 wWin
ON ANY-PRINTABLE OF wtran-refnum1 IN FRAME fMain /* Tran Refnum1 */
OR "Backspace" OF wTran-Refnum1 DO:

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wtran-refnum1 wWin
ON LEAVE OF wtran-refnum1 IN FRAME fMain /* Tran Refnum1 */
DO:
  APPLY "Choose" TO BtnSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wTransactions
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wTransactions wWin
ON CHOOSE OF wTransactions IN FRAME fMain /* Transactions */
DO:
  RUN c:\pvr\giph\obj\wtransactions.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wYearMonth1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wYearMonth1 wWin
ON VALUE-CHANGED OF wYearMonth1 IN FRAME fMain
DO:
  ASSIGN wyearmonthfn:SCREEN-VALUE = SELF:SCREEN-VALUE.

  IF SELF:SCREEN-VALUE = "2019" THEN DO:
     ASSIGN pyearmonth1 = "*2019*".
  END.
  ELSE
  ASSIGN pyearmonth1 = SELF:SCREEN-VALUE.


  IF SELF:SCREEN-VALUE = "2019-01" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(01/01/2019) wdate-fin:SCREEN-VALUE = string(01/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-02" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(02/01/2019) wdate-fin:SCREEN-VALUE = string(02/28/2019). END.
  IF SELF:SCREEN-VALUE = "2019-03" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(03/01/2019) wdate-fin:SCREEN-VALUE = string(03/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-04" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(04/01/2019) wdate-fin:SCREEN-VALUE = string(04/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-05" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(05/01/2019) wdate-fin:SCREEN-VALUE = string(05/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-06" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(06/01/2019) wdate-fin:SCREEN-VALUE = string(06/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-07" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(07/01/2019) wdate-fin:SCREEN-VALUE = string(07/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-08" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(08/01/2019) wdate-fin:SCREEN-VALUE = string(08/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-09" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(09/01/2019) wdate-fin:SCREEN-VALUE = string(09/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-10" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(10/01/2019) wdate-fin:SCREEN-VALUE = string(10/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-11" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(11/01/2019) wdate-fin:SCREEN-VALUE = string(11/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-12" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(12/01/2019) wdate-fin:SCREEN-VALUE = string(12/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019" THEN DO: ASSIGN wdate-ini:SCREEN-VALUE = string(01/01/2019) wdate-fin:SCREEN-VALUE = string(12/31/2019). END.

  /*APPLY "Choose" TO BtnSearchRef.*/

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Calculate_Total wWin 
PROCEDURE Calculate_Total :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR ptot-amt-db AS DEC.
DEF VAR ptot-amt-cr AS DEC.
DEF VAR ptot-amt-bal AS DEC.
DEF VAR ptot-amt-diff AS DEC.
DEF VAR pcount AS INT.

DO WITH FRAME {&FRAME-NAME}:
END.
ASSIGN 
    ptot-amt-db = 0
    ptot-amt-cr = 0
    ptot-amt-bal = 0
    ptot-amt-diff = 0
    pcount = 0
    .


      



FOR EACH b_gi_data_banks WHERE
    b_gi_data_banks.YearMonthFN MATCHES wYearMonthFn
     AND b_gi_data_banks.party-name MATCHES wParty-Name
     AND b_gi_data_banks.bank-code MATCHES pbank-code
     AND (wbank-cons > 0 and b_gi_data_banks.bank-cons = wbank-cons OR
          wbank-cons = 0 and b_gi_data_banks.bank-cons > 0)
     AND (
    (wHasTransaction = 1 and b_gi_data_banks.tran-refnum1 <> "") OR
    (wHasTransaction = 2 and b_gi_data_banks.tran-refnum1 = "") OR
    (wHasTransaction = 9 ) 
    )
     AND b_gi_data_banks.tran-refnum1 MATCHES wtran-refnum1
            AND b_gi_data_banks.date-cleared >= wdate-ini
            AND b_gi_data_banks.date-cleared <= wdate-fin 
        NO-LOCK :

    ASSIGN ptot-amt-db = ptot-amt-db + b_gi_data_banks.amt-db.
    ASSIGN ptot-amt-cr = ptot-amt-cr + b_gi_data_banks.amt-cr.
    ASSIGN pcount = pcount + 1.

END.
ASSIGN ptot-amt-diff = ptot-amt-db - ptot-amt-cr.

ASSIGN wtot-amt-db:SCREEN-VALUE = STRING(ptot-amt-db).
ASSIGN wtot-amt-cr:SCREEN-VALUE = STRING(ptot-amt-cr).
ASSIGN wtot-amt-diff:SCREEN-VALUE = STRING(ptot-amt-diff).
ASSIGN wcount:SCREEN-VALUE = STRING(pcount).
  
ASSIGN wamt-db = 0 wamt-cr = 0 wamt-db-cr-diff = 0.
FOR EACH b_gi_data_banks
      WHERE b_gi_data_banks.YearMonth MATCHES pYearMonth
        AND b_gi_data_banks.bank-code MATCHES pbank-code NO-LOCK:

    ASSIGN wamt-db = wamt-db + b_gi_data_banks.amt-db.
    ASSIGN wamt-cr = wamt-cr + b_gi_data_banks.amt-cr.
END.
ASSIGN wamt-db-cr-diff = wamt-db - wamt-cr.
ASSIGN wamt-db:SCREEN-VALUE = STRING(wamt-db).
ASSIGN wamt-cr:SCREEN-VALUE = STRING(wamt-cr).
ASSIGN wamt-db-cr-diff:SCREEN-VALUE = STRING(wamt-db-cr-diff).

ASSIGN wdebit = 0 wcredit = 0 wdebit-credit-diff = 0.
FOR EACH b_gi_acc_det WHERE b_gi_acc_det.YearMonth = pYearMonth
                        AND b_gi_acc_det.acc-led-name = pbank-des NO-LOCK, 
    EACH b_gi_acc_hea OF b_gi_acc_det NO-LOCK:
    ASSIGN wdebit = wdebit + b_gi_acc_det.debit.
    ASSIGN wcredit = wcredit + b_gi_acc_det.credit.

END. /* for each GI_ACC_DET */
ASSIGN wdebit-credit-diff = wdebit - wcredit.
ASSIGN wdebit:SCREEN-VALUE = STRING(wdebit).
ASSIGN wcredit:SCREEN-VALUE = STRING(wcredit).
ASSIGN wdebit-credit-diff:SCREEN-VALUE = STRING(wdebit-credit-diff).


ASSIGN wdiff-db = wamt-db - wcredit.
ASSIGN wdiff-cr = wamt-cr - wdebit.
ASSIGN wdiff-db:SCREEN-VALUE = STRING(wdiff-db).
ASSIGN wdiff-cr:SCREEN-VALUE = STRING(wdiff-cr).



    /*
wmonthly-trans-amt-txt
      */
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
  DISPLAY wdate-ini wdate-fin wYearMonth1 wyearmonthfn wbank-cons wParty-Name 
          wtran-refnum1 wHasTransaction wbank-code wbank-des wtrans-amt-txt 
          wtot-amt-diff wtot-amt-db wtot-amt-cr wcount wRefNumType 
          wtally-response wamt-db wamt-cr wamt-db-cr-diff wcredit wdebit 
          wdebit-credit-diff wdiff-db wdiff-cr 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wdate-ini wdate-fin BUTTON-1 wTallyStatus wShowTransaction wYearMonth1 
         BtnSearch wyearmonthfn wbank-cons wParty-Name wtran-refnum1 BtnImport 
         BtnValidate BtnExport wHasTransaction wbank-code wTransactions 
         BtnOpenExcelFile BROWSE-1 wRefNumType BROWSE-2 BROWSE-5 BROWSE-3 
         BROWSE-4 BtnReportDiffSummaryAll BtnProcessDiffSummarySelected 
         BtnProcessDiffSummaryAll BtnReportDiffSummarySelected 
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
  ASSIGN wYearMonthFn:SCREEN-VALUE = "2019".
  ASSIGN wYearMonthFn = "*2019*".
  ASSIGN pyearmonth1 = "2019".
  ASSIGN pbank-code = "AUB".
  ASSIGN wbank-code:SCREEN-VALUE = pbank-code.
  ASSIGN wbank-cons = 0.
  ASSIGN wbank-cons:SCREEN-VALUE = "".
  ASSIGN wRefNumType = 3.
  ASSIGN wYearMonth1:SCREEN-VALUE = "2019".

  ASSIGN wHasTransaction = 9.
  ASSIGN wHasTransaction:SCREEN-VALUE = STRING(wHasTransaction).

  ASSIGN wParty-Name:SCREEN-VALUE = "".
  ASSIGN wParty-Name = "*".

  ASSIGN wtran-refnum1:SCREEN-VALUE = "".
  ASSIGN wtran-refnum1 = "*".
  
  wtally-response:MOVE-TO-BOTTOM().

  /*APPLY "Value-Changed" TO wyearmonthfn.*/
  APPLY "Value-Changed" TO wYearMonth1.
  APPLY "Choose" TO BtnSearch.

  /*
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

