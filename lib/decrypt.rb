require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'
require './lib/message_file'

message = MessageFile.decrypt(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
File.write(message.text_file, message.text)

puts "Created '#{message.text_file}' with the key #{message.key} and date #{message.date}"
