require_relative "latex_helper"
require_relative "generate_problems"

def get_fraction(rn, options)
  num = rn.rand(options[:min]..options[:max])
  denom = rn.rand(options[:min]..options[:max])
  return { num: num, denom: denom }
end
  
def make_fraction_problems(input_options = {})
  problems_array = []
  number_of_problems = input_options[:number_problems] || 10
  random = (input_options[:operation] == random)
  number_of_problems.times do
    if random
      input_options[:operation] = [:addition, :subtraction, :multiplication, :division].sample
    end
    fractions = FractionProblem.new(input_options)
    problems_array << fractions.to_s
  end
  problems_array
end

class FractionProblem
  include LatexHelper
  
  def defaults
    {
      min_num: 1,
      min_denom: 2,
      max_denom: 100,
      negatives: :no,
      denom: :same,
      sum: :lt,
      operation: :addition,
    }
  end
  
  attr_accessor :min_num, :min_denom, :max_denom, :negatives, 
                :denom, :sum, :operation, :rn,
                :fraction_1, :fraction_2
  
  def initialize(options = {})
    options = defaults.merge(options)
    @min_num = options[:min_num] 
    @min_denom = options[:min_denom] 
    @max_denom = options[:max_denom] 
    @negatives = options[:negatives] 
    @denom = options[:denom] 
    @sum = options[:sum] 
    @operation = options[:operation] 
    self.rn = Random.new
    make_fractions
    make_negatives
  end
  
  def method
    "#{@denom}_denom_result_#{@sum}_one".to_sym
  end
  
  def to_s
    problem = send(@operation, @fraction_1, @fraction_2)
    problem = inline_math_mode(problem)
    answer_space(problem)
  end
  
  private
  
  def make_fractions
    self.send(method)
  end
  
  def make_negatives
    @fraction_1 = @rn.rand(1..2) > 1 ? @fraction_1 : make_negative(@fraction_1)
    @fraction_2 = @rn.rand(1..2) > 1 ? @fraction_2 : make_negative(@fraction_2)
  end
  
  def same_denom_result_lt_one
    numerator_2 = Proc.new { |numerator_1, denominator| @rn.rand(1..(denominator - numerator_1)) }
    return get_fractions_same_denom(numerator_2)
  end

  def same_denom_result_gt_one
    numerator_2 = Proc.new { |numerator_1, denominator| @rn.rand((denominator - numerator_1)...denominator) }
    return get_fractions_same_denom(numerator_2)
  end

  def diff_denom_result_lt_one
    equiv_numerator_2 = Proc.new do |equiv_numerator_1, equiv_denominator| 
      rn.rand(1..(equiv_denominator - equiv_numerator_1))
    end
    return get_fractions_diff_denom(equiv_numerator_2)
  end

  def diff_denom_result_gt_one
    equiv_numerator_2 = Proc.new do |equiv_numerator_1, equiv_denominator|
      rn.rand((equiv_denominator - equiv_numerator_1)...equiv_denominator)
    end
    return get_fractions_diff_denom(equiv_numerator_2)
  end

  def get_fractions_same_denom(get_num_2)
    denominator = @rn.rand(@min_denom..@max_denom)
    numerator_1 = @rn.rand(@min_num...denominator)
    numerator_2 = get_num_2.call(numerator_1, denominator)
    @fraction_1 = make_fraction(numerator_1, denominator)
    @fraction_2 = make_fraction(numerator_2, denominator)
  end

  def get_fractions_diff_denom(get_num_2)
    denominator_1 = @rn.rand(@min_denom..@max_denom)
    denominator_2 = denominator_1
    while denominator_1 == denominator_2
      denominator_2 = rn.rand(@min_denom..@max_denom)
    end
    numerator_1 = @rn.rand(@min_num...denominator_1)
    equiv_denominator = denominator_1 * denominator_2
    equiv_numerator_1 = numerator_1 * denominator_2
    equiv_numerator_2 = get_num_2.call(equiv_numerator_1, equiv_denominator)
    numerator_2 = equiv_numerator_2 / denominator_1
    @fraction_1 = make_fraction(numerator_1, denominator_1)
    @fraction_2 = make_fraction(numerator_2, denominator_2)
  end
  
  
end

make_fraction_problems
