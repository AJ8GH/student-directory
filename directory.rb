class String
  def underline
    puts self.chomp
    line
  end

  def overline
    line
    puts self.chomp
  end

  def over_under
    line
    puts self.chomp
    line
  end

  def format
    self.center(80)
  end

  def line
    puts ''.center(80, '-')
  end
end

@students = []
# ----------- Input ------------
class Menu
  @@main_menu = { 1 => 'Input students', 2 => 'Show the students', 3 => 'Show the cohorts',
             4 => 'Save students to csv file', 5 => 'Load students.csv', 9 => 'Exit'}

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
    when '3' then print_cohorts
    when '4' then get_filename(:save)
    when '5' then get_filename(:load)
    when '9' then feedback_message(:exit)
    else puts "I don't know what you meant, try again"
  end
end

def feedback_message(action)
  feedback = { save: 'File saved', load:'File loaded', exit: 'Bye!' }
  puts feedback[action]
  exit if action == :exit
end

def input_students
  print_intro; get_student_name
  while !@name.empty?
    get_student_cohort;
    add_student({ name: @name, cohort: @cohort })
    student_count; get_student_name
  end
end

def get_student_name
  puts 'Enter student name:'
  @name = STDIN.gets.chomp
end

def get_student_cohort
  puts 'Enter their cohort:'
  @cohort = STDIN.gets.chomp.to_sym
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
  @students.each_with_index { |student, i| puts format "#{i+1}. #{student[:name]}" }
end

def show_students
  print_header; print_students_list; print_footer
end

def print_cohort_students(students)
  puts students.map.with_index { |student, i| "#{i+1}. #{student}".format }
end

def print_cohort_title(cohort)
  "*** #{cohort.to_s.capitalize} Cohort ***".format.overline
end

def print_cohorts
  print_header; sort_by_cohort.each do |cohort, students|
    print_cohort_title(cohort)
    print_cohort_students(students)
  end
  print_footer
end

def print_footer
  singularise("Overall, we have #{@students.count} great students!").format.overline
end

def add_student(student)
  @students << student
end
# ----------- File ------------
def get_filename(action)
  puts "Enter filename"
  filename = gets.chomp
  action == :save ? save_students(filename) : load_students(filename)
end

def convert_save_data
  @students.map { |student| [student[:name], student[:cohort]].join(',') }
end

def convert_load_data(file)
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student({name: name, cohort: cohort.to_sym})
  end
end

def save_students(filename)
  File.open(filename, 'w') { |file| file.puts convert_save_data }
  feedback_message(:save)
end

def load_students_on_startup
  filename = ARGV.first
  return if filename.nil?
  File.exists?(filename) ? load_students(filename) : no_file(filename)
end

def no_file(filename)
  puts "Nope, #{filename} doesn't exist."; exit
end

def load_students(filename = 'students.csv')
  File.open(filename, 'r') { |file| convert_load_data(file) }
  feedback_message(:load)
end

load_students_on_startup
interactive_menu
