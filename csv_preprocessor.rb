class CSVPreprocessor
  def initialize(input_file)
    @input_file = input_file
  end

  def preprocess_input
    headers = File.open(@input_file).first
    if headers =~ /[,]/
      separator = ","
    elsif headers =~ /[|]/
      separator = "|"
    else
      separator = " "
    end

    processed_csv = CSV.read(@input_file, { :col_sep => separator })
    processed_csv.shift #remove headers

    return processed_csv
  end
end