DEF VAR pcons AS INT.
FOR EACH gi_data_packages_sum: DELETE gi_data_packages_sum. END. 

DEF VAR ppartyname AS CHAR INIT "Packages Purchases".
FOR EACH gi_data_packages:

    ASSIGN gi_data_packages.party-name = gi_data_packages.packagesupplier.
    ASSIGN gi_data_packages.Payable    = gi_data_packages.TotalPayable.


    FIND gi_data_packages_sum WHERE gi_data_packages_sum.YearMonthFN = gi_data_packages.YearMonth
                                AND gi_data_packages_sum.party-name  = ppartyname /*gi_data_packages.party-name*/ NO-ERROR.
    IF NOT AVAILABLE gi_data_packages_sum THEN DO:
        ASSIGN pcons = pcons + 1.
        CREATE gi_data_packages_sum.
        ASSIGN 
            gi_data_packages_sum.YearMonth        = gi_data_packages.YearMonth
            gi_data_packages_sum.YearMonthFN       = gi_data_packages.YearMonth
               gi_data_packages_sum.alias-name        = gi_data_packages.alias-name 
               gi_data_packages_sum.party-name        = ppartyname /*gi_data_packages.party-name */
               gi_data_packages_sum.packages-sum-cons = pcons
            .
    END.

    ASSIGN 
        gi_data_packages_sum.SellingPrice     = gi_data_packages_sum.SellingPrice     + gi_data_packages.SellingPrice           
        gi_data_packages_sum.VatCollectable   = gi_data_packages_sum.VatCollectable   + gi_data_packages.VatCollectable
        gi_data_packages_sum.MarkUp           = gi_data_packages_sum.MarkUp           + gi_data_packages.MarkUp    
        gi_data_packages_sum.TotalCollectable = gi_data_packages_sum.TotalCollectable + gi_data_packages.TotalCollectable
        gi_data_packages_sum.TotalPayable     = gi_data_packages_sum.TotalPayable     + gi_data_packages.TotalPayable
        gi_data_packages_sum.VatPayable       = gi_data_packages_sum.VatPayable       + gi_data_packages.VatPayable
        gi_data_packages_sum.AgentComm        = gi_data_packages_sum.AgentComm        + gi_data_packages.AgentComm        
        gi_data_packages_sum.MtAgentComm        = gi_data_packages_sum.MtAgentComm    + gi_data_packages.MtAgentComm        
        gi_data_packages_sum.Profit           = gi_data_packages_sum.Profit           + gi_data_packages.Profit           
        .


    ASSIGN
        gi_data_Packages_sum.db-ControlAgent      = gi_data_packages_sum.TotalCollectable
        gi_data_Packages_sum.cr-PackagesPurchases = gi_data_packages_sum.TotalPayable
        gi_data_Packages_sum.cr-PackagesSales     = gi_data_packages_sum.MarkUp      
        .

    ASSIGN 
        gi_data_Packages_sum.total-db         = gi_data_Packages_sum.db-ControlAgent 
        gi_data_Packages_sum.total-cr         = gi_data_Packages_sum.cr-PackagesPurchases + gi_data_Packages_sum.cr-PackagesSales       
        gi_data_Packages_sum.total-db-cr-diff = gi_data_Packages_sum.total-db  - gi_data_Packages_sum.total-cr
          .
        .

    ASSIGN
        gi_data_Packages_sum.AutoGP = gi_data_Packages_sum.cr-PackagesSales  
        gi_data_Packages_sum.DiffGP = gi_data_Packages_sum.AutoGP  - gi_data_Packages_sum.Profit 
        .

END. /* FOR EACH gi_data_packages */
