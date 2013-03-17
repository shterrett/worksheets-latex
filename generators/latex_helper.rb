module LatexHelper
  
  class << self

    def make_fraction(num, denom)
    "\\frac{#{num}}{#{denom}}"
    end
    
    def make_negative(str)
    "-#{str}"    
    end
    
    def addition(first, second)
    "#{first} + #{second}"
    end
    
    def subtraction(first, second)
    "#{first} - #{second}"
    end
    
    def multiplication(first, second)
    "#{first} \\cdot #{second}"
    end
    
    def division(first, second)
    "#{first} \\div #{second}"
    end
       
    def inline_math_mode(str)
    "\\[#{str}\\]"
    end
    
    def answer_space(str)
    "\\makebox{\\begin{minipage} {0.50\\textwidth} #{str} \\hfill \\vspace{4cm} \\end{minipage}}"
    end
    
  end
end