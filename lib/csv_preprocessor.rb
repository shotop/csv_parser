class CSVPreprocessor
  def initialize(input_file="", single_row="")
    @input_file = input_file
    @single_row = single_row
  end

  def preprocess_input
    headers = File.open(@input_file).first
    separator = determine_separator_for(headers)

    processed_csv = CSV.read(@input_file, { :col_sep => separator })
    processed_csv.shift #remove headers

    return processed_csv
  end

  def preprocess_single_row
    separator = determine_separator_for(@single_row)
    @single_row.split(separator)
  end

  private

  def determine_separator_for(item)
    if item =~ /[,]/
      separator = ","
    elsif item =~ /[|]/
      separator = "|"
    else
      separator = " "
    end
  end
end