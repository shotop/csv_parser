require 'csv'
require 'time'

class FileSorter
  attr_reader :arguments

  def initialize(arguments)
    @arguments = arguments
  end

  def run
    if arguments_valid?
      combine_inputs(@arguments[0], @arguments[1], @arguments[2])
      display_sorted_output
    else
      puts "Not the right number of arguments."
      puts "Usage: ruby file_sorter.rb input_file_1 input_file_2 input_file_3"
    end
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

  def format_row(row)
    row.each do |item|
      while item.length < 20
        item << " "
      end
    end
    puts row[0] + row[1].rjust(20) + row[2].rjust(20) + row[4].rjust(15) + row[3].rjust(20)
  end

  def display_sorted_output
    master = CSV.open("master_file").to_a

    header = ["LastName", "FirstName", "Gender", "FavoriteColor", "DateOfBirth"]

    puts "\n"

    p "OUTPUT 1: SORT BY GENDER THEN LAST NAME ASC"
    format_row(header)

    sort_by_gender_then_last_name_asc(master).each do |row|
      format_row(row)
    end

    puts "\n"

    p "OUTPUT 2: SORT BY BIRTHDAY ASC"
    format_row(header)

    sort_by_date_asc(master).each do |row|
      format_row(row)
    end

    puts "\n"

    p "OUTPUT 3: SORT BY LAST NAME DESC"
    format_row(header)

    sort_by_last_name_desc(master).each do |row|
      format_row(row)
    end
  end
end

file_sorter = FileSorter.new(ARGV)
file_sorter.run
File.delete("master_file") if File.exist?("master_file")