require 'erb'
require 'date'
require 'FileUtils'
require './generators/generate_problems'

class WorksheetInfo
  attr_accessor :class_name, :date, :aim, :title
  
  def print_date
    self.date.strftime "%b %d %Y"
  end
  
  def label_date
    self.date.strftime "%Y%m%d"
  end
  
  def get_binding
    binding()
  end
end

worksheet = WorksheetInfo.new
print "Class Name (ex 'Saturday Academy'): "
worksheet.class_name = gets.chomp
print "Date of Class (mm/dd/yyyy): "
input_date = gets.chomp
array_date = input_date.split '/'
worksheet.date = Date.new(array_date[2].to_i, array_date[0].to_i, array_date[1].to_i)
print "Text for 'Aim': "
worksheet.aim = gets.chomp
print "Title: "
worksheet.title = gets.chomp

template = ERB.new File.new("worksheet_template.tex.erb").read

class_directory = worksheet.class_name.gsub(" ","")
FileUtils.mkdir_p "#{ENV['HOME']}/worksheets/#{class_directory}/#{worksheet.label_date}" unless File.directory? "#{class_directory}/#{worksheet.label_date}"
file_name = "#{ENV['HOME']}/worksheets/#{class_directory}/#{worksheet.label_date}/#{worksheet.title}.tex"

file = File.open file_name, "w"
file.write template.result(worksheet.get_binding)

file.close
puts "An empty worksheet has been created at #{file_name}."