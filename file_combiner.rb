class FileCombiner
  def initialize(*files)
    @files = files
  end

  def combine_inputs
    @files.each do |file|

      CSV.open('master_file', 'a') do |csv_object|
        preprocess_input(file).each do |row|
          csv_object << row
        end
      end
    end
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
end