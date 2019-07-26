require './test/test_helper'

class OffsetTest < Minitest::Test
  def setup
    @offset = Offset.new('220686')
  end

  def test_it_exists
    assert_instance_of Offset, @offset
  end

  def test_attributes
    assert_equal '220686', @offset.date
  end
end
