# typed: true
# 04_object_class.rb
require_relative 'utils/Utils'

module ObjectClass
  extend Utils
  # 1. Class Definition
  class TodoItem
    include Utils
    # attr_accessor creates getter and setter methods automatically
    attr_accessor :title, :completed

    # Constructor called when TodoItem.new is executed
    def initialize(title)
      @title = title        # @variable is an Instance Variable (private to object)
      @completed = false
      puts "Created new item: '#{title}'" # Using method from Loggable module
    end

    # Instance Method
    def complete!
      @completed = true
      puts "Completed item: '#{@title}'"
    end

    # Custom string representation (like __str__ in Python)
    def to_s
      status = @completed ? "[x]" : "[ ]"
      "#{status} #{@title}"
    end
  end

  def self.run
    puts "Running ObjectClass sample..."

    # 2. Usage
    puts "--- Operations ---"
    item1 = TodoItem.new("Buy Milk")
    item2 = TodoItem.new("Learn Ruby")

    puts "\n--- Before Completion ---"
    puts item1  # Calls item1.to_s automatically
    puts item2

    puts "\n--- Action ---"
    item1.complete!

    puts "\n--- After Completion ---"
    puts item1
    puts item2
  end
end

if __FILE__ == $0
  ObjectClass.run
end
