require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'

message_file = ARGV[0]
write_to_file = ARGV[1]
key = ARGV[2]
date = ARGV[3]

message = File.read(message_file)
enigma = Enigma.new
decryption = enigma.decrypt(message, key, date)
File.write(write_to_file, decryption[:decryption])
puts "Created '#{ARGV[1]}' with the key #{decryption[:key]} and date #{decryption[:date]}"
