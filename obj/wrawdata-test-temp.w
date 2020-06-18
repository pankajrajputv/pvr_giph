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
&Scoped-define INTERNAL-TABLES gi_rawdata_temp

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 gi_rawdata_temp.period-txt ~
gi_rawdata_temp.accountanalysis-txt gi_rawdata_temp.account-txt ~
gi_rawdata_temp.bookno-txt gi_rawdata_temp.date-txt ~
gi_rawdata_temp.refno-txt gi_rawdata_temp.name-txt ~
gi_rawdata_temp.particulars-txt gi_rawdata_temp.currency-txt ~
gi_rawdata_temp.amount-txt gi_rawdata_temp.debit-txt ~
gi_rawdata_temp.credit-txt gi_rawdata_temp.runbal1-txt ~
gi_rawdata_temp.runbal2-txt gi_rawdata_temp.refnum1 gi_rawdata_temp.refdate ~
gi_rawdata_temp.refnum2 gi_rawdata_temp.partyname ~
gi_rawdata_temp.particulars gi_rawdata_temp.currency-data ~
gi_rawdata_temp.amount gi_rawdata_temp.debit gi_rawdata_temp.credit ~
gi_rawdata_temp.runbal1 gi_rawdata_temp.runbal2 gi_rawdata_temp.report-txt ~
gi_rawdata_temp.amt1 gi_rawdata_temp.amt2 gi_rawdata_temp.amt3 ~
gi_rawdata_temp.amt4 gi_rawdata_temp.report-txt2 ~
gi_rawdata_temp.ori-filename 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 ~
gi_rawdata_temp.ori-filename 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-1 gi_rawdata_temp
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-1 gi_rawdata_temp
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH gi_rawdata_temp NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH gi_rawdata_temp NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 gi_rawdata_temp
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 gi_rawdata_temp


/* Definitions for FRAME fMain                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-1 BtnImport 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BtnImport 
     LABEL "Import" 
     SIZE 15 BY 1.12.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      gi_rawdata_temp SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 wWin _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      gi_rawdata_temp.period-txt FORMAT "x(100)":U WIDTH 20
      gi_rawdata_temp.accountanalysis-txt FORMAT "x(50)":U WIDTH 26.29
      gi_rawdata_temp.account-txt FORMAT "x(100)":U WIDTH 20
      gi_rawdata_temp.bookno-txt FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.date-txt FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.refno-txt FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.name-txt FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.particulars-txt FORMAT "x(50)":U WIDTH 25
      gi_rawdata_temp.currency-txt FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.amount-txt FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.debit-txt FORMAT "x(50)":U WIDTH 16.86
      gi_rawdata_temp.credit-txt FORMAT "x(50)":U WIDTH 16.29
      gi_rawdata_temp.runbal1-txt FORMAT "x(50)":U WIDTH 20
      gi_rawdata_temp.runbal2-txt FORMAT "x(8)":U
      gi_rawdata_temp.refnum1 FORMAT "x(50)":U WIDTH 15.57
      gi_rawdata_temp.refdate FORMAT "99/99/99":U
      gi_rawdata_temp.refnum2 FORMAT "x(50)":U WIDTH 13.72
      gi_rawdata_temp.partyname FORMAT "x(100)":U WIDTH 27.43
      gi_rawdata_temp.particulars FORMAT "x(200)":U WIDTH 20
      gi_rawdata_temp.currency-data FORMAT "x(50)":U WIDTH 10
      gi_rawdata_temp.amount FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.debit FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.credit FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.runbal1 FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.runbal2 FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.report-txt FORMAT "x(8)":U
      gi_rawdata_temp.amt1 FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.amt2 FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.amt3 FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.amt4 FORMAT "->>>,>>>,>>9.99":U
      gi_rawdata_temp.report-txt2 FORMAT "x(8)":U
      gi_rawdata_temp.ori-filename FORMAT "x(200)":U
  ENABLE
      gi_rawdata_temp.ori-filename
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.72 BY 14.77
         TITLE "Raw Data Temp" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BROWSE-1 AT ROW 1.19 COL 2 WIDGET-ID 200
     BtnImport AT ROW 16.38 COL 114.43 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 182.29 BY 20.38 WIDGET-ID 100.


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
         HEIGHT             = 18.81
         WIDTH              = 132.29
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 182.29
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 182.29
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
/* BROWSE-TAB BROWSE-1 1 fMain */
ASSIGN 
       gi_rawdata_temp.ori-filename:COLUMN-READ-ONLY IN BROWSE BROWSE-1 = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "giph.gi_rawdata_temp"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > giph.gi_rawdata_temp.period-txt
