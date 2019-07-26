class Key
  include RandomChars

  def get_keys
    keygen = random_digits(5)
    {
      A: keygen[0..1],
      B: keygen[1..2],
      C: keygen[2..3],
      D: keygen[3..4]
    }.transform_values { |val| val.to_i}
  end
end
