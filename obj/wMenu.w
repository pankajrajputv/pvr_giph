&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
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

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE SUB-MENU m_Masters 
       MENU-ITEM m_Party_Ledger LABEL "Party Ledger"  
       MENU-ITEM m_Accounting_Groups LABEL "Accounting Groups"
       MENU-ITEM m_Agent_Account LABEL "Agent Account" 
       MENU-ITEM m_Ledgers      LABEL "Ledgers"       
       MENU-ITEM m_Product      LABEL "Product"       .

DEFINE SUB-MENU m_Data 
       MENU-ITEM m_Ferry        LABEL "Ferry"         
       MENU-ITEM m_Packages     LABEL "Packages"      
       MENU-ITEM m_Visa         LABEL "Visa"          
       MENU-ITEM m_Hotel        LABEL "Hotel"         
       MENU-ITEM m_ECPay        LABEL "ECPay"         
       MENU-ITEM m_Mobile       LABEL "Mobile"        
       MENU-ITEM m_Insurance    LABEL "Insurance"     
       MENU-ITEM m_Bus          LABEL "Bus"           
       MENU-ITEM m_Airline_IATA LABEL "Airline IATA"  
       MENU-ITEM m_Agent_Data   LABEL "Agent Data"    
       MENU-ITEM m_Airline      LABEL "Airline"       
       MENU-ITEM m_Banks_Transactions LABEL "Banks Transactions"
       MENU-ITEM m_Transactions LABEL "Transactions"  
       MENU-ITEM m_View_Transaction_by_Party_N LABEL "View Transaction by Party Name".

DEFINE SUB-MENU m_Tools 
       MENU-ITEM m_Data_Validation LABEL "Data Validation"
       MENU-ITEM m_Export_to_BI LABEL "Export to BI"  .

DEFINE MENU MENU-BAR-wWin MENUBAR
       SUB-MENU  m_Masters      LABEL "Masters"       
       SUB-MENU  m_Data         LABEL "Data"          
       SUB-MENU  m_Tools        LABEL "Tools"         
       MENU-ITEM m_Exit         LABEL "Exit"          .


/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 56.72 BY .92 WIDGET-ID 100.


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
         TITLE              = "Menu"
         HEIGHT             = .46
         WIDTH              = 56.72
         MAX-HEIGHT         = 28.81
         MAX-WIDTH          = 146.14
         VIRTUAL-HEIGHT     = 28.81
         VIRTUAL-WIDTH      = 146.14
         MAX-BUTTON         = no
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Menu */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Menu */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Accounting_Groups
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Accounting_Groups wWin
ON CHOOSE OF MENU-ITEM m_Accounting_Groups /* Accounting Groups */
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


&Scoped-define SELF-NAME m_Airline
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Airline wWin
ON CHOOSE OF MENU-ITEM m_Airline /* Airline */
DO:
      RUN C:\pvr\giph\obj\wdata_airline_name.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Airline_IATA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Airline_IATA wWin
ON CHOOSE OF MENU-ITEM m_Airline_IATA /* Airline IATA */
DO:
  RUN C:\pvr\giph\obj\wdata_airline_iata.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Banks_Transactions
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Banks_Transactions wWin
ON CHOOSE OF MENU-ITEM m_Banks_Transactions /* Banks Transactions */
DO:
  RUN C:\pvr\giph\obj\wdata_banks.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Bus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Bus wWin
ON CHOOSE OF MENU-ITEM m_Bus /* Bus */
DO:
    RUN C:\pvr\giph\obj\wdata_bus.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Data_Validation
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Data_Validation wWin
ON CHOOSE OF MENU-ITEM m_Data_Validation /* Data Validation */
DO:
    SESSION:SET-WAIT-STATE("GENERAL").
  RUN C:\pvr\giph\lib\data_validation.p.
  SESSION:SET-WAIT-STATE("").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_ECPay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_ECPay wWin
ON CHOOSE OF MENU-ITEM m_ECPay /* ECPay */
DO:
    RUN C:\pvr\giph\obj\wdata_ecpay.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Export_to_BI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Export_to_BI wWin
ON CHOOSE OF MENU-ITEM m_Export_to_BI /* Export to BI */
DO:
    SESSION:SET-WAIT-STATE("GENERAL").
  RUN C:\pvr\giph\lib\EXPORT_to_bi.p.
  SESSION:SET-WAIT-STATE("").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Ferry
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Ferry wWin
ON CHOOSE OF MENU-ITEM m_Ferry /* Ferry */
DO:

  RUN C:\pvr\giph\obj\wdata_ferry.w.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Hotel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Hotel wWin
ON CHOOSE OF MENU-ITEM m_Hotel /* Hotel */
DO:
    RUN C:\pvr\giph\obj\wdata_hotel.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Insurance
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Insurance wWin
ON CHOOSE OF MENU-ITEM m_Insurance /* Insurance */
DO:
      RUN C:\pvr\giph\obj\wdata_insurance.w.
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


&Scoped-define SELF-NAME m_Mobile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Mobile wWin
ON CHOOSE OF MENU-ITEM m_Mobile /* Mobile */
DO:
    RUN C:\pvr\giph\obj\wdata_mobile.w.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Packages
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Packages wWin
ON CHOOSE OF MENU-ITEM m_Packages /* Packages */
DO:
    RUN C:\pvr\giph\obj\wdata_packages.w.
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


&Scoped-define SELF-NAME m_Transactions
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Transactions wWin
ON CHOOSE OF MENU-ITEM m_Transactions /* Transactions */
DO:
      RUN C:\pvr\giph\obj\wtransactions.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_View_Transaction_by_Party_N
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_View_Transaction_by_Party_N wWin
ON CHOOSE OF MENU-ITEM m_View_Transaction_by_Party_N /* View Transaction by Party Name */
DO:
  
  RUN C:\pvr\giph\obj\wTransactionPartyName.w.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Visa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Visa wWin
ON CHOOSE OF MENU-ITEM m_Visa /* Visa */
DO:
    RUN C:\pvr\giph\obj\wdata_visa.w.
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
  VIEW FRAME fMain IN WINDOW wWin.
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

