class Key
  include RandomDigits

  attr_reader :keygen

  def initialize
    @keygen = random_gen(5)
  end

  def get_keys
    {
      A: keygen[0..1],
      B: keygen[1..2],
      C: keygen[2..3],
      D: keygen[3..4]
    }
  end
end
