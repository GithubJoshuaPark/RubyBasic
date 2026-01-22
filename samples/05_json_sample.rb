# typed: true
require 'json'
require_relative 'utils/Utils'

module JsonSample
  extend Utils

  def self.run
    log "Running JsonSample sample..."

    puts "--- 1. Ruby Hash to JSON String ---"

    # Simple Ruby Hash
    todo_item = {
      id: 1,
      title: "Learn JSON in Ruby",
      completed: false,
      tags: ["ruby", "json", "storage"]
    }

    # Convert Hash to JSON string
    # pretty_generate makes it readable (indented)
    json_string = JSON.pretty_generate(todo_item)

    puts "Ruby Hash: #{todo_item}"
    puts "JSON String:\n#{json_string}"
    puts "\n"


    puts "--- 2. Save JSON to File ---"
    current_dir = Dir.pwd
    filename = "#{current_dir}/todo_data.json"

    # Write string to file
    File.write(filename, json_string)
    puts "Saved to '#{filename}' successfully."
    puts "\n"


    puts "--- 3. Read JSON from File ---"

    if File.exist?(filename)
      # Read file content
      file_content = File.read(filename)

      # Parse JSON string back to Ruby Hash
      # symbolize_names: true converts keys to Symbols (e.g. :title) instead of Strings ("title")
      loaded_data = JSON.parse(file_content, symbolize_names: true)

      puts "Loaded Data Class: #{loaded_data.class}"
      puts "Title: #{loaded_data[:title]}"
      puts "Tags: #{loaded_data[:tags].join(', ')}"
    else
      puts "File not found!"
    end
    puts "\n"
  end
end

if __FILE__ == $0
  JsonSample.run
end