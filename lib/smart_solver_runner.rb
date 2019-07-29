require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'
require './lib/smart_solver'

encrypted_file = ARGV[0]
file_to_write = ARGV[1]

message = File.read(encrypted_file).chomp
solver = SmartSolver.new

start_time = Time.now
cracked = solver.smart_crack(message)
end_time = Time.now

File.write(file_to_write, cracked)

puts "**!Cracked!** in #{end_time - start_time} seconds."
puts "Created '#{file_to_write}' with decrypted message."
