require 'csv'

class String
  def underline
    puts self
    line
  end

  def overline
    line
    puts self
  end

  def over_under
    line
    puts self
    line
  end

  def format
    self.center(80)
  end

  def line
    puts ''.center(80, '-')
  end
end
# ----------- Input ------------
class Menu
  @@main_menu = { 1 => 'Input students',        2 => 'Show the students', 3 => 'Show the cohorts',
                  4 => 'Save students to file', 5 => 'Load student file', 6 => 'Print source code',
                  7 => 'Delete student',        8 => 'Delete cohort',     9 => 'Exit' }

  def self.print
    "What would you like to do?".format.over_under
    @@main_menu.each { |n, option| puts "#{n}. #{option}"}
  end
end

def interactive_menu
  loop do
    Menu.print
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when '1' then input_students
    when '2' then show_students
    when '3' then show_cohorts
    when '4' then get_filename(:save)
    when '5' then get_filename(:load)
    when '6' then print_source_code
    when '7' then delete_student
    when '8' then delete_cohort
    when '9' then feedback_message(:exit)
    else puts "I don't know what you meant, try again"
  end
end

def feedback_message(action)
  feedback = {save: 'File saved!', load:'File loaded!', exit: 'Bye!',
              delete_name: "#{@name} deleted!", delete_cohort: "#{@cohort} cohort deleted!"}

  feedback[action].overline; exit if action == :exit
end

@students = []

def input_students
  print_intro; get_student_name
  while !@name.empty?
    get_student_cohort;
    add_student(convert_student_data(@name, @cohort))
    student_count; get_student_name
  end
end

def get_student_name
  puts 'Enter student name:'
  @name = STDIN.gets.chomp
end

def get_student_cohort
  puts 'Enter cohort:'
  @cohort = STDIN.gets.chomp.to_sym
end

def convert_student_data(name, cohort)
  {name: name, cohort: cohort.to_sym}
end

def add_student(student)
  @students << student
end

def delete_student
  data = get_student_name
  delete_matching(:name, data)
  feedback_message(:delete_name)
end

def delete_cohort
  data = get_student_cohort
  delete_matching(:cohort, data)
  feedback_message(:delete_cohort)
end

def delete_matching(category, data)
  @students = @students.reject { |student| student[category] == data }
end
# ----------- Output ------------
def student_count
  singularise("Now we have #{@students.count} students!").underline
end

def singularise(statement)
  @students.count == 1 ? statement.sub('students', 'student') : statement
end

def sort_by_cohort
  sorted_cohorts = {}
  @students.each do |student|
    sorted_cohorts.include?(student[:cohort]) ?
    sorted_cohorts[student[:cohort]] << student[:name] :
    sorted_cohorts[student[:cohort]] = [student[:name]]
  end
  sorted_cohorts
end

def print_intro
  "Please enter the students' names into the directory".format.overline
  'To finish, just hit return twice'.format.underline
end

def print_header
  'The Students of Villains Academy'.format.over_under
end

def print_students_list
  @students.each_with_index { |student, i| puts "#{i+1}. #{student[:name]}".format }
end

def show_students
  print_header; print_students_list; print_footer
end

def no_students
  puts 'We currently have no students enrolled at the academy'.format
end

def print_cohort_students(students)
  puts students.map.with_index { |student, i| "#{i+1}. #{student}".format }
end

def print_cohort_title(cohort)
  "*** #{cohort.to_s.capitalize} Cohort ***".format.overline
end

def show_cohorts
  print_header; sort_by_cohort.each do |cohort, students|
    print_cohort_title(cohort)
    print_cohort_students(students)
  end
  print_footer
end

def print_footer
  @students. empty? ? no_students :
  singularise("Overall, we have #{@students.count} great students!").format.overline
end

def print_filename_header
  __FILE__.format.over_under
end

def print_source_code
  print_filename_header
  File.open(__FILE__, 'r') { |file| puts file.read }
end
# ----------- File ------------
def get_filename(selection)
  puts "Enter filename"
  filename = STDIN.gets.chomp
  selection == 'save' ? save_students(filename) : check_for_file(filename)
end

def load_students_on_startup
  filename = ARGV.first
  return if filename.nil?
  check_for_file(filename)
end

def check_for_file(filename)
  File.exists?(filename) ? load_students(filename) : no_file(filename)
end

def no_file(filename)
  "Sorry, #{filename} doesn't exist.".overline
end

def load_students(filename = 'students.csv')
  File.open(filename, 'r') { |file| convert_load_data(file) }
  feedback_message(:load)
end

def convert_load_data(file)
  CSV.parse(file).each do |line|
    name, cohort = line
    add_student(convert_student_data(name, cohort))
  end
end

def convert_save_data
  @students.map { |student| [student[:name], student[:cohort]].join(',') }
end

def save_students(filename)
  File.open(filename, 'w') { |file| file.puts convert_save_data }
  feedback_message(:save)
end

load_students_on_startup
interactive_menu
