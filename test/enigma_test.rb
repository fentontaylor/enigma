require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @shift = Shift.new(@key, @offset)
    @shift.stubs(:get_shifts).returns({ A: 3, B: 27, C: 73, D: 20 })
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_make_ciphers

  end
end
