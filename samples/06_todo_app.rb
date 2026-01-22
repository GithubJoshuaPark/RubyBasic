# typed: true
require_relative 'lib/todo_manager'
require_relative 'utils/Utils'

class TodoApp
  include Utils

  def self.run
    new.run
  end

  def initialize
    @manager = TodoManager.new
  end

  def run
    log "Running TodoApp sample..."

    puts "💎 --- Welcome to Ruby Todo App --- 💎"

    loop do
      print_menu

      # get user input
      input = gets.chomp

      if input.empty?
        puts "⚠️  Please select a number."
        next
      end

      choice = input.to_i

      case choice
      when 1
        list_todos
      when 2
        add_todo
      when 3
        toggle_todo
      when 4
        delete_todo
      when 0
        puts "\n👋 Goodbye! See you next time."
        break
      else
        puts "❌ Invalid choice, please try again."
      end
    end
  end

  private

  def print_menu
    puts "\n-----------------------------------"
    puts "1. 📝 List Todos"
    puts "2. ➕ Add Todo"
    puts "3. ✅ Toggle Complete (by ID)"
    puts "4. 🗑️  Delete Todo (by ID)"
    puts "0. 🚪 Exit"
    print "👉 Select an option: "
  end

  def list_todos
    todos = @manager.list
    if todos.empty?
      puts "\n📭 No todos found. Add one!"
    else
      puts "\n--- Todo List ---"
      todos.each_with_index do |item, index|
        puts "#{index + 1}. #{item}"
      end
    end
  end

  def add_todo
    print "Enter todo title: "
    title = gets.chomp
    if title.empty?
      puts "❌ Title cannot be empty."
    else
      item = @manager.add(title)
      puts "✅ Added: #{item.title}"
    end
  end

  def toggle_todo
    list_todos
    return if @manager.list.empty?

    print "Enter number to toggle: "
    index = gets.chomp.to_i - 1

    item = @manager.toggle_status(index)
    if item
      puts "🔄 Updated: #{item}"
    else
      puts "❌ Invalid number."
    end
  end

  def delete_todo
    list_todos
    return if @manager.list.empty?

    print "Enter number to delete: "
    index = gets.chomp.to_i - 1

    item = @manager.delete(index)
    if item
      puts "🗑️  Deleted: #{item.title}"
    else
      puts "❌ Invalid number."
    end
  end
end

if __FILE__ == $0
  TodoApp.new.run
end
