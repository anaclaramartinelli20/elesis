; EX 1

; RAM[3] = RAM[RAM[1]] - RAM[RAM[0]]

; RAM[RAM[1]] -> tem que mover duplamente do registrador

leaw $1, %A     ; A = RAM[1]
movw (%A), %A   ; A = RAM[RAM[1]]
movw (%A), %D   ; D = RAM[RAM[1]]

leaw $0, %A     ; A = 0
movw (%A), %A   ; A = RAM[RAM[0]]

subw %D, (%A), %D 

leaw $3, %A 
movw %D, (%A)   ; salva o conteúdo de D no endereço de A

---------------------------------------------

; EX 2

; RAM[3] = RAM[RAM[1]] - RAM[RAM[0]] -> apenas se RAM[1]>RAM[0]

; verificação
leaw $1, %A    
movw (%A), %D   
leaw $0, %A     
subw %D, (%A), %D 

; salto
leaw $END, %A 
jle %D 
nop

; subtração real
leaw $1, %A     ; A = RAM[1]
movw (%A), %A   ; A = RAM[RAM[1]]
movw (%A), %D   ; D = RAM[RAM[1]]

leaw $0, %A     ; A = 0
movw (%A), %A   ; A = RAM[RAM[0]]

subw %D, (%A), %D 

leaw $3, %A 
movw %D, (%A)   ; salva o conteúdo de D no endereço de A

END:

---------------------------------------------

; EX 3

; subtração de vetor : ram 20 ate 24

; RAM[0] contem o número de valores do vetor

; salvar na ram a partir da posição 30

; salvar nos leds dps -> posição 2184

; carregar todas as posições -> loop de subtração 

; carregando as posições e contadores

leaw $20, %A 
movw %A, %D 
leaw $1, %A     ; end do primeiro valor: RAM[20]
movw %D, (%A)

leaw $21, %A 
movw %A, %D 
leaw $2, %A     ; end do segundo: RAM[21]
movw %D, (%A)

leaw $30, %A 
movw %A, %D 
leaw $3, %A     ; end de onde gravar: RAM[30]
movw %D, (%A)

leaw $0, %A 
movw %A, %D 
leaw $4, %A     ; cont de diferenças: 0
movw %D, (%A)

LOOP:
leaw $2, %A     ; A = cont 2
movw (%A), %A   ; A = RAM[2]
movw (%A), %D   ; D = A

leaw $1, %A     ; A = cont 1
movw (%A), %A   ; A = RAM[1]

subw %D, (%A), %D   ; valor atual – próximo

leaw $3, %A     ; A = 3
movw (%A), %A   ; A = RAM[3]
movw %D, (%A)   ; salvando o resultado

leaw $1, %A
movw (%A), %D
incw %D         ; incrementando todos os contadores
movw %D, (%A)

leaw $2, %A
movw (%A), %D
incw %D
movw %D, (%A)

leaw $3, %A
movw (%A), %D
incw %D
movw %D, (%A)

leaw $4, %A     ; cont4
movw (%A), %D  
incw %D
movw %D, (%A)  

; testando o valor em RAM[4] -> comparando com RAM[0] -> devem estar iguais
; if (cont4 + 1) == n

incw %D 
leaw $0, %A 
subw %D, (%A), %D 
je %D, END
nop 

leaw $LOOP, %A      ; volta pro loop
jmp
nop