$wrap = "\n" + "".center(80, "-") + "\n"

def input_students
  puts $wrap + "Please enter the students' names into the directory.".center(80)
  puts 'To finish, just hit return twice.'.center(80) + $wrap
  puts 'Enter student name:'

  students = []
  name = gets.chomp.capitalize

  while !name.empty?
    puts 'Enter their cohort:'
    cohort = gets.chomp.to_sym.capitalize
    puts 'Enter their country of residence:'
    country = gets.chomp.capitalize
    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.chomp.split(', ')
    puts 'Enter their height in cm:'
    height = gets.chomp.to_i

    students << { name: name, country: country, hobbies: hobbies, height: height, cohort: cohort }

    puts "Now we have #{students.count} students." + $wrap
    puts 'Enter next student name:'
    name = gets.chomp
  end
  students
end

def print_header
  puts 'The Students of Villains Academy'.center(80)
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
    puts $wrap + "*** #{cohort.to_s.capitalize} cohort ***".center(80) + $wrap
    puts students.map.with_index { |student, i| "#{i+1}. #{student}".center(80) }
  end
end

def print_footer(students)
  puts $wrap + "Overall, we have #{students.count} great students!".center(80) + $wrap
end
# nothing happens until we call the methods
students = input_students
cohorts = sort_by_cohort(students)
print_header
print_cohorts(cohorts)
print_footer(students)
