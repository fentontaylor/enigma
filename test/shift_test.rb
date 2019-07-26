require './test/test_helper'

class ShiftTest < Minitest::Test
  def setup
    @key = Key.new
    @key.stubs(:random_digits).returns('31415')
    @offset = Offset.new('220686')
    @shift = Shift.new(@key, @offset)
  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_get_shifts
    expected = { A: 31, B: 19, C: 50, D: 21}
    assert_equal expected, @shift.get_shifts
  end
end
