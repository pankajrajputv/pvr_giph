DEF VAR ptexto LIKE gi_acc_hea.particulars.


OUTPUT TO "C:\pvr\giph\bidata\gi_year_month.txt".
    EXPORT DELIMITER "^"
        "YearMonth"
        .
    PUT UNFORMATTED
        "2019-01" SKIP  
        "2019-02" SKIP 
        "2019-03" SKIP 
        "2019-04" SKIP 
        "2019-05" SKIP 
        "2019-06" SKIP 
        "2019-07" SKIP 
        "2019-08" SKIP 
        "2019-09" SKIP 
        "2019-10" SKIP 
        "2019-11" SKIP 
        "2019-12" SKIP 
        .

OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_year_month_fn.txt".
    EXPORT DELIMITER "^"
        "YearMonth"
        "YearMonthFN"
        .
    PUT UNFORMATTED 
        "2019-01" "^" "2019-01-01"  SKIP 
        "2019-01" "^" "2019-01-02"  SKIP 
        "2019-02" "^" "2019-02-01"  SKIP 
        "2019-02" "^" "2019-02-02"  SKIP 
        "2019-03" "^" "2019-03-01"  SKIP 
        "2019-03" "^" "2019-03-02"  SKIP 
        "2019-04" "^" "2019-04-01"  SKIP 
        "2019-04" "^" "2019-04-02"  SKIP 
        "2019-05" "^" "2019-05-01"  SKIP 
        "2019-05" "^" "2019-05-02"  SKIP 
        "2019-06" "^" "2019-06-01"  SKIP 
        "2019-06" "^" "2019-06-02"  SKIP 
        "2019-07" "^" "2019-07-01"  SKIP 
        "2019-07" "^" "2019-07-02"  SKIP 
        "2019-08" "^" "2019-08-01"  SKIP 
        "2019-08" "^" "2019-08-02"  SKIP 
        "2019-09" "^" "2019-09-01"  SKIP 
        "2019-09" "^" "2019-09-02"  SKIP 
        "2019-10" "^" "2019-10-01"  SKIP 
        "2019-10" "^" "2019-10-02"  SKIP 
        "2019-11" "^" "2019-11-01"  SKIP 
        "2019-11" "^" "2019-11-02"  SKIP 
        "2019-12" "^" "2019-12-01"  SKIP 
        "2019-12" "^" "2019-12-02"  SKIP 
        .

OUTPUT CLOSE.



OUTPUT TO "C:\pvr\giph\bidata\gi_acc_hea.txt".
    EXPORT DELIMITER "^"
        "refnum1"
        "vouchertype"
        "refdate"
        "refnum2"
        "IsContra"
        "IsJV"
        "IsReceipt"
        "IsPayment"
        "IsPurchase"
        "IsSales"
        "particulars"
        "debit"
        "credit"
        "dbcr-diff"
        "amount"
        "VchId"
        "YearMonth"
        "YearMonthFN"
        .

FOR EACH gi_acc_hea:

    ASSIGN ptexto = gi_acc_hea.particulars .
    ptexto = REPLACE(ptexto,"~r"," /// ") /* strip cr */.

    ptexto = REPLACE(ptexto,"~n"," /// ") /* strip lf */.

    EXPORT DELIMITER "^"
        gi_acc_hea.refnum1 
        gi_acc_hea.vouchertype
        gi_acc_hea.refdate 
        gi_acc_hea.refnum2 
        gi_acc_hea.IsContra 
        gi_acc_hea.IsJV 
        gi_acc_hea.IsReceipt 
        gi_acc_hea.IsPayment 
        gi_acc_hea.IsPurchase 
        gi_acc_hea.IsSales 
        /*gi_acc_hea.particulars */ ptexto
        gi_acc_hea.debit 
        gi_acc_hea.credit 
        gi_acc_hea.dbcr-diff 
        gi_acc_hea.amount 
        gi_acc_hea.lastvchid
        gi_acc_hea.yearmonth
        gi_acc_hea.yearmonthFN
         .

END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_acc_det.txt".
    EXPORT DELIMITER "^"
        "refnum1"
        "reg"
        "refdate"
        "refnum2"
        "acc-led-name"
        "partyname"
        "is-cheque"
        "cheque-num"
        "currency"
        "forex-rate"
        "particulars"
        "debit"
        "credit"
        "amount"
        "runbal1"
        "runbal2"
        "cons"
        "currency-data"
        "report-txt"
        "report-txt2"
        "amt1"
        "amt2"
        "amt3"
        "amt4"
        "amt5"
        "YearMonth"
        "YearMonthFN"
        "BankCons"
        .

FOR EACH gi_acc_det:
    EXPORT DELIMITER "^"
        gi_acc_det.refnum1 
        gi_acc_det.reg 
        gi_acc_det.refdate 
        gi_acc_det.refnum2 
        gi_acc_det.acc-led-name 
        gi_acc_det.partyname 
        gi_acc_det.is-cheque 
        gi_acc_det.cheque-num 
        gi_acc_det.currency 
        gi_acc_det.forex-rate 
        gi_acc_det.particulars 
        gi_acc_det.debit 
        gi_acc_det.credit 
        gi_acc_det.amount 
        gi_acc_det.runbal1 
        gi_acc_det.runbal2
        gi_acc_det.cons 
        gi_acc_det.currency-data 
        gi_acc_det.report-txt 
        gi_acc_det.report-txt2 
        gi_acc_det.amt1 
        gi_acc_det.amt2 
        gi_acc_det.amt3 
        gi_acc_det.amt4 
        gi_acc_det.amt5 
        gi_acc_det.yearmonth
        gi_acc_det.yearmonthFN
        gi_acc_det.bank-cons
        .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_acc_grp.txt".
EXPORT DELIMITER "^"
    "acc-grp-name"
    "acc-grp-type"
    "tally-acc-grp"
    .

FOR EACH gi_acc_grp:
    EXPORT DELIMITER "^"
        gi_acc_grp.acc-grp-name 
        gi_acc_grp.acc-grp-type 
        gi_acc_grp.tally-acc-grp
        .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_acc_led.txt".
EXPORT DELIMITER "^"
    "acc-led-name"
    "acc-grp-name"
    "tally-acc-ledger"
    "IsAP"
    "IsAR"
    "IsBank"
    "IsCash"
    "IsExpenses"
    "IsIncome"
    .

FOR EACH gi_acc_led:
    EXPORT DELIMITER "^"
        gi_acc_led.acc-led-name 
        gi_acc_led.acc-grp-name 
        gi_acc_led.tally-acc-ledger     
        gi_acc_led.IsAP 
        gi_acc_led.IsAR 
        gi_acc_led.IsBank 
        gi_acc_led.IsCash 
        gi_acc_led.IsExpenses 
        gi_acc_led.IsIncome 
        .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_acc_party.txt".
