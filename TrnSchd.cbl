       IDENTIFICATION DIVISION.
       PROGRAM-ID. TrnSchd.
       AUTHOR. Pierre.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRAIN-FILE ASSIGN TO 'train.dat'
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD TRAIN-FILE
           RECORD IS VARYING IN SIZE FROM 19 TO 29 CHARACTERS
               DEPENDING ON TRAIN-RECORD-LENGTH.
       01 TRAIN-RECORD.
           05 TRAIN-TYPE          PIC X(3).
           05 DESTINA             PIC X(12).
           05 TRAIN-TIME.
               10 TRAIN-HOUR      PIC 99.
               10 TRAIN-MINUTES   PIC 99.
           05 NUMBER-OF-STOPS     PIC X(8).

       WORKING-STORAGE SECTION.
       01  TRAIN-RECORD-LENGTH         PIC 9(2) COMP.
       01  WS-NUMBER-OF-STOPS-LENGTH   PIC 9(2).
       01  WS-END-OF-FILE              PIC X VALUE 'N'.
           88 EOF               VALUE 'Y'.
           88 NOT-EOF           VALUE 'N'.

       PROCEDURE DIVISION.
           OPEN INPUT TRAIN-FILE
           PERFORM UNTIL EOF
               READ TRAIN-FILE INTO TRAIN-RECORD
                   AT END
                       MOVE 'Y' TO WS-END-OF-FILE
                   NOT AT END
                       MOVE FUNCTION LENGTH 
                                    (FUNCTION TRIM(NUMBER-OF-STOPS)) TO 
                                     WS-NUMBER-OF-STOPS-LENGTH
                DISPLAY "Train Type: " TRAIN-TYPE
                DISPLAY "Destination: " DESTINA
                DISPLAY "Train Time: " TRAIN-HOUR ":" TRAIN-MINUTES
                DISPLAY "Number of Stops: " NUMBER-OF-STOPS
                DISPLAY "Length of Number of Stops: " 
                        WS-NUMBER-OF-STOPS-LENGTH
                DISPLAY "------------------------------"
                END-READ
           END-PERFORM
           CLOSE TRAIN-FILE.
           STOP RUN.

