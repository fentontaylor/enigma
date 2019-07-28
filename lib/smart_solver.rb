
  def message_length(message)
    message.split('').select { |char| char_set.include? char }.length
  end

  def first_crack_shift(message)
    [:A, :B, :C, :D][message_length(message) % 4]
  end

  def crack_offset_ciphers(date)
    offsets = Offset.new(date).get_offsets
    offsets.transform_values do |val|
      val * -1
      # char_set.rotate(val)
    end
  end

  def end_order(message)
    [:A, :B, :C, :D].rotate(message_length(message) % 4)
  end

  def smart_solver(message, date = Date.today.strftime('%d%m%y'))
    message_end = message[-4..-1]
    last_four = end_order.zip(message_end.split('')).to_h
    last_four.each do |shift, letter|
      index = char_set.rindex(letter)
      new = char_set.rotate(crack_offset_ciphers(date)[shift])[index]
      require 'pry';binding.pry
    end

    { decryption: attempt, key: seed , date: date }
  end
