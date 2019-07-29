class Enigma
  include RandomChars

  def char_set
    @chars_array ||= ('a'..'z').to_a.push(' ')
  end

  def make_ciphers(key, date, type)
    shift = Shift.new( Key.new(key), Offset.new(date) )
    shift.get_shifts.transform_values do |val|
      val *= -1 if type == :decrypt
      char_set.rotate(val)
    end
  end

  def prep_message(message)
    message.downcase.split('')
  end

  def transcribe_message(message, key, date, type)
    shift_ref = [:D, :A, :B, :C]
    ciphers = make_ciphers(key, date, type)
    prep_message(message).map do |letter|
        if char_set.include?(letter)
          shift_ref.rotate!
          letter = ciphers[shift_ref.first][char_set.rindex(letter)]
        end
        letter
    end.join
  end

  def encrypt(message,
              key = random_digits(5),
              date = Date.today.strftime('%d%m%y'))
    code = transcribe_message(message, key, date, :encrypt)
    {encryption: code, key: key, date: date}
  end

  def decrypt(message,
              key,
              date = Date.today.strftime('%d%m%y'))
    code = transcribe_message(message, key, date, :decrypt)
    {decryption: code, key: key, date: date}
  end

  def crack(message, date = Date.today.strftime('%d%m%y'))
    attempt = 'abcd'
    seed = 1
    until attempt[-4..-1] == ' end'
      key = seed.to_s.rjust(5, '0')
      attempt = decrypt(message, key, date)[:decryption]
      seed += 1
    end
    { decryption: attempt, key: key, date: date }
  end
end
