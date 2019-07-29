require './test/test_helper'

class RandomCharsTest < Minitest::Test
  include RandomChars

  def test_generate_creates_correct_size
    assert_equal 1, random_digits(1).length
    assert_equal 2, random_digits(2).length
    assert_equal 3, random_digits(3).length
    assert_equal 4, random_digits(4).length
    assert_equal 5, random_digits(5).length
  end

  def test_generate_creates_strings_of_numbers
    nums = []
    10.times { nums << random_digits(5) }
    assert nums.all? { |num| num.class == String }

    ints = nums.map { |num| num.to_i }
    assert ints.all? { |num| num.class == Integer }
  end

  def test_character_set
    expected = {
      digits: (0..9).to_a,
      upper: ('A'..'Z').to_a,
      lower: ('a'..'z').to_a
    }
    assert_equal expected, character_set
  end

  def test_random_characters
    assert_equal 16, random_characters(16).length
    assert random_characters(16).split.all? do |char|
      chars = character_set.values.map { |arr| arr }.flatten
      chars.include? char
    end
  end
end
