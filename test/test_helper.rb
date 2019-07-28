require 'simplecov'

SimpleCov.start do
  add_filter '/test'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'date'
require './modules/random_chars'
require './lib/key'
require './lib/offset'
require './lib/shift'
require './lib/enigma'
require './lib/smart_solver'
