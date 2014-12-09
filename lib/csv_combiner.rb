require_relative 'csv_preprocessor'

class CSVCombiner
  def initialize(*files)
    @files = files
  end

  def combine_inputs
    @files.each do |file|

      CSV.open('data/tmp', 'a') do |csv_object|
        preprocessed_csv = CSVPreprocessor.new(file).preprocess_input
        preprocessed_csv.each do |row|
          csv_object << row
        end
      end
    end
    update_column_order
  end

  def update_column_order
    CSV.open('data/master_file', 'w+') do |master|
      CSV.read('data/tmp').each do |line|
        master << [line[0], line[1], line[2], line[4], line[3]]
      end
    end
  end

  def add_row_to_master(single_row)
    CSV.open('data/master_file', 'a') do |csv_object|
      row = CSVPreprocessor.new(nil, single_row).preprocess_single_row
      csv_object << [row[0], row[1], row[2], row[4], row[3]]
    end
  end
end