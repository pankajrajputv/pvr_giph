DEF VAR pfilename-import AS CHAR FORMAT "x(200)".
DEF VAR pcons AS INT.

ASSIGN pfilename-import = "c:\pvr\giph\tempdata\accountinggroups.csv".
MESSAGE "Deleting accounting groups data". PAUSE 0.
/*
FOR EACH gi_acc_grp: 
    DELETE gi_acc_grp. 
END.
*/

MESSAGE "Importing accounting group". PAUSE 0.
INPUT FROM VALUE(pfilename-import).
REPEAT:
    CREATE gi_acc_grp.
    IMPORT DELIMITER ","
        gi_acc_grp.acc-grp-name 
        gi_acc_grp.acc-grp-type
        .

END.
INPUT CLOSE.
MESSAGE "Finished accounting group import". PAUSE 0.

    
/*        
FOR EACH gi_acc_grp: DELETE gi_acc_grp. END.

CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Branch / Divisions".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Capital Account".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Reserves & Surplus".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Current Assets".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Accounts Receivable".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Bank Accounts".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Cash-in-hand".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Deposits (Asset)".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Loans & Advances (Asset)".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Stock-in-hand".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Current Liabilities".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Accounts Payable".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Duties & Taxes".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Provisions".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Direct Expenses".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Direct Incomes".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Fixed Assets".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Indirect Expenses".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Indirect Incomes".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Investments".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Loans (Liability)".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Bank OD A/c".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Secured Loans".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Unsecured Loans".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Misc. Expenses (ASSET)".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Purchase Accounts".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Sales Accounts".
CREATE gi_acc_grp. ASSIGN gi_acc_grp.acc-grp-name = "Suspense A/c".
  */
