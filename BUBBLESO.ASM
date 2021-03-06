.MODEL SMALL
DISPLAY MACRO MSG
   LEA DX,MSG
   MOV AH,09H
   INT 21H
ENDM

.DATA
N DB 6
A DB 05,07,09,03,01,08
MSG1 DB 0DH,0AH,"1-SORT IN ASCENDING ORDER...$"
MSG2 DB 0DH,0AH,"2-SORT IN DESCENDING ORDER...$"
MSG3 DB 0DH,0AH,"3-EXIT$"
MSG4 DB 0DH,0AH,"ENTER YOUR CHOICE$"
MSG5 DB 0DH,0AH,"INVALID CHOICE$"

.CODE
  MOV AX,@DATA
  MOV DS,AX
  LEA SI,A
  MOV CL,N
  DEC CL

DISPLAY MSG1
DISPLAY MSG2
DISPLAY MSG3
DISPLAY MSG4

  MOV AH,01H
  INT 21H
  SUB AL,30H
  CMP AL,01H
  JE ASCSORT
  CMP AL,02H
  JE DESCSORT
  CMP AL,03H
  JE FINAL
  DISPLAY MSG5
  JMP FINAL

ASCSORT:MOV CH,CL
        MOV SI,00H
INLOOPA:MOV AL,A[SI]
        INC SI
        CMP AL,A[SI]
        JC NOA
        XCHG AL,A[SI]
        MOV A[SI-1], AL
        NOA: DEC CH
        JNZ INLOOPA
        DEC CL
        JNZ ASCSORT
        JMP FINAL

DESCSORT:MOV CH,CL
        MOV SI,00H
INLOOPD:MOV AL,A[SI]
        INC SI
        CMP AL,A[SI]
        JC NOD
        XCHG AL,A[SI]
        MOV A[SI-1], AL
        NOD:DEC CH
        JNZ INLOOPD
        DEC CL
        JNZ DESCSORT
        JMP FINAL

FINAL:MOV AH,4CH
      INT 21H
      END


