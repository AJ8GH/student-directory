def input_students
  puts 'Enter student name:'
    # student data is stored in this array
  students = []
  name = gets.strip.capitalize

  while !name.empty?
    puts 'Enter their cohort:'
    cohort = gets.strip.to_sym.capitalize # method chaining to format each value to its desired type
    puts 'Enter their country of residence:'
    country = gets.strip.capitalize
    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.strip.split(', ')
    puts 'Enter their height in cm:'
    height = gets.strip.to_i
      # passes a hash for each student into the array
    students << { name: name, country: country, hobbies: hobbies, height: height, cohort: cohort }
      # conditionally reassigning variable to account for singular / plural students if no. if students < 1
    count_statement = "Now we have #{students.count} student"
    count_statement << 's' unless students.size == 1
    puts count_statement

    puts 'Enter next student name:'
    name = gets.strip
  end
  students
end
  # now 2 methods to let us print students by cohort; first one creates a hash: each key a cohort, each value an array of students in that cohort
def sort_by_cohort(students)
  sorted_cohorts = {}
  students.each do |student|
    sorted_cohorts.include?(student[:cohort]) ?
    sorted_cohorts[student[:cohort]] << student[:name] :
    sorted_cohorts[student[:cohort]] = [student[:name]]
  end
  sorted_cohorts
end
  # next, we iterate over the hash output from the previous `sort_by_cohort` method, printing each cohort and it's students
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
  final_statement = "Overall, we have #{students.count} great student!".center(80)
  final_statement.sub!(/!/, 's!') unless students.count == 1
  print_wrap
  puts final_statement
end

def print_intro
  print_wrap
  puts "Please enter the students' names into the directory".center(80)
  puts 'To finish, just hit return twice'.center(80)
  print_wrap
end

  # finally let's call all of our methods
print_intro
students = input_students
cohorts = sort_by_cohort(students)
unless students.empty?
  print_header
  print_cohorts(cohorts)
  print_footer(students)
end
