require_relative "fractions"
require_relative "integers"
require_relative "latex_helper"
require_relative "single_variable_algebra"
require "active_support/all"
IntegerRegex = /\A\d+\z/

def generate_problems(file)
  available_types = ["integer", "fraction", "single_variable_algebra"]
  sentence_options = { two_words_connector: ' or ', last_word_connector: ', or ' }
  print "Type of problem (#{available_types.to_sentence(sentence_options)}): "
  problem_type = gets.chomp.downcase
  if available_types.include? problem_type
    problems_array = send("generate_#{problem_type}_problems")
    file.write problems_array.join("\n")
  else
    generate_problems file
  end
end

def generate_fraction_problems

  available_options = { min_num: { instr: "Minimum Numerator - greater than zero: ", test: IntegerRegex }, min_denom: { instr: "Minimum Denominator - greater than one: ", test: IntegerRegex }, 
                        max_denom: { instr: "Maximum Denominator - greater than zero: ", test: IntegerRegex }, negatives: { instr: "Include Negative Fractions? (yes or no): ", test: /\A(yes|no)\z/ }, 
                        denom: { instr: "'same' or 'diff' denominators: ", test: /\A(same|diff)\z/ }, sum: { instr: "Sum Greater Than or Less Than One (gt or lt): ", test: /\A(gt|lt)\z/ },
                        operation: { instr: "Operation: addition, subtraction, multiplication, division, or random: ", test: /\A(addition|subtraction|multiplication|division|random)\z/ }, number_problem: { instr: "Number of Problems: ", test: IntegerRegex } }
  options = set_options(available_options)
  make_fraction_problems options
end

def generate_integer_problems
  available_options = { min: { instr: "Minimum Integer - greater than zero: ", test: IntegerRegex }, max: { instr: "Maximum Integer: ", test: IntegerRegex },
                       negatives: { instr: "Include Negative numbers? (yes or no): ", test: /\A(yes|no)\z/ } , operation: { instr: "Operation: addition, subtraction, multiplication, division, or random: ", test: /\A(addition|subtraction|multiplication|division|random)\z/ },
                       number_problems: { instr: "Number of problems: ", test: IntegerRegex } }
  options = set_options(available_options)
  make_integer_problems options
end

def generate_single_variable_algebra_problems
  available_options = { coeff_type: {instr: "'integer' or 'fraction' coefficents: ", test: /\A(integer|fraction)\z/}, min: { instr: "Minimum value of Coefficent: ", test: IntegerRegex }, max: { instr: "Maximum value of Coefficent: ", test: IntegerRegex },
                        num_steps: { instr: "Number of Inverse Operations: ", test: IntegerRegex }, number_problems: { instr: "Number of problems: ", test: IntegerRegex } }  
  options = set_options(available_options)
  make_single_variable_algebra_problems options
end

def set_options(available_options)
  puts "Please select a value for each option below. If you leave an option blank, it will default sensibly."
  options = {}
  available_options.each do |k, v|
    entry = "something guaranteed not to match the regex in the available_options hash; this guarantees the loop will run at least once"
    until v[:test] =~ entry || entry == ""
      print v[:instr]
      entry = gets.chomp
    end
    unless entry.empty?
      if IntegerRegex =~ entry
        entry = entry.to_i
      else
        entry = entry.to_sym
      end
      options[k] = entry
    end
  end
  return options
end

def generate_random_problem(num_1, num_2)
  operations = [:addition, :subtraction, :multiplication, :division]
  rand_index = rand(0..3)
  LatexHelper.send(operations[rand_index], num_1, num_2)
end

