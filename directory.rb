@students = []

class Menu
  @@menu = { 1 => 'Input students', 2=> 'Show the students', 3 => 'Show the Cohorts',
            4 => 'Save the list to students.csv', 5 => 'Load students.csv', 9 => 'Exit'}

  def self.print
    print_wrap; puts format "What would you like to do?"; print_wrap
    @@menu.each { |n, option| puts "#{n}. #{option}"}
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
    when '1' then students = input_students
    when '2' then show_students
    when '3' then print_cohorts
    when '4' then save_students
    when '5' then load_students
    when '9' then exit
    else puts "I don't know what you meant, try again"
  end
end

def input_students
  print_intro; get_student_name
  while !@name.empty?
    get_student_cohort; add_student({ name: @name, cohort: @cohort })
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

def student_count
  puts singularise("Now we have #{@students.count} students!")

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

def print_wrap
  puts ''.center(80, '-')
end

def format(text)
  text.center(80)
end

def print_intro
  print_wrap
  puts format "Please enter the students' names into the directory"
  puts format 'To finish, just hit return twice'
  print_wrap
end

def print_header
  print_wrap
  puts format 'The Students of Villains Academy'
end

def print_students_list
  @students.each_with_index { |student, i| puts format "#{i+1}. #{student[:name]}" }
end

def show_students
  print_header
  print_wrap
  print_students_list
  print_footer
end

def print_cohorts
  print_header
  sort_by_cohort.each do |cohort, students|
    print_wrap
    puts format "*** #{cohort.to_s.capitalize} Cohort ***"
    puts students.map.with_index { |student, i| format "#{i+1}. #{student}" }
  end
  print_footer
end

def print_footer
  print_wrap
  puts format singularise("Overall, we have #{@students.count} great students!")
end

def add_student(student)
  @students << student
end

def save_students
  file = File.open('students.csv', 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename = 'students.csv')
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student({name: name, cohort: cohort.to_sym})
  end
  file.close
end

try_load_students
interactive_menu
