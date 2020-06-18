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

DEF NEW SHARED VAR pTransactionId LIKE gi_agent.TransactionId.

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
&Scoped-define INTERNAL-TABLES gi_agent gi_mt_agent

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_agent.TravelAgentId ~
gi_agent.CompanyName gi_agent.DateTime11 gi_agent.Description ~
gi_agent.TransactionId gi_agent.DebitAmount gi_agent.CreditAmount ~
gi_agent.SmartRemaining gi_agent.Remarks gi_agent.DateTime22 ~
gi_agent.ODAmount gi_agent.TerminalName gi_agent.EnteredBy ~
gi_agent.Productname gi_agent.YearMonth1 gi_agent.YearMonth2 gi_agent.cons 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_agent.TravelAgentId ~
gi_agent.CompanyName gi_agent.TransactionId gi_agent.Remarks ~
gi_agent.EnteredBy gi_agent.Productname 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_agent
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_agent
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_agent ~
      WHERE gi_agent.DateTime11 >= wsearchrefdate1 ~
 AND gi_agent.DateTime11 <= wsearchrefdate2 ~
 AND (giph.gi_agent.CompanyName MATCHES wsearchparticular ~
 OR gi_agent.Description MATCHES wsearchparticular ~
 OR gi_agent.Productname MATCHES wsearchparticular ~
 OR gi_agent.Remarks MATCHES wsearchparticular ~
 OR gi_agent.TransactionId MATCHES wsearchparticular ~
 OR gi_agent.TravelAgentId MATCHES wsearchparticular ~
) NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_agent ~
      WHERE gi_agent.DateTime11 >= wsearchrefdate1 ~
 AND gi_agent.DateTime11 <= wsearchrefdate2 ~
 AND (giph.gi_agent.CompanyName MATCHES wsearchparticular ~
 OR gi_agent.Description MATCHES wsearchparticular ~
 OR gi_agent.Productname MATCHES wsearchparticular ~
 OR gi_agent.Remarks MATCHES wsearchparticular ~
 OR gi_agent.TransactionId MATCHES wsearchparticular ~
 OR gi_agent.TravelAgentId MATCHES wsearchparticular ~
) NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_agent
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_agent


/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 gi_mt_agent.TransactionId ~
gi_mt_agent.MTAgentName gi_mt_agent.DateTime11 gi_mt_agent.Description ~
gi_mt_agent.DebitAmount gi_mt_agent.debitamount-txt ~
gi_mt_agent.CreditAmount gi_mt_agent.creditamount-txt ~
gi_mt_agent.MtAgentRemaining gi_mt_agent.Remarks gi_mt_agent.ODAmount ~
gi_mt_agent.Product gi_mt_agent.Enteredby gi_mt_agent.YearMonth1 ~
gi_mt_agent.cons gi_mt_agent.month 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH gi_mt_agent ~
      WHERE gi_mt_agent.TransactionId = pTransactionId NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY BROWSE-2 FOR EACH gi_mt_agent ~
      WHERE gi_mt_agent.TransactionId = pTransactionId NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 gi_mt_agent
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 gi_mt_agent


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS wsearchparticular wsearchrefdate1 ~
wsearchrefdate2 BtnSearchRef BtnSearchRef-2 BROWSE-1 BROWSE-2 
&Scoped-Define DISPLAYED-OBJECTS wsearchparticular wsearchrefdate1 ~
wsearchrefdate2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-BROWSE-1 
       MENU-ITEM m_Create_Tally_Sales_Voucher LABEL "Create Tally Sales Voucher".


/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnSearchRef 
     LABEL "<S>" 
     SIZE 4.86 BY .96 TOOLTIP "Search Reference".

DEFINE BUTTON BtnSearchRef-2 
     LABEL "<x>" 
     SIZE 4.86 BY .96 TOOLTIP "Cancel Search Reference".

DEFINE VARIABLE wsearchparticular AS CHARACTER FORMAT "X(256)":U 
     LABEL "Search details" 
     VIEW-AS FILL-IN 
     SIZE 38.14 BY 1 TOOLTIP "Search Particular" NO-UNDO.

