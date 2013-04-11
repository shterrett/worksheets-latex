require_relative "latex_helper"
require_relative "generate_problems"

def get_integer(rn, options)
  options[:min] ||= 0
  options[:max] ||= 100
  rn.rand(options[:min]..options[:max])
end

def make_integer_problems(problem_options = {})
  problem_options[:number_problems] ||= 10
  problems_array = []
  problem_options[:number_problems].times do
    int_pblm = IntegerProblem.new problem_options
    problems_array << int_pblm.to_s
  end
end
  
class IntegerProblem
  include LatexHelper
  attr_accessor :min, :max, :negatives, :operation, :number_problems, :random_generator,
                :int1, :int2
  
  def initialize(options = {})
    self.min = options[:min] || 1
    self.max = options[:max] || 100
    self.negatives = options[:negatives] || :no
    self.operation = options[:operation] || :addition
    self.random_generator = Random.new
    self.int1 = get_integer
    self.int2 = get_integer
  end
  
  def get_integer
    int = random_generator.rand self.min..self.max
    if self.negatives == :yes && int.make_negative?
      int = make_negative(int)
    end
    int
  end
  
  def operation
    @operation == :random ? get_random_operation : @operation
  end
  
  def get_random_operation
    [:addition, :subtraction, :multiplication, :division].sample
  end
  
  def to_s
    problem_string = self.send(operation, int1, int2)
    problem_string = self.inline_math_mode problem_string
    self.answer_space problem_string  
  end
  
end

class Integer
  def make_negative?
    [true, false].sample
  end
end
    