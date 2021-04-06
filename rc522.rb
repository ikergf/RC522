require 'mfrc522' #Llibreria necessària per tenir accés al perifèric desde la Raspberry

class Rfid_rc522        
	@@r = MFRC522.new		#Creem l'objecte MFRC522
    def read_uid 	#Aquesta funció definida és l'encarregada de llegir l'identificador i tornar-lo en cas de que no hi hagi error
        puts "Passi la seva targeta pel sensor"
        while(true)
			begin
				@@r.picc_request(MFRC522::PICC_REQA)	#Passa el PICC de l'estat HALT o IDLE a l'estat ACTIU
				uid, sak = @@r.picc_select	#Llegeix l'uid
				rescue CommunicationError 
				rescue UnexpectedDataError => e
					puts "DataError: #{e.message}"
			
				if (uid)
					break
				end
			end
		end      
        return uid
    end
end



if __FILE__ == $0	#Aquí creem l'objecte Rfid_rc522 i cridem la funció creada per tal que s'imprimeixi l'identificador

	rf = Rfid_rc522.new
	uid=rf.read_uid
	puts "\n"
	puts "El seu identificador es: "
	hex = uid.pack('C*').unpack1('H*').upcase
	puts hex
end
