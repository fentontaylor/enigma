require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'
require './lib/message_file'

message = MessageFile.encrypt(ARGV[0], ARGV[1])
File.write( message.ciphertext_file, message.ciphertext )

puts "Created '#{message.ciphertext_file}' with the key #{message.key} and date #{message.date}"
