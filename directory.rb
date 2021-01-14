@students = []

def input_students
  print_intro
  puts 'Enter student name:'
  name = gets.strip.capitalize

  while !name.empty?
    puts 'Enter their cohort:'
    cohort = gets.strip.to_sym
    puts 'Enter their country of residence:'
    country = gets.strip.capitalize
    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.strip.split(', ')
    puts 'Enter their height in cm:'
    height = gets.strip.to_i

    @students << { name: name, country: country, hobbies: hobbies, height: height, cohort: cohort }

    count_statement = "Now we have #{@students.count} students!"
    count_statement.sub!('students', 'student') if @students.count == 1
    puts count_statement

    puts 'Enter next student name:'
    name = gets.strip.capitalize
  end
end

def print_menu
  menu = {1 => 'Input the students', 2=> 'Show the students', 9 => 'Exit'}
  puts "What would you like to do?"
  menu.each { |n, option| puts "#{n}. #{option}"}
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when '1' then students = input_students
    when '2' then show_students
    when '9' then exit
    else puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
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

def print_cohorts(sorted_cohorts)
  sorted_cohorts.each do |cohort, students|
    print_wrap
    puts "*** #{cohort.to_s.capitalize} Cohort ***".center(80)
    puts students.map.with_index { |student, i| "#{i+1}. #{student}".center(80) }
  end
end

def print_wrap
  puts ''.center(80, '-')
end

def print_header
  print_wrap
  puts 'The Students of Villains Academy'.center(80) # center ensures output looks good visually
end

def print_footer
  final_statement = "Overall, we have #{@students.count} great students!".center(80)
  final_statement.sub!('students', 'student') if @students.count == 1
  print_wrap
  puts final_statement
  print_wrap
end

def print_students_list
  @students.each_with_index { |student, i| puts "#{i+1}. #{student[:name]}".center(80)}
end

def print_intro
  print_wrap
  puts "Please enter the students' names into the directory".center(80)
  puts 'To finish, just hit return twice'.center(80)
  print_wrap
end

interactive_menu
