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
&Scoped-define INTERNAL-TABLES gi_acc_hea gi_acc_det gi_acc_led gi_acc_grp

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_acc_hea.refnum1 ~
gi_acc_hea.vouchertype gi_acc_hea.LastVchId gi_acc_hea.bank-cons ~
gi_acc_hea.refdate gi_acc_hea.refnum2 gi_acc_hea.IsContra gi_acc_hea.IsJV ~
gi_acc_hea.IsReceipt gi_acc_hea.IsPayment gi_acc_hea.IsSales ~
gi_acc_hea.IsPurchase gi_acc_hea.particulars gi_acc_hea.debit ~
gi_acc_hea.credit gi_acc_hea.dbcr-diff gi_acc_hea.amount 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_acc_hea.refnum1 
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
  NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_acc_hea
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_acc_hea


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.reg ~
gi_acc_det.acc-led-name gi_acc_det.partyname gi_acc_det.alias-name ~
gi_acc_det.debit gi_acc_det.credit gi_acc_det.cheque-num ~
gi_acc_det.currency gi_acc_det.forex-rate gi_acc_det.runbal1 ~
gi_acc_det.runbal2 gi_acc_det.amount gi_acc_det.refnum1 ~
gi_acc_det.particulars gi_acc_det.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 gi_acc_det.acc-led-name ~
gi_acc_det.partyname gi_acc_det.alias-name 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refnum1 = prefnum1 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_acc_det ~
      WHERE gi_acc_det.refnum1 = prefnum1 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_acc_det
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_acc_det


/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 gi_acc_led.acc-led-name ~
gi_acc_led.IsCash gi_acc_led.IsBank gi_acc_led.IsIncome ~
gi_acc_led.IsExpenses gi_acc_led.IsAR gi_acc_led.IsAP ~
gi_acc_led.acc-grp-name gi_acc_led.tally-acc-ledger 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3 
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH gi_acc_led ~
      WHERE gi_acc_led.acc-led-name = pacc-led-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY BROWSE-3 FOR EACH gi_acc_led ~
      WHERE gi_acc_led.acc-led-name = pacc-led-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 gi_acc_led
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 gi_acc_led


/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 gi_acc_grp.acc-grp-name ~
gi_acc_grp.acc-grp-type gi_acc_grp.tally-acc-grp 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4 
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH gi_acc_grp ~
      WHERE gi_acc_grp.acc-grp-name = pacc-grp-name NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY BROWSE-4 FOR EACH gi_acc_grp ~
      WHERE gi_acc_grp.acc-grp-name = pacc-grp-name NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 gi_acc_grp
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 gi_acc_grp


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
&Scoped-Define ENABLED-OBJECTS wExport wsearchref wsearchparticular ~
wsearchrefdate1 wsearchrefdate2 wlastVchId wvouchertype wError BtnSearchRef ~
BtnSearchRef-2 wYearMonth1 wbankstatement BROWSE-1 BROWSE-2 wtally-response ~
wparticulars BROWSE-3 BROWSE-5 BROWSE-4 
&Scoped-Define DISPLAYED-OBJECTS wsearchref wsearchparticular ~
wsearchrefdate1 wsearchrefdate2 wlastVchId wvouchertype wError wYearMonth1 ~
wbankstatement wtally-response wparticulars 

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

DEFINE VARIABLE wparticulars AS CHARACTER 
     VIEW-AS EDITOR
     SIZE 165 BY 2 NO-UNDO.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 45 BY 8.77
     FONT 4 NO-UNDO.

DEFINE VARIABLE wlastVchId AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Vch Id" 
     VIEW-AS FILL-IN 
     SIZE 15.57 BY .81 TOOLTIP "Voucher ID"
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

DEFINE VARIABLE wbankstatement AS INTEGER 
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
     SIZE 78 BY .77
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
      gi_acc_led SCROLLING.

