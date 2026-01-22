# typed: strict
require 'sorbet-runtime'
require_relative 'todo_item'
require_relative 'json_store'

class TodoManager
  extend T::Sig

  sig { params(filename: String).void }
  def initialize(filename = 'data/todos.json')
    @store = T.let(JsonStore.new(filename), JsonStore)
    @todos = T.let(load_todos, T::Array[TodoItem])
  end

  sig { params(title: String).returns(TodoItem) }
  def add(title)
    item = TodoItem.new(title)       # Create new TodoItem
    @todos << item                   # Add to todos array
    save_todos                       # Save to file
    item
  end

  sig { returns(T::Array[TodoItem]) }
  def list
    @todos
  end

  sig { params(index: Integer).returns(T.nilable(TodoItem)) }
  def delete(index)
    return nil if index < 0 || index >= @todos.length
    deleted_item = @todos.delete_at(index)
    save_todos
    deleted_item
  end

  sig { params(index: Integer).returns(T.nilable(TodoItem)) }
  def toggle_status(index)
    return nil if index < 0 || index >= @todos.length
    item = @todos[index]
    T.must(item).toggle_status! # T.must asserts item is not nil
    save_todos
    item
  end

  private

  sig { returns(T::Array[TodoItem]) }
  def load_todos
    data = @store.load
    data.map { |item_hash| TodoItem.from_h(item_hash) }
  end

  sig { void }
  def save_todos
    data = @todos.map(&:to_h)
    @store.save(data)
  end
end

