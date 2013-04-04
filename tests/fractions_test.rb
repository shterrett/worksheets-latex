require 'test/unit'
require_relative '../generators/fractions.rb'

class FractionsTest < Test::Unit::TestCase
  @@rn = Random.new
  
  def test_get_fraction_should_return_hash
    options = { min: 1, max: 10 }
    new_fraction = get_fraction(@@rn, options)
    assert new_fraction.is_a?(Hash), "Should return hash"
  end 
  
  def get_fraction_denom_test(same_or_diff)
    options = { min_num: 1, max_num: 10, min_denom: 2, max_denom: 11 }
    numerator_2 = Proc.new { 1 }
    if same_or_diff == :same
      new_fraction = get_fractions_same_denom(@@rn, numerator_2,  options)
    else 
      new_fraction = get_fractions_diff_denom(@@rn, numerator_2, options)
    end
  end
  
  def test_get_fractions_same_denom_should_return_hash
    new_fraction = get_fraction_denom_test :same
    assert new_fraction.is_a?(Hash), "Should return hash"
  end
  
  def test_get_fractions_same_denom_should_have_same_denom
    new_fraction = get_fraction_denom_test :same
    assert new_fraction[:denom_1] == new_fraction[:denom_2], "Should return the same denominoator for both fractions"
  end
  
  def test_get_fractions_same_denom_should_return_hash
    new_fraction = get_fraction_denom_test :different
    assert new_fraction.is_a?(Hash)
  end
      
  def test_get_fractions_diff_denom_should_have_different_denom
    new_fraction = get_fraction_denom_test :different
    assert new_fraction[:denom_1] != new_fraction[:denom_2], "Should return different denominator"
  end
  
  def def_options
    { min_num: 1, min_denom: 2, max_denom: 11 }
  end
  
  def test_get_fractions_same_denom_sum_lt_is_less_than_one
    new_fraction = same_denom_result_lt_one(@@rn, def_options)
    num_sum = new_fraction[:num_1] + new_fraction[:num_2]
    assert num_sum <= new_fraction[:denom_1], "Sum of numerators should be less than denominator"
  end
  
  def test_get_fractions_same_denom_sum_gt_is_greater_than_one
    new_fraction = same_denom_result_gt_one(@@rn, def_options)
    num_sum = new_fraction[:num_1] + new_fraction[:num_2]
    assert num_sum >= new_fraction[:denom_1], "Sum of numerators should be greater than denominator"
  end
  
  def simplify_fraction(fraction_hash)
    left_num = fraction_hash[:num_1] * fraction_hash[:denom_2]
    right_num = fraction_hash[:num_2] * fraction_hash[:denom_1]
    common_denom = fraction_hash[:denom_1] * fraction_hash[:denom_2]
    { num_1: left_num, num_2: right_num, common_denom: common_denom }
  end
  
  def test_get_fractions_diff_denom_sum_lt_is_less_than_one
    new_fraction = diff_denom_result_lt_one(@@rn, def_options)
    simple_fraction = simplify_fraction new_fraction
    num_sum = simple_fraction[:num_1] + simple_fraction[:num_2]
    assert num_sum <= simple_fraction[:common_denom], "Fraction sum should be less than one"
  end
  
  def test_get_fractions_diff_denom_sum_gt_is_greater_than_one
    new_fraction = diff_denom_result_gt_one(@@rn, def_options)
    simple_fraction = simplify_fraction new_fraction
    num_sum = simple_fraction[:num_1] + simple_fraction[:num_2]
    assert num_sum >= simple_fraction[:common_denom], "Fraction sum should be greater than one"
  end
  
end
