class Enigma
  include RandomChars

  def char_set
    @chars_array ||= ('a'..'z').to_a.push(' ')
  end

  def make_ciphers(key, date)
    shift = Shift.new( Key.new(key), Offset.new(date) )
    shift.get_shifts.transform_values { |val| char_set.rotate(val) }
  end

  def prep_message(message)
    message.downcase.split('')
  end

  def transcribe_message(message, key, date)
    shift_ref = [:D, :A, :B, :C]
    ciphers = make_ciphers(key, date)
    code = prep_message(message).map do |letter|
        shift_ref.rotate! if char_set.include?(letter)
        char_set.include?(letter) ? ciphers[shift_ref.first][char_set.rindex(letter)] : letter
    end.join
  end

  def encrypt(message, key = random_digits(5), date = Date.today.strftime('%d%m%y'))
    code = transcribe_message(message, key, date)
    {encryption: code, key: key, date: date}
  end
end
