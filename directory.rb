def input_students
  puts ''.center(80, '-')
  puts "Please enter the students' names into the directory.".center(80)
  puts 'To finish, just hit return twice.'.center(80)
  puts ''.center(80, '-')
  puts 'Enter the name and cohort of the first student, seperated by a space:'

  students = []
  name_cohort = gets.center(80).chomp.split
  name, cohort = name_cohort[0], name_cohort[1].to_sym

  while !name.empty? do
    puts 'Enter their country of residence:'
    country = gets.chomp

    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.chomp.split(', ')

    puts 'Enter their height in cm:'
    height = gets.chomp.to_i

    students << { name: name, country: country, hobbies: hobbies, height: height, cohort: cohort }
    puts "Now we have #{students.count} students."

    puts 'Enter the name and cohort of the next student:'
    name = gets.chomp
  end
  students
end

def print_header
  puts 'The Students of Villains Academy'.center(80)
  puts ''.center(80, '-')
end

def print(students)
  i = 0
  while i < students.length
    if students[i][:name].start_with?('A') && students[i][:name].length < 12
      puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)".center(80)
    end
    i += 1
  end
end
# finally, we print the total
def print_footer(students)
  puts ''.center(80, '-')
  puts "Overall, we have #{students.count} great students".center(80)
  puts ''.center(80, '-')
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
