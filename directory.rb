$wrap = "\n" + "".center(80, "-") + "\n" # dashed line to wrap titles, seperate lines and improve output visually
  # now to gather student data from user input
def input_students
  puts $wrap + "Please enter the students' names into the directory.".center(80)
  puts 'To finish, just hit return twice.'.center(80) + $wrap
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
    students.size == 1 ? $student_s = 'student' : $student_s = 'students'
    puts "Now we have #{students.count} #{$student_s}." + $wrap
    puts 'Enter next student name:'
    name = gets.strip
  end
  students
end

def print_header
  puts 'The Students of Villains Academy'.center(80) # center ensures output looks good visually
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
    puts $wrap + "*** #{cohort.to_s.capitalize} cohort ***".center(80) + $wrap
    puts students.map.with_index { |student, i| "#{i+1}. #{student}".center(80) }
  end
end

def print_footer(students)
  puts $wrap + "Overall, we have #{students.count} great #{$student_s}!".center(80) + $wrap
end
  # finally let's call all of our methods
students = input_students
cohorts = sort_by_cohort(students)

unless students.empty?
  print_header
  print_cohorts(cohorts)
  print_footer(students)
end
