# typed: true
# 03_file_io.rb
require_relative 'utils/Utils'

module FileIo
  extend Utils

  def self.run
    filename = "sample.txt"

    # 1. Write to a file (Mode 'w' - Write/Overwrite)
    # Using a block automatically closes the file after writing.
    puts "--- 1. Writing to #{filename} ---"
    File.open(filename, "w") do |file|
      file.puts "Ruby is fun!"
      file.puts "File I/O is easy."
      file.write "This is the third line." # write vs puts: 'puts' adds a newline, 'write' does not.
    end
    log "File created successfully."


    # 2. Read the entire file (Simple)
    puts "--- 2. Reading entire file content ---"
    if File.exist?(filename)
      content = File.read(filename)
      log content
    else
      log "File not found!"
    end
    log "\n"


    # 3. Append to a file (Mode 'a' - Append)
    puts "--- 3. Appending to #{filename} ---"
    File.open(filename, "a") do |file|
      file.puts "\nThis line is appended."
    end
    log "Content appended.\n\n"


    # 4. Read line by line (Efficient for large files)
    puts "--- 4. Reading line by line ---"
    number = 1
    if File.exist?(filename)
      File.foreach(filename) do |line|
        # line contains the trailing newline character, so we prefer 'chomp'
        log "Line #{number}: #{line.chomp}"
        number += 1
      end
    end
    log "\n"
  end
end

if __FILE__ == $0
  FileIo.run
end

# Hint:
# Python's `with open(...) as f:` is exactly `File.open(...) do |f|` in Ruby.

