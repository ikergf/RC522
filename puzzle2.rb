require 'gtk3'
require 'rfid_rc522'

class RubyApp < Gtk::Window

    def initialize
        super
    
			set_title  "Puzzle 2"
			signal_connect "destroy" do 
            Gtk.main_quit 
        end
        
        		@rf = Rfid_rc522.new

        set_border_width 10

		#CREEM UN GRID
		grid = Gtk::Grid.new #Això crea el grid(ens permetra col·locar els widgets a on volguem)
		add(grid) #Afegim el grid
		
		#Creem un label
        @label = Gtk::Label.new #Això crea el label, és el que anira canviant
        @label.set_text("Please, login with your university card") #Ens permet escriure al label
		grid.attach(@label,0,0,1,1) #Aquí li estem dient que volem que el label estigui a la columna 0 i la fila 0 i que ocupi 1 columna i 1 fila
		@label.set_size_request(500,100) #Fem el label més gran
		@label.override_background_color(0 , Gdk::RGBA::new(0, 0, 1.0, 1.0)) #Amb això fem que el fons del label sigui de color blau
		@label.override_color(0 , Gdk::RGBA::new(1.0, 1.0, 1.0, 1.0))	#Lletres de color blanc 
		
		
		#Creem el botó clear
		button = Gtk::Button.new(:label => "Clear") #Creem el botó, on hi ficarà clear
		button.signal_connect("clicked") do 
			@label.set_text("Please, login with your university card:")
			rc522
		end
		grid.attach(button, 0, 1, 1, 1) #El botó va a la columna 0, fila 1 i ocupa 1 columna i 1 fila
		
		#Col·loquem la finestra al centre de la pantalla
        set_window_position(:center)   
        
		rc522		
		    
        show_all
        Gtk.main
        
        
    end
    

    def rc522
    thr = Thread.new{
		uid = @rf.read_uid
		@label.set_text("uid #{uid}")
		@label.override_background_color(0 , Gdk::RGBA::new(1.0, 0, 0, 1.0)) #Color vermell
		
		  }     		
    end
    
    def clear
		
		
		@label.set_text("Please, login with your university card")
		@label.override_background_color(0 , Gdk::RGBA::new(0, 0, 1.0, 1.0)) #Color blau		
		hr=Thread.new {rc522}

    end
end


    window = RubyApp.new
  