EXPORT DELIMITER "^"
    "party-name"
    "acc-led-name"
    "product"
    "tally-acc-party "
    .
FOR EACH gi_acc_party
    BREAK BY gi_acc_party.party-name:
    IF FIRST-OF(gi_acc_party.party-name) THEN DO:
        EXPORT DELIMITER "^"
            gi_acc_party.party-name 
            gi_acc_party.acc-led-name 
            gi_acc_party.product 
            gi_acc_party.tally-acc-party
            .

    END.
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_product.txt".
EXPORT DELIMITER "^"
    "ProductName"
    .
FOR EACH gi_product:
    EXPORT DELIMITER "^"
        gi_product.ProductName 
        .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_agent.txt".
EXPORT DELIMITER "^"
    "CompanyName" 
    "AgentCons" 
    "CreditAmount" 
    "DateTime1" 
    "DateTime11" 
    "Datetime2" 
    "DateTime22" 
    "DebitAmount" 
    "Description" 
    "EnteredBy" 
    "ODAmount" 
    "Productname" 
    "Remarks" 
    "SmartRemaining" 
    "TerminalName" 
    "TransactionId" 
    "TravelAgentId" 
    "YearMonth1" 
    "YearMonth2"
    "YearMonth1FN"   
    "YearMonth1Week" 
        .
FOR EACH gi_agent:
    EXPORT DELIMITER "^"
        gi_agent.CompanyName 
        gi_agent.cons 
        gi_agent.CreditAmount 
        gi_agent.DateTime1 
        gi_agent.DateTime11 
        gi_agent.Datetime2 
        gi_agent.DateTime22 
        gi_agent.DebitAmount 
        gi_agent.Description 
        gi_agent.EnteredBy 
        gi_agent.ODAmount 
        gi_agent.Productname 
        gi_agent.Remarks 
        gi_agent.SmartRemaining 
        gi_agent.TerminalName 
        gi_agent.TransactionId 
        gi_agent.TravelAgentId 
        gi_agent.YearMonth1 
        gi_agent.YearMonth2
        gi_agent.YearMonth1FN 
        gi_agent.YearMonth1Week

        .
END.
OUTPUT CLOSE.


OUTPUT TO "C:\pvr\giph\bidata\gi_mt_agent.txt".
EXPORT DELIMITER "^"
    "MTAgentCons" 
    "CreditAmount" 
    "creditamount-txt" 
    "DateTime1" 
    "DateTime11" 
    "DebitAmount" 
    "Debitamount-txt" 
    "Description" 
    "Enteredby" 
    "Month" 
    "MTAgentName" 
    "MtAgentRemaining" 
    "MtAgentRemaining-txt" 
    "ODAmount" 
    "ODAmount-txt" 
    "Product" 
    "Remarks" 
    "TransactionId" 
    "YearMonth1"
    "YearMonth1FN"   
    "YearMonth1Week" 
        .

FOR EACH gi_mt_agent:
    EXPORT DELIMITER "^"
        gi_mt_agent.cons 
        gi_mt_agent.CreditAmount 
        gi_mt_agent.creditamount-txt 
        gi_mt_agent.DateTime1 
        gi_mt_agent.DateTime11 
        gi_mt_agent.DebitAmount 
        gi_mt_agent.debitamount-txt 
        gi_mt_agent.Description 
        gi_mt_agent.Enteredby 
        gi_mt_agent.month 
        gi_mt_agent.MTAgentName 
        gi_mt_agent.MtAgentRemaining 
        gi_mt_agent.MtAgentRemaining-txt 
        gi_mt_agent.ODAmount 
        gi_mt_agent.ODAmount-txt 
        gi_mt_agent.Product 
        gi_mt_agent.Remarks 
        gi_mt_agent.TransactionId 
        gi_mt_agent.YearMonth1
        gi_mt_agent.YearMonth1FN 
        gi_mt_agent.YearMonth1Week
        .
END.
OUTPUT CLOSE.


OUTPUT TO "C:\pvr\giph\bidata\gi_transaction_id.txt".
EXPORT DELIMITER "^"
    "TransactionID"
    .
FOR EACH gi_transaction_id:
    EXPORT DELIMITER "^"
        gi_transaction_id.TransactionId 
        .
END.
OUTPUT CLOSE.


OUTPUT TO "C:\pvr\giph\bidata\gi_data_airline.txt".
EXPORT DELIMITER "^"
    "YearMonth"
    "TrnsType"
    "AirlinesName"
    "AgentName"
    "TravelAgentId"
    "IATAStock"
    "BKPNR"
    "AirlinePNR"
    "CRSPNR"
    "TicketNumber"
    "TravelType"
    "MTAgentName"
    "SalesPersonName"
    "IssuedDate"
    "NoOfSegments"
    "Segments"
    "BasicAmt"
    "Tax"
    "TopUpAmt"
    "MtagentComm"
    "TransFee"
    "Penalty"
    "AgentComm"
    "CollectFromAgent"
    "SupplierComm"
    "PayableToAirline"
    "SegmentFee"
    "Profit"
    "ClassCode"
    "Airline-Cons"
    "YearMonthFN"
    "TopUpamt1"
    "MtAgentcomm1"
    "TransFee1"
    "AgentComm1"
    "CollectFromAgent1"
    "SupplierComm1"
    "PayableToAirline1"
    "Inputvat"
    "Outputvat"
    .

FOR EACH gi_data_airline:
    IF gi_data_airline.trnstype = "Total" THEN DO: DELETE gi_data_airline.
        NEXT.
    END.
    EXPORT DELIMITER "^"
        gi_data_airline.YearMonth
        gi_data_airline.TrnsType	
        gi_data_airline.AirlinesName	
        gi_data_airline.AgentName	
        gi_data_airline.TravelAgentId	
        gi_data_airline.IATAStock	
        gi_data_airline.BKPNR	
        gi_data_airline.AirlinePNR	
        gi_data_airline.CRSPNR	
        gi_data_airline.TicketNumber	
        gi_data_airline.TravelType	
        gi_data_airline.MTAgentName	
        gi_data_airline.SalesPersonName	
        gi_data_airline.IssuedDate	
        gi_data_airline.NoOfSegments	
        gi_data_airline.Segments	
        gi_data_airline.BasicAmt	
        gi_data_airline.Tax	
        gi_data_airline.TopUpAmt	
        gi_data_airline.MtagentComm
        gi_data_airline.TransFee	
        gi_data_airline.Penalty	
        gi_data_airline.AgentComm
        gi_data_airline.CollectFromAgent	
        gi_data_airline.SupplierComm
        gi_data_airline.PayableToAirline	
        gi_data_airline.SegmentFee	
        gi_data_airline.Profit
        gi_data_airline.ClassCode
        gi_data_airline.Airline-Cons
        gi_data_airline.YearMonthFN
        gi_data_airline.topupamt1        
        gi_data_airline.mtagentcomm1     
        gi_data_airline.transfee1        
        gi_data_airline.agentcomm1       
        gi_data_airline.CollectFromAgent1
        gi_data_airline.SupplierComm1    
        gi_data_airline.PayableToAirline1
        gi_data_airline.inputvat         
        gi_data_airline.outputvat        
        .
