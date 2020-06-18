/*
DEF SHARED VAR pbank-cons-ini LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-cons-fin LIKE gi_data_banks.bank-cons. 
DEF SHARED VAR pbank-code LIKE gi_data_banks.bank-code.
DEF SHARED VAR pbank-des LIKE gi_data_banks.bank-des.
*/
DEF VAR pfilename AS CHAR FORMAT "x(200)".
DEF VAR pdate AS DATE.

ASSIGN pfilename = "C:\pvr\giph\Bank_Reports\" + "Bank_Data.csv".

OUTPUT TO VALUE(pfilename).
EXPORT DELIMITER ","
    "Bank"     
    "Cons"     
    "Month"    
    "Reg"      
    "Date"     
    "Refnum"   
    "DateIssue" 
    "Debit"     
    "Credit"    
    "Bal"      
    "USD Db"   
    "USD Cr"   
    "Ch Num"   
    "Refnum1"     
    "Refnum1a"    
    "Remarks"     
    "Remarks"     
    "Acc Ori"      
    "Acc Des"      
    "Receiver"     
    "Payer"      
    "Narration"  
    "Rate"      
    "LedgerDb"  
    "LedgerCr"  
    "Partyname" 
    "Alias"     
    "VchId"     
    "MonthFN"   
    "Tran"      
    "Conv"      
    "Branch"    
    "Description" 
.
 FOR EACH gi_data_banks 
     BREAK BY gi_data_banks.bank-code
           BY gi_data_banks.bank-cons:     
     EXPORT DELIMITER ","
        gi_data_banks.bank-code          
        gi_data_banks.bank-cons         
        gi_data_banks.YearMonth         
        gi_data_banks.bank-reg          
        gi_data_banks.date-cleared      
        gi_data_banks.tran-refnum1      
        gi_data_banks.date-issue        
        gi_data_banks.amt-db            
        gi_data_banks.amt-cr            
        gi_data_banks.amt-bal           
        gi_data_banks.usd-amt-db        
        gi_data_banks.usd-amt-cr        
        gi_data_banks.ch-num            
        gi_data_banks.refnum1           
        gi_data_banks.refnum1a          
        gi_data_banks.remarks           
        gi_data_banks.remarks1          
        gi_data_banks.acc-origin        
        gi_data_banks.acc-destination   
        gi_data_banks.acc-receiver      
        gi_data_banks.acc-payer         
        gi_data_banks.narration         
        gi_data_banks.rate-exchange     
        gi_data_banks.ledger-db         
        gi_data_banks.ledger-cr         
        gi_data_banks.party-name        
        gi_data_banks.alias-name        
        gi_data_banks.LastVchId         
        gi_data_banks.YearMonthFN       
        gi_data_banks.has-tran          
         gi_data_banks.conv-val          
         gi_data_banks.branch            
         gi_data_banks.description       
        .

END.
OUTPUT CLOSE.

OS-COMMAND NO-WAIT VALUE(pfilename).


