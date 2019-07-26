require './test/test_helper'

class ShiftTest < Minitest::Test
  def setup
    @key = Key.new
    @key.stubs(:random_digits).returns('02715')
    @offset = Offset.new('040895')
    @shift = Shift.new(@key, @offset)
  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_get_shifts
    expected = { A: 3, B: 27, C: 73, D: 20 }
    assert_equal expected, @shift.get_shifts
  end
end
