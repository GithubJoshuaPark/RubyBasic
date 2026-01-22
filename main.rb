require_relative 'samples/utils/Utils'

module Main
  extend Utils # Make Utils methods available as class/module methods
  extend self  # Make instance methods (load_samples, print_menu) available as module methods

  def load_samples
    # load all .rb files in samples directory
    # sort by filename
    # return array of file paths
    Dir.glob("samples/*.rb").sort
  end

  def print_menu(samples)
    # print menu
    puts "\n💎 --- Ruby Sample Runner --- 💎"
    samples.each_with_index do |file, index|
      # print file name without extension
      puts "   #{index + 1}. #{Utils.getOneIconRandomlyAmong20Icons} #{File.basename(file, ".rb")}"
    end
    puts "   0. 🚪 Exit"
    print "\n👉 Select a number to run: "
  end

  def self.run
    log "Running Main sample..."

    # Create samples directory if it doesn't exist
    Dir.mkdir("samples") unless Dir.exist?("samples")

    loop do
      # load samples
      samples = load_samples
      print_menu(samples)

      # get user input
      input = gets.chomp

      if input.empty?
        puts "⚠️  Please select a number."
        next
      end

      choice = input.to_i

      # exit if user selects 0
      if choice == 0 && input == "0"
        puts "\n💎 Goodbye! 💎\n\n"
        break
      elsif choice > 0 && choice <= samples.length
        selected_file = samples[choice - 1]
        # run selected file
        puts "\n💎 [Run] running #{selected_file}... 💎\n\n"

        begin
          # Load the file to define the module
          load selected_file

          # Derive module name from filename (e.g., "02_basic" -> "Basic")
          basename = File.basename(selected_file, ".rb")
          parts = basename.split('_')
          parts.shift if parts.first.match?(/^\d+$/) # Remove leading number if present
          module_name = parts.map(&:capitalize).join

          # Find the module and call the run method
          if Object.const_defined?(module_name)
            module_obj = Object.const_get(module_name)
            if module_obj.respond_to?(:run)
              module_obj.run
            else
              puts "⚠️  Module #{module_name} does not have a 'run' method."
            end
          else
            puts "⚠️  Module #{module_name} not found in #{selected_file}."
          end
        rescue StandardError => e
          puts "❌ Error running sample: #{e.message}"
          puts e.backtrace.first(3)
        end

        puts "\n💎 [End] Completed #{selected_file} 💎\n\n"
      else
        # invalid selection
        puts "Invalid selection!"
      end
    end
  end
end

if __FILE__ == $0
  Main.run
end