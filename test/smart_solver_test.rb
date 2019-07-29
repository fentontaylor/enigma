require './test/test_helper'

class SmartSolverTest < Minitest::Test
  def setup
    @solver = SmartSolver.new
  end
  
  def test_message_length
    assert_equal 15, @solver.message_length('hello world end')
    assert_equal 15, @solver.message_length('hello! world! end')
  end

  def test_end_order
    assert_equal [:A, :B, :C, :D], @solver.end_order('abcd end')
    assert_equal [:D, :A, :B, :C], @solver.end_order('abc end')
    assert_equal [:C, :D, :A, :B], @solver.end_order('ab end')
    assert_equal [:B, :C, :D, :A], @solver.end_order('a end')
  end

  def test_message_end
    assert_equal 'thnw', @solver.message_end('keder ohulwthnw')
  end

  def test_last_four
    expected = {D: 't', A: 'h', B: 'n', C: 'w'}
    assert_equal expected, @solver.last_four('keder ohulwthnw')
  end

  def test_last_four_actual
    expected = {D: ' ', A: 'e', B: 'n', C: 'd'}
    assert_equal expected, @solver.last_four_actual('keder ohulwthnw')
  end

  def test_find_shift_num
    assert_equal (-15), @solver.find_shift_num('o', ' ')
    assert_equal  (-2), @solver.find_shift_num('g', 'e')
    assert_equal     0, @solver.find_shift_num('n', 'n')
    assert_equal (-17), @solver.find_shift_num('u', 'd')
  end

  def test_get_unshift_set
    expected = {A: -3, B: 0, C: -19, D: -20}
    assert_equal expected, @solver.get_unshift_set('keder ohulwthnw')
  end

  def test_get_shifted_letter
    assert_equal 'a', @solver.get_shifted_letter(-3, 'd')
    assert_equal 'x', @solver.get_shifted_letter(-7, 'd')
  end

  def test_smart_crack
    assert_equal 'hello world end', @solver.smart_crack('keder ohulwthnw')
    assert_equal 'hello world! end', @solver.smart_crack('keder ohulw!thnw')
  end
end
