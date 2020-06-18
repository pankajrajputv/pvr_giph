DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.

/*ASSIGN pfilename-import = "c:\pvr\giph\tempdata\data3.csv".*/
ASSIGN pfilename-import = "C:\pvr\giph\GL2019-CSV\temp\data5.csv".
MESSAGE "Deleting raw data". PAUSE 1.
FOR EACH gi_rawdata: 

    /*
    FOR EACH gi_acc_hea WHERE gi_acc_hea.refnum1 = gi_rawdata.refnum1:
        DELETE gi_acc_hea.
    END.
    FOR EACH gi_acc_det WHERE gi_acc_det.refnum1 = gi_rawdata.refnum1:
        DELETE gi_acc_det.
    END.
    */
    DELETE gi_rawdata. 
    
END.

MESSAGE "Importing raw data". PAUSE 1.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    pcons = pcons + 1.
    CREATE gi_rawdata.
    ASSIGN gi_rawdata.cons = pcons.
    IMPORT DELIMITER ","
        gi_rawdata.period-txt 
        gi_rawdata.accountanalysis-txt 
        gi_rawdata.account-txt 
        gi_rawdata.bookno-txt 
        gi_rawdata.date-txt 
        gi_rawdata.refno-txt 
        gi_rawdata.name-txt 
        gi_rawdata.particulars-txt 
        gi_rawdata.currency-txt 
        gi_rawdata.amount-txt 
        gi_rawdata.debit-txt 
        gi_rawdata.credit-txt 
        gi_rawdata.runbal1-txt 
        gi_rawdata.runbal2-txt

        
        gi_rawdata.refnum1 
        gi_rawdata.refdate 
        gi_rawdata.refnum2 
        gi_rawdata.partyname 
        gi_rawdata.particulars 
        gi_rawdata.currency-data 
        
        gi_rawdata.txt-amount 
        gi_rawdata.txt-debit 
        gi_rawdata.txt-credit        
        gi_rawdata.txt-runbal1 
        gi_rawdata.txt-runbal2 
        /*
        gi_rawdata.amount 
        gi_rawdata.debit 
        gi_rawdata.credit        
        gi_rawdata.runbal1 
        gi_rawdata.runbal2 
          */
        gi_rawdata.report-txt   
        gi_rawdata.amt1-txt         
        gi_rawdata.amt2-txt         
        gi_rawdata.amt3-txt 
        gi_rawdata.amt4-txt 
        gi_rawdata.report-txt2 
        /*
        gi_rawdata.alias-name
          */
       /* gi_rawdata.amt5 */

    NO-ERROR.

 MESSAGE gi_rawdata.cons. PAUSE 0.


   
    IF gi_rawdata.txt-amount  = "-" THEN ASSIGN gi_rawdata.txt-amount  = "0".
    IF gi_rawdata.txt-debit   = "-" THEN ASSIGN gi_rawdata.txt-debit   = "0".
    IF gi_rawdata.txt-credit  = "-" THEN ASSIGN gi_rawdata.txt-credit  = "0".
    IF gi_rawdata.txt-runbal1 = "-" THEN ASSIGN gi_rawdata.txt-runbal1 = "0".
    IF gi_rawdata.txt-runbal2 = "-" THEN ASSIGN gi_rawdata.txt-runbal2 = "0".
     
   /*
ASSIGN gi_rawdata.amount  = DEC(gi_rawdata.txt-amount).
ASSIGN gi_rawdata.debit   = DEC(gi_rawdata.txt-debit)  .
ASSIGN gi_rawdata.credit  = DEC(gi_rawdata.txt-credit) .
ASSIGN gi_rawdata.runbal1 = DEC(gi_rawdata.txt-runbal1).
ASSIGN gi_rawdata.runbal2 = DEC(gi_rawdata.txt-runbal2).
     */


    /*MESSAGE pcons gi_rawdata.period-txt gi_rawdata.refnum1 . PAUSE .*/
    ASSIGN gi_rawdata.particulars = TRIM(gi_rawdata.particulars).
    
    ASSIGN gi_rawdata.acc-led-name = REPLACE(gi_rawdata.account-txt,"Account  : ","").
    ASSIGN gi_rawdata.currency = ENTRY(1,REPLACE(gi_rawdata.currency-data,"@",",")) NO-ERROR.
    ASSIGN gi_rawdata.forex-rate = DEC(ENTRY(2,REPLACE(gi_rawdata.currency-data,"@",","))) NO-ERROR.
      

END.
INPUT CLOSE.
MESSAGE "Finished raw data import". PAUSE 0.
