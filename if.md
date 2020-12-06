 **Если A = B, выполнить True, иначе выполнить False:**

C:
```c
if (A == B) {
    // True
} else {
    // False
}
```
ASM с использованием BREQ и RJMP:
```asm
SUB R16, R17
BREQ TR
    ; False (3 такта)
RJMP EN
TR:
    ; True (2 такта)
EN:
```
ASM с использованием BRNE и RJMP:
```asm
SUB R16, R17
BRNE FL
    ; True (3 такта)
RJMP EN
FL:
    ; False (2 такта)
EN:
```
ASM с использованием BRNE и BREQ:
```asm
SUB R16, R17
BRNE EN
    ; True ==
EN:

SUB R16, R17
BREQ EN
    ; True !=
EN:
```
**Если A > B, выполнить True, иначе выполнить False:**

C:
```c
if (A > B) {
    // True
} else {
    // False
}
```
ASM с использованием BRCS и RJMP:
```asm
SUB R17, R16
BRCS RT
    ; False (A <= B) (3 такта)
RJMP EN
TR:
    ; True (A > B) (2 такта)
EN:
```
ASM с использованием BRCC и RJMP:
```asm
SUB R17, R16
BRCC FL
    ; True (A > B) (3 такта)
RJMP EN
FL:
    ; False (A <= B) (2 такта)
EN:
```
ASM с использованием BRCS:
```asm
SUB R16, R17
BRCS EN
    ; True (A >= B)
EN:
```
ASM с использованием BRCC:
```asm
SUB R17, R16
BRCC EN
    ; True (A > B)
EN:
```

**Если A < B, выполнить True, иначе выполнить False:**

С:
```c
if (A < B) {
    // True
} else {
    // False
}
```
ASM с использованием BRCS и RJMP:
```asm
SUB R16, R17
BRCS TR
    ; False (A >= B) (3 такта)
RJMP EN
TR:
    ; True (A < B) (2 такта)
EN:
```
ASM с использованием BRCC и RJMP:
```asm
SUB R16, R17
BRCC FL
    ; True (A < B) (3 такта)
RJMP EN
FL:
    ; False (A >= B) (2 такта)
EN:
```
ASM с использованием BRCC:
```asm
SUB R16, R17
BRCC EN
    ; True (A < B)
EN:
```
ASM с использованием BRCS:
```asm
SUB R17, R16
BRCS EN
    ; True (A <= B)
EN:
```

**Если A > B, выполнить True, иначе выполнить False: (для больших чисел)**

C:
```c
int A = 1324;
int B = 5412;
if (A > B) {
    // True
} else {
    // False
}
```
ASM с использованием CP, CPC, BRCC, RJMP:
```asm
LDI R16, low(1324)
LDI R17, high(1324)
LDI R18, low(5412)
LDI R19, high(5412)

CP R18, R16
CPC R19, R17
BRCC FL
    ; True (A>B) (3 такта)
RJMP EN
FL:
    ; False (A <= B) (2 такта)
EN:
```

**Если A > B > C, выполнить True, иначе выполнить False:**

A = R16

B = R17

C = R18

C:
```c
if ((A>B)&&(B>C)) {
    // True
} else {
    // False
}
```
ASM с использованием SUB, BRCC, RJMP:
```asm
SUB R17, R16
BRCC FL
SUB R18, R17
BRCC FL
    ; True (4+2 такта)
RJMP EN
FL:
    ; False (3) (6)
EN:
```


**Если (A > B) || (A > C), выполнить True, иначе выполнить False:**

A = R16

B = R17

C = R18

C:
```c
if ((A > B) || (A > C)) {
    // True
} else {
    // False
}
```
ASM с использованием SUB, BRCC, RJMP:
```asm
SUB R17, R17
BRCC OR
TR:
    ; True (2+2) (7+2)
RJMP EN

OR:

SUB R18, R16
BRCC FL
RJMP TR
FL:
    ; False (6 тактов)

EN:
```
ASM с использованием SUB, BRCC, RJMP, BRCS:
```asm
SUB R17, R17
BRCC OR
TR:
    ; True (2+2) (6+2)
RJMP EN

OR:

SUB R18, R16
BRCS TR
FL:
    ; False (5 тактов)

EN:
```
