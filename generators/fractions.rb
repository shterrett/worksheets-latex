require_relative "latex_helper"

def same_denom_result_lt_one(rn, options)
  numerator_2 = Proc.new { |numerator_1, denominator| rn.rand(1..(denominator - numerator_1)) }
  return get_fractions_same_denom(rn, numerator_2, options)
end

def same_denom_result_gt_one(rn, options)
  numerator_2 = Proc.new { |numerator_1, denominator| rn.rand((denominator - numerator_1)...denominator) }
  return get_fractions_same_denom(rn, numerator_2, options)
end

def diff_denom_result_lt_one(rn, options)
  equiv_numerator_2 = Proc.new do |equiv_numerator_1, equiv_denominator| 
    rn.rand(1..(equiv_denominator - equiv_numerator_1))
  end
  return get_fractions_diff_denom(rn, equiv_numerator_2, options)
end

def diff_denom_result_gt_one(rn, options)  
  equiv_numerator_2 = Proc.new do |equiv_numerator_1, equiv_denominator|
    rn.rand((equiv_denominator - equiv_numerator_1)...equiv_denominator)
  end
  return get_fractions_diff_denom(rn, equiv_numerator_2, options)
end

def get_fractions_same_denom(rn, get_num_2, options)
  denominator = rn.rand(options[:min_denom]..options[:max_denom])
  numerator_1 = rn.rand(options[:min_num]...denominator)
  numerator_2 = get_num_2.call(numerator_1, denominator)
  return { num_1: numerator_1, num_2: numerator_2, denom_1: denominator, denom_2: denominator }
end

def get_fractions_diff_denom(rn, get_num_2, options)
  denominator_1 = rn.rand(options[:min_denom]..options[:max_denom])
  denominator_2 = rn.rand(options[:min_denom]..options[:max_denom])
  numerator_1 = rn.rand(options[:min_num]...denominator_1)
  equiv_denominator = denominator_1 * denominator_2
  equiv_numerator_1 = numerator_1 * denominator_2
  equiv_numerator_2 = get_num_2.call(equiv_numerator_1, equiv_denominator)
  numerator_2 = equiv_numerator_2 / denominator_1
  return { num_1: numerator_1, num_2: numerator_2, denom_1: denominator_1, denom_2: denominator_2 }
end

def make_fraction_problems(problem_options = {})
  problem_options[:min_num] ||= 1
  problem_options[:min_denom] ||= 2
  problem_options[:max_denom] ||= 100
  problem_options[:negatives] ||= :no
  problem_options[:denom] ||= :same
  problem_options[:sum] ||= :lt_one
  problem_options[:operation] ||= :addition
  problem_options[:number_problems] ||= 10
  fraction_options = { min_num: problem_options[:min_num], min_denom: problem_options[:min_denom], max_denom: problem_options[:max_denom] }
  random_generator = Random.new
  if problem_options[:denom] == :same
    if problem_options[:sum] == :lt_one
        method = :same_denom_result_lt_one
    else
        method = :same_denom_result_gt_one
    end
  else
    if problem_options[:sum] == :lt_one
        method = :diff_denom_result_lt_one
    else
        method = :diff_denom_result_gt_one
    end
  end
  
  problem_options[:number_problems].times do
    fraction_parts = send(method, random_generator, fraction_options)
    fract_1 = LatexHelper.make_fraction(fraction_parts[:num_1], fraction_parts[:denom_1])
    fract_2 = LatexHelper.make_fraction(fraction_parts[:num_2], fraction_parts[:denom_2])
    unless problem_options[:negatives] == :no
      fract_1 = random_generator.rand(1..2) == 1 ? LatexHelper.make_negative(fract_1) : fract_1
      fract_2 = random_generator.rand(1..2) == 1 ? LatexHelper.make_negative(fract_2) : fract_2
    end
    fract_problem = LatexHelper.send(problem_options[:operation], fract_1, fract_2)
    fract_problem_in_math = LatexHelper.inline_math_mode(fract_problem)
    final_problem = LatexHelper.answer_space(fract_problem_in_math)
    puts final_problem
  end
end





