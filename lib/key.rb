class Key
  include RandomChars
  attr_reader :key_val

  def initialize(key_val)
    @key_val = key_val
  end

  def get_keys
    {
      A: @key_val[0..1],
      B: @key_val[1..2],
      C: @key_val[2..3],
      D: @key_val[3..4]
    }.transform_values { |val| val.to_i }
  end
end
