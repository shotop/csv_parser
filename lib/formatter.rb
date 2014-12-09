require 'csv'
require 'json'
require_relative 'csv_sorter'

class Formatter
  HEADER = ["LastName", "FirstName", "Gender", "DateOfBirth", "FavoriteColor"]


  def self.display_sorted_output
    master = CSV.read("data/master_csv").to_a

    sorts = ["sort_by_gender_then_last_name_asc", "sort_by_date_asc", "sort_by_last_name_desc"]

    sorts.each_with_index do |sort, index|
      puts "\n"
      puts "OUTPUT #{index + 1}: #{sort.gsub(/_/,' ').upcase}"
      format_row(HEADER)
      sorted_csv = CSVSorter.new(master).send(sort)
      sorted_csv.each do |row|
        format_row(row)
      end
    end
  end

  def self.format_row(row)
    row.each do |item|
      while item.length < 20
        item << " "
      end
    end
    puts row[0] + row[1].rjust(20) + row[2].rjust(20) + row[3].rjust(15) + row[4].rjust(20)
  end


  def self.format_for_json(sort)
    master = CSV.read(Dir.glob("../**/master_csv").first).to_a

    sorted_csv = CSVSorter.new(master).send(sort)

    records = Hash.new { |h,k| h[k] = [] }

    sorted_csv.each do |row|
      records[:Records] << Hash[HEADER[0..-1].zip(row[0..-1])]
    end
    records
  end
end
