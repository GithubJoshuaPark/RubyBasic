# typed: true
require_relative 'utils/Utils'

module ObjectClass2
  extend Utils
  class TodoItem
    include Utils
    attr_accessor :title, :completed

    # Instance Method
    # Initialize a new TodoItem
    def initialize(title)
      @title = title
      @completed = false
      puts "Created new item: '#{@title}'"
    end

    # Instance Method
    # Mark the item as completed
    def complete
      @completed = true
      puts "Completed item: '#{@title}'"
    end

    # Instance Method
    # Custom string representation
    def to_s
      status = @completed ? "[x]" : "[ ]"
      "#{status} #{@title}"
    end
  end

  def self.run
    puts "Running ObjectClass2 sample..."

    puts "--- Operations ---"
    item1 = TodoItem.new("Buy Milk")
    item2 = TodoItem.new("Learn Ruby")

    puts "\n--- Before Completion ---"
    puts item1
    puts item2

    puts "\n--- Action ---"
    item1.complete

    puts "\n--- After Completion ---"
    puts item1
    puts item2
  end
end

if __FILE__ == $0
  ObjectClass2.run
end
