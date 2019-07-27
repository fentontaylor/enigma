class Enigma
  def char_set
    @chars_array ||= ('a'..'z').to_a.push(' ')
  end

  def make_ciphers(key, date)
    shifts = Shift.new( Key.new(key), Offset.new(date) ).get_shifts
    shifts.transform_values { |val| char_set.rotate(val) }
  end

  def encrypt(message, key, date)
    shifts = Shift.new( Key.new(key), Offset.new(date) ).get_shifts
    message_array = message.downcase.split('')
    message_array.map.with_index do |letter, i|
      if (i + 1) % 4 == 0

    end
  end
end
