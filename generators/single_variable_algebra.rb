require_relative "fractions"
require_relative "integers"
require_relative "latex_helper"

def get_coeff(rn, options)
  if options[:coeff_type] == :fraction || options[:coeff_type] == :integer
    coeff = send("get_#{options[:coeff_type]}", rn, options)  
  else
    coeff_type = rn.rand(1..2) == 1 ? :fraction : :integer    
    coeff = send("get_#{coeff_type}", rn, options)
  end
  coeff
end

def make_single_variable_algebra_problems(options)
  options[:coeff_type] ||= :integer
  options[:num_steps] ||= 2
  options[:number_problems] ||= 10
  random_generator = Random.new
  equations_array = []
  options[:number_problems].times do
    equation_parts= { ls: "x", rs: get_coeff(random_generator, options) }
    pick_side = Proc.new { random_generator.rand(1..2) == 1 ? :ls : :rs }
    operations = [:addition, :subtraction, :multiplication, :division]
    pick_operation = Proc.new { operations[random_generator.rand(0..3)] }
    options[:num_steps].times do
      chosen_side = pick_side.call
      if random_generator.rand(1..3) == 1
        coeff = "x"
      else
        coeff = get_coeff(random_generator, options)
      end
      operation = pick_operation.call
      equation_parts[chosen_side] = LatexHelper.send(operation, equation_parts[chosen_side], coeff) 
    end
    equation = LatexHelper.inline_math_mode_two_side(equation_parts[:ls], equation_parts[:rs])
    equation_with_space = LatexHelper.answer_space(equation)
    equations_array << equation_with_space
  end
  equations_array
end

