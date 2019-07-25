require './test/test_helper'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_attributes
    assert_instance_of String, @key.keygen
    assert_equal 5, @key.keygen.length
  end

  def test_get_keys
    @key.stubs(:keygen).returns('31415')
    expected = { A: '31', B: '14', C: '41', D: '15' }
    assert_equal expected, @key.get_keys
  end
end
