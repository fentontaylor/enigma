require './test/test_helper'

class MessageFileTest < Minitest::Test
  def setup
    @message = MessageFile.new(text_file: 'message.txt',
                              ciphertext_file: 'encrypted.txt',
                              text: 'hello world',
                              ciphertext: 'keder ohulw',
                              key: '02715',
                              date: '040895')
  end

  def test_it_exists
    assert_instance_of MessageFile, @message
  end

  def test_attributes
    assert_equal 'message.txt', @message.text_file
    assert_equal 'encrypted.txt', @message.ciphertext_file
    assert_equal 'hello world', @message.text
    assert_equal 'keder ohulw', @message.ciphertext
    assert_equal '02715', @message.key
    assert_equal '040895', @message.date
  end

  def test_encrypt
    Date.any_instance.stubs(:strftime).returns('040895')
    Enigma.any_instance.stubs(:random_digits).returns('02715')

    message = MessageFile.encrypt('texts/test_message.txt',
                                  'texts/test_encrypted.txt')

    assert_equal 'texts/test_message.txt', message.text_file
    assert_equal 'texts/test_encrypted.txt', message.ciphertext_file
    assert_equal 'hello world', message.text.chomp
    assert_equal 'keder ohulw', message.ciphertext.chomp
    assert_equal '02715', message.key
    assert_equal '040895', message.date
  end

  def test_decrypt
    Date.any_instance.stubs(:strftime).returns('040895')
    Enigma.any_instance.stubs(:random_digits).returns('02715')

    message_encrypt = MessageFile.encrypt('texts/test_message.txt',
                                  'texts/test_encrypted.txt')

    File.write(message_encrypt.ciphertext_file, message_encrypt.ciphertext)

    message_decrypt = MessageFile.decrypt('texts/test_encrypted.txt',
                                  'texts/test_decrypted.txt',
                                  "#{message_encrypt.key}",
                                  "#{message_encrypt.date}")
    assert_equal 'texts/test_decrypted.txt', message_decrypt.text_file
    assert_equal 'texts/test_encrypted.txt', message_decrypt.ciphertext_file
    assert_equal 'hello world', message_decrypt.text.chomp
    assert_equal 'keder ohulw', message_decrypt.ciphertext.chomp
    assert_equal '02715', message_decrypt.key
    assert_equal '040895', message_decrypt.date
  end
end
