class Enigma
  include RandomChars

  def char_set
    @chars_array ||= ('a'..'z').to_a.push(' ')
  end

  def make_ciphers(key, date)
    shift = Shift.new( Key.new(key), Offset.new(date) )
    shift.get_shifts.transform_values { |val| char_set.rotate(val) }
  end

  def transcribe_message(message, key, date)
    shift_ref = [:D, :A, :B, :C]
    ciphers = make_ciphers(key, date)
    message_array = message.downcase.split('')
    code = message_array.map.with_index do |letter, i|
        shift_ref.rotate!
        ciphers[shift_ref.first][char_set.rindex(letter)]
    end.join
  end

  def encrypt(message, key = random_digits(5), date = Date.today.strftime('%d%m%y'))
    code = transcribe_message(message, key, date)
    {encryption: code, key: key, date: date}
  end
end
