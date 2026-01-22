# typed: true
# 02_basic.rb
require_relative 'utils/Utils'

module Basic
  extend Utils

  # 5. Methods (defined as module method for usage inside run)
  def self.greet(username)
    return "Welcome back, #{username}!"
  end

  def self.run
    log "Running Basic sample..."

    # 1. Variables and Output
    name = "Ruby Learner"
    age = 25
    puts "Hello, #{name}! You are #{age} years old." # String Interpolation

    # 2. Data Types
    is_learning = true                   # Boolean
    skills = ["Python", "Java", "Ruby"]  # Array
    profile = {                          # Hash
      name: "Coder",
      level: "Beginner",
      lang: "Ruby" # Modern Syntax for Symbol keys
    }

    puts "Is Learning: #{is_learning}"
    puts "Skills: #{skills.join(', ')}"
    puts "Profile Level: #{profile[:level]}"

    # 3. Control Structures
    score = 85

    if score >= 90
      puts "Grade: A"
    elsif score >= 80
      puts "Grade: B"
    else
      puts "Grade: C"
    end

    # 4. Loops
    puts "\n--- Counting 1 to 3 ---"
    3.times do |i|
      puts "Count: #{i + 1}"
    end

    puts "\n--- Iterating Array ---"
    skills.each do |skill|
      puts "Learning: #{skill}"
    end

    puts "\n" + greet(name)
  end
end

