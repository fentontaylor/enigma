require './test/test_helper'

class RandomDigitsTest < Minitest::Test
  include RandomDigits

  def test_generate
    assert_equal 4, generate(4).digits.length
  end
end
