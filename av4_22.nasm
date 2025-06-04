; EX 1 
; vai-um -> "carry-out" de um bit -> soma dos menos
; 16 bits menos temp par 0,2 (RAM[5] e RAM[7])
; 16 bits mais temp impar 1,3
; salvar o resultado em temp 4 (RAM[9]) e temp 5

; RACIOCINIO
; serão duas funções: main e vaium
; main-> definir e inicializar os parâmetros + chamar vaium
; vaium -> implementar condições descritas no enunciado de or e and

function main 0
push temp 0
push temp 2
add
pop temp 4  ; temp[4] = temp[0]+temp[2]

push temp 0     ; passando os argumentos da função
push temp 2
call vaium 2    ; chamando a função

push temp 1
push temp 3
add            ; faz a soma 
add            ; acrescenta o carry que ficou no topo da pilha
pop temp 5  ; temp[5] = temp[1]+temp[3]


function vaium 2
; Entradas: argument 0 = x e argument 1 = y

; caso 1: ambos positivos, carry "garantido"
push argument 0
push argument 1
and 

; caso 2: x = 1 e y = 0, com a soma = 0
push argument 0
push argument 1
or

; caso 3: x = 0 e y = 1, com a soma = 0
push argument 0
push argument 1
add             ; faz soma truncada
not             ; inverte todos os bits

; faz a comparação geral (fora dos parênteses)
and             ; combina caso 2 e caso 3 ( = caso 4)
or              ; combina caso 4 e caso 1 ( = caso 5)

push constant 0
lt              ; se for < 0
if-goto um 
push constant 0
goto end 

label um
push constant 1
label end 
return

--------------------------------------------
; EX 2
; Assembler -> instrução modificada
; se fala de mnemonic olhar arquivo code aps g
; pede para adicionar em "addw" -> SÓ MEXER NELE
; dentro do if-else devemos preencher com a instrução em binário -> manual em instruction set Z01
; as instrucoes são colocadas do bit 3-9

public static String comp(String[] mnemnonic) {
         String op = mnemnonic[0];
         String code7 = "0000000"; // fallback padrão
     
         switch (op) {
             case "movw":
                 switch (mnemnonic[1]) {
                     case "%D": code7 = "0001100"; break;
                     case "%A": code7 = "0110000"; break;
                     case "(%A)": code7 = "1110000"; break;
                     case "$0": code7 = "0101010"; break;
                     case "$1": code7 = "0111111"; break;
                 }
                 break;
     
             case "addw": {
                 String a = mnemnonic[1];
                 String b = mnemnonic[2];
                 if ((a.equals("%D") && b.equals("%A")) || (a.equals("%A") && b.equals("%D"))) {
                     code7 = "0000010"; // D+A
                 } else if ((a.equals("%D") && b.equals("(%A)")) || (a.equals("(%A)") && b.equals("%D"))) {
                     code7 = "1000010"; // D+M
                 } else if ((a.equals("%A") && b.equals("$1")) || (a.equals("$1") && b.equals("%A"))) {
                     code7 = "0110111"; // A+1
                 } else if ((a.equals("%D") && b.equals("$1")) || (a.equals("$1") && b.equals("%D"))) {
                     code7 = "0011111"; // D+1
                 } else if ((a.equals("(%A)") && b.equals("(%A)"))) ||  ((a.equals("(%A)") && b.equals("%A)")){
                     code7 = "1110111"; 
                 } 
                
                 break;
             }
     
             case "subw": {
                 String a = mnemnonic[1];
                 String b = mnemnonic[2];
                 if (a.equals("%D") && b.equals("%A")) {
                     code7 = "0010011"; // D-A
                 } else if (a.equals("%D") && b.equals("(%A)")) {
                     code7 = "1010011"; // D-M
                 } else if (a.equals("(%A)") && b.equals("$1")) {
                     code7 = "1110010"; // M-1
                 } else if (a.equals("%A") && b.equals("$1")) {
                     code7 = "0110010"; // A-1
                 } else if (a.equals("%D") && b.equals("$1")) {
                     code7 = "0001110"; // D-1
                 }
                 break;
             }
     
             case "rsubw": {
                 String a = mnemnonic[1];
                 String b = mnemnonic[2];
                 if (a.equals("%A") && b.equals("%D")) {
                     code7 = "0000111"; // A-D
                 } else if (a.equals("(%A)") && b.equals("%D")) {
                     code7 = "1000111"; // M-D
                 } else if (a.equals("$1") && b.equals("%A")) {
                     code7 = "0111010"; // 1 - A (hipotético, se suportado)
                 } else if (a.equals("%D") && b.equals("(%A)")) {
                     code7 = "1000111"; // M-D (mesma coisa)
                 }
                 break;
             }
             
     
             case "incw":
                 switch (mnemnonic[1]) {
                     case "%A": code7 = "0110111"; break;
                     case "%D": code7 = "0011111"; break;
                     case "(%A)": code7 = "1110111"; break;
                 }
                 break;
     
             case "decw":
                 switch (mnemnonic[1]) {
                     case "%A": code7 = "0110010"; break;
                     case "%D": code7 = "0001110"; break;
                     case "(%A)": code7 = "1110010"; break;
                 }
                 break;
     
             case "notw":
                 switch (mnemnonic[1]) {
                     case "%A": code7 = "0110001"; break;
                     case "%D": code7 = "0001101"; break;
                     case "(%A)": code7 = "1110001"; break;
                 }
                 break;
     
             case "negw":
                 switch (mnemnonic[1]) {
                     case "%A": code7 = "0110011"; break;
                     case "%D": code7 = "0001111"; break;
                     case "(%A)": code7 = "1110011"; break;
                 }
                 break;
     
             case "andw": {
                 String a = mnemnonic[1];
                 String b = mnemnonic[2];
                 if ((a.equals("%D") && b.equals("%A")) || (a.equals("%A") && b.equals("%D"))) {
                     code7 = "0000000"; // D&A
                 } else if ((a.equals("%D") && b.equals("(%A)")) || (a.equals("(%A)") && b.equals("%D"))) {
                     code7 = "1000000"; // D&M
                 }
                 break;
             }
     
             case "orw": {
                 String a = mnemnonic[1];
                 String b = mnemnonic[2];
                 if ((a.equals("%D") && b.equals("%A")) || (a.equals("%A") && b.equals("%D"))) {
                     code7 = "0010101"; // D|A
                 } else if ((a.equals("%D") && b.equals("(%A)")) || (a.equals("(%A)") && b.equals("%D"))) {
                     code7 = "1010101"; // D|M
                 }
                 break;
             }
     
             default:
                 code7 = "0001100"; // valor padrão para instruções como `nop`, `jmp`
         }
     
         return "00" + code7;
     }