"period-txt" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > giph.gi_rawdata_temp.accountanalysis-txt
"accountanalysis-txt" ? ? "character" ? ? ? ? ? ? no ? no no "26.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > giph.gi_rawdata_temp.account-txt
"account-txt" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > giph.gi_rawdata_temp.bookno-txt
"bookno-txt" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > giph.gi_rawdata_temp.date-txt
"date-txt" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > giph.gi_rawdata_temp.refno-txt
"refno-txt" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > giph.gi_rawdata_temp.name-txt
"name-txt" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > giph.gi_rawdata_temp.particulars-txt
"particulars-txt" ? ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > giph.gi_rawdata_temp.currency-txt
"currency-txt" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > giph.gi_rawdata_temp.amount-txt
"amount-txt" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > giph.gi_rawdata_temp.debit-txt
"debit-txt" ? ? "character" ? ? ? ? ? ? no ? no no "16.86" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > giph.gi_rawdata_temp.credit-txt
"credit-txt" ? ? "character" ? ? ? ? ? ? no ? no no "16.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > giph.gi_rawdata_temp.runbal1-txt
"runbal1-txt" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   = giph.gi_rawdata_temp.runbal2-txt
     _FldNameList[15]   > giph.gi_rawdata_temp.refnum1
"refnum1" ? ? "character" ? ? ? ? ? ? no ? no no "15.57" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   = giph.gi_rawdata_temp.refdate
     _FldNameList[17]   > giph.gi_rawdata_temp.refnum2
"refnum2" ? ? "character" ? ? ? ? ? ? no ? no no "13.72" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > giph.gi_rawdata_temp.partyname
"partyname" ? ? "character" ? ? ? ? ? ? no ? no no "27.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > giph.gi_rawdata_temp.particulars
"particulars" ? ? "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > giph.gi_rawdata_temp.currency-data
"currency-data" ? ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   = giph.gi_rawdata_temp.amount
     _FldNameList[22]   = giph.gi_rawdata_temp.debit
     _FldNameList[23]   = giph.gi_rawdata_temp.credit
     _FldNameList[24]   = giph.gi_rawdata_temp.runbal1
     _FldNameList[25]   = giph.gi_rawdata_temp.runbal2
     _FldNameList[26]   = giph.gi_rawdata_temp.report-txt
     _FldNameList[27]   = giph.gi_rawdata_temp.amt1
     _FldNameList[28]   = giph.gi_rawdata_temp.amt2
     _FldNameList[29]   = giph.gi_rawdata_temp.amt3
     _FldNameList[30]   = giph.gi_rawdata_temp.amt4
     _FldNameList[31]   = giph.gi_rawdata_temp.report-txt2
     _FldNameList[32]   > giph.gi_rawdata_temp.ori-filename
"ori-filename" ? ? "character" ? ? ? ? ? ? yes ? no no ? yes no yes "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
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


&Scoped-define SELF-NAME BtnImport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BtnImport wWin
ON CHOOSE OF BtnImport IN FRAME fMain /* Import */
DO:
  SESSION:SET-WAIT-STATE("GENERAL").
  RUN c:\pvr\giph\lib\ImportRawData_temp1.p.
  SESSION:SET-WAIT-STATE("").

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
  ENABLE BROWSE-1 BtnImport 
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
    {&OPEN-QUERY-BROWSE-1}
    APPLY "Value-Changed" TO BROWSE-1.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

