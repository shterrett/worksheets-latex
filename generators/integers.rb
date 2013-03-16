require "./latex_helper"

random_generator = Random.new

def get_integer(rn, options = {})
  options[:min] ||= 0
  options[:max] ||= 100
  rn.rand(options[:min]..options[:max])
end

def make_integer_problems(problem_options = {})
  problem_options[:min] ||= 1
  problem_options[:max] ||= 100
  problem_options[:negatives] ||= :no
  problem_options[:operation] ||= :addition
  problem_options[:number_problems] ||= 10
  int_options = { min: problem_options[:min], max: problem_options[:max] }
  random_generator = Random.new
  problem_options[:number_problems].times do
    int_1 = get_integer(random_generator, int_options)
    int_2 = get_integer(random_generator, int_options)
    unless problem_options[:negatives] == :no
      int_1 = rn.rand(1..2) == 1 ? LatexHelper.make_negative(int_1) : int_1
      int_2 = rn.rand(1..2) == 1 ? LatexHelper.make_negative(int_2) : int_2
    end
    int_problem = LatexHelper.send(problem_options[:operation], int_1, int_2)
    int_problem_in_math = LatexHelper.inline_math_mode(int_problem)
    final_problem = LatexHelper.answer_space(int_problem_in_math)
    puts final_problem
  end
end

make_integer_problems