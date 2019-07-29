require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @key = Key.new('02715')
    @offset = Offset.new('040895')
    @enigma = Enigma.new
    @all_characters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'] +
                      ['j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'] +
                      ['s', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_char_set
    assert_equal @all_characters, @enigma.char_set
  end

  def test_make_ciphers
    expected = {
      A: @all_characters.rotate(3),
      B: @all_characters.rotate(27),
      C: @all_characters.rotate(73),
      D: @all_characters.rotate(20)
    }
    assert_equal expected, @enigma.make_ciphers(@key.key_val, @offset.date, :encrypt)

    expected = {
      A: @all_characters.rotate(-3),
      B: @all_characters.rotate(-27),
      C: @all_characters.rotate(-73),
      D: @all_characters.rotate(-20)
    }
    assert_equal expected, @enigma.make_ciphers(@key.key_val, @offset.date, :decrypt)
  end

  def test_prep_message
    assert_equal %w[h e l l o], @enigma.prep_message('hello')
    assert_equal %w[h e l l o], @enigma.prep_message('HELLo')
    assert_equal %w[h e l l o !], @enigma.prep_message('Hello!')
    assert_equal %w[h e l l o ! 4 %], @enigma.prep_message('Hello!4%')
  end

  def test_transcribe_message
    expected = 'keder ohulw'
    actual = @enigma.transcribe_message('hello world', '02715', '040895', :encrypt)
    assert_equal expected, actual

    expected = 'keder? ohulw!'
    actual = @enigma.transcribe_message('hello? world!', '02715', '040895', :encrypt)
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
    assert actual.values.none?(&:nil?)
    assert actual.values.all? { |val| val.class == String }
    assert actual[:key].to_i > 0
    assert actual[:date].to_i > 0
  end

  def test_decrypt
    expected = {
      decryption: 'hello world',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.decrypt('keder ohulw', '02715', '040895')
  end

  def test_encrypt_decrypt_integration
    encrypted = @enigma.encrypt("What's up?", '31415')
    decrypted = @enigma.decrypt(encrypted[:encryption], '31415')
    assert_equal "what's up?", decrypted[:decryption]
  end

  def test_crack
    encrypted = @enigma.encrypt('hello world end', '07190', '220619')
    cracked = @enigma.crack(encrypted[:encryption], '220619')
    assert_equal 'hello world end', cracked[:decryption]
    assert_equal '07190', cracked[:key]

    encrypted_2 = @enigma.encrypt("Don't stop believing! end", '31415', '220619')
    cracked_2 = @enigma.crack(encrypted_2[:encryption], '220619')
    assert_equal "don't stop believing! end", cracked_2[:decryption]
  end

  def test_crack_using_todays_date
    encrypted = @enigma.encrypt('hello world end')
    cracked = @enigma.crack(encrypted[:encryption])
    assert_equal 'hello world end', cracked[:decryption]
  end
end
