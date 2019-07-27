require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'

message = File.read( ARGV[0] )
enigma = Enigma.new
encryption = enigma.encrypt(message)
File.write( ARGV[1], encryption[:encryption] )
puts "Created '#{ARGV[1]}' with the key #{encryption[:key]} and date #{encryption[:date]}"
