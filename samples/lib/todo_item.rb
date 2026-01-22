# typed: true
require 'sorbet-runtime'
require 'securerandom'
require 'time'
require_relative '../utils/Utils'

class TodoItem
  extend T::Sig
  include Utils

  # Define return types although attr_accessor generates them dynamically,
  # Sorbet usually infers basic attr_accessors, but we can be explicit with instance variables type.
  # For stricter checking, we declare instance variables in initialize.

  attr_accessor :id, :title, :completed, :created_at

  sig { params(title: String, id: T.nilable(String), completed: T::Boolean, created_at: T.nilable(String)).void }
  def initialize(title, id: nil, completed: false, created_at: nil)
    @id = T.let(id || SecureRandom.uuid[0..7], String)
    @title = T.let(title, String)
    @completed = T.let(completed, T::Boolean)
    @created_at = T.let(created_at || Time.now.to_s, String)

    # log is available via include Utils, but Utils needs to be typed compatible ideally.
    # We will assume Utils exists.
    puts "Created new item: '#{@title}'"
  end

  sig { void }
  def complete!
    @completed = true
    puts "Completed item: '#{@title}'"
  end

  sig { void }
  def toggle_status!
    @completed = !@completed
  end

  # Convert object to Hash for JSON storage
  sig { returns(T::Hash[Symbol, T.untyped]) }
  def to_h
    {
      id: @id,
      title: @title,
      completed: @completed,
      created_at: @created_at
    }
  end

  # Create TodoItem from Hash (when loading from JSON)
  sig { params(hash: T::Hash[Symbol, T.untyped]).returns(TodoItem) }
  def self.from_h(hash)
    new(
      T.cast(hash[:title], String),
      id: T.cast(hash[:id], T.nilable(String)),
      completed: T.cast(hash[:completed], T::Boolean),
      created_at: T.cast(hash[:created_at], T.nilable(String))
    )
  end

  sig { returns(String) }
  def to_s
    status = @completed ? "[x]" : "[ ]"
    "#{status} #{@title} (ID: #{@id})"
  end
end

