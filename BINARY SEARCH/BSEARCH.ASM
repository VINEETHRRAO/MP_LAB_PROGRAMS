.MODEL SMALL
; MACRO TO DISPLAY THE MESSAGE....
DISPLAY MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM

.DATA
LIST DB 01H, 05H, 07H, 10H, 12H, 14H
NUMBER EQU ($-LIST)         ;NUMBER IS HAVING VALUE 6
KEY DB 10H
MSG1 DB 0DH, 0AH, "ELEMENT FOUND IN THE LIST...$"
MSG2 DB 0DH, 0AH, "SEARCH FAILED!! ELEMENT NOT FOND IN THE LIST $"

.CODE
START  : MOV AX,@DATA
         MOV DS,AX

         MOV CH,NUMBER-1   ;HIGH VALUE...
         MOV CL,00H        ;LOW VLUE...

AGAIN  : MOV SI, OFFSET LIST          ;SI IS A SOURCE INDEX
         XOR AX, AX
         CMP CL, CH
         JE NEXT                       
         JNC FAILED

NEXT  : MOV AL, CL
        ADD AL, CH
        SHR AL, 01H                   ;SHIFTRIGHT TO DIV BY 2
        MOV BL, AL
        XOR AH, AH
        MOV BP, AX
        MOV AL, DS:[BP][SI]
        CMP AL, KEY
        JE SUCCESS
        JC INCLOW
        MOV CH, BL
        DEC CH
        JMP AGAIN

INCLOW: MOV CL, BL
        INC CL
        JMP AGAIN

SUCCESS: DISPLAY MSG1
         JMP FINAL

FAILED: DISPLAY MSG2

FINAL: MOV AH,4CH
       INT 21H
       END START
