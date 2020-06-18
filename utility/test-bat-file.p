DEF VAR pbat-filename AS CHAR. 

ASSIGN pbat-filename = "C:\pvr\giph\tallylib\CreateVoucherJournal.BAT".


OS-COMMAND VALUE(pbat-filename) NO-ERROR.
