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
