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
DEF BUFFER b_gi_acc_det FOR gi_acc_det.
DEF BUFFER b1_gi_acc_det FOR gi_acc_det.
DEF NEW SHARED VAR poutput-filename AS CHAR.
DEF NEW SHARED VAR pLastVchId LIKE gi_acc_hea.LastVchId.
DEF NEW SHARED VAR pVoucherType LIKE gi_acc_hea.VoucherType.
DEF VAR prefdate AS DATE.

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
&Scoped-define INTERNAL-TABLES gi_acc_hea gi_acc_det gi_data_banks

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_acc_hea.refnum1 ~
gi_acc_hea.vouchertype gi_acc_hea.LastVchId gi_acc_hea.bank-cons ~
gi_acc_hea.refdate gi_acc_hea.refnum2 gi_acc_hea.IsContra gi_acc_hea.IsJV ~
gi_acc_hea.IsReceipt gi_acc_hea.IsPayment gi_acc_hea.IsSales ~
gi_acc_hea.IsPurchase gi_acc_hea.particulars gi_acc_hea.debit ~
gi_acc_hea.credit gi_acc_hea.dbcr-diff gi_acc_hea.amount 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_acc_hea.refnum1 ~
gi_acc_hea.vouchertype 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_acc_hea
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_acc_hea
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_acc_hea ~
      WHERE (giph.gi_acc_hea.refnum1 MATCHES wsearchref ~
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
 AND ( ~
(wbankstatement = 1 and gi_acc_hea.bank-cons > 0) OR ~
(wbankstatement = 2 and gi_acc_hea.bank-cons = 0) OR ~
(wbankstatement = 9 )  ~
) ~
 ~
 AND ( ~
(wvoucherid = 1 and gi_acc_hea.LastVchId > 0) OR ~
(wvoucherid = 2 and gi_acc_hea.LastVchId = 0) OR ~
(wvoucherid = 9 )  ~
) ~
  NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_acc_hea ~
      WHERE (giph.gi_acc_hea.refnum1 MATCHES wsearchref ~
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
 AND ( ~
(wbankstatement = 1 and gi_acc_hea.bank-cons > 0) OR ~
(wbankstatement = 2 and gi_acc_hea.bank-cons = 0) OR ~
(wbankstatement = 9 )  ~
) ~
 ~
 AND ( ~
(wvoucherid = 1 and gi_acc_hea.LastVchId > 0) OR ~
(wvoucherid = 2 and gi_acc_hea.LastVchId = 0) OR ~
(wvoucherid = 9 )  ~
) ~
  NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_acc_hea
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_acc_hea


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.refnum1-clean ~
gi_acc_det.reg gi_acc_det.bank-cons gi_acc_det.acc-led-name ~
gi_acc_det.partyname gi_acc_det.alias-name gi_acc_det.debit ~
gi_acc_det.credit gi_acc_det.cheque-num gi_acc_det.currency ~
gi_acc_det.forex-rate gi_acc_det.runbal1 gi_acc_det.runbal2 ~
gi_acc_det.amount gi_acc_det.refnum1 gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.acc-led-name ~
gi_acc_det.partyname gi_acc_det.alias-name gi_acc_det.debit ~
gi_acc_det.credit gi_acc_det.amount 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refnum1 = prefnum1 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refnum1 = prefnum1 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_acc_det


/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 gi_data_banks.bank-reg ~
gi_data_banks.bank-cons gi_data_banks.date-cleared ~
gi_data_banks.tran-refnum1 gi_data_banks.LastVchId gi_data_banks.amt-db ~
gi_data_banks.amt-cr gi_data_banks.amt-bal gi_data_banks.remarks ~
gi_data_banks.remarks1 gi_data_banks.ch-num gi_data_banks.refnum1 ~
gi_data_banks.refnum1a gi_data_banks.acc-origin ~
gi_data_banks.acc-destination gi_data_banks.acc-receiver ~
gi_data_banks.acc-payer gi_data_banks.narration gi_data_banks.YearMonthFN ~
gi_data_banks.YearMonth gi_data_banks.rate-exchange gi_data_banks.conv-val ~
gi_data_banks.ledger-db gi_data_banks.ledger-cr gi_data_banks.party-name ~
gi_data_banks.alias-name gi_data_banks.usd-amt-db gi_data_banks.usd-amt-cr ~
gi_data_banks.has-tran gi_data_banks.branch gi_data_banks.description ~
gi_data_banks.date-issue 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH gi_data_banks ~
      WHERE gi_data_banks.date-cleared = prefdate ~
 AND gi_data_banks.bank-des = pacc-led-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH gi_data_banks ~
      WHERE gi_data_banks.date-cleared = prefdate ~
 AND gi_data_banks.bank-des = pacc-led-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 gi_data_banks
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 gi_data_banks


/* Definitions for BROWSE BROWSE-5                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-5 gi_acc_det.partyname ~
gi_acc_det.refnum1 gi_acc_det.reg gi_acc_det.refdate gi_acc_det.bank-cons ~
gi_acc_det.debit gi_acc_det.credit gi_acc_det.cheque-num gi_acc_det.runbal1 ~
gi_acc_det.runbal2 gi_acc_det.amount gi_acc_det.particulars gi_acc_det.cons ~
gi_acc_det.currency gi_acc_det.forex-rate 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-5 
&Scoped-define QUERY-STRING-BROWSE-5 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.acc-led-name = pacc-led-name ~
 AND gi_acc_det.refdate >= wsearchrefdate1 ~
 AND gi_acc_det.refdate <= wsearchrefdate2 ~
 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-5 OPEN QUERY BROWSE-5 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.acc-led-name = pacc-led-name ~
 AND gi_acc_det.refdate >= wsearchrefdate1 ~
 AND gi_acc_det.refdate <= wsearchrefdate2 ~
 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-5 gi_acc_det
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-5 gi_acc_det


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wsearchref wsearchparticular wsearchrefdate1 ~
wsearchrefdate2 wlastVchId wvouchertype BtnSearchRef BtnSearchRef-2 ~
wExportSelected wExportAll wYearMonth1 wError wAssignBankCons wDataBanks ~
wbankstatement wvoucherid BROWSE-1 BROWSE-2 wtally-response wparticulars ~
BROWSE-3 BROWSE-5 
&Scoped-Define DISPLAYED-OBJECTS wsearchref wsearchparticular ~
wsearchrefdate1 wsearchrefdate2 wlastVchId wvouchertype wYearMonth1 wError ~
wbankstatement wvoucherid wtot-vou wtot-amt-diff wtot-amt-db wtot-amt-cr ~
wtally-response wparticulars 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Masters 
       MENU-ITEM m_Ledgers      LABEL "Ledgers"       
       MENU-ITEM m_Product      LABEL "Product"       
       MENU-ITEM m_Account_Groups LABEL "Account Groups"
       MENU-ITEM m_Party_Ledger LABEL "Party Ledger"  .

DEFINE SUB-MENU m_Data 
       MENU-ITEM m_Agent_Data   LABEL "Agent Data"    
       MENU-ITEM m_Summary_Airline_Data_-_IATA LABEL "Summary Airline Data - IATA"
       MENU-ITEM m_Summary_Airline_Data_-_Airl LABEL "Summary Airline Data - Airlines Name".

DEFINE SUB-MENU m_Tools 
       MENU-ITEM m_Fix_CSV_Files LABEL "Fix CSV Files" 
       MENU-ITEM m_Process_CSV_Files LABEL "Process CSV Files"
       MENU-ITEM m_Create_CSV_file LABEL "Create CSV file"
       MENU-ITEM m_Import_Data  LABEL "Import Data"   
       MENU-ITEM m_Create_Transaction_from_Raw LABEL "Create Transaction from Raw Data"
       MENU-ITEM m_Data_Validation LABEL "Data Validation"
       MENU-ITEM m_Export_to_BI LABEL "Export to BI"  .

DEFINE MENU MENU-BAR-wWin MENUBAR
       SUB-MENU  m_Masters      LABEL "Masters"       
       SUB-MENU  m_Data         LABEL "Data"          
       SUB-MENU  m_Tools        LABEL "Tools"         .

DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Voucher LABEL "Create Voucher"
       RULE
       MENU-ITEM m_Open_XML_File LABEL "Open XML File" .

DEFINE MENU POPUP-MENU-BROWSE-2 
       MENU-ITEM m_Add_Ledger   LABEL "Add Ledger"    
       MENU-ITEM m_Recalculate_Voucher_Total LABEL "Recalculate Voucher Total".


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnSearchRef 
     LABEL "<S>" 
     SIZE 4.86 BY .81 TOOLTIP "Search Reference"
     FONT 4.

DEFINE BUTTON BtnSearchRef-2 
     LABEL "<X>" 
     SIZE 4.86 BY .81 TOOLTIP "Cancel Search Reference"
     FONT 4.

DEFINE BUTTON wAssignBankCons 
     LABEL "Assign Bank Cons" 
     SIZE 14 BY .81 TOOLTIP "Assign bank cons to the blank (from the detail of bank transaction)"
     FONT 4.

DEFINE BUTTON wDataBanks 
     LABEL "Data Banks" 
     SIZE 11.29 BY .81
     FONT 4.

DEFINE BUTTON wExportAll 
     LABEL "Export All" 
     SIZE 14.29 BY .81
     FONT 4.

DEFINE BUTTON wExportSelected 
     LABEL "Export Selected" 
     SIZE 12 BY .81
     FONT 4.

DEFINE VARIABLE wvouchertype AS CHARACTER FORMAT "X(256)":U 
     LABEL "Vou. Type" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "All","Contra","Receipt","Payment","Journal","Sales","Purchase" 
     DROP-DOWN-LIST
     SIZE 13.29 BY 1 TOOLTIP "Voucher Type"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wparticulars AS CHARACTER 
     VIEW-AS EDITOR
     SIZE 131.57 BY 2 NO-UNDO.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 32.72 BY 10.92
     FONT 4 NO-UNDO.

DEFINE VARIABLE wlastVchId AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Vch Id" 
     VIEW-AS FILL-IN 
     SIZE 10.43 BY .81 TOOLTIP "Voucher ID"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchparticular AS CHARACTER FORMAT "X(256)":U 
     LABEL "Particular" 
     VIEW-AS FILL-IN 
     SIZE 17.57 BY .81 TOOLTIP "Search Particular"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchref AS CHARACTER FORMAT "X(256)":U 
     LABEL "Ref." 
     VIEW-AS FILL-IN 
     SIZE 11.72 BY .81 TOOLTIP "Search Reference"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchrefdate1 AS DATE FORMAT "99/99/9999":U 
     LABEL "Date From" 
     VIEW-AS FILL-IN 
     SIZE 9.86 BY .81 TOOLTIP "Search date"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wsearchrefdate2 AS DATE FORMAT "99/99/9999":U 
     LABEL "To" 
     VIEW-AS FILL-IN 
     SIZE 9.86 BY .81 TOOLTIP "Search date"
     FONT 4 NO-UNDO.

DEFINE VARIABLE wtot-amt-cr AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total Cr" 
     VIEW-AS FILL-IN 
     SIZE 23.72 BY 1
     BGCOLOR 20  NO-UNDO.

DEFINE VARIABLE wtot-amt-db AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total Db" 
     VIEW-AS FILL-IN 
     SIZE 23.72 BY 1
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE wtot-amt-diff AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     LABEL "Total Diff" 
     VIEW-AS FILL-IN 
     SIZE 23.72 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE wtot-vou AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Total Vouchers" 
     VIEW-AS FILL-IN 
     SIZE 21.57 BY 1
     BGCOLOR 16  NO-UNDO.

DEFINE VARIABLE wbankstatement AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"All", 9
     SIZE 15.29 BY .69
     FONT 4 NO-UNDO.

DEFINE VARIABLE wvoucherid AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"All", 9
     SIZE 15.29 BY .69
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
     SIZE 72.14 BY .77
     FONT 2 NO-UNDO.

DEFINE VARIABLE wError AS LOGICAL INITIAL no 
     LABEL "Error" 
     VIEW-AS TOGGLE-BOX
     SIZE 6.29 BY .77
     FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_acc_hea SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_acc_det SCROLLING.

DEFINE QUERY BROWSE-3 FOR 
      gi_data_banks SCROLLING.

DEFINE QUERY BROWSE-5 FOR 
      gi_acc_det SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_acc_hea.refnum1 COLUMN-LABEL "Ref. No" FORMAT "x(50)":U
            WIDTH 10.57
      gi_acc_hea.vouchertype COLUMN-LABEL "Vch.Type" FORMAT "x(8)":U
            WIDTH 9.43
      gi_acc_hea.LastVchId FORMAT "->>>>>>9":U COLUMN-FGCOLOR 9
      gi_acc_hea.bank-cons COLUMN-LABEL "Bank!Cons" FORMAT "->>>>>>9":U
            WIDTH 6.72 COLUMN-BGCOLOR 22
      gi_acc_hea.refdate COLUMN-LABEL "Date" FORMAT "99/99/9999":U
            WIDTH 9.86
      gi_acc_hea.refnum2 COLUMN-LABEL "Ref No 2" FORMAT "x(50)":U
            WIDTH 11.57
      gi_acc_hea.IsContra COLUMN-LABEL "Contra" FORMAT "yes/no":U
            WIDTH 4.57
      gi_acc_hea.IsJV FORMAT "yes/no":U WIDTH 4.14
      gi_acc_hea.IsReceipt FORMAT "yes/no":U
      gi_acc_hea.IsPayment FORMAT "yes/no":U WIDTH 6.29
      gi_acc_hea.IsSales COLUMN-LABEL "Sales" FORMAT "yes/no":U
            WIDTH 4.14
      gi_acc_hea.IsPurchase COLUMN-LABEL "Purc." FORMAT "yes/no":U
            WIDTH 4
      gi_acc_hea.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 33.43
      gi_acc_hea.debit COLUMN-LABEL "Debit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 10.72
      gi_acc_hea.credit COLUMN-LABEL "Credit" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 9.72
      gi_acc_hea.dbcr-diff FORMAT "->>>,>>>,>>9.99":U WIDTH 11.43
      gi_acc_hea.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
  ENABLE
      gi_acc_hea.refnum1
      gi_acc_hea.vouchertype
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 165 BY 7.15
         FONT 4
         TITLE "Transaction" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_acc_det.refnum1-clean COLUMN-LABEL "Refnum" FORMAT "x(50)":U
            WIDTH 11
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
      gi_acc_det.bank-cons COLUMN-LABEL "Bank!Cons" FORMAT "->>>>>>9":U
            COLUMN-BGCOLOR 22
      gi_acc_det.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(100)":U
            WIDTH 20.29
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 20.57
      gi_acc_det.alias-name FORMAT "x(100)":U WIDTH 15
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
      gi_acc_det.alias-name
      gi_acc_det.debit
      gi_acc_det.credit
      gi_acc_det.amount
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131.57 BY 8.77
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 wWin _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      gi_data_banks.bank-reg FORMAT "->>>>>>9":U
      gi_data_banks.bank-cons FORMAT "->>>>>>9":U
      gi_data_banks.date-cleared FORMAT "99/99/9999":U
      gi_data_banks.tran-refnum1 FORMAT "x(20)":U WIDTH 11.57
      gi_data_banks.LastVchId FORMAT "->>>>>>9":U
      gi_data_banks.amt-db FORMAT "->,>>>,>>>,>>9.99":U WIDTH 15.29
      gi_data_banks.amt-cr FORMAT "->,>>>,>>>,>>9.99":U
      gi_data_banks.amt-bal FORMAT "->,>>>,>>>,>>9.99":U
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
      gi_data_banks.alias-name FORMAT "x(100)":U
      gi_data_banks.usd-amt-db FORMAT "->,>>>,>>>,>>9.99":U COLUMN-FGCOLOR 9
      gi_data_banks.usd-amt-cr FORMAT "->,>>>,>>>,>>9.99":U COLUMN-FGCOLOR 9
      gi_data_banks.has-tran FORMAT "yes/no":U WIDTH 7.72
      gi_data_banks.branch FORMAT "x(50)":U WIDTH 10.14
      gi_data_banks.description FORMAT "x(50)":U WIDTH 15.86
      gi_data_banks.date-issue FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 90.57 BY 7.5
         FONT 4
         TITLE "Bank Statement" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-5 wWin _STRUCTURED
  QUERY BROWSE-5 NO-LOCK DISPLAY
      gi_acc_det.partyname COLUMN-LABEL "Party" FORMAT "x(100)":U
            WIDTH 19.86
      gi_acc_det.refnum1 COLUMN-LABEL "Ref" FORMAT "x(50)":U WIDTH 8.72
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U WIDTH 3
      gi_acc_det.refdate COLUMN-LABEL "RefDate" FORMAT "99/99/99":U
      gi_acc_det.bank-cons FORMAT "->>>>>>9":U WIDTH 6.29
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
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 73.57 BY 7.35
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wsearchref AT ROW 1.19 COL 4.72 COLON-ALIGNED WIDGET-ID 2
     wsearchparticular AT ROW 1.19 COL 27.14 COLON-ALIGNED WIDGET-ID 8
     wsearchrefdate1 AT ROW 1.19 COL 56 COLON-ALIGNED WIDGET-ID 10
     wsearchrefdate2 AT ROW 1.19 COL 69.72 COLON-ALIGNED WIDGET-ID 12
     wlastVchId AT ROW 1.19 COL 86.72 COLON-ALIGNED WIDGET-ID 26
     wvouchertype AT ROW 1.19 COL 107.86 COLON-ALIGNED WIDGET-ID 20
     BtnSearchRef AT ROW 1.19 COL 123.86 WIDGET-ID 4
     BtnSearchRef-2 AT ROW 1.19 COL 129 WIDGET-ID 6
     wExportSelected AT ROW 1.19 COL 134.14 WIDGET-ID 22
     wExportAll AT ROW 1.19 COL 146.86 WIDGET-ID 124
     wYearMonth1 AT ROW 2.19 COL 1.86 NO-LABEL WIDGET-ID 64
     wError AT ROW 2.19 COL 108 WIDGET-ID 18
     wAssignBankCons AT ROW 2.19 COL 141 WIDGET-ID 114
     wDataBanks AT ROW 2.19 COL 155.57 WIDGET-ID 54
     wbankstatement AT ROW 2.23 COL 90.43 NO-LABEL WIDGET-ID 108
     wvoucherid AT ROW 2.23 COL 124.86 NO-LABEL WIDGET-ID 118
     BROWSE-1 AT ROW 3.23 COL 1.86 WIDGET-ID 200
     wtot-vou AT ROW 10.54 COL 44 COLON-ALIGNED WIDGET-ID 116
     wtot-amt-diff AT ROW 10.54 COL 75.29 COLON-ALIGNED WIDGET-ID 58
     wtot-amt-db AT ROW 10.54 COL 108.29 COLON-ALIGNED WIDGET-ID 46
     wtot-amt-cr AT ROW 10.54 COL 141 COLON-ALIGNED WIDGET-ID 48
     BROWSE-2 AT ROW 11.77 COL 1.86 WIDGET-ID 300
     wtally-response AT ROW 11.77 COL 134 NO-LABEL WIDGET-ID 24
     wparticulars AT ROW 20.69 COL 1.86 NO-LABEL WIDGET-ID 16
     BROWSE-3 AT ROW 22.81 COL 2 WIDGET-ID 700
     BROWSE-5 AT ROW 22.92 COL 93.43 WIDGET-ID 600
     "VchId" VIEW-AS TEXT
          SIZE 5.43 BY .69 AT ROW 2.23 COL 118.86 WIDGET-ID 122
     "Bank Statement" VIEW-AS TEXT
          SIZE 15 BY .69 AT ROW 2.23 COL 74.86 WIDGET-ID 112
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 167.86 BY 29.42 WIDGET-ID 100.


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
         TITLE              = "Transactions"
         HEIGHT             = 29.42
         WIDTH              = 167.86
         MAX-HEIGHT         = 32.19
         MAX-WIDTH          = 228.57
         VIRTUAL-HEIGHT     = 32.19
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

ASSIGN {&WINDOW-NAME}:MENUBAR    = MENU MENU-BAR-wWin:HANDLE.
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
/* BROWSE-TAB BROWSE-1 wvoucherid fMain */
/* BROWSE-TAB BROWSE-2 wtot-amt-cr fMain */
/* BROWSE-TAB BROWSE-3 wparticulars fMain */
/* BROWSE-TAB BROWSE-5 BROWSE-3 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_hea.refnum1:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

ASSIGN 
       BROWSE-2:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-2:HANDLE
       BROWSE-2:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-3:NUM-LOCKED-COLUMNS IN FRAME fMain     = 8
       BROWSE-3:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-3:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-5:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-5:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-5:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       wparticulars:READ-ONLY IN FRAME fMain        = TRUE.

ASSIGN 
       wtally-response:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN wtot-amt-cr IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-amt-db IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-amt-diff IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-vou IN FRAME fMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_acc_hea"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "(giph.gi_acc_hea.refnum1 MATCHES wsearchref
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
 AND (
(wbankstatement = 1 and giph.gi_acc_hea.bank-cons > 0) OR
(wbankstatement = 2 and giph.gi_acc_hea.bank-cons = 0) OR
(wbankstatement = 9 ) 
)

 AND (
(wvoucherid = 1 and giph.gi_acc_hea.LastVchId > 0) OR
(wvoucherid = 2 and giph.gi_acc_hea.LastVchId = 0) OR
(wvoucherid = 9 ) 
)
 "
     _FldNameList[1]   > giph.gi_acc_hea.refnum1
"gi_acc_hea.refnum1" "Ref. No" ? "character" ? ? ? ? ? ? yes ? no no "10.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_hea.vouchertype
"gi_acc_hea.vouchertype" "Vch.Type" ? "character" ? ? ? ? ? ? yes ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_hea.LastVchId
"gi_acc_hea.LastVchId" ? ? "integer" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_hea.bank-cons
"gi_acc_hea.bank-cons" "Bank!Cons" ? "integer" 22 ? ? ? ? ? no ? no no "6.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_hea.refdate
"gi_acc_hea.refdate" "Date" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_hea.refnum2
"gi_acc_hea.refnum2" "Ref No 2" ? "character" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_hea.IsContra
"gi_acc_hea.IsContra" "Contra" ? "logical" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_hea.IsJV
"gi_acc_hea.IsJV" ? ? "logical" ? ? ? ? ? ? no ? no no "4.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = giph.gi_acc_hea.IsReceipt
     _FldNameList[10]   > giph.gi_acc_hea.IsPayment
"gi_acc_hea.IsPayment" ? ? "logical" ? ? ? ? ? ? no ? no no "6.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_hea.IsSales
"gi_acc_hea.IsSales" "Sales" ? "logical" ? ? ? ? ? ? no ? no no "4.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_hea.IsPurchase
"gi_acc_hea.IsPurchase" "Purc." ? "logical" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_hea.particulars
"gi_acc_hea.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "33.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_hea.debit
"gi_acc_hea.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "10.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_hea.credit
"gi_acc_hea.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "9.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_acc_hea.dbcr-diff
"gi_acc_hea.dbcr-diff" ? ? "decimal" ? ? ? ? ? ? no ? no no "11.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_acc_hea.amount
"gi_acc_hea.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_det.refnum1 = prefnum1"
     _FldNameList[1]   > giph.gi_acc_det.refnum1-clean
"gi_acc_det.refnum1-clean" "Refnum" ? "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.bank-cons
"gi_acc_det.bank-cons" "Bank!Cons" ? "integer" 22 ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? yes ? no no "20.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? yes ? no no "20.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.alias-name
"gi_acc_det.alias-name" ? ? "character" ? ? ? ? ? ? yes ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? yes ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? yes ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "4.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "giph.gi_data_banks"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "gi_data_banks.date-cleared = prefdate
 AND gi_data_banks.bank-des = pacc-led-name"
     _FldNameList[1]   = giph.gi_data_banks.bank-reg
     _FldNameList[2]   = giph.gi_data_banks.bank-cons
     _FldNameList[3]   = giph.gi_data_banks.date-cleared
     _FldNameList[4]   > giph.gi_data_banks.tran-refnum1
"gi_data_banks.tran-refnum1" ? ? "character" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = giph.gi_data_banks.LastVchId
     _FldNameList[6]   > giph.gi_data_banks.amt-db
"gi_data_banks.amt-db" ? ? "decimal" ? ? ? ? ? ? no ? no no "15.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = giph.gi_data_banks.amt-cr
     _FldNameList[8]   = giph.gi_data_banks.amt-bal
     _FldNameList[9]   > giph.gi_data_banks.remarks
"gi_data_banks.remarks" ? ? "character" ? ? ? ? ? ? no ? no no "13.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_data_banks.remarks1
"gi_data_banks.remarks1" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_data_banks.ch-num
"gi_data_banks.ch-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_data_banks.refnum1
"gi_data_banks.refnum1" ? ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_data_banks.refnum1a
"gi_data_banks.refnum1a" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_data_banks.acc-origin
"gi_data_banks.acc-origin" ? ? "character" ? ? ? ? ? ? no ? no no "28.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_data_banks.acc-destination
"gi_data_banks.acc-destination" ? ? "character" ? ? ? ? ? ? no ? no no "31.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > giph.gi_data_banks.acc-receiver
"gi_data_banks.acc-receiver" ? ? "character" ? ? ? ? ? ? no ? no no "24.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > giph.gi_data_banks.acc-payer
"gi_data_banks.acc-payer" ? ? "character" ? ? ? ? ? ? no ? no no "26.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_data_banks.narration
"gi_data_banks.narration" ? ? "character" ? ? ? ? ? ? no ? no no "35.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   = giph.gi_data_banks.YearMonthFN
     _FldNameList[20]   = giph.gi_data_banks.YearMonth
     _FldNameList[21]   = giph.gi_data_banks.rate-exchange
     _FldNameList[22]   = giph.gi_data_banks.conv-val
     _FldNameList[23]   > giph.gi_data_banks.ledger-db
"gi_data_banks.ledger-db" ? ? "character" ? ? ? ? ? ? no ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[24]   > giph.gi_data_banks.ledger-cr
"gi_data_banks.ledger-cr" ? ? "character" ? ? ? ? ? ? no ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[25]   > giph.gi_data_banks.party-name
"gi_data_banks.party-name" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[26]   = giph.gi_data_banks.alias-name
     _FldNameList[27]   > giph.gi_data_banks.usd-amt-db
"gi_data_banks.usd-amt-db" ? ? "decimal" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[28]   > giph.gi_data_banks.usd-amt-cr
"gi_data_banks.usd-amt-cr" ? ? "decimal" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[29]   > giph.gi_data_banks.has-tran
"gi_data_banks.has-tran" ? ? "logical" ? ? ? ? ? ? no ? no no "7.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[30]   > giph.gi_data_banks.branch
"gi_data_banks.branch" ? ? "character" ? ? ? ? ? ? no ? no no "10.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[31]   > giph.gi_data_banks.description
"gi_data_banks.description" ? ? "character" ? ? ? ? ? ? no ? no no "15.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[32]   = giph.gi_data_banks.date-issue
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-5
/* Query rebuild information for BROWSE BROWSE-5
     _TblList          = "giph.gi_acc_det"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_det.acc-led-name = pacc-led-name
 AND giph.gi_acc_det.refdate >= wsearchrefdate1
 AND giph.gi_acc_det.refdate <= wsearchrefdate2
"
     _FldNameList[1]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? no ? no no "19.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.refnum1
"gi_acc_det.refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.refdate
"gi_acc_det.refdate" "RefDate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.bank-cons
"gi_acc_det.bank-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "6.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "11.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "12.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.runbal1
"gi_acc_det.runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.runbal2
"gi_acc_det.runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.amount
"gi_acc_det.amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.particulars
"gi_acc_det.particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.cons
"gi_acc_det.cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.currency
"gi_acc_det.currency" ? ? "character" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.forex-rate
"gi_acc_det.forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "5.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-5 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Transactions */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Transactions */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Transaction */
DO:
  
    IF AVAILABLE gi_acc_hea THEN DO:
        ASSIGN prefnum1 = gi_acc_hea.refnum1.
        ASSIGN prefdate = gi_acc_hea.refdate.
        ASSIGN wtally-response:SCREEN-VALUE = gi_acc_hea.tally-response.
       
    END.
    ELSE DO:
        ASSIGN prefnum1 = ?.
        ASSIGN prefdate = ?.
    END.
    {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2.  



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 wWin
ON VALUE-CHANGED OF BROWSE-2 IN FRAME fMain /* Transaction Details */
DO:
  IF AVAILABLE gi_acc_det THEN DO:
      ASSIGN wparticulars:SCREEN-VALUE = gi_acc_det.particulars.
      ASSIGN pacc-led-name = gi_acc_det.acc-led-name.

  END.
  ELSE 
  ASSIGN wparticulars:SCREEN-VALUE = ""
         pacc-led-name = "".

  {&OPEN-QUERY-BROWSE-3}
  APPLY "Value-Changed" TO BROWSE-3.  
  /*
  {&OPEN-QUERY-BROWSE-5}
  APPLY "Value-Changed" TO BROWSE-5.  
    */
  /*ASSIGN browse-5:TITLE = pacc-led-name.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
&Scoped-define SELF-NAME BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 wWin
ON VALUE-CHANGED OF BROWSE-3 IN FRAME fMain /* Bank Statement */
DO:
    /*
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
                             /*
    {&OPEN-QUERY-BROWSE-3}
    APPLY "Value-Changed" TO BROWSE-3.  
                               */
      */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-5
&Scoped-define SELF-NAME BROWSE-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-5 wWin
ON VALUE-CHANGED OF BROWSE-5 IN FRAME fMain /* Transaction Details */
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
    IF wlastVchId:SCREEN-VALUE = "" THEN DO:
        ASSIGN wlastVchId = ?.
    END.
    ELSE DO:
        ASSIGN wlastVchId = (wlastVchId:SCREEN-VALUE).
    END.
    ASSIGN wsearchparticular = "*" + wsearchparticular:SCREEN-VALUE + "*".
    ASSIGN wsearchrefdate1 = DATE(wsearchrefdate1:SCREEN-VALUE).
    ASSIGN wsearchrefdate2 = DATE(wsearchrefdate2:SCREEN-VALUE).
    ASSIGN pvouchertype = wvouchertype:SCREEN-VALUE.

    /*
    ASSIGN wLastVchId = wLastVchId:SCREEN-VALUE.
    ASSIGN pLastVchId = wLastVchId.
      */
    ASSIGN psearchrefdate1 = wsearchrefdate1.
    ASSIGN psearchrefdate2 = wsearchrefdate2.

    RUN CalcTotals.
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


&Scoped-define SELF-NAME m_Account_Groups
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Account_Groups wWin
ON CHOOSE OF MENU-ITEM m_Account_Groups /* Account Groups */
DO:
    RUN C:\pvr\giph\obj\waccountinggroups.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Add_Ledger
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Add_Ledger wWin
ON CHOOSE OF MENU-ITEM m_Add_Ledger /* Add Ledger */
DO:
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
    DEF VAR preg AS INT.
    ASSIGN preg = 0.
  IF AVAILABLE gi_acc_det THEN DO:
      FIND LAST b1_gi_acc_det WHERE gi_acc_det.refnum1 = prefnum1 USE-INDEX idx8 NO-LOCK NO-ERROR.
      IF AVAILABLE b1_gi_acc_det THEN DO:
          ASSIGN preg = b1_gi_acc_det.reg + 1.
      END.
      ELSE DO:
          ASSIGN preg = 1.
      END.


      CREATE b_gi_acc_det.
      ASSIGN b_gi_acc_det.reg = preg.
      BUFFER-COPY gi_acc_det EXCEPT reg acc-led-name
          TO b_gi_acc_det .
      ASSIGN b_gi_acc_det.is-forced = TRUE.
      ASSIGN b_gi_acc_det.acc-led-name = "Prepaid Expenses".
      
      APPLY "Value-Changed" TO BROWSE-1.  

      
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Agent_Data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Agent_Data wWin
ON CHOOSE OF MENU-ITEM m_Agent_Data /* Agent Data */
DO:
    RUN C:\pvr\giph\obj\wagent_account.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_CSV_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_CSV_file wWin
ON CHOOSE OF MENU-ITEM m_Create_CSV_file /* Create CSV file */
DO:
  /*RUN c:\pvr\giph\lib\ImportRawData_temp3.p.*/
  /*RUN c:\pvr\giph\lib\ImportRawData_temp2.p.*/
  RUN c:\pvr\giph\lib\ImportRawData_temp2a.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Transaction_from_Raw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Transaction_from_Raw wWin
ON CHOOSE OF MENU-ITEM m_Create_Transaction_from_Raw /* Create Transaction from Raw Data */
DO:
  
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Import accounting raw data?"            
  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
  TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\create_transactions_from_rawdata.p.
  END.
  SESSION:SET-WAIT-STATE("").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Voucher
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Voucher wWin
ON CHOOSE OF MENU-ITEM m_Create_Voucher /* Create Voucher */
DO:
    /*
  DEF VAR poutput-filename AS CHAR.
  ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucher-response.txt".
  FOR EACH b_gi_acc_hea WHERE b_gi_acc_hea.refdate >= wsearchrefdate1
                          AND b_gi_acc_hea.refdate <= wsearchrefdate2:
      ASSIGN prefnum1 = gi_acc_hea.refnum1.
  END. /* for each b_gi_acc_hea */
      */
  DO WITH FRAME {&FRAME-NAME}:
  END.
  IF AVAILABLE gi_acc_hea THEN DO:
      /*RUN CreateVoucher.*/
     IF gi_acc_hea.vouchertype = "Payment" OR 
        gi_acc_hea.vouchertype = "Receipt" OR
        gi_acc_hea.vouchertype = "Contra"  OR 
        gi_acc_hea.vouchertype = "Journal"  OR 
        gi_acc_hea.vouchertype = "Purchase" OR 
         gi_acc_hea.vouchertype = "Sales"  
          THEN DO:
        SESSION:SET-WAIT-STATE("GENERAL").
        IF gi_acc_hea.vouchertype = "Payment" THEN DO:
           RUN c:\pvr\giph\lib\CREATE_tally_voucher_payment.p.
        END.
        ELSE
        IF gi_acc_hea.vouchertype = "Receipt" THEN DO:
           RUN c:\pvr\giph\lib\CREATE_tally_voucher_receipt.p.
        END.
        ELSE
        IF gi_acc_hea.vouchertype = "Contra" THEN DO:
           RUN c:\pvr\giph\lib\CREATE_tally_voucher_contra.p.
        END.
        ELSE
        IF gi_acc_hea.vouchertype = "Journal" THEN DO:
           RUN c:\pvr\giph\lib\CREATE_tally_voucher_journal.p.
        END.
        ELSE
        IF gi_acc_hea.vouchertype = "Purchase" THEN DO:
           RUN c:\pvr\giph\lib\CREATE_tally_voucher_purchase.p.
        END.
        ELSE
        IF gi_acc_hea.vouchertype = "Sales" THEN DO:
           RUN c:\pvr\giph\lib\CREATE_tally_voucher_sales.p.
        END.

        FIND b_gi_acc_hea OF gi_acc_hea NO-ERROR.
        IF AVAILABLE b_gi_acc_hea THEN DO:
           RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_acc_hea.LastVchId, OUTPUT b_gi_acc_hea.tally-response).
           MESSAGE b_gi_acc_hea.refnum1 b_gi_acc_hea.refdate "VchID" b_gi_acc_hea.LastVchId. PAUSE 0.
        END.
        SESSION:SET-WAIT-STATE("").
        APPLY "Value-Changed" TO BROWSE-1. 
     END.
     ELSE DO:
         MESSAGE "Vouchertype " pvouchertype "is not configured to be exported to Tally"
             VIEW-AS ALERT-BOX INFO BUTTONS OK.
         RETURN NO-APPLY.

     END.

  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Data_Validation
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Data_Validation wWin
ON CHOOSE OF MENU-ITEM m_Data_Validation /* Data Validation */
DO:
  DO WITH FRAME {&FRAME-NAME}:
  END.
  SESSION:SET-WAIT-STATE("GENERAL").

  MESSAGE "Process data validation of accounting data?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN C:\pvr\giph\lib\data_validation.p.
      RUN c:\pvr\giph\lib\assign_year_month_gi_acc_hea.p.
  END.
  SESSION:SET-WAIT-STATE("").

  APPLY "Choose" TO BtnSearchRef.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Export_to_BI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Export_to_BI wWin
ON CHOOSE OF MENU-ITEM m_Export_to_BI /* Export to BI */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").

  MESSAGE "Export for BI?"            
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
      TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN C:\pvr\giph\lib\EXPORT_to_bi.p.
  END.

  SESSION:SET-WAIT-STATE("").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Fix_CSV_Files
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Fix_CSV_Files wWin
ON CHOOSE OF MENU-ITEM m_Fix_CSV_Files /* Fix CSV Files */
DO:
  MESSAGE "Open individual CSV files and " SKIP
       "remove the title of the ledger from the first row"
      VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Import_Data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Import_Data wWin
ON CHOOSE OF MENU-ITEM m_Import_Data /* Import Data */
DO:
  
  SESSION:SET-WAIT-STATE("GENERAL").
  MESSAGE "Import accounting raw data?"            
  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL                    
  TITLE "" UPDATE choice AS LOGICAL.
  IF choice THEN DO:
      RUN c:\pvr\giph\lib\ImportRawData.p.
      RUN c:\pvr\giph\lib\import_raw_data_assign_amounts.p.
  END.
  SESSION:SET-WAIT-STATE("").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Ledgers
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Ledgers wWin
ON CHOOSE OF MENU-ITEM m_Ledgers /* Ledgers */
DO:
  RUN C:\pvr\giph\obj\wledgers.w.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Open_XML_File
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Open_XML_File wWin
ON CHOOSE OF MENU-ITEM m_Open_XML_File /* Open XML File */
DO:
    DEF VAR pcom-name AS CHAR.
  ASSIGN pcom-name = "Start notepad.exe" + " C:\pvr\giph\tallylib\CreateVoucher.XML".
  OS-COMMAND SILENT VALUE(pcom-name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Party_Ledger
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Party_Ledger wWin
ON CHOOSE OF MENU-ITEM m_Party_Ledger /* Party Ledger */
DO:
  RUN C:\pvr\giph\obj\wledgerparty.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Process_CSV_Files
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Process_CSV_Files wWin
ON CHOOSE OF MENU-ITEM m_Process_CSV_Files /* Process CSV Files */
DO:
  /*RUN C:\pvr\giph\utility\read-folder-2.p.*/
  RUN C:\pvr\giph\utility\read-folder-2a.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Product wWin
ON CHOOSE OF MENU-ITEM m_Product /* Product */
DO:
    RUN C:\pvr\giph\obj\wproduct.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Recalculate_Voucher_Total
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Recalculate_Voucher_Total wWin
ON CHOOSE OF MENU-ITEM m_Recalculate_Voucher_Total /* Recalculate Voucher Total */
DO:
    DEF VAR ptot-amount LIKE gi_acc_hea.amount.
    DEF VAR ptot-credit LIKE gi_acc_hea.credit. 
    DEF VAR ptot-debit  LIKE gi_acc_hea.debit. 
    ASSIGN ptot-amount = 0
           ptot-credit = 0
           ptot-debit  = 0.

    DO WITH FRAME {&FRAME-NAME}:
        
    END.
  IF AVAILABLE gi_acc_det THEN DO:

      FOR EACH b_gi_acc_det WHERE b_gi_acc_det.refnum1 = prefnum1 :
          ASSIGN ptot-amount = ptot-amount + b_gi_acc_det.amount
                 ptot-credit = ptot-credit + b_gi_acc_det.credit 
                 ptot-debit  = ptot-debit  + b_gi_acc_det.debit. 
      END.

      FIND b_gi_acc_hea WHERE b_gi_acc_hea.refnum1 = prefnum1  NO-ERROR.
      IF AVAILABLE b_gi_acc_hea THEN DO:
           ASSIGN b_gi_acc_hea.amount = ptot-amount
                  b_gi_acc_hea.credit = ptot-credit
                  b_gi_acc_hea.debit  = ptot-debit.
           ASSIGN b_gi_acc_hea.dbcr-diff = b_gi_acc_hea.debit - b_gi_acc_hea.credit.
        END.
        {&OPEN-QUERY-BROWSE-1}
        APPLY "Value-Changed" TO BROWSE-1.  

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Summary_Airline_Data_-_Airl
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Summary_Airline_Data_-_Airl wWin
ON CHOOSE OF MENU-ITEM m_Summary_Airline_Data_-_Airl /* Summary Airline Data - Airlines Name */
DO:
    RUN C:\pvr\giph\obj\wdata_airline_name.w.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Summary_Airline_Data_-_IATA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Summary_Airline_Data_-_IATA wWin
ON CHOOSE OF MENU-ITEM m_Summary_Airline_Data_-_IATA /* Summary Airline Data - IATA */
DO:
      RUN C:\pvr\giph\obj\wdata_airline_iata.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wAssignBankCons
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wAssignBankCons wWin
ON CHOOSE OF wAssignBankCons IN FRAME fMain /* Assign Bank Cons */
DO:
  RUN c:\pvr\giph\lib\ASSIGN_gi_acc_hea_bank_cons.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wbankstatement
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wbankstatement wWin
ON VALUE-CHANGED OF wbankstatement IN FRAME fMain
DO:
    ASSIGN wbankstatement = INT(SELF:SCREEN-VALUE).
  

  APPLY "Choose" TO BtnSearchRef.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wDataBanks
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wDataBanks wWin
ON CHOOSE OF wDataBanks IN FRAME fMain /* Data Banks */
DO:
  RUN c:\pvr\giph\obj\wData_Banks.w.
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


&Scoped-define SELF-NAME wExportAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wExportAll wWin
ON CHOOSE OF wExportAll IN FRAME fMain /* Export All */
DO:
    DEF VAR n AS INT.
    APPLY "Choose" TO BtnSearchRef.

    DEF VAR i AS INT. 
    DO i = 1 TO 5:
       IF I = 1 THEN ASSIGN pvouchertype = "Contra".
       IF I = 2 THEN ASSIGN pvouchertype = "Receipt".
       IF I = 3 THEN ASSIGN pvouchertype = "Journal".
       IF I = 4 THEN ASSIGN pvouchertype = "Purchase".
       IF I = 5 THEN ASSIGN pvouchertype = "Payment".
       RUN c:\pvr\giph\lib\PROCESS_vouchers.p NO-ERROR.

    END.



             /*
    RUN c:\pvr\giph\lib\PROCESS_vouchers.p NO-ERROR.
    */

  /*
  SESSION:SET-WAIT-STATE("GENERAL").
  SESSION:SET-WAIT-STATE("").
    */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wExportSelected
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wExportSelected wWin
ON CHOOSE OF wExportSelected IN FRAME fMain /* Export Selected */
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


&Scoped-define SELF-NAME wsearchparticular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchparticular wWin
ON ANY-PRINTABLE OF wsearchparticular IN FRAME fMain /* Particular */
OR "Backspace" OF wsearchparticular DO:

    ASSIGN wsearchparticular = "*" + wsearchparticular:SCREEN-VALUE + "*".
    SESSION:SET-WAIT-STATE("General").

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    SESSION:SET-WAIT-STATE("").
    APPLY LAST-EVENT:LABEL TO SELF.
    RETURN NO-APPLY.

  
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

    /*
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    */
    SESSION:SET-WAIT-STATE("").

    APPLY LAST-EVENT:LABEL TO SELF.
    RETURN NO-APPLY.
  
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


&Scoped-define SELF-NAME wvoucherid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wvoucherid wWin
ON VALUE-CHANGED OF wvoucherid IN FRAME fMain
DO:
    ASSIGN wvoucherid = INT(SELF:SCREEN-VALUE).
  

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


&Scoped-define SELF-NAME wYearMonth1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wYearMonth1 wWin
ON VALUE-CHANGED OF wYearMonth1 IN FRAME fMain
DO:

  IF SELF:SCREEN-VALUE = "2019-01" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(01/01/2019) wsearchrefdate2:SCREEN-VALUE = string(01/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-02" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(02/01/2019) wsearchrefdate2:SCREEN-VALUE = string(02/28/2019). END.
  IF SELF:SCREEN-VALUE = "2019-03" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(03/01/2019) wsearchrefdate2:SCREEN-VALUE = string(03/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-04" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(04/01/2019) wsearchrefdate2:SCREEN-VALUE = string(04/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-05" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(05/01/2019) wsearchrefdate2:SCREEN-VALUE = string(05/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-06" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(06/01/2019) wsearchrefdate2:SCREEN-VALUE = string(06/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-07" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(07/01/2019) wsearchrefdate2:SCREEN-VALUE = string(07/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-08" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(08/01/2019) wsearchrefdate2:SCREEN-VALUE = string(08/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-09" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(09/01/2019) wsearchrefdate2:SCREEN-VALUE = string(09/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-10" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(10/01/2019) wsearchrefdate2:SCREEN-VALUE = string(10/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019-11" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(11/01/2019) wsearchrefdate2:SCREEN-VALUE = string(11/30/2019). END.
  IF SELF:SCREEN-VALUE = "2019-12" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(12/01/2019) wsearchrefdate2:SCREEN-VALUE = string(12/31/2019). END.
  IF SELF:SCREEN-VALUE = "2019" THEN DO: ASSIGN wsearchrefdate1:SCREEN-VALUE = string(01/01/2019) wsearchrefdate2:SCREEN-VALUE = string(12/31/2019). END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE CalcTotals wWin 
PROCEDURE CalcTotals :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN wtot-amt-db = 0 wtot-amt-cr = 0 wtot-amt-diff = 0 wtot-vou = 0.

DO WITH FRAME {&FRAME-NAME}:
END.


FOR EACH b_gi_acc_hea
      WHERE (b_gi_acc_hea.refnum1 MATCHES wsearchref
         OR b_gi_acc_hea.refnum2 MATCHES wsearchref) 
         and
        (INT(wLastVchId) > 0 AND b_gi_acc_hea.lastVchId = INT(wlastVchId)
         OR INT(wLastVchId) = 0 AND b_gi_acc_hea.lastVchId = 0
         OR INT(wLastVchId) = ? and b_gi_acc_hea.lastVchId <> ?
        ) 
        
         AND b_gi_acc_hea.refdate >= wsearchrefdate1
         AND b_gi_acc_hea.refdate <= wsearchrefdate2
         AND b_gi_acc_hea.particulars MATCHES wsearchparticular
         AND (
        (wvouchertype <> "All" AND b_gi_acc_hea.vouchertype = wvouchertype) 
        OR (wvouchertype = "All")
        )
        AND 
        ((werror = True and (b_gi_acc_hea.dbcr-diff > 0 
                           or b_gi_acc_hea.vouchertype = ""
         )
          OR werror = false))
         AND (
        (wbankstatement = 1 and b_gi_acc_hea.bank-cons > 0) OR
        (wbankstatement = 2 and b_gi_acc_hea.bank-cons = 0) OR
        (wbankstatement = 9 ) 
        )

         AND (
        (wvoucherid = 1 and b_gi_acc_hea.LastVchId > 0) OR
        (wvoucherid = 2 and b_gi_acc_hea.LastVchId = 0) OR
        (wvoucherid = 9 ) 
        )

          NO-LOCK :

    ASSIGN wtot-amt-db = wtot-amt-db + b_gi_acc_hea.debit.
    ASSIGN wtot-amt-cr = wtot-amt-cr + b_gi_acc_hea.credit.
    ASSIGN wtot-amt-diff = wtot-amt-diff + b_gi_acc_hea.dbcr-diff.
    ASSIGN wtot-vou = wtot-vou + 1.


END.

ASSIGN wtot-amt-db:SCREEN-VALUE = STRING(wtot-amt-db).
ASSIGN wtot-amt-cr:SCREEN-VALUE = STRING(wtot-amt-cr).
ASSIGN wtot-amt-diff:SCREEN-VALUE = STRING(wtot-amt-diff).
ASSIGN wtot-vou:SCREEN-VALUE = STRING(wtot-vou).


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
  DISPLAY wsearchref wsearchparticular wsearchrefdate1 wsearchrefdate2 
          wlastVchId wvouchertype wYearMonth1 wError wbankstatement wvoucherid 
          wtot-vou wtot-amt-diff wtot-amt-db wtot-amt-cr wtally-response 
          wparticulars 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wsearchref wsearchparticular wsearchrefdate1 wsearchrefdate2 
         wlastVchId wvouchertype BtnSearchRef BtnSearchRef-2 wExportSelected 
         wExportAll wYearMonth1 wError wAssignBankCons wDataBanks 
         wbankstatement wvoucherid BROWSE-1 BROWSE-2 wtally-response 
         wparticulars BROWSE-3 BROWSE-5 
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

  /*
  ASSIGN wsearchrefdate1 = 01/1/19
         wsearchrefdate2 = 12/31/19.
         */
  ASSIGN wYearMonth1:SCREEN-VALUE = "2019".

  ASSIGN wsearchrefdate1:SCREEN-VALUE = string(01/01/2019) wsearchrefdate2:SCREEN-VALUE = string(12/31/2019).
  /*
  ASSIGN wsearchrefdate1:SCREEN-VALUE = STRING(wsearchrefdate1).
  ASSIGN wsearchrefdate2:SCREEN-VALUE = STRING(wsearchrefdate2).
  */

  ASSIGN wbankstatement = 9.
  ASSIGN wbankstatement:SCREEN-VALUE = STRING(wbankstatement).

  ASSIGN wvoucherid = 9.
  ASSIGN wvoucherid:SCREEN-VALUE = STRING(wvoucherid).


  ASSIGN werror = FALSE.
  ASSIGN werror:SCREEN-VALUE = STRING(werror).
  ASSIGN wvouchertype = "All".
  ASSIGN wvouchertype:SCREEN-VALUE = wvouchertype.

  APPLY "Choose" TO BtnSearchRef.

  /*
 {&OPEN-QUERY-BROWSE-1}
 APPLY "Value-Changed" TO BROWSE-1.  
 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

