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

module StudentFilter
  def filter_by_name(directory)
    directory.roster.select.with_index { |student, i| "#{i+1}. #{student.name}" }
  end

  def filter_by_cohort(directory)
    cohorts = {}
    directory.roster.each do |student|
      cohorts.include? student.cohort ?
      cohorts[student.cohort] << student.name : cohorts[student.cohort] = [student.name]
    end
    cohorts
  end
end

class Printer
  include StudentFilter

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
    print_wrap
  end

  def print_footer(directory)
    print_wrap
    puts "We have #{directory.roster.size} great students!".center(80)
    print_wrap
  end

  def print_students(directory)
    directory.roster.each_with_index { |student, i| puts "#{i}. #{student.name}".center(80) }
  end

  def print_cohorts(directory)
    filter_by_cohort(directory).each do |cohort, names|
      puts "*** #{cohort.to_s.capitalize} ***".center(80)
      puts names.map.with_index { |name, i| "#{i+1}. #{name}".center(80) }
    end
  end
end

def input_students
  students = []
  name = gets.strip.capitalize

  while !name.empty?
    puts 'Enter their cohort:'
    cohort = gets.strip.to_sym.capitalize
    puts 'Enter their country of residence:'
    country = gets.strip.capitalize
    puts 'Enter their hobbies each seperated by a comma and a space:'
    hobbies = gets.strip.split(', ')
    puts 'Enter their height in cm:'
    height = gets.strip.to_i

    students << { name: name, country: country, hobbies: hobbies, height: height, cohort: cohort }

    puts "Now we have #{students.count} students."
    puts 'Enter next student name:'
    name = gets.strip
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
villains_academy.print_cohorts(villains_academy)
villains_academy.print_footer(villains_academy)