END.
OUTPUT CLOSE.


OUTPUT TO "C:\pvr\giph\bidata\gi_data_airline_sum.txt".
EXPORT DELIMITER "^"
        "AgentComm"                             
        "AgentComm1"
        "airline-sum-cons"
        "BasicAmt"
        "CollectFromAgent"
        "CollectFromAgent1"
        "IATAStock"
        "InputVat"
        "MTAgentComm"
        "MTAgentComm1"
        "OutputVat"
        "PayableToAirline"
        "PayableToAirline1"
        "Penalty"
        "Profit"
        "SegmentFee"
        "SegmentFee1"
        "SupplierComm"
        "SupplierComm1"
        "Tax"
        "TopUpAmt"
        "TopUpAmt1"
        "total-cr"
        "total-db"
        "total-db-cr-diff"
        "TransFee"
        "TransFee1"
        "YearMonth"
        "YearMonthFN"
        "VchId"
  .
FOR EACH gi_data_airline_sum:
  EXPORT DELIMITER "^"
        gi_data_airline_sum.AgentComm 
        gi_data_airline_sum.AgentComm1 
        gi_data_airline_sum.airline-sum-cons 
        gi_data_airline_sum.BasicAmt 
        gi_data_airline_sum.CollectFromAgent 
        gi_data_airline_sum.CollectFromAgent1 
        gi_data_airline_sum.IATAStock 
        gi_data_airline_sum.InputVat 
        gi_data_airline_sum.MTAgentComm 
        gi_data_airline_sum.MTAgentComm1 
        gi_data_airline_sum.OutputVat 
        gi_data_airline_sum.PayableToAirline 
        gi_data_airline_sum.PayableToAirline1 
        gi_data_airline_sum.Penalty 
        gi_data_airline_sum.Profit 
        gi_data_airline_sum.SegmentFee 
        gi_data_airline_sum.SegmentFee1 
        gi_data_airline_sum.SupplierComm 
        gi_data_airline_sum.SupplierComm1 
        gi_data_airline_sum.Tax 
        gi_data_airline_sum.TopUpAmt 
        gi_data_airline_sum.TopUpAmt1 
        gi_data_airline_sum.total-cr 
        gi_data_airline_sum.total-db 
        gi_data_airline_sum.total-db-cr-diff 
        gi_data_airline_sum.TransFee 
        gi_data_airline_sum.TransFee1 
        gi_data_airline_sum.YearMonth 
        gi_data_airline_sum.YearMonthFN
        gi_data_airline_sum.lastvchid

      .
END.
OUTPUT CLOSE.
  
OUTPUT TO "C:\pvr\giph\bidata\gi_data_airline_sum1.txt".
EXPORT DELIMITER "^"
        "AirlinesName"
        "AgentComm"
        "AgentComm1"
        "Airline-sum1-cons"
        "BasicAmt"
        "CollectFromAgent"
        "CollectFromAgent1"
        "IATAStock"
        "InputVat"
        "MTAgentComm"
        "MTAgentComm1"
        "OutputVat"
        "PayableToAirline"
        "PayableToAirline1"
        "Penalty"
        "Profit"
        "SegmentFee"
        "SegmentFee1"
        "SupplierComm"
        "SupplierComm1"
        "Tax"
        "TopUpAmt"
        "TopUpAmt1"
        "total-cr"
        "total-db"
        "total-db-cr-diff"
        "TransFee"
        "TransFee1"
        "YearMonth"
        "YearMonthFN"
  .
FOR EACH gi_data_airline_sum1:
  EXPORT DELIMITER "^"
      gi_data_airline_sum1.AirlinesName	                                     
      gi_data_airline_sum1.AgentComm 
      gi_data_airline_sum1.AgentComm1 
      gi_data_airline_sum1.airline-sum1-cons 
      gi_data_airline_sum1.BasicAmt 
      gi_data_airline_sum1.CollectFromAgent 
      gi_data_airline_sum1.CollectFromAgent1 
      gi_data_airline_sum1.IATAStock 
      gi_data_airline_sum1.InputVat 
      gi_data_airline_sum1.MTAgentComm 
      gi_data_airline_sum1.MTAgentComm1 
      gi_data_airline_sum1.OutputVat 
      gi_data_airline_sum1.PayableToAirline 
      gi_data_airline_sum1.PayableToAirline1 
      gi_data_airline_sum1.Penalty 
      gi_data_airline_sum1.Profit 
      gi_data_airline_sum1.SegmentFee 
      gi_data_airline_sum1.SegmentFee1 
      gi_data_airline_sum1.SupplierComm 
      gi_data_airline_sum1.SupplierComm1 
      gi_data_airline_sum1.Tax 
      gi_data_airline_sum1.TopUpAmt 
      gi_data_airline_sum1.TopUpAmt1 
      gi_data_airline_sum1.total-cr 
      gi_data_airline_sum1.total-db 
      gi_data_airline_sum1.total-db-cr-diff 
      gi_data_airline_sum1.TransFee 
      gi_data_airline_sum1.TransFee1 
      gi_data_airline_sum1.YearMonth 
      gi_data_airline_sum1.YearMonthFN

      .
END.
OUTPUT CLOSE.
  

OUTPUT TO "C:\pvr\giph\bidata\gi_data_hotel.txt".
EXPORT DELIMITER "^"
    "YearMonFN"         
    "HotelCons"           
    "Transaction Id"     
    "TransType"        
    "TerminalId"        
    "CompanyName"       
    "HotelName"         
    "OperatorName"      
    "TranDateTxt"    
    "CollFromAgent"    
    "AgentComm"         
    "PayableToOperate" 
    "Profit"              
    "MTAgentComm"      
    "Date1"               
    "PartyName"          
    "DbGrossAmount"     
    "DbAgentComm"      
    "DbMTAgentComm"   
    "DbInputVat"       
    "CrMTAgentComm2"    
    "CrPayable"         
    "CrCommIncome"    
    "CrOutputVat"      
    "TotalDebit"        
    "TotalCredit"       
    "DbCrDiff"          
  .
