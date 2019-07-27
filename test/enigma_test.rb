require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @key = Key.new('02715')
    @offset = Offset.new('040895')
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_char_set
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
    assert_equal expected, @enigma.char_set
  end

  def test_make_ciphers
    expected = {
      A: ('a'..'z').to_a.push(' ').rotate(3),
      B: ('a'..'z').to_a.push(' ').rotate(27),
      C: ('a'..'z').to_a.push(' ').rotate(73),
      D: ('a'..'z').to_a.push(' ').rotate(20)
    }
    assert_equal expected, @enigma.make_ciphers(@key.key_val, @offset.date)
  end

  def test_prep_message
    assert_equal %w[h e l l o], @enigma.prep_message('hello')
    assert_equal %w[h e l l o], @enigma.prep_message('HELLo')
    assert_equal %w[h e l l o !], @enigma.prep_message('Hello!')
    assert_equal %w[h e l l o ! 4 %], @enigma.prep_message('Hello!4%')
  end

  def test_transcribe_message
    expected = 'keder ohulw'
    actual = @enigma.transcribe_message('hello world', '02715', '040895')
    assert_equal expected, actual
  end

  def test_encrypt
    expected = {
      encryption: 'keder ohulw',
      key: '02715',
      date: '040895'
    }
    actual = @enigma.encrypt('hello world', '02715', '040895')
    assert_equal expected, actual

    actual_2 = @enigma.encrypt('Hello WORLD', '02715', '040895')
    assert_equal expected, actual_2

    expected_2 = {
      encryption: '$keder ohulw!',
      key: '02715',
      date: '040895'
    }
    actual_3 = @enigma.encrypt('$Hello WORLD!', '02715', '040895')
    assert_equal expected_2, actual_3
  end

  def test_encrypt_without_date
    Date.any_instance.stubs(:strftime).returns('040895')
    expected = {
      encryption: 'keder',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.encrypt('hello', '02715')

    actual = @enigma.encrypt('hello', '02715')
    assert actual.values.all? { |val| val.class == String }
    assert actual[:date].to_i != 0
  end

  def test_encrypt_without_date_or_key
    Date.any_instance.stubs(:strftime).returns('040895')
    @enigma.stubs(:random_digits).returns('02715')
    expected = {
      encryption: 'keder',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.encrypt('hello')

    actual = @enigma.encrypt('hello')
    assert actual.values.all? { |val| val.class == String }
    assert actual[:key].to_i > 0
  end
end