DEFINE QUERY BROWSE-4 FOR 
      gi_acc_grp SCROLLING.

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
            WIDTH 6.72
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
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 165 BY 7.12
         FONT 4
         TITLE "Transaction" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_acc_det.reg COLUMN-LABEL "Num" FORMAT "->>>9":U
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
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 119 BY 8.77
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 wWin _STRUCTURED
  QUERY BROWSE-3 NO-LOCK DISPLAY
      gi_acc_led.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(50)":U
            WIDTH 20.57
      gi_acc_led.IsCash FORMAT "yes/no":U
      gi_acc_led.IsBank COLUMN-LABEL "Bank" FORMAT "yes/no":U WIDTH 4.14
      gi_acc_led.IsIncome FORMAT "yes/no":U WIDTH 5.14
      gi_acc_led.IsExpenses COLUMN-LABEL "Exps" FORMAT "yes/no":U
            WIDTH 3.57
      gi_acc_led.IsAR COLUMN-LABEL "AR" FORMAT "yes/no":U
      gi_acc_led.IsAP COLUMN-LABEL "AP" FORMAT "yes/no":U
      gi_acc_led.acc-grp-name COLUMN-LABEL "Account Group" FORMAT "x(50)":U
            WIDTH 18.57
      gi_acc_led.tally-acc-ledger FORMAT "x(100)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 91 BY 4.31
         FONT 4
         TITLE "Ledgers" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 wWin _STRUCTURED
  QUERY BROWSE-4 NO-LOCK DISPLAY
      gi_acc_grp.acc-grp-name COLUMN-LABEL "Account Group" FORMAT "x(50)":U
            WIDTH 24.57
      gi_acc_grp.acc-grp-type COLUMN-LABEL "Group Type" FORMAT "x(50)":U
            WIDTH 25.57
      gi_acc_grp.tally-acc-grp FORMAT "x(100)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 91 BY 4.31
         FONT 4
         TITLE "Account Group" FIT-LAST-COLUMN.

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 73.57 BY 8.65
         FONT 4
         TITLE "Transaction Details" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wExport AT ROW 1.15 COL 159.57 WIDGET-ID 22
     wsearchref AT ROW 1.19 COL 4.72 COLON-ALIGNED WIDGET-ID 2
     wsearchparticular AT ROW 1.19 COL 30.86 COLON-ALIGNED WIDGET-ID 8
     wsearchrefdate1 AT ROW 1.19 COL 59.57 COLON-ALIGNED WIDGET-ID 10
     wsearchrefdate2 AT ROW 1.19 COL 76.14 COLON-ALIGNED WIDGET-ID 12
     wlastVchId AT ROW 1.19 COL 96.29 COLON-ALIGNED WIDGET-ID 26
     wvouchertype AT ROW 1.19 COL 126.72 COLON-ALIGNED WIDGET-ID 20
     wError AT ROW 1.19 COL 143.14 WIDGET-ID 18
     BtnSearchRef AT ROW 1.19 COL 150 WIDGET-ID 4
     BtnSearchRef-2 AT ROW 1.19 COL 154.72 WIDGET-ID 6
     wYearMonth1 AT ROW 2.15 COL 1.86 NO-LABEL WIDGET-ID 64
     wbankstatement AT ROW 2.19 COL 105.29 NO-LABEL WIDGET-ID 108
     BROWSE-1 AT ROW 3.27 COL 1.86 WIDGET-ID 200
     BROWSE-2 AT ROW 10.58 COL 1.86 WIDGET-ID 300
     wtally-response AT ROW 10.58 COL 121.72 NO-LABEL WIDGET-ID 24
     wparticulars AT ROW 19.5 COL 1.86 NO-LABEL WIDGET-ID 16
     BROWSE-3 AT ROW 21.62 COL 1.86 WIDGET-ID 400
     BROWSE-5 AT ROW 21.62 COL 93.43 WIDGET-ID 600
     BROWSE-4 AT ROW 26 COL 1.86 WIDGET-ID 500
     "Bank Statement" VIEW-AS TEXT
          SIZE 15 BY .69 AT ROW 2.19 COL 89.57 WIDGET-ID 112
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
/* BROWSE-TAB BROWSE-1 wbankstatement fMain */
/* BROWSE-TAB BROWSE-2 BROWSE-1 fMain */
/* BROWSE-TAB BROWSE-3 wparticulars fMain */
/* BROWSE-TAB BROWSE-5 BROWSE-3 fMain */
/* BROWSE-TAB BROWSE-4 BROWSE-5 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_hea.refnum1:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

ASSIGN 
       BROWSE-2:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_acc_det.acc-led-name:COLUMN-READ-ONLY IN BROWSE BROWSE-2 = TRUE
       gi_acc_det.partyname:COLUMN-READ-ONLY IN BROWSE BROWSE-2 = TRUE.

ASSIGN 
       BROWSE-3:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-3:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-4:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-4:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       BROWSE-5:NUM-LOCKED-COLUMNS IN FRAME fMain     = 3
       BROWSE-5:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-5:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       wparticulars:READ-ONLY IN FRAME fMain        = TRUE.

ASSIGN 
       wtally-response:READ-ONLY IN FRAME fMain        = TRUE.

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
 "
     _FldNameList[1]   > giph.gi_acc_hea.refnum1
"gi_acc_hea.refnum1" "Ref. No" ? "character" ? ? ? ? ? ? yes ? no no "10.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_hea.vouchertype
"gi_acc_hea.vouchertype" "Vch.Type" ? "character" ? ? ? ? ? ? no ? no no "9.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_hea.LastVchId
"gi_acc_hea.LastVchId" ? ? "integer" ? 9 ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_hea.bank-cons
"gi_acc_hea.bank-cons" "Bank!Cons" ? "integer" ? ? ? ? ? ? no ? no no "6.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
     _FldNameList[1]   > giph.gi_acc_det.reg
"gi_acc_det.reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.acc-led-name
"gi_acc_det.acc-led-name" "Ledger" ? "character" ? ? ? ? ? ? yes ? no no "20.29" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.partyname
"gi_acc_det.partyname" "Party" ? "character" ? ? ? ? ? ? yes ? no no "20.57" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.alias-name
"gi_acc_det.alias-name" ? ? "character" ? ? ? ? ? ? yes ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.debit
"gi_acc_det.debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "12.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.credit
"gi_acc_det.credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "11.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.cheque-num
"gi_acc_det.cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "12.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _TblList          = "giph.gi_acc_led"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_led.acc-led-name = pacc-led-name"
     _FldNameList[1]   > giph.gi_acc_led.acc-led-name
"gi_acc_led.acc-led-name" "Ledger" "x(50)" "character" ? ? ? ? ? ? no ? no no "20.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = giph.gi_acc_led.IsCash
     _FldNameList[3]   > giph.gi_acc_led.IsBank
"gi_acc_led.IsBank" "Bank" ? "logical" ? ? ? ? ? ? no ? no no "4.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_led.IsIncome
"gi_acc_led.IsIncome" ? ? "logical" ? ? ? ? ? ? no ? no no "5.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_led.IsExpenses
"gi_acc_led.IsExpenses" "Exps" ? "logical" ? ? ? ? ? ? no ? no no "3.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_led.IsAR
"gi_acc_led.IsAR" "AR" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_led.IsAP
"gi_acc_led.IsAP" "AP" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_led.acc-grp-name
"gi_acc_led.acc-grp-name" "Account Group" "x(50)" "character" ? ? ? ? ? ? no ? no no "18.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = giph.gi_acc_led.tally-acc-ledger
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-3 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _TblList          = "giph.gi_acc_grp"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_acc_grp.acc-grp-name = pacc-grp-name"
     _FldNameList[1]   > giph.gi_acc_grp.acc-grp-name
"gi_acc_grp.acc-grp-name" "Account Group" "x(50)" "character" ? ? ? ? ? ? no ? no no "24.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_grp.acc-grp-type
"gi_acc_grp.acc-grp-type" "Group Type" ? "character" ? ? ? ? ? ? no ? no no "25.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = giph.gi_acc_grp.tally-acc-grp
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-4 */
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
"partyname" "Party" ? "character" ? ? ? ? ? ? no ? no no "19.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_det.refnum1
"refnum1" "Ref" ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_det.reg
"reg" "Num" ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_det.refdate
"refdate" "RefDate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_det.bank-cons
"bank-cons" ? ? "integer" ? ? ? ? ? ? no ? no no "6.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_det.debit
"debit" "Debit" ? "decimal" ? ? ? ? ? ? no ? no no "11.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_det.credit
"credit" "Credit" ? "decimal" ? ? ? ? ? ? no ? no no "12.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_det.cheque-num
"cheque-num" ? ? "character" ? ? ? ? ? ? no ? no no "8.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_det.runbal1
"runbal1" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_det.runbal2
"runbal2" "Run. Bal1" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_acc_det.amount
"amount" "Amount" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_acc_det.particulars
"particulars" "Particulars" ? "character" ? ? ? ? ? ? no ? no no "50" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_acc_det.cons
"cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_acc_det.currency
"currency" ? ? "character" ? ? ? ? ? ? no ? no no "6.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > giph.gi_acc_det.forex-rate
"forex-rate" ? ? "decimal" ? ? ? ? ? ? no ? no no "5.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
        ASSIGN wtally-response:SCREEN-VALUE = gi_acc_hea.tally-response.
    END.
    ELSE DO:
        ASSIGN prefnum1 = ?.
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
  {&OPEN-QUERY-BROWSE-5}
  APPLY "Value-Changed" TO BROWSE-5.  
  ASSIGN browse-5:TITLE = pacc-led-name.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
