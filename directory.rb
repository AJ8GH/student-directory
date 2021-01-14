def input_students
  print_intro
  puts 'Enter student name:'
    # student data is stored in this array
  students = []
  name = gets.strip.capitalize

  while !name.empty?
    puts 'Enter their cohort:'
    cohort = gets.strip.to_sym # method chaining to format each value to its desired type

    puts 'Enter their country of residence:'
    country = gets.strip.capitalize

    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.strip.split(', ')

    puts 'Enter their height in cm:'
    height = gets.strip.to_i
      # passes a hash for each student into the array
    students << { name: name, country: country, hobbies: hobbies, height: height, cohort: cohort }
      # conditionally reassigning variable to account for singular / plural students if no. if students < 1
    count_statement = "Now we have #{students.count} students!"
    count_statement.sub!('students', 'student') if students.count == 1
    puts count_statement

    puts 'Enter next student name:'
    name = gets.strip.capitalize
  end
  students
end

def interactive_menu
  menu = {1 => 'Input the students', 2=> 'Show the students', 9 => 'Exit'}
  students = []

  loop do
    puts "What would you like to do?"
    menu.each { |n, option| puts "#{n}. #{option}"}
    selection = gets.chomp

    case selection
      when '1'
        students = input_students
      when '2'
        print_header
        print(students)
        print_footer(students)
      when '9'
        exit
      else
        puts "I don't know what you meant, try again"
    end
  end
end

def sort_by_cohort(students)
  sorted_cohorts = {}
  students.each do |student|
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

def print_footer(students)
  final_statement = "Overall, we have #{students.count} great students!".center(80)
  final_statement.sub!('students', 'student') if students.count == 1
  print_wrap
  puts final_statement
  print_wrap
end

def print(students)
  students.each_with_index { |student, i| puts "#{i+1}. #{student[:name]}".center(80)}
end

def print_intro
  print_wrap
  puts "Please enter the students' names into the directory".center(80)
  puts 'To finish, just hit return twice'.center(80)
  print_wrap
end

interactive_menu
