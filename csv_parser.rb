require 'csv'
require_relative 'lib/csv_combiner'
require_relative 'lib/csv_sorter'
require_relative 'lib/argument_validator'
require_relative 'lib/json_formatter'
require_relative 'lib/console_formatter'

class FileParser
  def initialize(arguments)
    @arguments = arguments
  end

  def run
    if ArgumentValidator.new(@arguments).arguments_valid?
      CSVCombiner.new(@arguments[0], @arguments[1], @arguments[2]).combine_inputs
      ConsoleFormatter.new.display_sorted_output
    else
      puts "Not the right number of arguments."
      puts "Usage: ruby file_parser.rb input_file_1 input_file_2 input_file_3"
    end
  end
end

file_parser = FileParser.new(ARGV)
File.truncate("data/master_csv", 0) if File.exist?("data/master_csv")
File.truncate("data/tmp", 0) if File.exist?("data/tmp")
file_parser.run
