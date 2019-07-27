module RandomChars
  def random_digits(num_digits)
    num = rand(1..10**num_digits - 1)
    num.to_s.rjust(num_digits, '0')
  end
end
