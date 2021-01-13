def input_students

  puts 'Please enter the names of the students into the directory.'
  puts 'To finish, just hit return twice.'
  puts 'Enter the name of the first student:'

  students = []
  name = gets.chomp

  while !name.empty? do
    puts 'Enter their country of residence:'
    country = gets.chomp

    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.chomp.split(', ')

    puts 'Enter their height in cm:'
    height = gets.chomp.to_i

    students << { name: name, country: country, hobbies: hobbies, height: height, cohort: :february }
    puts "Now we have #{students.count} students."

    puts 'Enter the name of the next student:'
    name = gets.chomp
  end
  students
end

def print_header
  puts 'The students of Villains Academy'.center(45)
  puts ''.center(45, '-')
end

def print(students)
  i = 0
  while i < students.length
    if students[i][:name].start_with?('A') && students[i][:name].length < 12
      puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)".center(45)
    end
    i += 1
  end
end
# finally, we print the total
def print_footer(students)
  puts ''.center(45, '-')
  puts "Overall, we have #{students.count} great students".center(45)
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
