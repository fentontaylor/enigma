class Key
  include RandomDigits

  def get_keys
    keygen = random_gen(5)
    {
      A: keygen[0..1],
      B: keygen[1..2],
      C: keygen[2..3],
      D: keygen[3..4]
    }
  end
end
