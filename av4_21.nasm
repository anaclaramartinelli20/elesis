; EX 1 - VM

; sequencia de fibonacci n = (n-2)+(n-1)
; n-2 -> 0
; n-1 -> 1
; 11 primeiros termos
; for i < 10, sendo i = 0: n += (n-2)+(n-1)

push constant 0
pop temp 2     ; i = 0 

push constant 0
push constant 1

label loop
pop temp 0
pop temp 1

push temp 0
push temp 1
push temp 0
push temp 1
add           ; somando os termos

push temp 2
push constant 1
add
pop temp 2    ; iterando o contador

push temp 2
push constant 9
lt
if-goto loop  ; menor que 9 -> volta pro loop

; EX 2 - VM

; integração numérica -> função 

; A = (x2 - x1) * (y1 + y2) / 2
; x2 : argument 0
; x1 : argument 1
; y2 : argument 2
; y1 : argument 3

function trapz 0
push argument 0
push argument 1
sub

push argument 2
push argument 3
add

call mult 2         ; função da aps H

push constant 2
call div 2          ; função da aps H

return

; EX 3 - Assembler -> java

; presumindo que o método está pronto
; string: mnemonic

if (mnemonic.lenght > 3){
    return '11';
} else if (mnemonic[2].equals('%A')){
    return '00'
} else if (mnemonic[2].equals('%D')){
    return '01'
} else {
    return '11'
}


; EX 4 - VM translator -> java

; adicionar o comando popp que copia o último valor da pilha mas não o apaga

; usar commands.add('alguma coisa em assembly')

commands.add('leaw $SP, %A'); // stack pointer
commands.add('movw (%A), %A');
commands.add('decw %A');
commands.add('movw (%A), %D');
commands.add(String.format("leaw $%d,%%A", (index+5) )); //usa o String.format para substituir o %d pelo valor de index+5
commands.add('movw %D, (%A)');



