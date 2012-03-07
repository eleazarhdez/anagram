#!/usr/bin/env ruby
require 'optparse'							#nos deja disponibles la clase option parse, se puede parsear la linea de comandos

dictionary = "/usr/share/dict/words"	
OptionParser.new do |opts|					#construye un objeto parser de la linea de comandos, recibe un bloque en el que se define como hacer el parsing. opts es el parser 
  opts.banner = "Usage: anagram [ options ] word ..."		#define el banner en el caso de que se pida el uso del comando
  opts.on("-d", "--dict path", String, "Path to dictionary") do |dict|	#activamos opciones, la -d en este caso y recibe un argumento de la clase string.dict es el desciptor
    dictionary = dict
  end
  opts.on("-h", "--help", "Show this message") do	#activa otra opcion, forma corta -h, forma larga --help
    puts opts													#se imprime el objeto parser
    exit
  end
  begin
    ARGV << '-h' if ARGV.empty?		#si no hay argumentos pone la opcion -h por defecto
    opts.parse!(ARGV)					#modifica el estado interno del objeto el parse!
    rescue OptionParser::ParseError => e	#capturamos la excepcion, y su tipo
      STDERR.puts e.message,"\n",opts		#luego tiramso el mensaje de la excepcion por pantalla
      exit(-1)
  end
end


def signature_of(word)
  word.unpack("c*").sort.pack("c*")
end


signatures = Hash.new { |h,k| h[k] = [] }		#cada elemento del hash si no esta inicializado se inicializa así, h= hash, k = key, si ta vacio el signature se pone a nil
File.foreach(dictionary) do |line|			#
  word = line.chomp								#chomp quita el retorno de carro final de la linea, solo el ultimo
  signature = signature_of(word)				#
  signatures[signature] << word				#claves son las palabras, y sus valores seran arrays que contienen todos los anagramas de esa palabra
end


ARGV.each do |word|
  s = signature_of(word)						
  if signatures[s].length != 0
    puts "Anagrams of '#{word}': #{signatures[s].join(', ')}"
  else
    puts "No anagrams of '#{word}' found in #{dictionary}"
  end
end



