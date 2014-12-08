require 'csv'
require 'json'
require_relative 'csv_sorter'

class Formatter

  def initialize
    @master = CSV.open("../master_file").to_a
    @header = ["LastName", "FirstName", "Gender", "FavoriteColor", "DateOfBirth"]
  end

  def display_sorted_output
    sorts = ["sort_by_gender_then_last_name_asc", "sort_by_date_asc", "sort_by_last_name_desc"]

    sorts.each_with_index do |sort, index|
      puts "\n"
      puts "OUTPUT #{index + 1}: #{sort.gsub(/_/,' ').upcase}"
      format_row(@header)
      sorted_csv = CSVSorter.new(@master).send(sort)
      sorted_csv.each do |row|
        format_row(row)
      end
    end
  end

  def format_row(row)
    row.each do |item|
      while item.length < 20
        item << " "
      end
    end
    puts row[0] + row[1].rjust(20) + row[2].rjust(20) + row[4].rjust(15) + row[3].rjust(20)
  end


  def format_for_json(sort)
    sorted_csv = CSVSorter.new(@master).send(sort)
    update_column_order(sorted_csv)

    records = Hash.new { |h,k| h[k] = [] }

    sorted_csv.each do |row|
      records[:Records] << Hash[@header[0..-1].zip(row[0..-1])]
    end
    records
  end

  private

  def update_column_order(csv)
    CSV.open("../master_file", "w") do |master|
      csv.each do |line|
        master << [line[0], line[1], line[2], line[4], line[3]]
      end
    end
  end
end
