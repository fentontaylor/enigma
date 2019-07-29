require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'

encrypted_file = ARGV[0]
cracked_file = ARGV[1]
date = ARGV[2]

message = File.read(encrypted_file).chomp
enigma = Enigma.new
start_time = Time.now
cracked = enigma.crack(message, date)
end_time = Time.now
File.write(cracked_file, cracked[:decryption])
puts "**!Cracked!** in #{end_time - start_time} seconds."
puts "Created '#{cracked_file}' with the cracked key #{cracked[:key]} and date #{date}"
