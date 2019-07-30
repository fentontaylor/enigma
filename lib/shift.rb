class Shift
  def initialize(key_obj, offset_obj)
    @key = key_obj
    @offset = offset_obj
  end

  def get_shifts
    keys = @key.get_keys
    offsets = @offset.get_offsets
    keys.merge(offsets) { |key, k_val, o_val| k_val + o_val }
  end
end
