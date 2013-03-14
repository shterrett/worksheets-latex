require "./latex_helper"

random_generator = Random.new

def same_denom_result_lt_one(rn)
  numerator_2 = Proc.new { |numerator_1, denominator| rn.rand(1..(denominator - numerator_1)) }
  return get_fractions_same_denom(rn, numerator_2)
end

def same_denom_result_gt_one(rn)
  numerator_2 = Proc.new { |numerator_1, denominator| rn.rand((denominator - numerator_1)...denominator) }
  return get_fractions_same_denom(rn, numerator_2)
end

def diff_denom_result_lt_one(rn)
  equiv_numerator_2 = Proc.new do |equiv_numerator_1, equiv_denominator| 
    rn.rand(1..(equiv_denominator - equiv_numerator_1))
  end
  return get_fractions_diff_denom(rn, equiv_numerator_2)
end

def diff_denom_result_gt_one(rn)  
  equiv_numerator_2 = Proc.new do |equiv_numerator_1, equiv_denominator|
    rn.rand((equiv_denominator - equiv_numerator_1)...equiv_denominator)
  end
  return get_fractions_diff_denom(rn, equiv_numerator_2)
end

def get_fractions_same_denom(rn, get_num_2)
  denominator = rn.rand(2..100)
  numerator_1 = rn.rand(1...denominator)
  numerator_2 = get_num_2.call(numerator_1, denominator)
  return [numerator_1, numerator_2, denominator]
end

def get_fractions_diff_denom(rn, get_num_2)
  denominator_1 = rn.rand(2..100)
  denominator_2 = rn.rand(2..100)
  numerator_1 = rn.rand(1...denominator_1)
  equiv_denominator = denominator_1 * denominator_2
  equiv_numerator_1 = numerator_1 * denominator_2
  equiv_numerator_2 = get_num_2.call(equiv_numerator_1, equiv_denominator)
  numerator_2 = equiv_numerator_2 / denominator_1
  return [numerator_1, numerator_2, denominator_1, denominator_2]
end

fractions = same_denom_result_lt_one random_generator
puts "#{fractions[0]} / #{fractions[2]} + #{fractions[1]} / #{fractions[2]}"

fractions_diff = diff_denom_result_lt_one random_generator
puts "#{fractions_diff[0]} / #{fractions_diff[2]} + #{fractions_diff[1]} / #{fractions_diff[3]}" 

fractions_gt_one = same_denom_result_gt_one random_generator
puts "#{fractions_gt_one[0]} / #{fractions_gt_one[2]} + #{fractions_gt_one[1]} / #{fractions_gt_one[2]}"

fractions_diff_gt_one = diff_denom_result_gt_one random_generator
puts "#{fractions_diff_gt_one[0]} / #{fractions_diff_gt_one[2]} + #{fractions_diff_gt_one[1]} / #{fractions_diff_gt_one[3]}"