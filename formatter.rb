class Formatter
  def self.display_sorted_output
    master = CSV.open("master_file").to_a

    header = ["LastName", "FirstName", "Gender", "FavoriteColor", "DateOfBirth"]

    puts "\n"

    p "OUTPUT 1: SORT BY GENDER THEN LAST NAME ASC"
    format_row(header)

    sorted_csv = CSVSorter.new(master).sort_by_gender_then_last_name_asc

    sorted_csv.each do |row|
      format_row(row)
    end

    puts "\n"

    p "OUTPUT 2: SORT BY BIRTHDAY ASC"
    format_row(header)

    sorted_csv = CSVSorter.new(master).sort_by_date_asc

    sorted_csv.each do |row|
      format_row(row)
    end

    puts "\n"

    p "OUTPUT 3: SORT BY LAST NAME DESC"
    format_row(header)

    sorted_csv = CSVSorter.new(master).sort_by_last_name_desc

    sorted_csv.each do |row|
      format_row(row)
    end
  end

  def self.format_row(row)
    row.each do |item|
      while item.length < 20
        item << " "
      end
    end
    puts row[0] + row[1].rjust(20) + row[2].rjust(20) + row[4].rjust(15) + row[3].rjust(20)
  end
end
