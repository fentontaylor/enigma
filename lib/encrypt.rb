require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'

message_file = ARGV[0]
file_to_write = ARGV[1]

message = File.read(message_file)
enigma = Enigma.new
encryption = enigma.encrypt(message)
File.write( file_to_write, encryption[:encryption] )
puts "Created '#{file_to_write}' with the key #{encryption[:key]} and date #{encryption[:date]}"
