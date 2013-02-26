worksheets-latex
================

LaTeX template and ruby script to generate new worksheets for class

+ Worksheet.sty is a custom package for LaTeX that defines functions and styles for worksheets
	 + It should be symlinked into the $TEXMFHOME/tex/latex/worksheet/worksheet.sty

+ The ruby script automatically generates a skeleton worksheet using the woksheet_template.tex.erb file. You should modify the name in this file

+ The default file structure is <classname>/<date>/<title>.tex
	
