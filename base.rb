class Maquina
    def getChar
      print(">> ")
      gets.chomp
    end
    
    def iniciar
      estado = "q0"
      loop do
        case [estado, getChar]
          # Q0
          in ["q0", "a"]
            estado = "q1"
          in ["q0", "b"]
            estado = "q0"
  
          #Q1
          in ["q1", "a"]
            estado = "q2"
          in ["q1", "b"]
            estado = "q0"
  
          #Q2
          in ["q2", "a"]
            estado = "q3"
          in ["q2", "b"]
            estado = "q0"
  
          #Q3
          in ["q3", "b"]
            estado = "q4"
          in ["q3", "a"]
            estado = "q7"
  
          #Q4
          in ["q4", "a"]
            estado = "q5"
          in ["q4", "b"]
            estado = "q4"
  
          #Q5
          in ["q5", "a"]
            estado = "q6"
          in ["q5", "b"]
            estado = "q4"
  
          #Q6
          in ["q6", "a"]
            estado = "q7"
          in ["q6", "b"]
            estado = "q4"
  
          #Q7
          in ["q7", "b"]
            estado = "q8"
  
          #Q8
          in ["q8", "a"]
            estado = "q9"
          in ["q8", "b"]
            estado = "8"
  
          #Q9
          in ["q9", "a"]
            estado = "q10"
          in ["q9", "b"]
            estado = "q8"
  
          #Q10
          in ["q10", "b"]
            estado = "q8"
  
          # Estados de aceitação
          in ["q7", ""] 
            puts "Aceito"
            break
          
          in ["q8", ""] 
            puts "Aceito"
            break
  
          in ["q9", ""] 
            puts "Aceito"
            break
          
          in ["q10", ""] 
            puts "Aceito"
            break
  
          # Erro
          else
            puts "Erro"
            break
        end
  
        puts "Estado: " + estado
      end
    end
  end
  
  rodar = Maquina.new()
  rodar.iniciar()