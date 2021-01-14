@students = []

def print_menu
  menu = { 1 => 'Input students', 2=> 'Show the students', 3 => 'Show the Cohorts',
           4 => 'Save the list to students.csv', 5 => 'Load students.csv', 9 => 'Exit'
         }
  puts "What would you like to do?"
  menu.each { |n, option| puts "#{n}. #{option}"}
end

def interactive_menu
  loop do
    print_menu
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
  print_intro
  puts 'Enter student name:'

  name = STDIN.gets.chomp
  while !name.empty?
    puts 'Enter their cohort:'
    cohort = STDIN.gets.strip.to_sym

    add_students({ name: name, cohort: cohort })
    count_statement = "Now we have #{@students.count} students!"
    count_statement.sub!('students', 'student') if @students.count == 1
    puts count_statement

    puts 'Enter next student name:'
    name = STDIN.gets.chomp
  end
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

def print_intro
  print_wrap
  puts "Please enter the students' names into the directory".center(80)
  puts 'To finish, just hit return twice'.center(80)
  print_wrap
end

def print_header
  print_wrap
  puts 'The Students of Villains Academy'.center(80) # center ensures output looks good visually
end

def print_students_list
  @students.each_with_index { |student, i| puts "#{i+1}. #{student[:name]}".center(80)}
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
    puts "*** #{cohort.to_s.capitalize} Cohort ***".center(80)
    puts students.map.with_index { |student, i| "#{i+1}. #{student}".center(80) }
  end
  print_footer
end

def print_footer
  final_statement = "Overall, we have #{@students.count} great students!".center(80)
  final_statement.sub!('students', 'student') if @students.count == 1
  print_wrap
  puts final_statement
  print_wrap
end

def add_students(students)
  @students << students
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
    add_students ({name: name, cohort: cohort.to_sym})
  end
  file.close
end

try_load_students
interactive_menu
