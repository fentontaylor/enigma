require 'date'

class Offset
  # attr_reader :date

  def initialize(date)
    @date = date
  end

  def offset_prep
    sq = @date.to_i ** 2
    sq.to_s[-4..-1]
  end

  def get_offsets
    prep = offset_prep
    {
      A: prep[0].to_i,
      B: prep[1].to_i,
      C: prep[2].to_i,
      D: prep[3].to_i
    }
  end
end
