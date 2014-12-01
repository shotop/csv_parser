require 'csv'

class FileSorter
  attr_reader :arguments

  def initialize(arguments)
    @arguments = arguments
  end

  def arguments_valid?
    @arguments.length == 3 ? true : false
  end

  def preprocess_input(input_file)
    headers = File.open(input_file).first
    if headers =~ /[,]/
      separator = ","
    elsif headers =~ /[|]/
      separator = "|"
    else
      separator = " "
    end

    processed_csv = CSV.read(input_file, { :col_sep => separator })
    processed_csv.shift #remove headers

    return processed_csv
  end

  def combine_inputs(*args)
    args.each do |arg_item|

      CSV.open('master_file', 'a') do |csv_object|
        preprocess_input(arg_item).each do |row|
          csv_object << row
        end
      end
    end
  end
end