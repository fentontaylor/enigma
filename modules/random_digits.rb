module RandomDigits
  def generate(num_digits)
    num = rand(10**num_digits)
    num = num.to_s.rjust(num_digits, 0)
  end
end
