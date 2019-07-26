module RandomChars
  def random_digits(num_digits)
    num = rand(10**num_digits)
    num.to_s.rjust(num_digits, '0')
  end
end
