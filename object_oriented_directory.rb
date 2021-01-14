class Student
  attr_accessor :name, :cohort, :hobbies, :country, :height, :details

  def initialize(details = {})
    @details = details
    @name = details[:name]
    @cohort = details[:cohort]
    @hobbies = details[:hobbies]
    @country = details[:country]
    @height = details[:height]
  end
end

module DirectoryFilter
  def filter_by_name(directory)
    directory.roster.select.with_index { |student, i| "#{i+1}. #{student.name}" }
  end

  def filter_by_cohort
    cohorts = {}
    self.roster.each do |student|
      if cohorts.include? student.cohort
        cohorts[student.cohort] << student.name
      else
        cohorts[student.cohort] = [student.name]
      end
    end
    cohorts
  end
end

class Printer
  include DirectoryFilter

  def print_wrap
    puts ''.center(80, '-')
  end

  def print_introduction
    print_wrap
    puts 'Welcome to the Villains Academy Student Directory'.center(80)
    print_wrap
    puts "Please enter the students' names into the directory".center(80)
    puts 'To finish, just hit return twice'.center(80)
    print_wrap
    puts 'Enter student name:'
  end

  def print_header
    print_wrap
    puts 'The Students of Villains Academy'.center(80)
  end

  def print_footer
    last_statement = "Overall we have #{self.roster.count} great students!".center(80)
    last_statement.sub!('students', 'student') if self.roster.count == 1
    print_wrap
    puts last_statement
    print_wrap
  end

  def print_students
    self.filter_by_name.each_with_index { |student, i| puts "#{i}. #{student.name}".center(80) }
  end

  def print_cohorts
    self.filter_by_cohort.each do |cohort, names|
      print_wrap
      puts "*** #{cohort.to_s.capitalize} Cohort ***".center(80)
      puts names.map.with_index { |name, i| "#{i+1}. #{name}".center(80) }
    end
  end
end

def input_students
  students = []
  name = gets.chomp

  while !name.empty?
    puts 'Enter their cohort:'
    cohort = gets.chomp.to_sym

    students << { name: name, cohort: cohort }

    count_statement = "Now we have #{students.count} students"
    count_statement.sub!('students', 'student') if students.count == 1

    puts "Now we have #{students.count} students."
    puts 'Enter next student name:'
    name = gets.chomp
  end
  students
end

class Directory < Printer
  attr_accessor :roster

  def initialize
    @roster = []
  end

  def add_students(students)
    students.each { |student| roster << Student.new(student) }
  end
end

villains_academy = Directory.new
villains_academy.print_introduction
students = input_students
villains_academy.add_students(students)
villains_academy.print_header
villains_academy.print_cohorts
villains_academy.print_footer
