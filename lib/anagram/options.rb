require 'optparse'		#provee una libreria para el parseo de la linea de comando

module Anagram				#un modulo provee un espacio de nombres, significa que los objetos ke estan dentro de el, llevan su nombre completo anagram, es como una interfaz pero 								tiene codigo, provee metodos tambien
  class Options
     
    DEFAULT_DICTIONARY = "/usr/share/dict/words"	#
    
    attr_reader :dictionary
    attr_reader :words_to_find
    
    def initialize(argv)		#metodo llamado por el constructor, y que por tanto inicializa
      @dictionary = DEFAULT_DICTIONARY
      parse(argv) 
      @words_to_find = argv
    end
                 
  private											#lo que sigue a partir de aqui es privado
    
    def parse(argv)								#metodo privado
      OptionParser.new do |opts|  
        opts.banner = "Usage:  anagram [ options ]  word..."

        opts.on("-d", "--dict path", String, "Path to dictionary") do |dict|
          @dictionary = dict
        end 

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

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
