require './test/test_helper'

class RandomDigitsTest < Minitest::Test
  include RandomDigits

  def test_generate_creates_correct_size
    assert_equal 1, generate(1).length
    assert_equal 2, generate(2).length
    assert_equal 3, generate(3).length
    assert_equal 4, generate(4).length
    assert_equal 5, generate(5).length
  end

  def test_generate_creates_strings_of_numbers
    nums = []
    10.times { nums << generate(5) }
    assert nums.all? { |num| num.class == String }

    ints = nums.map { |num| num.to_i }
    assert ints.all? { |num| num.class == Integer }
  end
end
