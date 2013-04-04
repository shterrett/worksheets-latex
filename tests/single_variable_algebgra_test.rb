require 'test/unit'
require_relative '../generators/single_variable_algebra.rb'

class SingleVariableAlgebraTest < Test::Unit::TestCase
  @@rn = Random.new
  
  def test_get_coeff_integer
    options = { coeff_type: :integer }
    coeff = get_coeff(@@rn, options)
    assert coeff.is_a?(Integer), "Should return an Integer"
  end
  
  def test_get_coeff_fraction
    options = { coeff_type: :fraction, min: 1, max: 10 }
    coeff = get_coeff(@@rn, options)
    assert options.is_a?(Hash), "Should return a Hash"
    assert coeff[:num].is_a?(Integer), "Hash should have numerator key that is an integer"
    assert coeff[:denom].is_a?(Integer), "Hash should have denominator key that is an integer"
  end
  
  def test_get_problems
    problems = make_fraction_problems
    assert problems.is_a?(Array), "Should return an array"
    assert problems.length == 10, "Should return default of 10 problems"
    assert problems[0].include?("="), "Problems should be algebra and include an '='"
  end
  
end