# AVR-ASM
Конспект по AVR ASM

Device:
Atmega328P

:black_square_button: Для удобного просмотра таблицы команд разверните файл

## 3 вида памяти в AVR:
### 1) Flash 16-bits - память программ

Не очень много памяти.
0x0000 - 0xFFFF

### 2) SRAM 8-bits   - Static Random access memory

Лучше хранит данные, без необходимости их обновлять.
0x0000 - 0xFFFF

1) 0x0000 - 0x001F - POH

2) 0x0020 - 0x005F - I/O (все данные подключенные к процессору, настройки переферии)

3) 0x0060 - RAMEND - Внутренняя SRAM (хранить что хочется)

4) RAMEND+1 - 0xFFFF - Внешняя SRAM

#### Регистры:
Всегда 32 регистра. В каждом по байту.

**Адресация:**

1) 5 бит
2) 4 бит
3) 2 бит 

2-х битные могут объединяться по парам (X, Y, Z):
1) X - 26, 27
2) Y - 28, 29
3) Z - 30, 31

![Регистры](https://raw.githubusercontent.com/TomasGlgg/AVR-ASM/main/AVR-registers.PNG)


### 3) EEPROM 8-bits 
Данные между включениями и выключениями


## Сегменты:
```.dseg``` - Данные после запуска МК


```.cseg``` - Сегмент кода


```.eseg``` - EEPROM


## Метки:
```RESET``` - Код если МК сломан

```MAIN``` - Код

## Флаги:
```SREG``` - Регистр статуса

**Список флагов:**
| Флаг | Расшифровка                        | Описание                                                  |
|------|:----------------------------------:|:----------------------------------------------------------|
| C    | Carry                              | Флаг переноса                                             |
| Z    | Zero                               | Флаг нулевого значения                                    |
| N    | Negative                           | Флаг отрицательного значения (Старший бит после операции) |
| V    | Two's complement overflow indictor | Флаг указатель переполнения (Переполнение перешло в знак) |
| S    | Signed Test                        | Флаг для проверок со знаком (S = V xor N)                 |
| H    | Half Carry                         | Флаг полупереноса (Переполнение 4 бита)                   |
| T    | Transfer bit                       | Флаг переноски (Используется как временный флаг)          |
| I    | Interrupt Enable Flag              | Флаг разрешения глобального прерывания                    |

----
## КОМАНДЫ:

**Синтаксис команд:**
<Команда> <Куда> <Откуда>

**Список команд:**
| Команда | Синтаксис  | Биты команды               | Операнды                                  | Такты | Флаги      | Описание                                       |
|---------|:----------:|:--------------------------:|:-----------------------------------------:|:-----:|:----------:|-----------------------------------------------:|
| NOP     | NOP        | 0000 0000 &#124; 0000 0000 |                                           | 1     |            | Ничего не делать                               |
| MOV     | MOV Rd, Rr | 0010 11rd &#124; dddd rrrr | 0<=r<=32, 0<=d<=32                        | 1     |            | Копировать регистр                             |
| LDI     | LDI Rd, K  | 1110 KKKK &#124; dddd KKKK | Операнды 16<=d<=31, 0<=K<=255             | 1     |            | Загрузить значение в регистр                   |
| ADD     | ADD Rd, Rr | 0000 11rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |H+S+V+N+Z+C+| Сложить без переноса                           |
| INC     | INC Rd     | 1001 010d &#124; dddd 0011 | 0<=d<=31                                  | 1     |S+V+N+Z+    | Инкрементировать                               |
| DEC     | DEC Rd     | 1001 010d &#124; dddd 1010 | 0<=d<=31                                  | 1     |S+V+N+Z+    | Декрементировать                               |
| SUB     | SUB Rd, Rr | 0001 10rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |H+S+V+N+Z+C+| Вычесть без переноса                           |
| SUBI    | SUBI Rd, K | 0101 KKKK &#124; dddd KKKK | 16<=d<=31, 0<=K<=255                      | 1     |H+S+V+N+Z+C+| Вычесть значение из регистра                   |
| ADIW    | ADIW Rdl, K| 1001 0110 &#124; KKdd KKKK | dl {24, 26, 28, 30} (X, Y, Z), 0<=K<=63   | 2     |S+V+N+Z+C+  | Сложить значение с парой регистров (16 бит)    |
| SBIW    | SBIW RDl, K| 1001 0111 &#124; KKdd KKKK | dl {24, 26, 28, 30} (X, Y, Z), 0<=K<=63   | 2     |S+V+N+Z+C+  | Вычесть значение из пары регистров             |
| ADC     | ADC Rd, Rr | 0001 11rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |H+S+V+N+Z+C+| Сложение двух регистров и содержимого флага переноса|
| SBC     | SBC Rd, Rr | 0000 10rd &#124; dddd rrrr | 0<=d<= 31, 0<= r<= 31                     | 1     |H+S+V+N+Z+C+| Вычитание содержимого регистра и содержимого флага переноса (С)|
| SBCI    | SBCI Rd, K | 0100 KKKK &#124; dddd KKKK | 0<=d<= 31, 16<=K<=31                      | 1     |H+S+V+N+Z+C+| Вычитание константы и содержимого флага переноса|
| СOM     | COM Rd     | 1001 010d &#124; dddd 0000 | 0<=d<=31                                  | 1     |S+V0N+Z+C1  | Перевод в обратный код                         |
| NEG     | NEG Rd     | 1001 010d &#124; dddd 0001 | 0<=d<=31                                  | 1     |H+S+V+N+Z+C+| Перевод в дополнительный код(Значение 0x80 не изменно)|
| AND     | AND Rd, Rr | 0010 00rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |S+V0N+Z+    | Логические И между двумя регистрами            |
| ANDI    | ANDI Rd, K | 0111 KKKK &#124; dddd KKKK | 16<=d<=31, 0<=K<=255                      | 1     |S+V0N+Z+    | Логическое И между регистром и значением       |
| OR      | OR Rd, Rr  | 0010 10rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |S+V0N+Z+    | Логическое ИЛИ между двумя регистрами          |
| ORI     | ORI Rd, K  | 0110 KKKK &#124; dddd KKKK | 16<=d<=31, 0<=K<=255                      | 1     |S+V0N+Z+    | Логическое ИЛИ между ригистром и значением     |
| EOR     | EOR Rd, Rr | 0010 01rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |S+V0N+Z+    | Исключающее ИЛИ между двумя регистрами         |
| LSL     | LSL Rd     | 0000 11dd &#124; dddd dddd | 0<=d<=31                                  | 1     |H+S+V+N+Z+C+| Логический сдвинуть влево (7-й бит выгружается во флаг переноса (C))|
| LSR     | LSR Rd     | 1001 010d &#124; dddd 0110 | 0<=d<=31                                  | 1     |S+V+N0Z+C+  | Логически сдвинуть вправо                      |
| ROL     | ROL Rd     | 0001 11dd &#124; dddd dddd | 0<=d<=31                                  | 1     |H+S+V+N+Z+C+| Логически сдвинуть влево через перенос (Флаг переноса (С) смещается на место бита 0 регистра Rd. Бит 7 смещается во флаг переноса (С))|
| ROR     | ROR Rd     | 1001 010d &#124; dddd 0111 | 0<=d<=31                                  | 1     |S+V+N+Z+C+  | Логически сдвинуть вправо через перенос (Флаг переноса (С) на место 0-го бита, 7-й бит смещается во флаг переноса (С))|
| ASR     | ASR Rd     | 1001 010d &#124; dddd 0101 | 0<=d<=31                                  | 1     |S+V+N+Z+C+  | Арифметически сдвинуть вправо (Флаг переноса (С) смещается на место 7-го бита, 0-й бит выгружается во флаг переноса (С))|
| SEP     | SEP Rd     | 1110 1111 &#124; dddd 1111 | 16<=d<=31                                 | 1     |            | Включить все биты регистра                     |
| CLR     | CLR Rd     | 0010 01dd &#124; dddd dddd | 0<=d<=31                                  | 1     |S0V0N0Z1    | Очистить регистр                               |
| RJMP    | RJMP k     | 1100 kkkk &#124; kkkk kkkk | -2K≤k≤2K                                  | 2     |            | Перейти относительно                           |
| JMP     | JMP k      | 1001 010k &#124; kkkk 110k &#124; kkkk kkkk &#124; kkkk kkkk| 0<=k<=4M | 3     |            | Перейти абсолютно                              |
| BRCC    | BRCC k     | 1111 01kk &#124; kkkk k000 | -64<=k<=63                                | 1 or 2|            | Перейти если флаг С очищен                     |
| BRCS    | BRCS k     | 1111 00kk &#124; kkkk k000 | -64<=k<=63                                | 1 or 2|            | Перейти если флаг С установлен                 |
| BRNE    | BRNE k     | 1111 01kk &#124; kkkk k001 | -64<=k<=63                                | 1 or 2|            | Перейти если флаг Z очищен                     |
| BREQ    | BREQ k     | 1111 00kk &#124; kkkk k001 | -64<=k<=63                                | 1 or 2|            | Перейти если флаг Z установлен                 |
| CP      | CP Rd, Rr  | 0001 01rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |H+S+V+N+Z+C+| Сравнить без переноса                          |
| CPC     | CPC Rd, Rr | 0000 01rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        | 1     |H+S+V+N+Z+C+| Сравнить с учетом переноса                     |
| CPI     | CPI Rd, K  | 0011 KKKK &#124; dddd KKKK | 16<=d<=31                                 | 1     |H+S+V+N+Z+C+| Сравнить с константой                          |
| CPSE    | CPSE Rd, Rr| 0001 00rd &#124; dddd rrrr | 0<=d<=31, 0<=r<=31                        |1or2or3|H+S+V+N+Z+C+| Сравнить и пропустить если равно               |


## Примеры:

**Сложение 5 и -5:**
```asm
LDI R16, 5
LDI R18, 5

NEG R18
ADD R16, R18  ; 5 + (-5)
```

**Swap двух регистров без временного регистра:**
```asm
A = A xor B
B = A xor B
A = A xor B
```

**Загрузить старшие биты числа 1234 в регистр R28, а в регистр R29 записать младшие биты числа 1234:**
```asm
LDI R28, low(1234) 
LDI R29, high(1234) 
```

**Цикл со счетчиком используя условный переход BRNE:**
```asm
    LDI R16, 4

LOOP:
    NOP
    DEC R16
    BRNE LOOP
```

[Примеры условий](https://github.com/TomasGlgg/AVR-ASM/blob/main/if.md)