&Scoped-define SELF-NAME BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-3 wWin
ON VALUE-CHANGED OF BROWSE-3 IN FRAME fMain /* Ledgers */
DO:
    IF AVAILABLE gi_acc_led THEN DO:
        ASSIGN pacc-grp-name = gi_acc_led.acc-grp-name.

    END.
    ELSE DO:
        ASSIGN pacc-grp-name = "".
    END.

    {&OPEN-QUERY-BROWSE-4}
    APPLY "Value-Changed" TO BROWSE-4.  


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


&Scoped-define SELF-NAME m_Agent_Data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Agent_Data wWin
ON CHOOSE OF MENU-ITEM m_Agent_Data /* Agent Data */
DO:
    RUN C:\pvr\giph\obj\wagent_account.w.
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


&Scoped-define SELF-NAME m_Product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Product wWin
ON CHOOSE OF MENU-ITEM m_Product /* Product */
DO:
    RUN C:\pvr\giph\obj\wproduct.w.
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


&Scoped-define SELF-NAME wbankstatement
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wbankstatement wWin
ON VALUE-CHANGED OF wbankstatement IN FRAME fMain
DO:
    ASSIGN wbankstatement = INT(SELF:SCREEN-VALUE).
  

  APPLY "Choose" TO BtnSearchRef.
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
          wlastVchId wvouchertype wError wYearMonth1 wbankstatement 
          wtally-response wparticulars 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wExport wsearchref wsearchparticular wsearchrefdate1 wsearchrefdate2 
         wlastVchId wvouchertype wError BtnSearchRef BtnSearchRef-2 wYearMonth1 
         wbankstatement BROWSE-1 BROWSE-2 wtally-response wparticulars BROWSE-3 
         BROWSE-5 BROWSE-4 
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