FOR EACH gi_data_hotel:
  EXPORT DELIMITER "^"
      gi_data_hotel.YearMonthFN         
      gi_data_hotel.hotel-cons          
      gi_data_hotel.TransactionId       
      gi_data_hotel.TransType           
      gi_data_hotel.TerminalId          
      gi_data_hotel.CompanyName         
      gi_data_hotel.HotelName           
      gi_data_hotel.OperatorName        
      gi_data_hotel.TranDate-Txt        
      gi_data_hotel.CollectFromAgent    
      gi_data_hotel.AgentComm           
      gi_data_hotel.PayableToOperate    
      gi_data_hotel.Profit              
      gi_data_hotel.MTAgentComm         
      gi_data_hotel.date1               
      gi_data_hotel.party-name          
      gi_data_hotel.GrossAmount1        
      gi_data_hotel.AgentComm1          
      gi_data_hotel.MTAgentComm1        
      gi_data_hotel.InputVat            
      gi_data_hotel.MTAgentComm2        
      gi_data_hotel.Payable1            
      gi_data_hotel.comm-income1        
      gi_data_hotel.OutputVat           
      gi_data_hotel.total-db            
      gi_data_hotel.total-cr            
      gi_data_hotel.total-db-cr-diff    
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_hotel_sum.txt".
EXPORT DELIMITER "^"
    "YearMonthFN"             
    "HotelSumCons"            
    "VchId"                   
    "PartyName"               
    "CollFromAgent"           
    "AgentComm"               
    "PayableToOperate"        
    "Profit"                  
    "DbMTAgentComm"           
    "DbGrossAmount"           
    "DbAgentComm"             
    "DbMTAgentComm"           
    "DbInputVat"              
    "CrMTAgentComm2"          
    "CrPayable"               
    "CrCommIncome"            
    "CrOutput Vat"            
    "TotalDebit"              
    "TotalCredit"             
    "DbCrDiff"                
  .
FOR EACH gi_data_hotel_sum:
  EXPORT DELIMITER "^"
      gi_data_hotel_sum.YearMonthFN         
      gi_data_hotel_sum.hotel-sum-cons      
      gi_data_hotel_sum.LastVchId           
      gi_data_hotel_sum.party-name          
      gi_data_hotel_sum.CollectFromAgent    
      gi_data_hotel_sum.AgentComm           
      gi_data_hotel_sum.PayableToOperate    
      gi_data_hotel_sum.Profit              
      gi_data_hotel_sum.MTAgentComm         
      gi_data_hotel_sum.GrossAmount1        
      gi_data_hotel_sum.AgentComm1          
      gi_data_hotel_sum.MTAgentComm1        
      gi_data_hotel_sum.InputVat            
      gi_data_hotel_sum.MTAgentComm2        
      gi_data_hotel_sum.Payable1            
      gi_data_hotel_sum.comm-income1        
      gi_data_hotel_sum.OutputVat           
      gi_data_hotel_sum.total-db            
      gi_data_hotel_sum.total-cr            
      gi_data_hotel_sum.total-db-cr-diff    
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_mobile.txt".
EXPORT DELIMITER "^"
    "YearMonFN"       
    "MobileCons"      
    "AgentName"       
    "GroupDesc"       
    "ItemDesc"        
    "TransNo"         
    "MobileNo"        
    "RechargeDate"    
    "MRPValue"        
    "SupplierComm"    
    "Payable"         
    "AgentComm"       
    "CollFromAgent"   
    "TotalTSSComm"    
    "Profit"          
    "PartyName"       
    "Date"            
    "DbGrossAmount"   
    "CrPayable"       
    "CrCommIncome"    
    "CrOutputVat"     
    "TotalDebit"      
    "TotalCredit"     
    "DbCrDiff"        
    "AgentComm"       
  .
FOR EACH gi_data_mobile:
    EXPORT DELIMITER "^"
    gi_data_mobile.YearMonthFN        
    gi_data_mobile.mobile-cons        
    gi_data_mobile.AgentName          
    gi_data_mobile.GroupDesc          
    gi_data_mobile.ItemDesc           
    gi_data_mobile.TransNo            
    gi_data_mobile.MobileNo           
    gi_data_mobile.RechargeDateTxt    
    gi_data_mobile.MrpValue           
    gi_data_mobile.SupplierComm       
    gi_data_mobile.Payable            
    gi_data_mobile.AgentComm          
    gi_data_mobile.CollectFromAgent1  
    gi_data_mobile.TotalTssComm       
    gi_data_mobile.Profit             
    gi_data_mobile.party-name         
    gi_data_mobile.date1              
    gi_data_mobile.GrossAmount1       
    gi_data_mobile.Payable1           
    gi_data_mobile.comm-income1       
    gi_data_mobile.OutputVat          
    gi_data_mobile.total-db           
    gi_data_mobile.total-cr           
    gi_data_mobile.total-db-cr-diff   
    gi_data_mobile.AgentComm1         
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_mobile_sum.txt".
EXPORT DELIMITER "^"
    "YearMonthFN"  
    "PartyName"    
    "MRPValue"     
    "SupplierComm" 
    "Payable"      
    "AgentComm"    
    "CollFromAgent"
    "TotalTSSComm" 
    "Profit"       
    "DbGrossAmount"
    "CrPayable"    
    "CrCommIncome" 
    "CrOutputVat"  
    "TotalDebit"   
    "TotalCredit"  
    "DbCrDiff"     
    "Collectable"  
  .
FOR EACH gi_data_mobile_sum:
  EXPORT DELIMITER "^"
      gi_data_mobile_sum.YearMonthFN         
      gi_data_mobile_sum.party-name          
      gi_data_mobile_sum.MrpValue            
      gi_data_mobile_sum.SupplierComm        
      gi_data_mobile_sum.Payable             
      gi_data_mobile_sum.AgentComm           
      gi_data_mobile_sum.CollectFromAgent1    
      gi_data_mobile_sum.TotalTssComm        
      gi_data_mobile_sum.Profit              
      gi_data_mobile_sum.GrossAmount1         
      gi_data_mobile_sum.Payable1            
      gi_data_mobile_sum.comm-income1        
      gi_data_mobile_sum.OutputVat           
      gi_data_mobile_sum.total-db            
      gi_data_mobile_sum.total-cr            
      gi_data_mobile_sum.total-db-cr-diff    
      gi_data_mobile_sum.Collectable         
      .

