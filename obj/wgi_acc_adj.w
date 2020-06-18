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

DEF NEW SHARED VAR pYearMonth AS CHAR. 
DEF NEW SHARED VAR pcons AS INT.
DEF VAR pYearMonth1 AS CHAR. 
DEF BUFFER b_gi_acc_adj FOR gi_acc_adj .
DEF VAR poutput-filename AS CHAR FORMAT "x(200)".

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
&Scoped-define INTERNAL-TABLES gi_acc_adj

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_acc_adj.cons gi_acc_adj.refdate ~
gi_acc_adj.vouchernumber gi_acc_adj.LastVchId gi_acc_adj.amount ~
gi_acc_adj.db-ledger gi_acc_adj.cr-ledger gi_acc_adj.IsActive ~
gi_acc_adj.particulars gi_acc_adj.YearMonth 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_acc_adj.refdate ~
gi_acc_adj.LastVchId gi_acc_adj.amount gi_acc_adj.db-ledger ~
gi_acc_adj.cr-ledger gi_acc_adj.IsActive gi_acc_adj.particulars ~
gi_acc_adj.YearMonth 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_acc_adj
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_acc_adj
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_acc_adj ~
      WHERE gi_acc_adj.YearMonth MATCHES pyearmonth1 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_acc_adj ~
      WHERE gi_acc_adj.YearMonth MATCHES pyearmonth1 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_acc_adj
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_acc_adj


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BtnAdd wYearMonth BtnSearchRef BROWSE-1 ~
wtally-response 
&Scoped-Define DISPLAYED-OBJECTS wYearMonth wtally-response wtot-amt-diff ~
wtot-amt-db wtot-amt-cr 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Voucher LABEL "Create Voucher".


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnAdd 
     LABEL "Add" 
     SIZE 15 BY 1.12.

DEFINE BUTTON BtnSearchRef 
     LABEL "<S>" 
     SIZE 4.86 BY .81 TOOLTIP "Search Reference"
     FONT 4.

DEFINE VARIABLE wtally-response AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 32.72 BY 9.46
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

