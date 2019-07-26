require './test/test_helper'

class OffsetTest < Minitest::Test
  def setup
    @offset = Offset.new('040895')
  end

  def test_it_exists
    assert_instance_of Offset, @offset
  end

  # def test_attributes
  #   assert_equal '220686', @offset.date
  # end

  def test_offset_prep
    assert_equal '1025', @offset.offset_prep
  end

  def test_get_offsets
    expected = { A: 1, B: 0, C: 2, D: 5 }
    assert_equal expected, @offset.get_offsets
  end
end