END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_ferry.txt".
EXPORT DELIMITER "^"
    "YearMonFN" 
    "TravelAgentID" 
    "AgentName" 
    "TerminalId" 
    "TerminalName" 
    "ConfirmationNo" 
    "IssuedDateTxt" 
    "TravelType" 
    "TransType" 
    "NoOfSegment" 
    "NetFare" 
    "SCDiscount" 
    "DiscountFare" 
    "Fuel"
    "SecurityFee" 
    "TerminalFee" 
    "Meal"
    "Insurance" 
    "Linen"  
    "VatableAmount" 
    "Vat"
    "VatExempt" 
    "ZeroVat" 
    "TransactionFee" 
    "Penalty"
    "Handling Fee" 
    "CollFromAgent" 
    "Payable"
    "Profit"
    "SupplierComm" 
    "AgentComm" 
    "Operator"
    "Date1"
    "PartyName" 
    "DbGrossAmount" 
    "DbAgentComm" 
    "DbInputVat" 
    "CrPayable" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
    "YearMonth" 
    "FerryCons"
  .

FOR EACH gi_data_ferry:
  EXPORT DELIMITER "^"
      gi_data_ferry.YearMonthFN         
      gi_data_ferry.TravelAgentId       
      gi_data_ferry.AgentName           
      gi_data_ferry.TerminalId          
      gi_data_ferry.TerminalName        
      gi_data_ferry.ConfirmationNo       
      gi_data_ferry.TranDate-Txt         
      gi_data_ferry.TravelType          
      gi_data_ferry.TransType           
      gi_data_ferry.NoOfSegment         
      gi_data_ferry.NetFare             
      gi_data_ferry.ScDiscount          
      gi_data_ferry.DiscountFare        
      gi_data_ferry.Fuel                
      gi_data_ferry.SecurityFee         
      gi_data_ferry.TerminalFee         
      gi_data_ferry.Meal                
      gi_data_ferry.Insurance           
      gi_data_ferry.Linen               
      gi_data_ferry.VatableAmount       
      gi_data_ferry.Vat                 
      gi_data_ferry.VatExempt           
      gi_data_ferry.ZeroVat             
      gi_data_ferry.TransactionFee       
      gi_data_ferry.Penalty             
      gi_data_ferry.HandlingFee         
      gi_data_ferry.CollectFromAgent     
      gi_data_ferry.Payable             
      gi_data_ferry.Profit              
      gi_data_ferry.SupplierComm        
      gi_data_ferry.AgentComm           
      gi_data_ferry.Operator            
      gi_data_ferry.date1               
      gi_data_ferry.party-name          
      gi_data_ferry.GrossAmount1        
      gi_data_ferry.AgentComm1          
      gi_data_ferry.InputVat            
      gi_data_ferry.Payable1            
      gi_data_ferry.comm-income1        
      gi_data_ferry.OutputVat           
      gi_data_ferry.total-db            
      gi_data_ferry.total-cr            
      gi_data_ferry.total-db-cr-diff    
      gi_data_ferry.YearMonth           
      gi_data_ferry.ferry-cons          
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_ferry_sum.txt".
EXPORT DELIMITER "^"
    "FerrySumCons"
    "YearMonthFN" 
    "VchId"
    "PartyName" 
    "NetFare" 
    "SCDiscount" 
    "DiscountFare" 
    "Fuel"
    "SecurityFee" 
    "TerminalFee" 
    "Meal"
    "Insurance" 
    "Linen" 
    "VatableAmount" 
    "Vat"
    "VatExempt" 
    "ZeroVat" 
    "TransacFee" 
    "Penalty"
    "HandlingFee" 
    "CollFromAgent" 
    "Payable"
    "Profit"
    "SupplierComm" 
    "AgentComm" 
    "DbGrossAmount" 
    "DbAgentComm" 
    "DbInputVat" 
    "CrPayable" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
  .
FOR EACH gi_data_ferry_sum:
  EXPORT DELIMITER "^"
      gi_data_ferry_sum.ferry-sum-cons         
      gi_data_ferry_sum.YearMonthFN            
      gi_data_ferry_sum.LastVchId              
      gi_data_ferry_sum.party-name             
      gi_data_ferry_sum.NetFare                
      gi_data_ferry_sum.ScDiscount             
      gi_data_ferry_sum.DiscountFare           
      gi_data_ferry_sum.Fuel                   
      gi_data_ferry_sum.SecurityFee            
      gi_data_ferry_sum.TerminalFee            
      gi_data_ferry_sum.Meal                   
      gi_data_ferry_sum.Insurance              
      gi_data_ferry_sum.Linen                  
      gi_data_ferry_sum.VatableAmount          
      gi_data_ferry_sum.Vat                    
      gi_data_ferry_sum.VatExempt              
      gi_data_ferry_sum.ZeroVat                
      gi_data_ferry_sum.TransactionFee         
      gi_data_ferry_sum.Penalty                
      gi_data_ferry_sum.HandlingFee            
      gi_data_ferry_sum.CollectFromAgent       
      gi_data_ferry_sum.Payable                
      gi_data_ferry_sum.Profit                 
      gi_data_ferry_sum.SupplierComm           
      gi_data_ferry_sum.AgentComm              
      gi_data_ferry_sum.GrossAmount1           
      gi_data_ferry_sum.AgentComm1             
      gi_data_ferry_sum.InputVat               
      gi_data_ferry_sum.Payable1               
      gi_data_ferry_sum.comm-income1           
      gi_data_ferry_sum.OutputVat              
      gi_data_ferry_sum.total-db               
      gi_data_ferry_sum.total-cr               
      gi_data_ferry_sum.total-db-cr-diff       
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_insurance.txt".
EXPORT DELIMITER "^"
    "YearMonFN" 
    "InsuranceCons"
    "TravelAgentID" 
    "AgentName" 
    "TerminalId" 
    "TerminalName"
    "PolicyNo" 
    "PassengerName" 
    "BkPnr" 
    "TranDateTxt" 
    "TotPremiumAmt" 
    "SupplierComm" 
    "AgentComm" 
    "CollFromAgent" 
    "PayableToAirline" 
    "Payable"
    "Profit"
    "Date1"
    "PartyName" 
    "DbGrossAmount" 
    "DbAgentComm" 
    "DbInputVat" 
    "CrPayable" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
  .
