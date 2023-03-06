require 'timeout'

class TCP
    def initialize *args
        @estado = "CLOSED"
    end
    attr_reader :estado

    def recv(recvd)
        case [@estado, recvd.strip]
            # Closed
            in ["CLOSED", "listen"]
                @estado = "LISTEN"


            in ["CLOSED", "connect"] #  by the application.
                @estado = "SYN_SENT"
                return "SYN"
        
            # Server Listen
            in ["LISTEN", "SYN"]
                @estado = "SYN_RCVD"
                return "SYN,ACK"
            
            # Server SYN_RCVD
            in ["SYN_RCVD", "ACK"]
                @estado = "ESTABLISHED"


            in ["SYN_RCVD", "RST"]
                @estado = "LISTEN"


            in ["SYN_RCVD", "close"] 
                @estado = "FIN_WAIT_1"
                return "FIN"

            # Client SYN_SENT
            in ["SYN_SENT", "SYN,ACK"]
                @estado = "ESTABLISHED"
                return "ACK"

            in ["SYN_SENT", "close"]
                @estado = "SYN_SENT"
            
            # Established
            in ["ESTABLISHED", "FIN"]
                @estado = "CLOSE_WAIT"
                return "ACK"

            in ["ESTABLISHED", "close"] # close by the application.
                @estado = "FIN_WAIT_1"
                return "FIN"
            in ["ESTABLISHED", "ACK"]
                return "ACK"
            
            # Fin_Wait_1
            in ["FIN_WAIT_1","ACK"]
                @estado = "FIN_WAIT_2"

            in ["FIN_WAIT_1","FIN"]
                @estado = "CLOSING"
                return "ACK"
                
            in ["FIN_WAIT_1","FIN,ACK"]
                @estado = "TIME_WAIT"
                return "ACK"
            
            # Fin_Wait_2
            in ["FIN_WAIT_2", "FIN"]
                @estado = "TIME_WAIT"
                return "ACK"
            
            # Close_Wait
            in ["CLOSE_WAIT", "close"] # close by the application.
                @estado = "LAST_ACK"
                return "FIN"
            
            # Last_Ack
            in ["LAST_ACK","ACK"]
                @estado = "CLOSED"
            
            in [_, "exit"]
                return "exit"   
        else
            if @estado == "ESTABLISHED" then
                return "ACK"
            end        
        end

        return "nothing"
    end
end

tcp = TCP.new()
print("State: "+tcp.estado+"\n")
input = ""
loop do
    if %w(SYN_RCVD SYN_SENT TIME_WAIT).include? tcp.estado
        begin
            Timeout::timeout(15) {
                print("SEND: ")
                input = gets()
            }

            print("Received From Remote Machine: " + tcp.recv(input)+"\n")
            print("Remote Machine State: "+tcp.estado+"\n\n")

        rescue Timeout::Error
            print("TIMEOUT\n")
            tcp.estado = "CLOSED"
            print("Received From Remote Machine: " + tcp.recv(input)+"\n")
        end    
    else
        print("SEND: ")
        input = gets()
        print("Received From Remote Machine: " + tcp.recv(input)+"\n")
        print("Remote Machine State: "+tcp.estado+"\n\n")
end
end