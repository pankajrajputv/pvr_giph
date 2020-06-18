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

DEF BUFFER b_gi_acc_led FOR gi_acc_led.

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
&Scoped-define INTERNAL-TABLES gi_acc_led

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_acc_led.acc-led-name ~
gi_acc_led.sys-acc-grp-name gi_acc_led.acc-grp-name gi_acc_led.IsBank ~
gi_acc_led.IsCash gi_acc_led.IsIncome gi_acc_led.IsExpenses gi_acc_led.IsAR ~
gi_acc_led.IsAP gi_acc_led.tally-acc-ledger 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 gi_acc_led.acc-led-name ~
gi_acc_led.sys-acc-grp-name gi_acc_led.acc-grp-name gi_acc_led.IsBank ~
gi_acc_led.IsCash gi_acc_led.IsIncome gi_acc_led.IsExpenses gi_acc_led.IsAR ~
gi_acc_led.IsAP gi_acc_led.tally-acc-ledger 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_acc_led
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_acc_led
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_acc_led NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_acc_led NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_acc_led
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_acc_led


/* Definitions for FRAME fMain                                          */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fMain ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-1 BtnCreate 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnCreate 
     LABEL "Create Ledger" 
     SIZE 15 BY 1.12.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_acc_led SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_acc_led.acc-led-name COLUMN-LABEL "Ledger" FORMAT "x(50)":U
            WIDTH 35.72
      gi_acc_led.sys-acc-grp-name FORMAT "x(100)":U WIDTH 31.29
      gi_acc_led.acc-grp-name COLUMN-LABEL "Account Group" FORMAT "x(50)":U
            WIDTH 37
      gi_acc_led.IsBank FORMAT "yes/no":U
      gi_acc_led.IsCash FORMAT "yes/no":U
      gi_acc_led.IsIncome FORMAT "yes/no":U
      gi_acc_led.IsExpenses FORMAT "yes/no":U
      gi_acc_led.IsAR COLUMN-LABEL "AR" FORMAT "yes/no":U WIDTH 4.86
      gi_acc_led.IsAP COLUMN-LABEL "AP" FORMAT "yes/no":U WIDTH 5.57
      gi_acc_led.tally-acc-ledger FORMAT "x(100)":U
  ENABLE
      gi_acc_led.acc-led-name
      gi_acc_led.sys-acc-grp-name
      gi_acc_led.acc-grp-name
      gi_acc_led.IsBank
      gi_acc_led.IsCash
      gi_acc_led.IsIncome
      gi_acc_led.IsExpenses
      gi_acc_led.IsAR
      gi_acc_led.IsAP
      gi_acc_led.tally-acc-ledger
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 161.86 BY 16.42
         TITLE "Ledgers" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BROWSE-1 AT ROW 1.31 COL 2.72 WIDGET-ID 200
     BtnCreate AT ROW 18 COL 2.72 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 164.86 BY 18.5 WIDGET-ID 100.


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
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 18.5
         WIDTH              = 164.86
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 164.86
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 164.86
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
/* BROWSE-TAB BROWSE-1 1 fMain */
ASSIGN 
       BROWSE-1:COLUMN-RESIZABLE IN FRAME fMain       = TRUE
       BROWSE-1:COLUMN-MOVABLE IN FRAME fMain         = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_acc_led"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > giph.gi_acc_led.acc-led-name
"gi_acc_led.acc-led-name" "Ledger" "x(50)" "character" ? ? ? ? ? ? yes ? no no "35.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_acc_led.sys-acc-grp-name
"gi_acc_led.sys-acc-grp-name" ? ? "character" ? ? ? ? ? ? yes ? no no "31.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_acc_led.acc-grp-name
"gi_acc_led.acc-grp-name" "Account Group" "x(50)" "character" ? ? ? ? ? ? yes ? no no "37" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_acc_led.IsBank
"gi_acc_led.IsBank" ? ? "logical" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_acc_led.IsCash
"gi_acc_led.IsCash" ? ? "logical" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_acc_led.IsIncome
"gi_acc_led.IsIncome" ? ? "logical" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_acc_led.IsExpenses
"gi_acc_led.IsExpenses" ? ? "logical" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_acc_led.IsAR
"gi_acc_led.IsAR" "AR" ? "logical" ? ? ? ? ? ? yes ? no no "4.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_acc_led.IsAP
"gi_acc_led.IsAP" "AP" ? "logical" ? ? ? ? ? ? yes ? no no "5.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_acc_led.tally-acc-ledger
"gi_acc_led.tally-acc-ledger" ? ? "character" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BtnCreate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnCreate wWin
ON CHOOSE OF BtnCreate IN FRAME fMain /* Create Ledger */
DO:
    DEF VAR pcons AS INT.
    ASSIGN pcons = 0.
    FOR EACH b_gi_acc_led:
        ASSIGN pcons = pcons + 1.
    END.
    CREATE b_gi_acc_led.
    ASSIGN b_gi_acc_led.acc-led-name = "---" +  STRING(pcons,"9999") + "---".
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  


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
  ENABLE BROWSE-1 BtnCreate 
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