FOR EACH gi_data_insurance:
  EXPORT DELIMITER "^"
      gi_data_insurance.YearMonthFN             
      gi_data_insurance.insurance-cons          
      gi_data_insurance.TravelAgentId           
      gi_data_insurance.AgentName               
      gi_data_insurance.TerminalId              
      gi_data_insurance.TerminalName            
      gi_data_insurance.PolicyNo                
      gi_data_insurance.PassengerName           
      gi_data_insurance.BkPnr                   
      gi_data_insurance.TranDate-Txt            
      gi_data_insurance.TotalPremiumAmount      
      gi_data_insurance.SupplierComm            
      gi_data_insurance.AgentComm               
      gi_data_insurance.CollectFromAgent        
      gi_data_insurance.PayableToSupplier       
      gi_data_insurance.Payable                 
      gi_data_insurance.Profit                  
      gi_data_insurance.date1                   
      gi_data_insurance.party-name              
      gi_data_insurance.GrossAmount1            
      gi_data_insurance.AgentComm1              
      gi_data_insurance.InputVat                
      gi_data_insurance.Payable1                
      gi_data_insurance.comm-income1            
      gi_data_insurance.OutputVat               
      gi_data_insurance.total-db                
      gi_data_insurance.total-cr                
      gi_data_insurance.total-db-cr-diff        
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_insurance_sum.txt".
EXPORT DELIMITER "^"
    "InsuranceSumCons"
    "YearMonthFN" 
    "VchId"
    "PartyName" 
    "TotPremiumAmt" 
    "SupplierComm" 
    "AgentComm" 
    "CollFromAgent" 
    "PayableToAirline" 
    "Payable"
    "Profit"
    "DbGrossAmount" 
    "DbAgentComm" 
    "DbInputVat" 
    "CrPayable" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
  .
FOR EACH gi_data_insurance_sum:
  EXPORT DELIMITER "^"
      gi_data_insurance_sum.insurance-sum-cons  
      gi_data_insurance_sum.YearMonthFN         
      gi_data_insurance_sum.LastVchId           
      gi_data_insurance_sum.party-name          
      gi_data_insurance_sum.TotalPremiumAmount  
      gi_data_insurance_sum.SupplierComm        
      gi_data_insurance_sum.AgentComm           
      gi_data_insurance_sum.CollectFromAgent    
      gi_data_insurance_sum.PayableToSupplier   
      gi_data_insurance_sum.Payable             
      gi_data_insurance_sum.Profit              
      gi_data_insurance_sum.GrossAmount1        
      gi_data_insurance_sum.AgentComm1          
      gi_data_insurance_sum.InputVat            
      gi_data_insurance_sum.Payable1            
      gi_data_insurance_sum.comm-income1        
      gi_data_insurance_sum.OutputVat           
      gi_data_insurance_sum.total-db            
      gi_data_insurance_sum.total-cr            
      gi_data_insurance_sum.total-db-cr-diff    
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_packages.txt".
EXPORT DELIMITER "^"
    "YearMonFN" 
    "BookingType" 
    "TransId" 
    "TravelAgentID" 
    "TerminalId" 
    "PackageSupplier" 
    "PackageType" 
    "PakageDiscription" 
    "BookingDate" 
    "SellingPrice" 
    "VatCollect." 
    "Markup"
    "TotalCollect." 
    "TotalPayable" 
    "VATPayable" 
    "AgentComm" 
    "MTagentComm" 
    "Profit"
    "NoOfAdults" 
    "TravelDate" 
    "BookedBY" 
    "Date1"
    "PartyName" 
    "DbSellingPrice" 
    "CrPayable" 
    "CrMark Up" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
    "PackagesCons"
  .
FOR EACH gi_data_packages:
  EXPORT DELIMITER "^"
      gi_data_packages.YearMonthFN              
      gi_data_packages.BookingType              
      gi_data_packages.TransId                  
      gi_data_packages.TravelAgentId            
      gi_data_packages.TerminalId               
      gi_data_packages.PackageSupplier          
      gi_data_packages.PackageType              
      gi_data_packages.PackageDescription       
      gi_data_packages.BookingDate              
      gi_data_packages.SellingPrice             
      gi_data_packages.VatCollectable           
      gi_data_packages.Markup                   
      gi_data_packages.TotalCollectable         
      gi_data_packages.TotalPayable             
      gi_data_packages.VATPayable               
      gi_data_packages.AgentComm                
      gi_data_packages.MTagentComm              
      gi_data_packages.Profit                   
      gi_data_packages.NoOfAdults               
      gi_data_packages.TravelDate               
      gi_data_packages.BookedBy                 
      gi_data_packages.date1                    
      gi_data_packages.party-name               
      gi_data_packages.SellingPrice1            
      gi_data_packages.Payable1                 
      gi_data_packages.MarkUp1                  
      gi_data_packages.OutputVat                
      gi_data_packages.total-db                 
      gi_data_packages.total-cr                 
      gi_data_packages.total-db-cr-diff         
      gi_data_packages.packages-cons            
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_packages_sum.txt".
EXPORT DELIMITER "^"
    "YearMonthFN" 
    "PackagesSumCon"
    "VchId"
    "PartyName" 
    "SellingPrice" 
    "VatCollectable" 
    "MarkUp"
    "TotalCollectable" 
    "TotalPayable" 
    "VATPayable" 
    "Payable"
    "AgentComm" 
    "MTagentComm" 
    "Profit"
    "DbSellingPrice" 
    "CrPayable" 
    "CrMarkUp" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
  .
FOR EACH gi_data_packages_sum:
  EXPORT DELIMITER "^"
      gi_data_packages_sum.YearMonthFN          
      gi_data_packages_sum.packages-sum-cons    
      gi_data_packages_sum.LastVchId            
      gi_data_packages_sum.party-name           
      gi_data_packages_sum.SellingPrice         
      gi_data_packages_sum.VatCollectable       
      gi_data_packages_sum.Markup               
      gi_data_packages_sum.TotalCollectable     
      gi_data_packages_sum.TotalPayable         
      gi_data_packages_sum.VATPayable           
      gi_data_packages_sum.Payable              
      gi_data_packages_sum.AgentComm            
      gi_data_packages_sum.MTagentComm          
      gi_data_packages_sum.Profit               
      gi_data_packages_sum.SellingPrice1        
      gi_data_packages_sum.Payable1             
      gi_data_packages_sum.MarkUp1              
      gi_data_packages_sum.OutputVat            
      gi_data_packages_sum.total-db             
      gi_data_packages_sum.total-cr             
      gi_data_packages_sum.total-db-cr-diff     
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_ecpay.txt".
EXPORT DELIMITER "^"
    "YearMonFN" 
    "EcpayCons"
    "SrNo" 
    "TransDateTxt" 
    "TravelAgentId" 
    "CompanyName" 
    "TraceNumber" 
    "CustomerId" 
    "BiyahekoPNR" 
    "TotalAmount" 
    "ConvFee" 
    "PayableToOperator" 
    "AgentComm" 
    "MtAgentComm" 
    "Profit"
    "Date1"
    "DbCollFromAgent" 
    "DbGrossAmount" 
    "DbAgentComm" 
    "DbInputVat" 
    "CrPayable" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
    "PartyName" 
  .
