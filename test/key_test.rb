require './test/test_helper'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_get_keys
    @key.stubs(:random_gen).returns('31415')
    expected = { A: '31', B: '14', C: '41', D: '15' }
    assert_equal expected, @key.get_keys
  end
end
