class Shift
  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def get_shifts
    @key.get_keys.merge(@offset.get_offsets) do |key, k_val, o_val|
      k_val + o_val
    end
  end
end
