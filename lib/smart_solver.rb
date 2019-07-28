class SmartSolver < Enigma
  def message_length(message)
    message.split('').select { |char| char_set.include? char }.length
  end

  # def first_crack_shift(message)
  #   [:A, :B, :C, :D][message_length(message) % 4]
  # end

  def crack_offsets(date)
    offsets = Offset.new(date).get_offsets
    offsets.transform_values do |val|
      val * -1
    end
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

  def undo_offsets(message, date)
    offsets = crack_offsets(date)
    undone = {}
    last_four(message).each do |shift, letter|
      rotated = char_set.rotate(offsets[shift])
      undone[shift] = rotated[char_set.rindex(letter)]
    end
    undone
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

  def crack(message, date = Date.today.strftime('%d%m%y'))

    { decryption: attempt, key: seed , date: date }
  end
end
