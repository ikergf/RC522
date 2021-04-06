require 'mfrc522' #Llibreria necessària per tenir accés al perifèric desde la Raspberry

class Rfid_rc522
    @@r = MFRC522.new		#Creem l'objecte MFRC522
    def read_uid 	#Aquesta funció definida és l'encarregada de llegir l'identificador i tornar-lo en cas de que no hi hagi error
        while(true)
			begin
				@@r.picc_request(MFRC522::PICC_REQA)	#Passa ek PICC de l'estat HALT o IDLE a l'estat ACTIU
				uid, sak = @@r.picc_select	#Llegeix l'uid
				rescue CommunicationError 
				rescue UnexpectedDataError 
				
				if (uid)
					break
				end
			end
		end
		hex = uid.pack('C*').unpack1('H*').upcase
        return hex
    end
end
