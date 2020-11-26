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
