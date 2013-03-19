worksheets-latex
================

LaTeX template and ruby script to generate new worksheets for class

+ Worksheet.sty is a custom package for LaTeX that defines functions and styles for worksheets
	 + It should be symlinked into the $TEXMFHOME/tex/latex/worksheet/worksheet.sty

+ The ruby script automatically generates a skeleton worksheet using the woksheet_template.tex.erb file. You should modify the name in this file

+ The default file structure is ~/worksheets/<classname>/<date>/<title>.tex
	
+ During worksheet generation, and option will be presented to generate problems as well
  + Current problems include integer and fraction addition/subtraction/multiplication/division
  
**TODO:**
+ Single-operation alegbraic equations in one variable
+ Two operation algebraic equations in one variable
+ Quadratic equations
