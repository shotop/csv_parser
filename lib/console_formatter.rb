require_relative 'formatter'

class ConsoleFormatter < Formatter
  def initialize
    super
  end

  def display_sorted_output
    master = CSV.read("data/master_csv").to_a

    sorts = ["sort_by_gender_then_last_name_asc", "sort_by_date_asc", "sort_by_last_name_desc"]

    sorts.each_with_index do |sort, index|
      puts "\n"
      puts "OUTPUT #{index + 1}: #{sort.gsub(/_/,' ').upcase}"
      format_row(@header)
      sorted_csv = CSVSorter.new(master).send(sort)
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
    puts row[0] + row[1].rjust(20) + row[2].rjust(20) + row[3].rjust(15) + row[4].rjust(20)
  end
end