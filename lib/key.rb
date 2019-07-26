class Key
  include RandomChars

  def get_keys(key = random_digits(5))
    {
      A: key[0..1],
      B: key[1..2],
      C: key[2..3],
      D: key[3..4]
    }.transform_values { |val| val.to_i }
  end
end