DEFINE VARIABLE wsearchrefdate1 AS DATE FORMAT "99/99/9999":U 
     LABEL "Date From" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY 1 TOOLTIP "Search date" NO-UNDO.

DEFINE VARIABLE wsearchrefdate2 AS DATE FORMAT "99/99/9999":U 
     LABEL "To" 
     VIEW-AS FILL-IN 
     SIZE 12.57 BY 1 TOOLTIP "Search date" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_agent SCROLLING.

DEFINE QUERY BROWSE-2 FOR 
      gi_mt_agent SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_agent.TravelAgentId FORMAT "x(20)":U
      gi_agent.CompanyName FORMAT "x(100)":U WIDTH 20
      gi_agent.DateTime11 FORMAT "99/99/9999":U
      gi_agent.Description FORMAT "x(200)":U WIDTH 20
      gi_agent.TransactionId FORMAT "x(50)":U WIDTH 15
      gi_agent.DebitAmount FORMAT "->>,>>9.99":U
      gi_agent.CreditAmount FORMAT "->>,>>9.99":U
      gi_agent.SmartRemaining FORMAT "->>,>>9.99":U
      gi_agent.Remarks FORMAT "x(200)":U WIDTH 20
      gi_agent.DateTime22 FORMAT "99/99/99":U
      gi_agent.ODAmount FORMAT "->>,>>9.99":U
      gi_agent.TerminalName FORMAT "x(100)":U WIDTH 15
      gi_agent.EnteredBy FORMAT "x(15)":U
      gi_agent.Productname FORMAT "x(20)":U WIDTH 10
      gi_agent.YearMonth1 FORMAT "x(8)":U
      gi_agent.YearMonth2 FORMAT "x(8)":U
      gi_agent.cons FORMAT "->,>>>,>>9":U
  ENABLE
      gi_agent.TravelAgentId
      gi_agent.CompanyName
      gi_agent.TransactionId
      gi_agent.Remarks
      gi_agent.EnteredBy
      gi_agent.Productname
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 153 BY 11.15
         FONT 4
         TITLE "Agent Account Statement" FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 wWin _STRUCTURED
  QUERY BROWSE-2 NO-LOCK DISPLAY
      gi_mt_agent.TransactionId FORMAT "x(20)":U
      gi_mt_agent.MTAgentName FORMAT "x(100)":U WIDTH 20
      gi_mt_agent.DateTime11 FORMAT "99/99/9999":U
      gi_mt_agent.Description FORMAT "x(100)":U WIDTH 20
      gi_mt_agent.DebitAmount COLUMN-LABEL "DebitAmt" FORMAT "->>,>>9.99":U
      gi_mt_agent.debitamount-txt COLUMN-LABEL "DebitTxt" FORMAT "x(20)":U
            WIDTH 7.14
      gi_mt_agent.CreditAmount COLUMN-LABEL "CreditAmt" FORMAT "->>,>>9.99":U
      gi_mt_agent.creditamount-txt COLUMN-LABEL "CreditTxt" FORMAT "x(20)":U
            WIDTH 7.57
      gi_mt_agent.MtAgentRemaining FORMAT "->>,>>9.99":U
      gi_mt_agent.Remarks FORMAT "x(100)":U WIDTH 20
      gi_mt_agent.ODAmount FORMAT "->>,>>9.99":U
      gi_mt_agent.Product FORMAT "x(20)":U WIDTH 10
      gi_mt_agent.Enteredby FORMAT "x(20)":U
      gi_mt_agent.YearMonth1 FORMAT "x(8)":U
      gi_mt_agent.cons FORMAT "->>>>>>9":U
      gi_mt_agent.month FORMAT ">9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 153 BY 13.35
         FONT 4
         TITLE "MT Agent Account Statement" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     wsearchparticular AT ROW 1.23 COL 16.14 COLON-ALIGNED WIDGET-ID 8
     wsearchrefdate1 AT ROW 1.23 COL 66.72 COLON-ALIGNED WIDGET-ID 10
     wsearchrefdate2 AT ROW 1.23 COL 83.43 COLON-ALIGNED WIDGET-ID 12
     BtnSearchRef AT ROW 1.27 COL 141 WIDGET-ID 4
     BtnSearchRef-2 AT ROW 1.27 COL 146.29 WIDGET-ID 6
     BROWSE-1 AT ROW 2.62 COL 2.57 WIDGET-ID 200
     BROWSE-2 AT ROW 14.08 COL 2.57 WIDGET-ID 300
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 157 BY 26.77 WIDGET-ID 100.


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
         TITLE              = "Agent Data"
         HEIGHT             = 26.77
         WIDTH              = 157
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 157
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 157
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
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
/* BROWSE-TAB BROWSE-1 BtnSearchRef-2 fMain */
/* BROWSE-TAB BROWSE-2 BROWSE-1 fMain */
ASSIGN 
       BROWSE-1:POPUP-MENU IN FRAME fMain             = MENU POPUP-MENU-BROWSE-1:HANDLE
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

