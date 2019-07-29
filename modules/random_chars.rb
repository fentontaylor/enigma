module RandomChars
  def random_digits(num_digits)
    num = rand(1..10**num_digits - 1)
    num.to_s.rjust(num_digits, '0')
  end

  def character_set
    @chars ||= {
      digits: (0..9).to_a,
      upper: ('A'..'Z').to_a,
      lower: ('a'..'z').to_a
    }
  end

  def random_characters(num_chars)
    char_types = character_set.keys
    key = []
    num_chars.times { key << character_set[char_types.sample].sample }
    key.join
  end
end
