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
; calcular o vetor das diferenças -> R[24]-R[23] ; R[23]-R[22]
; até a ram 20 e salvar o resultado na ram[30]-ram[33]
; led devem mostrar o número de diferenças 

; RACIOCINIO:
; inicializar todas as rams antes do loop e criar contadores, que vão funcionar como "ponteiros"
; decrementar o contador a cada iteracao e pular para o fim quando for <= 0
; loop de subtração

