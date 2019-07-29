class SmartSolver < Enigma
  def message_length(message)
    message.split('').select { |char| char_set.include? char }.length
  end

  def end_order(message)
    [:A, :B, :C, :D].rotate(message_length(message) % 4)
  end

  def message_end(message)
    message[-4..-1]
  end

  def last_four(message)
    end_ord = end_order(message)
    mess_end = message_end(message).split('')
    end_ord.zip(mess_end).to_h
  end

  def last_four_actual(message)
    actual = ' end'.split('')
    order = end_order(message)
    order.zip(actual).to_h
  end

  def find_shift_num(from, to)
    num = 0
    index = char_set.rindex(from)
    rotated = char_set
    until from == to
      rotated = rotated.rotate(-1)
      from = rotated[index]; num -= 1
    end
    num
  end

  def get_unshift_set(message)
    unshift_set = {}
    last_four(message).each do |shift, letter|
      to_letter = last_four_actual(message)[shift]
      unshift_set[shift] = find_shift_num(letter, to_letter)
    end
    unshift_set
  end

  def get_shifted_letter(shift, letter)
    rotated = char_set.rotate(shift)
    rotated[char_set.rindex(letter)]
  end

  def smart_crack(message)
    shift_ref = [:D, :A, :B, :C]
    shifts = get_unshift_set(message)
    prep_message(message).map do |letter|
      if char_set.include?(letter)
        shift_ref.rotate!
        letter = get_shifted_letter(shifts[shift_ref.first], letter)
      end
      letter
    end.join
  end
end
