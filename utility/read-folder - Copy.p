DEF NEW SHARED VAR pfilename-csv AS CHAR.
DEFINE VARIABLE cDir AS CHARACTER NO-UNDO INITIAL 'C:\pvr\giph\GL2019-CSV'.
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.
DEF VAR pcons AS INT.
DEF VAR n AS INT.

DEF VAR pfilename-temp AS CHAR.
DEF VAR pfilecorrection AS CHAR.
DEF VAR ptexto AS CHAR FORMAT "x(2000)".

DEF TEMP-TABLE det
    FIELD cDir AS CHARACTER FORMAT "x(100)"
    FIELD cFileStream AS CHAR FORMAT "x(100)"
    FIELD cFilename AS CHAR FORMAT "x(100)"
    .

DEF TEMP-TABLE tt_file
    FIELD ptexto AS CHAR FORMAT "X(2000)"
    FIELD pcons AS INT
    INDEX idx AS PRIMARY UNIQUE pcons.

INPUT FROM OS-DIR (cDir).

REPEAT:
    IMPORT cFileStream.
    FILE-INFO:FILE-NAME = cDir + "\" + cFileStream.
    CREATE det.
    ASSIGN det.cFilename = FILE-INFO:FILE-NAME.
    IF det.cfilename MATCHES "*.csv" THEN DO:
        n = n + 1.
        IF n > 1 THEN NEXT.
        IF SEARCH(det.cfilename) <> ? THEN DO:
            DISPLAY det.cfilename FORMAT "x(70)".
            /*ASSIGN pfilecorrection = REPLACE(det.cfilename,".csv","-temp.csv").*/
            ASSIGN pfilename-temp = det.cfilename.
            ASSIGN pfilename-temp = REPLACE(det.cfilename," ","_").

            ASSIGN pfilename-temp = REPLACE(pfilename-temp,"C:\pvr\giph\GL2019-CSV","C:\pvr\giph\GL2019-CSV\TEMP").
            ASSIGN pfilecorrection = REPLACE(pfilename-temp,".csv","_temp.csv").
            ASSIGN pfilename-temp = pfilecorrection.
            ASSIGN pfilename-csv = pfilename-temp.
            OS-COPY VALUE(det.cfilename) VALUE(pfilename-temp).
            RUN c:\pvr\giph\lib\rename_file_in_powershell.p.
            OS-COMMAND VALUE("C:\pvr\giph\lib\fix_csvfiles.bat").

            INPUT FROM VALUE(pfilename-temp).
            REPEAT:
                IMPORT UNFORMATTED ptexto.
                ASSIGN ptexto = REPLACE(ptexto,CHR(13),"").
                ASSIGN ptexto = REPLACE(ptexto,CHR(34),"").
                MESSAGE ptexto. PAUSE 0.
                IF ptexto MATCHES "*For The Period Covering*" THEN DO:
                    ASSIGN pcons = pcons + 1.
                    CREATE tt_file.
                    ASSIGN tt_file.pcons = pcons
                           tt_file.ptexto = ptexto.
                    /*MESSAGE ptexto. PAUSE 0.*/
                END.
                FIND tt_file WHERE tt_file.pcons = pcons NO-ERROR.
                IF AVAILABLE tt_file THEN DO:
                    IF ptexto BEGINS '",' THEN DO:
                        ASSIGN tt_file.ptexto = tt_file.ptexto + ptexto.
                    END.
                    ELSE DO:
                        ASSIGN tt_file.ptexto = tt_file.ptexto + " // " + ptexto.
                    END.
                    /*MESSAGE tt_file.ptexto. PAUSE 0.*/
                END.
            END.
            INPUT CLOSE.
            OUTPUT TO VALUE(pfilecorrection).
            FOR EACH tt_file BREAK BY tt_file.pcons:
                EXPORT tt_file.pcons REPLACE(tt_file.ptexto,'"','').
            END.
            OUTPUT CLOSE.
            OS-COMMAND NO-WAIT VALUE(pfilecorrection).

        END.
    END.

END.



/*
    /*
    DISPLAY cFileStream FORMAT "X(18)" LABEL 'name of the file'
            FILE-INFO:FULL-PATHNAME FORMAT "X(21)" LABEL 'FULL-PATHNAME'
            FILE-INFO:PATHNAME FORMAT "X(21)" LABEL 'PATHNAME'
            FILE-INFO:FILE-TYPE FORMAT "X(5)" LABEL 'FILE-TYPE'.
            */

*/

/*
 POWERSHELL
 $path = "abc.csv"
>> (Get-Content $path -Raw).Replace('For The Period',"`r`n For The Period") | Set-Content $path -Force
*/


/*
 $path = "abc.csv"
>> (Get-Content $path -Raw).Replace("`r`n","`n") | Set-Content $path -Force 

*/

/*****************

$path = "C:\Users\abc\Desktop\File\abc.txt"
(Get-Content $path -Raw).Replace("`r`n","`n") | Set-Content $path -Force


********************/
