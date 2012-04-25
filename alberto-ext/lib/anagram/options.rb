require 'optparse'

# Se provee el espacio de nombres Anagram
# Anagram::Options
module Anagram
  class Options
    #Diccionario por defecto cuando no se manda por parámetro  
    DEFAULT_DICTIONARY = "/usr/share/dict/words"
    
		# Define getters y setters para el diccionario y las palabras
		# a encontrar
    attr_reader :dictionary
    attr_reader :words_to_find
    
		
    def initialize(argv)
      @dictionary = DEFAULT_DICTIONARY
      parse(argv) 
			# Se establecen las opciones y se eliminan del ARGV
			# El resto de opciones son las palabras a buscar.
      @words_to_find = argv
    end
    
		# Metodos privados         
  private
		# Se define un OptionParser para las opciones del programa
    def parse(argv)
      OptionParser.new do |opts| 
				# Ayuda pra caso de errores
        opts.banner = "Usage:  anagram [ options ]  word..."
				# Especificación del diccionario
        opts.on("-d", "--dict path", String, "Path to dictionary") do |dict|
          @dictionary = dict
        end 
				# Opción de ayuda
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

				# Como se realiza el parse de la entrada
        begin
          argv = ["-h"] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end    
    end
  end

end

