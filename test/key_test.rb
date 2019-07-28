require './test/test_helper'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new('02715')
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_attributes
    assert_equal '02715', @key.key_val
  end

  def test_get_keys_with_given_digits
    expected = { A: 2, B: 27, C: 71, D: 15 }
    assert_equal expected, @key.get_keys
  end
end