DEFINE VARIABLE wYearMonth AS CHARACTER 
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

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_acc_adj SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_acc_adj.cons COLUMN-LABEL "Cons" FORMAT "->>>>>>9":U
      gi_acc_adj.refdate COLUMN-LABEL "Date" FORMAT "99/99/99":U
      gi_acc_adj.vouchernumber COLUMN-LABEL "Voucher Num" FORMAT "x(20)":U
            WIDTH 13.72
      gi_acc_adj.LastVchId FORMAT "->>>>>>9":U
      gi_acc_adj.amount COLUMN-LABEL "Amount" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 12.57 COLUMN-FGCOLOR 12
      gi_acc_adj.db-ledger FORMAT "x(100)":U WIDTH 30 COLUMN-FGCOLOR 9
      gi_acc_adj.cr-ledger FORMAT "x(100)":U WIDTH 33 COLUMN-FGCOLOR 9
      gi_acc_adj.IsActive FORMAT "yes/no":U
      gi_acc_adj.particulars COLUMN-LABEL "Particulars" FORMAT "x(200)":U
            WIDTH 30
      gi_acc_adj.YearMonth FORMAT "x(8)":U
  ENABLE
      gi_acc_adj.refdate
      gi_acc_adj.LastVchId
      gi_acc_adj.amount
      gi_acc_adj.db-ledger
      gi_acc_adj.cr-ledger
      gi_acc_adj.IsActive
      gi_acc_adj.particulars
      gi_acc_adj.YearMonth
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 165.43 BY 12.12
         FONT 4
         TITLE "Accounting Adjusments" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BtnAdd AT ROW 1.19 COL 75.43 WIDGET-ID 2
     wYearMonth AT ROW 1.38 COL 2.43 NO-LABEL WIDGET-ID 64
     BtnSearchRef AT ROW 1.42 COL 162 WIDGET-ID 4
     BROWSE-1 AT ROW 2.54 COL 2.29 WIDGET-ID 200
     wtally-response AT ROW 14.88 COL 135 NO-LABEL WIDGET-ID 24
     wtot-amt-diff AT ROW 15 COL 41.43 COLON-ALIGNED WIDGET-ID 58
     wtot-amt-db AT ROW 15 COL 74.43 COLON-ALIGNED WIDGET-ID 46
     wtot-amt-cr AT ROW 15 COL 107.14 COLON-ALIGNED WIDGET-ID 48
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 168.14 BY 23.73 WIDGET-ID 100.


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
         TITLE              = "Accounting Adjustments"
         HEIGHT             = 23.73
         WIDTH              = 168.14
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
/* BROWSE-TAB BROWSE-1 BtnSearchRef fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       wtally-response:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN wtot-amt-cr IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-amt-db IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN wtot-amt-diff IN FRAME fMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_acc_adj"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "gi_acc_adj.YearMonth MATCHES pyearmonth1"
     _FldNameList[1]   > giph.gi_acc_adj.cons
"cons" "Cons" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_adj.refdate
"refdate" "Date" ? "date" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_adj.vouchernumber
"vouchernumber" "Voucher Num" ? "character" ? ? ? ? ? ? no ? no no "13.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_adj.LastVchId
"LastVchId" ? ? "integer" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_adj.amount
"amount" "Amount" ? "decimal" ? 12 ? ? ? ? yes ? no no "12.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_adj.db-ledger
"db-ledger" ? ? "character" ? 9 ? ? ? ? yes ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_adj.cr-ledger
"cr-ledger" ? ? "character" ? 9 ? ? ? ? yes ? no no "33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_adj.IsActive
"IsActive" ? ? "logical" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_adj.particulars
"particulars" "Particulars" ? "character" ? ? ? ? ? ? yes ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_adj.YearMonth
"YearMonth" ? ? "character" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Accounting Adjustments */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Accounting Adjustments */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Accounting Adjusments */
DO:
  IF AVAILABLE gi_acc_adj THEN DO:
      ASSIGN pcons = gi_acc_adj.cons.
      ASSIGN wtally-response:SCREEN-VALUE = gi_acc_adj.tally-response.
  END.
  ELSE ASSIGN pcons = ?
       wtally-response:SCREEN-VALUE = "".


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnAdd wWin
ON CHOOSE OF BtnAdd IN FRAME fMain /* Add */
DO:
    IF pyearmonth = "2019" THEN DO:
        MESSAGE "Invalid date. Please select the month"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN NO-APPLY.
    END.
  RUN c:\pvr\giph\lib\add_gi_acc_adj.p.
  APPLY "Choose" TO BtnSearchRef.
  /*
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearchRef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearchRef wWin
ON CHOOSE OF BtnSearchRef IN FRAME fMain /* <S> */
DO:

    ASSIGN pyearmonth1 = "*" + pyearmonth + "*".

    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Voucher
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Voucher wWin
ON CHOOSE OF MENU-ITEM m_Create_Voucher /* Create Voucher */
DO:
    IF NOT AVAILABLE gi_acc_adj THEN DO:
        MESSAGE "Please select adjutment voucher first"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN NO-APPLY.
    END.
    DO WITH FRAME {&FRAME-NAME}:
        
    END.
    IF gi_acc_adj.amount = 0 THEN DO:
        MESSAGE "Please input the amount"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN NO-APPLY.
    END.

    IF gi_acc_adj.db-ledger = "" THEN DO:
        MESSAGE "Please input debit ledger name"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN NO-APPLY.
    END.

    IF gi_acc_adj.cr-ledger = "" THEN DO:
        MESSAGE "Please input credit ledger name"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN NO-APPLY.
    END.


    RUN c:\pvr\giph\lib\CREATE_tally_voucher_journal_adjustment.p.

    FIND b_gi_acc_adj OF gi_acc_adj NO-ERROR.
    IF AVAILABLE b_gi_acc_adj THEN DO:
        ASSIGN poutput-filename = "C:\pvr\giph\tallylib\CreateVoucher-response.txt".

       RUN c:\pvr\giph\lib\get_voucher_id.p(INPUT poutput-filename, OUTPUT b_gi_acc_adj.LastVchId, OUTPUT b_gi_acc_adj.tally-response).
       MESSAGE b_gi_acc_adj.cons b_gi_acc_adj.refdate "VchID" b_gi_acc_adj.LastVchId. PAUSE 0.
    END.
        APPLY "Value-Changed" TO BROWSE-1.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wYearMonth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wYearMonth wWin
ON VALUE-CHANGED OF wYearMonth IN FRAME fMain
DO:
  ASSIGN pyearmonth = SELF:SCREEN-VALUE.


  APPLY "Choose" TO BtnSearchRef.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  DISPLAY wYearMonth wtally-response wtot-amt-diff wtot-amt-db wtot-amt-cr 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE BtnAdd wYearMonth BtnSearchRef BROWSE-1 wtally-response 
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

  ASSIGN wYearMonth:SCREEN-VALUE = "2019".
  APPLY "Value-Changed" TO wyearmonth.
  APPLY "Choose" TO BtnSearchRef.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

