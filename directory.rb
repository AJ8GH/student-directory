def input_students
  puts "Please enter the names of the students"
  puts "to finish, just hit return twice"

  students = []
  name = gets.chomp

  while !name.empty? do
    students << { name: name, cohort: :february }
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, i|
    if student[:name].start_with?('A') && student[:name].length < 12
      puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end
# finally, we print the total
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
