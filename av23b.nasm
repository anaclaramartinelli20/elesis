; EX 1
; sempre que falar sobre instruções na ram com registradores / mux -> CODE.JAVA
; o resultado deve ser salvo nos reg A a G, além da memória (%A)
; compara dois números e faz o salto se a sub entre eles for maior que zero
; pegamos as intruções desde o começo (essa tem mais que o normal)
; só vamos incluir o que queremos da instrução -> nesse caso, registradores e salto

public static String comp(String[] mnemnonic) {
    comando = mnemnonic[0]  ; primeira palavra da instrução
    reg1 = mnemnonic [1] ; primeiro reg apontado
    reg2 = mnemnonic[2]  ; segundo e terceito reg apontado

    switch (comando){       ; primeira comparação: comando
        case "comp_jg":         
            switch(reg1){   ; segunda comparação: primeiro reg
                case "%A": 
                    switch(reg2){   ;terceira comparacao: segundo reg
                        case "%A": 
                            return "000000000111";
                        case "%B": 
                            return "000001000111";
                        case "%C": 
                            return "000010000111";
                        case "%D": 
                            return "000011000111";
                        case "%E": 
                            return "000100000111";
                        case "%F": 
                            return "000101000111";
                        case "%G": 
                            return "000110000111";
                        case "(%A)": 
                            return "000111000111";
                    }
            }
        default:
            return "000000000000";
    }
}

---------------------
; EX 2
; calcular as diferenças de um vetor de números
; a memória temp 0 armazena a quantidade de números no vetor
; tem que ter um contador para iterar sobre (pensar em for -> label)

function Main 0

push constant 5000
pop pointer 0       ; ponteiro 

push temp 0         