ASSIGN 
       gi_agent.TravelAgentId:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_agent.CompanyName:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_agent.TransactionId:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_agent.Remarks:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_agent.EnteredBy:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE
       gi_agent.Productname:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

ASSIGN 
       BROWSE-2:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_agent"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_agent.DateTime11 >= wsearchrefdate1
 AND giph.gi_agent.DateTime11 <= wsearchrefdate2
 AND (giph.gi_agent.CompanyName MATCHES wsearchparticular
 OR giph.gi_agent.Description MATCHES wsearchparticular
 OR giph.gi_agent.Productname MATCHES wsearchparticular
 OR giph.gi_agent.Remarks MATCHES wsearchparticular
 OR giph.gi_agent.TransactionId MATCHES wsearchparticular
 OR giph.gi_agent.TravelAgentId MATCHES wsearchparticular
)"
     _FldNameList[1]   > giph.gi_agent.TravelAgentId
"gi_agent.TravelAgentId" ? ? "character" ? ? ? ? ? ? yes ? no no ? yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_agent.CompanyName
"gi_agent.CompanyName" ? ? "character" ? ? ? ? ? ? yes ? no no "20" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = giph.gi_agent.DateTime11
     _FldNameList[4]   > giph.gi_agent.Description
"gi_agent.Description" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_agent.TransactionId
"gi_agent.TransactionId" ? ? "character" ? ? ? ? ? ? yes ? no no "15" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = giph.gi_agent.DebitAmount
     _FldNameList[7]   = giph.gi_agent.CreditAmount
     _FldNameList[8]   = giph.gi_agent.SmartRemaining
     _FldNameList[9]   > giph.gi_agent.Remarks
"gi_agent.Remarks" ? ? "character" ? ? ? ? ? ? yes ? no no "20" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   = giph.gi_agent.DateTime22
     _FldNameList[11]   = giph.gi_agent.ODAmount
     _FldNameList[12]   > giph.gi_agent.TerminalName
"gi_agent.TerminalName" ? ? "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_agent.EnteredBy
"gi_agent.EnteredBy" ? ? "character" ? ? ? ? ? ? yes ? no no ? yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > giph.gi_agent.Productname
"gi_agent.Productname" ? ? "character" ? ? ? ? ? ? yes ? no no "10" yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   = giph.gi_agent.YearMonth1
     _FldNameList[16]   = giph.gi_agent.YearMonth2
     _FldNameList[17]   = giph.gi_agent.cons
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _TblList          = "giph.gi_mt_agent"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "giph.gi_mt_agent.TransactionId = pTransactionId"
     _FldNameList[1]   = giph.gi_mt_agent.TransactionId
     _FldNameList[2]   > giph.gi_mt_agent.MTAgentName
"gi_mt_agent.MTAgentName" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = giph.gi_mt_agent.DateTime11
     _FldNameList[4]   > giph.gi_mt_agent.Description
