require 'test/unit'
require_relative '../generators/integers.rb'

class IntegersTest < Test::Unit::TestCase
  @@rn = Random.new
  @@options = { min: 1, max: 10 }
  
  def test_get_integer_should_return_integer
    new_int = get_integer(@@rn, @@options)
    assert new_int.is_a?(Integer), "Should return an integer"
  end
  
  def test_get_integer_between_min_and_max
    new_int = get_integer(@@rn, @@options)
    assert new_int >= 1 && new_int <= 10, "Should be between 1 and 10"
  end
  
  # test make_integer_problems with defaults
  def test_make_integer_problems_should_return_array
    int_array = make_integer_problems
    assert int_array.is_a?(Array), "Should return an array"
  end
  
  def test_make_integer_problems_array_length
    int_array = make_integer_problems
    assert_equal 10, int_array.length, "Should be 10 problems long"
  end
  
  def test_make_integer_problems_format
    int_array = make_integer_problems
    assert int_array[0].include?("\\makebox{\\begin{minipage} {0.50\\textwidth}"), "Should begin with latex"
    assert int_array[0].include?("\\hfill \\vspace{4cm} \\end{minipage}}"), "Should end with latex"
  end
  
end