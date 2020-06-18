DEF NEW SHARED VAR pfilename-csv AS CHAR.
DEFINE VARIABLE cDir AS CHARACTER NO-UNDO INITIAL 'C:\pvr\giph\GL2019-CSV-van'.
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.
DEF VAR pcons AS INT.
DEF VAR n AS INT.

DEF VAR ptext-1 AS CHAR FORMAT "x(2000)".
DEF VAR ptext-2 AS CHAR FORMAT "x(2000)".


DEF VAR pfilename AS CHAR.
DEF VAR pfilename-temp AS CHAR.
DEF VAR pfilecorrection AS CHAR.
DEF VAR pfileprocess AS CHAR.
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
END.
INPUT CLOSE.

FOR EACH det:
    IF det.cfilename MATCHES "*.csv" THEN DO:
        n = n + 1.
        /*
        IF n > 4 THEN DO:

        END.
        ELSE DO:
            NEXT.
        END.
          */

        IF SEARCH(det.cfilename) <> ? THEN DO:
            /*DISPLAY det.cfilename FORMAT "x(70)".*/
            MESSAGE det.cfilename. PAUSE 0.
            /*ASSIGN pfilecorrection = REPLACE(det.cfilename,".csv","-temp.csv").*/
            ASSIGN pfilename = det.cfilename.
            ASSIGN pfilename = TRIM(pfilename, ",.;:!? ~"~ ’[]()&").
            ASSIGN pfilename = REPLACE(pfilename,"&","_").
            ASSIGN pfilename = REPLACE(pfilename," ","_").

            ASSIGN pfilename  = REPLACE(pfilename,"C:\pvr\giph\GL2019-CSV-van","C:\pvr\giph\GL2019-CSV-van\TEMP").
            ASSIGN pfilename-temp  = REPLACE(pfilename,".csv","_temp.csv").
            ASSIGN pfilecorrection = REPLACE(pfilename,".csv","_temp1.csv").
            ASSIGN pfileprocess    = REPLACE(pfilename,".csv","_temp2.csv").
            /*ASSIGN pfilename-temp  = pfilecorrection.*/
            ASSIGN pfilename-csv   = pfilename-temp.
            OS-COPY VALUE(det.cfilename) VALUE(pfilename-temp).
            RUN c:\pvr\giph\lib\rename_file_in_powershell.p.
            OS-COMMAND SILENT VALUE("C:\pvr\giph\lib\fix_csvfiles.bat").
            INPUT FROM VALUE(pfilename-temp).
            REPEAT:
                IMPORT UNFORMATTED ptexto.
                /*MESSAGE ptexto. PAUSE 0.*/
                ASSIGN pcons = pcons + 1.
                CREATE tt_file.
                ASSIGN tt_file.pcons = pcons.
                ASSIGN ptexto = REPLACE(ptexto,")","").
                ASSIGN ptexto = REPLACE(ptexto,"(","").
                ASSIGN tt_file.ptexto = ptexto.

                IF pcons = 2 THEN DO:
                    ASSIGN ptext-1 = tt_file.ptexto.
                    /*ASSIGN ptext-2 = REPLACE(ptext-1,ENTRY(15,ptext-1) + ",","") NO-ERROR.
                    IF ERROR-STATUS:ERROR THEN DO:
                        MESSAGE ptext-1
                            VIEW-AS ALERT-BOX INFO BUTTONS OK.
                    END.
                    
                    ASSIGN tt_file.ptexto = ptext-2.
                    */
                END.
                /*ASSIGN tt_file.ptexto = REPLACE(tt_file.ptexto,'"",""','", "').*/
                /*
                IF ptexto MATCHES "*For The Period Covering*" THEN DO:
                    ASSIGN pcons = pcons + 1.
                    CREATE tt_file.
                    ASSIGN tt_file.pcons = pcons
                           tt_file.ptexto = ptexto.
                    /*MESSAGE ptexto. PAUSE 0.*/
                END.
                */
            END.
            INPUT CLOSE.
            
            OUTPUT TO VALUE(pfileprocess).
            FOR EACH tt_file BREAK BY tt_file.pcons:
                PUT UNFORMATTED tt_file.ptexto SKIP.
                /*EXPORT REPLACE(tt_file.ptexto,'""','"').
                EXPORT REPLACE(tt_file.ptexto,",",", ").  */
            END.
            OUTPUT CLOSE.
            EMPTY TEMP-TABLE tt_file.

            /*
            OS-COMMAND NO-WAIT VALUE(pfileprocess).
            */
            /*
            OS-COMMAND SILENT c:\pvr\quoter.exe -d ',' VALUE(pfilecorrection) > VALUE(pfileprocess). 
            OS-COMMAND NO-WAIT VALUE(pfileprocess).
              */

              
        END. /* IF SEARCH(det.cfilename) <> ? */
    END. /* IF det.cfilename MATCHES "*.csv" */

END. /* Repeat */



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
