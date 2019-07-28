
  def test_message_length
    assert_equal 15, @enigma.message_length('hello world end')
    assert_equal 15, @enigma.message_length('hello! world! end')
  end

  def test_first_crack_shift
    assert_equal :D, @enigma.first_crack_shift('hello world end')
    assert_equal :C, @enigma.first_crack_shift('ello world end')
    assert_equal :B, @enigma.first_crack_shift('ello worl end')
    assert_equal :A, @enigma.first_crack_shift('ello wor end')
  end