FOR EACH gi_data_ecpay:
  EXPORT DELIMITER "^"
      gi_data_ecpay.YearMonthFN             
      gi_data_ecpay.ecpay-cons              
      gi_data_ecpay.ecpay-sr-no             
      gi_data_ecpay.TranDate-Txt            
      gi_data_ecpay.TravelAgentId           
      gi_data_ecpay.CompanyName             
      gi_data_ecpay.TraceNumber             
      gi_data_ecpay.CustomerId              
      gi_data_ecpay.BiyahekoPNR             
      gi_data_ecpay.TotalAmount             
      gi_data_ecpay.ConvenienceFee          
      gi_data_ecpay.PayableToOperator        
      gi_data_ecpay.AgentComm               
      gi_data_ecpay.MtAgentComm             
      gi_data_ecpay.Profit                  
      gi_data_ecpay.date1                   
      gi_data_ecpay.CollectFromAgent         
      gi_data_ecpay.GrossAmount1            
      gi_data_ecpay.AgentComm1              
      gi_data_ecpay.InputVat                
      gi_data_ecpay.Payable1                
      gi_data_ecpay.comm-income1            
      gi_data_ecpay.OutputVat               
      gi_data_ecpay.total-db                
      gi_data_ecpay.total-cr                
      gi_data_ecpay.total-db-cr-diff        
      gi_data_ecpay.party-name              
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_ecpay_sum.txt".
EXPORT DELIMITER "^"
    "YearMonthFN" 
    "EcPaySumCons"
    "VchId"
    "PartyName" 
    "TotalAmount" 
    "ConvenienceFee" 
    "PayableToOperator" 
    "AgentComm" 
    "MtAgentComm" 
    "Profit"
    "DbCollFromAgent" 
    "DbGrossAmount" 
    "DbAgentComm" 
    "DbInputVat" 
    "CrPayable" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
    "EcPaySrNo"
  .
FOR EACH gi_data_ecpay_sum:
  EXPORT DELIMITER "^"
      gi_data_ecpay_sum.YearMonthFN          
      gi_data_ecpay_sum.ecpay-sum-cons       
      gi_data_ecpay_sum.LastVchId            
      gi_data_ecpay_sum.party-name           
      gi_data_ecpay_sum.TotalAmount          
      gi_data_ecpay_sum.ConvenienceFee       
      gi_data_ecpay_sum.PayableToOperator    
      gi_data_ecpay_sum.AgentComm            
      gi_data_ecpay_sum.MtAgentComm          
      gi_data_ecpay_sum.Profit               
      gi_data_ecpay_sum.CollectFromAgent     
      gi_data_ecpay_sum.GrossAmount1         
      gi_data_ecpay_sum.AgentComm1           
      gi_data_ecpay_sum.InputVat             
      gi_data_ecpay_sum.Payable1             
      gi_data_ecpay_sum.comm-income1         
      gi_data_ecpay_sum.OutputVat            
      gi_data_ecpay_sum.total-db             
      gi_data_ecpay_sum.total-cr             
      gi_data_ecpay_sum.total-db-cr-diff     
      gi_data_ecpay_sum.ecpay-sr-no          
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_visa.txt".
EXPORT DELIMITER "^"
    "YearMonFN" 
    "SrNo" 
    "TravelAgentID" 
    "AgentName" 
    "TerminalId" 
    "TerminalName" 
    "TransactionId" 
    "TypeOfVisa" 
    "TranDateTxt" 
    "EnteredBy" 
    "Country"
    "Supplier"
    "SellingPrice" 
    "MarkUpAmount" 
    "GrossAmount" 
    "AgentComm" 
    "CollFromAgent" 
    "Payable"
    "Profit"
    "CourierCharges" 
    "Penalty"
    "VisaCons"
    "Date1"
    "DbGrossAmount1" 
    "DbAgentComm1" 
    "DbInputVat" 
    "CrPayable1" 
    "CrCommIncome" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
    "PartyName" 
  .
FOR EACH gi_data_visa:
  EXPORT DELIMITER "^"
      gi_data_visa.YearMonthFN              
      gi_data_visa.visa-sr-no               
      gi_data_visa.TravelAgentId            
      gi_data_visa.AgentName                
      gi_data_visa.TerminalId               
      gi_data_visa.TerminalName             
      gi_data_visa.TransactionId            
      gi_data_visa.TypeOfVisa               
      gi_data_visa.TranDate-Txt             
      gi_data_visa.EnteredBy                
      gi_data_visa.Country                  
      gi_data_visa.Supplier                 
      gi_data_visa.SellingPrice             
      gi_data_visa.MarkUpAmount             
      gi_data_visa.GrossAmount              
      gi_data_visa.AgentComm                
      gi_data_visa.CollectFromAgent         
      gi_data_visa.Payable                  
      gi_data_visa.Profit                   
      gi_data_visa.CourierCharges           
      gi_data_visa.Penalty                  
      gi_data_visa.visa-cons                
      gi_data_visa.date1                    
      gi_data_visa.GrossAmount1             
      gi_data_visa.AgentComm1               
      gi_data_visa.InputVat                 
      gi_data_visa.Payable1                 
      gi_data_visa.comm-income1             
      gi_data_visa.OutputVat                
      gi_data_visa.total-db                 
      gi_data_visa.total-cr                 
      gi_data_visa.total-db-cr-diff         
      gi_data_visa.party-name               
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_visa_sum.txt".
EXPORT DELIMITER "^"
     "VisaSumCons"
     "YearMonthFN" 
     "VchId"
     "PartyName" 
     "SellingPrice" 
     "MarkUpAmount" 
     "GrossAmount" 
     "AgentComm" 
     "CollFromAgent" 
     "Payable"
     "Profit"
     "CourierCharges" 
     "Penalty"
     "DbGrossAmount1" 
     "DbAgentComm1" 
     "DbInputVat" 
     "CrCommIncome1" 
     "CrPayable1" 
     "CrOutputVat" 
     "TotalDebit" 
     "TotalCredit" 
     "DbCrDiff" 
  .
FOR EACH gi_data_visa_sum:
  EXPORT DELIMITER "^"
      gi_data_visa_sum.visa-sum-cons         
      gi_data_visa_sum.YearMonthFN           
      gi_data_visa_sum.LastVchId             
      gi_data_visa_sum.party-name            
      gi_data_visa_sum.SellingPrice          
      gi_data_visa_sum.MarkUpAmount          
      gi_data_visa_sum.GrossAmount           
      gi_data_visa_sum.AgentComm             
      gi_data_visa_sum.CollectFromAgent      
      gi_data_visa_sum.Payable               
      gi_data_visa_sum.Profit                
      gi_data_visa_sum.CourierCharges        
      gi_data_visa_sum.Penalty               
      gi_data_visa_sum.GrossAmount1          
      gi_data_visa_sum.AgentComm1            
      gi_data_visa_sum.InputVat              
      gi_data_visa_sum.comm-income1          
      gi_data_visa_sum.Payable1              
      gi_data_visa_sum.OutputVat             
      gi_data_visa_sum.total-db              
      gi_data_visa_sum.total-cr              
      gi_data_visa_sum.total-db-cr-diff      
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_bus.txt".
EXPORT DELIMITER "^"
    "YearMonFN" 
    "SrNo" 
    "TravelAgentId" 
    "CompanyName" 
    "TerminalId" 
    "TerminalName" 
    "TransType" 
    "TransactionID" 
    "TransportPnr" 
    "ServiceCharge" 
    "GrossAmount" 
    "SupplierComm" 
    "AgentComm" 
    "CollFromAgent" 
    "Payable"
    "Profit"
    "Date1"
    "DbGrossAmount1" 
    "DbAgentComm1" 
    "DbInputVat" 
    "CrCommIncome1" 
    "CrPayable1" 
    "CrOutputVat" 
    "TotalCredit" 
    "TotalDebit" 
    "DbCrDiff" 
    "Buscons"
    "MtAgentComm1"
  .
