require './test/test_helper'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_get_keys_with_random_digits
    @key.stubs(:random_digits).returns('02715')
    expected = { A: 2, B: 27, C: 71, D: 15 }
    assert_equal expected, @key.get_keys
  end

  def test_get_keys_with_given_digits
    keys = @key.get_keys('12345')
    expected = { A: 12, B: 23, C: 34, D: 45 }
    assert_equal expected, keys 
  end
end
