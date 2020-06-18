DEF NEW SHARED VAR pfilename-csv AS CHAR.
DEFINE VARIABLE cDir AS CHARACTER NO-UNDO INITIAL 'C:\pvr\giph\GL2019-CSV\temp'.
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.
DEF VAR pcons AS INT.
DEF VAR n AS INT.


DEF TEMP-TABLE det
    FIELD cDir AS CHARACTER FORMAT "x(100)"
    FIELD cFileStream AS CHAR FORMAT "x(100)"
    FIELD cFilename AS CHAR FORMAT "x(100)"
    .

INPUT FROM OS-DIR (cDir).
REPEAT:
    IMPORT cFileStream.
    FILE-INFO:FILE-NAME = cDir + "\" + cFileStream.
    CREATE det.
    ASSIGN det.cFilename = FILE-INFO:FILE-NAME.
END.
INPUT CLOSE.



DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pfilename-correction AS CHAR FORMAT "x(200)".

ASSIGN pfilename-import     = "C:\pvr\giph\GL2019-CSV\temp\13th_month_pay_temp2.csv".
ASSIGN pfilename-correction = "C:\pvr\giph\GL2019-CSV\temp\13th_month_pay_temp3.csv".
/*ASSIGN pfilename-correction = "C:\pvr\giph\GL2019-CSV\temp\13th_month_pay_temp.csv".*/
MESSAGE "Deleting raw data". PAUSE 1.
FOR EACH gi_rawdata_temp: 

    /*
    FOR EACH gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_rawdata_temp.refnum1:
        DELETE gi_acc_hea.
    END.
    FOR EACH gi_acc_det WHERE gi_acc_det.refnum1 = gi_rawdata_temp.refnum1:
        DELETE gi_acc_det.
    END.
    */
    DELETE gi_rawdata_temp. 
    
END.



OS-COMMAND SILENT c:\pvr\quoter.exe -d ',' VALUE(pfilename-import) > VALUE(pfilename-correction). 

MESSAGE "Importing raw data". PAUSE 1.
/*INPUT FROM VALUE(pfilename-import).*/
INPUT FROM VALUE(pfilename-correction).
REPEAT:
    pcons = pcons + 1.
    CREATE gi_rawdata_temp.
    ASSIGN gi_rawdata_temp.cons = pcons.
    
    
    IMPORT 
        gi_rawdata_temp.period-txt 
        gi_rawdata_temp.accountanalysis-txt 
        gi_rawdata_temp.account-txt 
        gi_rawdata_temp.bookno-txt 
        gi_rawdata_temp.date-txt 
        gi_rawdata_temp.refno-txt 
        gi_rawdata_temp.name-txt 
        gi_rawdata_temp.particulars-txt 
        gi_rawdata_temp.currency-txt 
        gi_rawdata_temp.amount-txt 
        gi_rawdata_temp.debit-txt 
        gi_rawdata_temp.credit-txt 
        gi_rawdata_temp.runbal1-txt 
        gi_rawdata_temp.runbal2-txt

        gi_rawdata_temp.refnum1 
        gi_rawdata_temp.refdate 
        gi_rawdata_temp.refnum2 
        gi_rawdata_temp.partyname 
        gi_rawdata_temp.particulars 
        gi_rawdata_temp.currency-data 
        gi_rawdata_temp.amount 
        gi_rawdata_temp.debit 
        gi_rawdata_temp.credit 
        gi_rawdata_temp.runbal1 
        gi_rawdata_temp.runbal2 
        gi_rawdata_temp.report-txt 
        gi_rawdata_temp.amt1 
        gi_rawdata_temp.amt2 
        gi_rawdata_temp.amt3 
        gi_rawdata_temp.amt4 
        gi_rawdata_temp.report-txt2 
        gi_rawdata_temp.alias-name
       /* gi_rawdata_temp.amt5 */
        .




     /*   
    MESSAGE 
        REPLACE((ENTRY(21,gi_rawdata_temp.text-ori)),'"','')
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
        

     ASSIGN gi_rawdata_temp.period-txt              = REPLACE((ENTRY(1,gi_rawdata_temp.text-ori)),'"','').
     ASSIGN gi_rawdata_temp.accountanalysis-txt     = REPLACE((ENTRY(2,gi_rawdata_temp.text-ori)),'"','').
     ASSIGN gi_rawdata_temp.account-txt             = REPLACE((ENTRY(3,gi_rawdata_temp.text-ori)),'"','').
     
    ASSIGN gi_rawdata_temp.bookno-txt               = REPLACE((ENTRY(4,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.date-txt                 = REPLACE((ENTRY(5,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.refno-txt                = REPLACE((ENTRY(6,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.name-txt                 = REPLACE((ENTRY(7,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.particulars-txt          = REPLACE((ENTRY(8,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.currency-txt             = REPLACE((ENTRY(9,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.amount-txt               = REPLACE((ENTRY(10,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.debit-txt                = REPLACE((ENTRY(11,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.credit-txt               = REPLACE((ENTRY(12,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.runbal1-txt              = REPLACE((ENTRY(13,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.runbal2-txt              = REPLACE((ENTRY(14,gi_rawdata_temp.text-ori)),'"','').   
    ASSIGN gi_rawdata_temp.refnum1                  = REPLACE((ENTRY(15,gi_rawdata_temp.text-ori)),'"','').      
    ASSIGN gi_rawdata_temp.refdate                  = DATE(REPLACE((ENTRY(16,gi_rawdata_temp.text-ori)),'"','')). 
    ASSIGN gi_rawdata_temp.refnum2                  = REPLACE((ENTRY(17,gi_rawdata_temp.text-ori)),'"','').                         
    
    ASSIGN gi_rawdata_temp.partyname                = REPLACE((ENTRY(18,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.particulars              = REPLACE((ENTRY(19,gi_rawdata_temp.text-ori)),'"',''). 
    ASSIGN gi_rawdata_temp.currency-data            = REPLACE((ENTRY(20,gi_rawdata_temp.text-ori)),'"',''). 
    ASSIGN gi_rawdata_temp.amount                   = DEC(REPLACE((ENTRY(21,gi_rawdata_temp.text-ori)),'"','')). /*
    ASSIGN gi_rawdata_temp.debit                    = DEC(REPLACE((ENTRY(22,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.credit                   = DEC(REPLACE((ENTRY(23,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.runbal1                  = DEC(REPLACE((ENTRY(24,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.runbal2                  = DEC(REPLACE((ENTRY(25,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.report-txt               = REPLACE((ENTRY(26,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.amt1                     = DEC(REPLACE((ENTRY(27,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.amt2                     = DEC(REPLACE((ENTRY(28,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.amt3                     = DEC(REPLACE((ENTRY(29,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.amt4                     = DEC(REPLACE((ENTRY(30,gi_rawdata_temp.text-ori)),'"','')).
    ASSIGN gi_rawdata_temp.report-txt2              = REPLACE((ENTRY(31,gi_rawdata_temp.text-ori)),'"','').
    ASSIGN gi_rawdata_temp.alias-name               = REPLACE((ENTRY(32,gi_rawdata_temp.text-ori)),'"','').      
    */

