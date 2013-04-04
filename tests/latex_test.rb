require 'test/unit'
require_relative '../generators/latex_helper.rb'

class SingleVariableAlgebraTest < Test::Unit::TestCase
  @@rn = Random.new
  
  def test_make_fraction
    fraction = LatexHelper.make_fraction(1, 2)
    assert_equal "\\frac{1}{2}", fraction
  end
  
  def test_make_negative
    negative = LatexHelper.make_negative(1)
    assert_equal "-1", negative  
  end
  
  def test_addition
    addition = LatexHelper.addition(1, 2)
    assert_equal "1 + 2 ", addition
  end
    
  def test_subtraction
    subtraction = LatexHelper.subtraction(1, 2)
    assert_equal "1 - 2 ", subtraction
  end
    
  def test_multiplication
    mult = LatexHelper.multiplication(1, 2)
    assert_equal "1 \\cdot 2 ", mult
  end
    
  def test_division
    div = LatexHelper.division(1, 2)
    assert_equal "1 \\div 2 ", div
  end
    
  def test_parentheses
    paren = LatexHelper.parentheses(1)
    assert_equal "(1)", paren
  end
       
  def test_inline_math_mode
    inline = LatexHelper.inline_math_mode(1)
    assert_equal "\\[1 =\\]", inline
  end
    
  def test_inline_math_mode_two_side  
    inline = LatexHelper.inline_math_mode_two_side(1, 1)
    assert_equal "\\[1 = 1\\]", inline
  end
    
  def test_answer_space
    space = LatexHelper.answer_space(1)
    assert_equal "\\makebox{\\begin{minipage} {0.50\\textwidth} 1 \\hfill \\vspace{4cm} \\end{minipage}}", space
  end
    
end