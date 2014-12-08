require_relative 'csv_preprocessor'

class FileCombiner
  def initialize(*files)
    @files = files
  end

  def combine_inputs
    @files.each do |file|

      CSV.open('master_file', 'a') do |csv_object|
        preprocessed_csv = CSVPreprocessor.new(file).preprocess_input
        preprocessed_csv.each do |row|
          csv_object << row
        end
      end
    end
  end

  def self.add_row_to_master(single_row)
    CSV.open('../master_file', 'a') do |csv_object|
      preprocessed_row = CSVPreprocessor.new(nil, single_row).preprocess_single_row
      csv_object << preprocessed_row
    end
  end
end