/* ASSIGN gi_rawdata_temp.amt5 = REPLACE((ENTRY(33,gi_rawdata_temp.text-ori)),'"',''). */
    ASSIGN gi_rawdata_temp.cons = pcons.
       */
    
    MESSAGE pcons
        gi_rawdata_temp.period-txt 
        gi_rawdata_temp.accountanalysis-txt 
        gi_rawdata_temp.account-txt 
        
        . PAUSE. 
        
        /*
    ASSIGN gi_rawdata_temp.acc-led-name = REPLACE(gi_rawdata_temp.account-txt,"Account  : ","").
    ASSIGN gi_rawdata_temp.currency = ENTRY(1,REPLACE(gi_rawdata_temp.currency-data,"@",",")) NO-ERROR.
    ASSIGN gi_rawdata_temp.forex-rate = DEC(ENTRY(2,REPLACE(gi_rawdata_temp.currency-data,"@",","))) NO-ERROR.
          */

END.
INPUT CLOSE.
MESSAGE "Finished raw data import". PAUSE 0.



/*
    IMPORT DELIMITER ","
        gi_rawdata_temp.period-txt 
        gi_rawdata_temp.accountanalysis-txt 
        gi_rawdata_temp.account-txt 
        gi_rawdata_temp.bookno-txt 
        gi_rawdata_temp.date-txt 
        gi_rawdata_temp.refno-txt 
        gi_rawdata_temp.name-txt 
        gi_rawdata_temp.particulars-txt 
        gi_rawdata_temp.currency-txt 
        gi_rawdata_temp.amount-txt 
        gi_rawdata_temp.debit-txt 
        gi_rawdata_temp.credit-txt 
        gi_rawdata_temp.runbal1-txt 
        gi_rawdata_temp.runbal2-txt

        gi_rawdata_temp.refnum1 
        gi_rawdata_temp.refdate 
        gi_rawdata_temp.refnum2 
        gi_rawdata_temp.partyname 
        gi_rawdata_temp.particulars 
        gi_rawdata_temp.currency-data 
        gi_rawdata_temp.amount 
        gi_rawdata_temp.debit 
        gi_rawdata_temp.credit 
        gi_rawdata_temp.runbal1 
        gi_rawdata_temp.runbal2 
        gi_rawdata_temp.report-txt 
        gi_rawdata_temp.amt1 
        gi_rawdata_temp.amt2 
        gi_rawdata_temp.amt3 
        gi_rawdata_temp.amt4 
        gi_rawdata_temp.report-txt2 
        gi_rawdata_temp.alias-name
       /* gi_rawdata_temp.amt5 */


*/
