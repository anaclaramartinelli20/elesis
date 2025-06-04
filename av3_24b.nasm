; EX 1
; RAM[3] = RAM[RAM[1]] - RAM[RAM[0]]

leaw $0, %A ; A = RAM[0]
movw (%A), %A ; A = RAM[RAM[0]]
movw (%A), %D ; D = A 

leaw $1, %A ; A = RAM[1]
movw (%A), %A ; A = RAM[RAM[1]]

subw %D, (%A), %D

leaw $3, %A 
movw %D, (%A)

--------
; EX 2
; igual ao 1, mas apenas se RAM[1]>RAM[0]
; deve desviar se subw<0

; verificação:
leaw $0, %A ; A = RAM[0]
movw (%A), %D ; D = A 

leaw $1, %A ; A = RAM[1]

subw %D, (%A), %D

leaw $END, %A 
jl %D 
nop

; subtração de verdade
leaw $0, %A ; A = RAM[0]
movw (%A), %A ; A = RAM[RAM[0]]
movw (%A), %D ; D = A 

leaw $1, %A ; A = RAM[1]
movw (%A), %A ; A = RAM[RAM[1]]

subw %D, (%A), %D

leaw $3, %A 
movw %D, (%A)

END: 

----------
; EX 3
; calcular o vetor de n valores das diferenças -> R[24]-R[23] ; R[23]-R[22]
; número n armazenado em RAM[0]
; até a ram 20 e salvar o resultado na ram[30]-ram[33]
; led devem mostrar o número de diferenças 

; RACIOCINIO:
; primeiro, verificar o número na ram[0]
; inicializar as rams iniciaies (primeiras duas da subtração, primeira da "memória" e a 0) antes do loop e criar contadores, que vão funcionar como armazenadores e "ponteiros"
; decrementar o contador a cada iteracao e pular para o fim quando for <= 0
; loop de subtração a partir dos "armazenadores". iremos trabalhar apenas com eles dentro do loop

leaw $24, %A    ; A = RAM[24]
movw (%A), %D 
leaw $1, %A     ; se repete em todos abaixo: armazenador 
movw %D, (%A)   ; se repete em todos abaixo: para esse -> 1 = RAM[24]

leaw $23, %A 
movw (%A), %D 
leaw $2, %A 
movw %D, (%A) 

leaw $30, %A 
movw (%A), %D 
leaw $3, %A     
movw %D, (%A)

leaw $0, %A 
movw (%A), %D 
leaw $4, %A     
movw %D, (%A)

; agora, com tudo inicializado e armazenado, podemos iniciar o loop
LOOP:
; 1 - realizar a subtração
leaw $1, %A 
movw (%A), %A           ; REG[A] = RAM[24] = RAM[RAM[24]]
movw (%A), %D

leaw $2, %A
movw (%A), %A

subw  (%A), %D, %D      ; D = D - A

; 2 - salvar em RAM[30]
leaw $3, %A 
movw %D, (%A)

; 3 - incrementando os ponteiros  para percorrer todas as RAMs 
leaw $1, %A 
movw (%A), %D   ; pega o ponteiro
incw %D         ; incrementa
movw %D, (%A)   ; devolve para o registrador pq depois precisaremos verificar se = 0

leaw $2, %A 
movw (%A), %D  
incw %D 
movw %D, (%A)

leaw $3, %A 
movw (%A), %D   
incw %D 
movw %D, (%A)

leaw $4, %A 
movw (%A), %D   
incw %D 
movw %D, (%A)

; 4 - salta se for igual a zero (subtração terminou)
incw %D         ; if D == RAM[0]
leaw $0, %A 
subw %D, (%A), %D

leaw $END, %A
je %D 
nop

leaw $LOOP, %A  ; volta para o loop
jmp
nop

; 5 - label END: resposta armazenador 4 -> led
END:
leaw $4, %A 
movw (%A), %D 
leaw $21184, %A 
movw %D, (%A)