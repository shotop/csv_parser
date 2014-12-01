require 'csv'
require 'time'

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

  def sort_by_date_asc(rows)
    rows.sort_by! {|column| Time.strptime(column[4], "%m/%d/%Y")}
  end

  def sort_by_last_name_desc(rows)
    rows.sort_by! {|column| column[0]}.reverse
  end

  def sort_by_gender_then_last_name_asc(rows)
    rows.sort_by! {|column| [column[2], column[0]]}
  end
end