"gi_mt_agent.Description" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_mt_agent.DebitAmount
"gi_mt_agent.DebitAmount" "DebitAmt" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_mt_agent.debitamount-txt
"gi_mt_agent.debitamount-txt" "DebitTxt" ? "character" ? ? ? ? ? ? no ? no no "7.14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_mt_agent.CreditAmount
"gi_mt_agent.CreditAmount" "CreditAmt" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_mt_agent.creditamount-txt
"gi_mt_agent.creditamount-txt" "CreditTxt" ? "character" ? ? ? ? ? ? no ? no no "7.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = giph.gi_mt_agent.MtAgentRemaining
     _FldNameList[10]   > giph.gi_mt_agent.Remarks
"gi_mt_agent.Remarks" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   = giph.gi_mt_agent.ODAmount
     _FldNameList[12]   > giph.gi_mt_agent.Product
"gi_mt_agent.Product" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   = giph.gi_mt_agent.Enteredby
     _FldNameList[14]   = giph.gi_mt_agent.YearMonth1
     _FldNameList[15]   = giph.gi_mt_agent.cons
     _FldNameList[16]   = giph.gi_mt_agent.month
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Agent Data */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Agent Data */
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
ON VALUE-CHANGED OF BROWSE-1 IN FRAME fMain /* Agent Account Statement */
DO:
  IF AVAILABLE gi_agent THEN DO:
      ASSIGN pTransactionId = gi_agent.TransactionId.
  END.
  ELSE DO:
      ASSIGN pTransactionId = ?.

  END.
    {&OPEN-QUERY-BROWSE-2}
    APPLY "Value-Changed" TO BROWSE-2.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearchRef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearchRef wWin
ON CHOOSE OF BtnSearchRef IN FRAME fMain /* <S> */
DO:
    /*
    ASSIGN wsearchref = "*" + wsearchref:SCREEN-VALUE + "*".
    */
    ASSIGN wsearchparticular = "*" + wsearchparticular:SCREEN-VALUE + "*".
    ASSIGN wsearchrefdate1 = DATE(wsearchrefdate1:SCREEN-VALUE).
    ASSIGN wsearchrefdate2 = DATE(wsearchrefdate2:SCREEN-VALUE).
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnSearchRef-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnSearchRef-2 wWin
ON CHOOSE OF BtnSearchRef-2 IN FRAME fMain /* <x> */
DO:
    /*
    ASSIGN wsearchref = "*".
    ASSIGN wsearchref:SCREEN-VALUE = "".
    */
    ASSIGN wsearchparticular = "*".
    ASSIGN wsearchparticular:SCREEN-VALUE = "".
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Create_Tally_Sales_Voucher
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Create_Tally_Sales_Voucher wWin
ON CHOOSE OF MENU-ITEM m_Create_Tally_Sales_Voucher /* Create Tally Sales Voucher */
DO:
  IF AVAILABLE gi_agent THEN DO:
      RUN c:\pvr\giph\lib\create_tally_voucher_sales.p.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME wsearchparticular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wsearchparticular wWin
ON ANY-PRINTABLE OF wsearchparticular IN FRAME fMain /* Search details */
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
ON LEAVE OF wsearchparticular IN FRAME fMain /* Search details */
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
  DISPLAY wsearchparticular wsearchrefdate1 wsearchrefdate2 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE wsearchparticular wsearchrefdate1 wsearchrefdate2 BtnSearchRef 
         BtnSearchRef-2 BROWSE-1 BROWSE-2 
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

  ASSIGN wsearchrefdate1 = 10/1/19
         wsearchrefdate2 = 10/31/19.
  ASSIGN wsearchrefdate1:SCREEN-VALUE = STRING(wsearchrefdate1).
  ASSIGN wsearchrefdate2:SCREEN-VALUE = STRING(wsearchrefdate2).
  ASSIGN wsearchparticular = "*".
  ASSIGN wsearchparticular:SCREEN-VALUE = "".


    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

