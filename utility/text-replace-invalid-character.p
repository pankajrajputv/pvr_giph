DEFINE VARIABLE cSourceFileName AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cTargetFileName AS CHARACTER   NO-UNDO.

DEFINE VARIABLE mSourceMemptr   AS MEMPTR      NO-UNDO.
DEFINE VARIABLE mTargetMemptr   AS MEMPTR      NO-UNDO.

DEFINE VARIABLE iSourceCounter  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iTargetCounter  AS INTEGER     NO-UNDO.
DEFINE VARIABLE iMemptrSize     AS INTEGER     NO-UNDO.
DEFINE VARIABLE iCurrentByte    AS INTEGER     NO-UNDO.

DEFINE VARIABLE cUndesirableCharacterList AS CHARACTER   NO-UNDO.

ASSIGN cSourceFileName = "C:\pvr\giph\GL2019-CSV\temp\abc.csv"
       cTargetFileName = "C:\pvr\giph\GL2019-CSV\temp\abc_temp.csv"
       cUndesirableCharacterList = "ASCII(13)".

RUN LoadFileToMemptr(INPUT cSourceFileName, OUTPUT mSourceMemptr).

ASSIGN iMemptrSize = GET-SIZE(mSourceMemptr).

SET-SIZE(mTargetMemptr) = iMemptrSize.

DO iSourceCounter = 1 TO iMemptrSize:
     iCurrentByte = GET-BYTE( mSourceMemptr , iSourceCounter).
     IF LOOKUP(STRING(iCurrentByte),CHR(13), ',') = 0 THEN
        DO:
            iTargetCounter = iTargetCounter + 1.
            PUT-BYTE ( mTargetMemptr , iTargetCounter ) = iCurrentByte.
        END.
END.


RUN SaveMemptrToFile(INPUT mTargetMemptr, INPUT cTargetFileName, INPUT iTargetCounter).

SET-SIZE(mSourceMemptr) = 0.
SET-SIZE(mTargetMemptr) = 0.

PROCEDURE LoadFileToMemptr:
     DEFINE INPUT PARAMETER ipcFileName AS CHARACTER NO-UNDO.
     DEFINE OUTPUT PARAMETER opmMessage AS MEMPTR NO-UNDO.
     FILE-INFO:FILE-NAME = ipcFileName.
     SET-SIZE(opmMessage) = FILE-INFO:FILE-SIZE.
     INPUT FROM VALUE(ipcFileName) BINARY NO-MAP NO-CONVERT.
     IMPORT UNFORMATTED opmMessage.
     INPUT CLOSE.
 END PROCEDURE.

PROCEDURE SaveMemptrToFile:
     DEFINE INPUT PARAMETER ipmMessage AS MEMPTR NO-UNDO.
     DEFINE INPUT PARAMETER ipcFileName AS CHARACTER NO-UNDO.
     DEFINE INPUT PARAMETER ipiLength AS INTEGER NO-UNDO.

     DEFINE VARIABLE vTemp AS MEMPTR NO-UNDO.

     SET-SIZE(vTemp) = ipiLength.
     PUT-BYTES(vTemp,1) = GET-BYTES(ipmMessage,1,ipiLength).
     OUTPUT TO VALUE(ipcFileName) BINARY NO-MAP NO-CONVERT.
     EXPORT vTemp.
     OUTPUT CLOSE.
     SET-SIZE(vTemp) = 0.
 END PROCEDURE.

/* report #bytes */
message "   " imemptrsize "bytes: original".
message "   " iTargetCounter "bytes: new".
