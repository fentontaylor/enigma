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

  def test_crack_offsets
    assert_equal ({A: -1, B: 0, C: -2, D: -5}), @solver.crack_offsets('040895')
  end

  def test_last_four
    expected = {D: 't', A: 'h', B: 'n', C: 'w'}
    assert_equal expected, @solver.last_four('keder ohulwthnw')
  end

  def test_undo_offsets
    expected = {D: 'o', A: 'g', B: 'n', C: 'u'}
    assert_equal expected, @solver.undo_offsets('keder ohulwthnw', '040895')
  end

  def test_find_shift_num
    assert_equal -15, @solver.find_shift_num('o', ' ')
    assert_equal  -2, @solver.find_shift_num('g', 'e')
    assert_equal   0, @solver.find_shift_num('n', 'n')
    assert_equal -17, @solver.find_shift_num('u', 'd')
  end

  def test_get_unshift_set
    assert_equal
  end

  # def test_first_crack_shift
  #   assert_equal :D, @solver.first_crack_shift('hello world end')
  #   assert_equal :C, @solver.first_crack_shift('ello world end')
  #   assert_equal :B, @solver.first_crack_shift('ello worl end')
  #   assert_equal :A, @solver.first_crack_shift('ello wor end')
  # end
end