FOR EACH gi_data_bus:
  EXPORT DELIMITER "^"
      gi_data_bus.YearMonthFN                
      gi_data_bus.bus-sr-no                  
      gi_data_bus.TravelAgentId              
      gi_data_bus.Party-Name                 
      gi_data_bus.TerminalId                 
      gi_data_bus.TerminalName               
      gi_data_bus.TransType                  
      gi_data_bus.TransactionId              
      gi_data_bus.TransportPnr               
      gi_data_bus.ServiceCharge              
      gi_data_bus.GrossAmount                
      gi_data_bus.SupplierComm               
      gi_data_bus.AgentComm                  
      gi_data_bus.CollectFromAgent           
      gi_data_bus.Payable                    
      gi_data_bus.Profit                     
      gi_data_bus.date1                      
      gi_data_bus.GrossAmount1               
      gi_data_bus.AgentComm1                 
      gi_data_bus.InputVat                   
      gi_data_bus.comm-income1               
      gi_data_bus.Payable1                   
      gi_data_bus.OutputVat                  
      gi_data_bus.total-cr                   
      gi_data_bus.total-db                   
      gi_data_bus.total-db-cr-diff           
      gi_data_bus.bus-cons                   
      gi_data_bus.MTAgentComm1               
      .
END.
OUTPUT CLOSE.

OUTPUT TO "C:\pvr\giph\bidata\gi_data_bus_sum_a.txt".
EXPORT DELIMITER "^"
    "BusSumCon"
    "YearMonthFN" 
    "VchId"
    "PartyName" 
    "Amount"
    "ServiceCharge" 
    "GrossAmount" 
    "SupplierComm" 
    "AgentComm" 
    "CollFromAgent" 
    "Payable"
    "Profit"
    "DbGrossAmount1" 
    "DbAgentComm1" 
    "DbInputVat" 
    "CrCommIncome1" 
    "CrPayable1" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DbCrDiff" 
  .
FOR EACH gi_data_bus_sum:
  EXPORT DELIMITER "^"
      gi_data_bus_sum.bus-sum-cons          
      gi_data_bus_sum.YearMonthFN           
      gi_data_bus_sum.LastVchId             
      gi_data_bus_sum.party-name            
      gi_data_bus_sum.Amount                
      gi_data_bus_sum.ServiceCharge         
      gi_data_bus_sum.GrossAmount           
      gi_data_bus_sum.SupplierComm          
      gi_data_bus_sum.AgentComm             
      gi_data_bus_sum.CollectFromAgent      
      gi_data_bus_sum.Payable               
      gi_data_bus_sum.Profit                
      gi_data_bus_sum.GrossAmount1          
      gi_data_bus_sum.AgentComm1            
      gi_data_bus_sum.InputVat              
      gi_data_bus_sum.comm-income1          
      gi_data_bus_sum.Payable1              
      gi_data_bus_sum.OutputVat             
      gi_data_bus_sum.total-db              
      gi_data_bus_sum.total-cr              
      gi_data_bus_sum.total-db-cr-diff      
      .
END.
OUTPUT CLOSE.



OUTPUT TO "C:\pvr\giph\bidata\gi_data_airline_sum_a.txt".
EXPORT DELIMITER "^"
    "AirlineSumCons" 
    "YearMonthFN" 
    "VchId" 
    "Party Name" 
    "Alias" 
    "IATAStock" 
    "BasicAmt" 
    "Tax" 
    "TopUpAmt" 
    "MTAgentComm" 
    "TransFee" 
    "Penalty" 
    "AgentComm" 
    "CollFromAgent" 
    "SupplierComm" 
    "PayableToAirline" 
    "SegmentFee" 
    "Profit"
    "DbAgentComm" 
    "DbCollFromAgent" 
    "DbInputVat" 
    "CrTopUpAmt" 
    "CrMTAgentComm" 
    "CrTransFee" 
    "CrSupplierComm" 
    "CrPayableToAirline" 
    "CrOutputVat" 
    "TotalDebit" 
    "TotalCredit" 
    "DebitCreditDiff" 
    "SegmentFee" 
    "YearMonth"
  .
FOR EACH gi_data_airline_sum:
  EXPORT DELIMITER "^"
      gi_data_airline_sum.airline-sum-cons 
      gi_data_airline_sum.YearMonthFN 
      gi_data_airline_sum.LastVchId 
      gi_data_airline_sum.party-name 
      gi_data_airline_sum.alias-name  
      gi_data_airline_sum.IATAStock 
      gi_data_airline_sum.BasicAmt 
      gi_data_airline_sum.Tax  
      gi_data_airline_sum.TopUpAmt 
      gi_data_airline_sum.MTAgentComm 
      gi_data_airline_sum.TransFee 
      gi_data_airline_sum.Penalty 
      gi_data_airline_sum.AgentComm 
      gi_data_airline_sum.CollectFromAgent 
      gi_data_airline_sum.SupplierComm 
      gi_data_airline_sum.PayableToAirline 
      gi_data_airline_sum.SegmentFee 
      gi_data_airline_sum.Profit  
      gi_data_airline_sum.AgentComm1 
      gi_data_airline_sum.CollectFromAgent1 
      gi_data_airline_sum.InputVat 
      gi_data_airline_sum.TopUpAmt1 
      gi_data_airline_sum.MTAgentComm1 
      gi_data_airline_sum.TransFee1 
      gi_data_airline_sum.SupplierComm1 
      gi_data_airline_sum.PayableToAirline1 
      gi_data_airline_sum.OutputVat 
      gi_data_airline_sum.total-db 
      gi_data_airline_sum.total-cr 
      gi_data_airline_sum.total-db-cr-diff 
      gi_data_airline_sum.SegmentFee1 
      gi_data_airline_sum.YearMonth 

      .
END.
OUTPUT CLOSE.















MESSAGE "Process ended"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.


