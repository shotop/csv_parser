require 'spec_helper'

describe "file_sorter" do
  before(:each) do
    File.truncate("master_file", 0) if File.exist?("master_file")
    File.truncate("tmp", 0) if File.exist?("tmp")
  end

  let(:valid_args) { ["spec/test_data/ReverbCommaTestData", "spec/test_data/ReverbPipeTestData", "spec/test_data/ReverbSpaceTestData"] }
  let(:invalid_args) { ["spec/test_data/ReverbCommaTestData", "spec/test_data/ReverbPipeTestData"] }

  describe 'arguments_valid?' do

    context 'valid arguments' do

      let(:argument_validator) {ArgumentValidator.new(valid_args)}

      it 'is true when arguments are valid' do
        expect(argument_validator.arguments_valid?).to be true
      end
    end

    context 'invalid arguments' do

      let(:argument_validator) {ArgumentValidator.new(invalid_args)}

      it 'is false when arguments are invalid' do
        expect(argument_validator.arguments_valid?).to be false
      end
    end
  end

  describe 'preprocess_input' do

    let(:comma_separated_data) {valid_args[0]}
    let(:pipe_separated_data) {valid_args[1]}
    let(:space_separated_data) {valid_args[2]}

    context 'processing input data with various delimiters' do

      it 'parses comma-separated data' do
        result = [["Hotop", "Tom", "Male", "Blue", "09/25/1971"]]

        processed_csv = CSVPreprocessor.new(comma_separated_data).preprocess_input

        expect(processed_csv).to eq(result)
      end

      it 'parses pipe-separated data' do
        result = [["Coca", "Andrea", "Female", "Blue", "02/25/1983"]]

        processed_csv = CSVPreprocessor.new(pipe_separated_data).preprocess_input

        expect(processed_csv).to eq(result)
      end

      it 'parses space-separated data' do
        result = [["Gerard", "Tom", "Male", "Blue", "02/26/1983"]]

        processed_csv = CSVPreprocessor.new(space_separated_data).preprocess_input

        expect(processed_csv).to eq(result)
      end
    end
  end

  describe 'combine_inputs' do
    let(:file_combiner) {FileCombiner.new(valid_args[0], valid_args[1], valid_args[2])}

    it 'creates the master file' do
      file_combiner.combine_inputs

      expect(File.exists?('master_file')).to be true
    end

    it 'appends input data to master file' do

      contents = [["Hotop", "Tom", "Male", "09/25/1971", "Blue"],
                  ["Coca", "Andrea", "Female", "02/25/1983", "Blue"],
                  ["Gerard", "Tom", "Male", "02/26/1983", "Blue"]]

      file_combiner.combine_inputs

      expect(CSV.read('master_file')).to eq(contents)
    end
  end

  describe 'sort' do

    it 'sorts by date asc' do
      input_rows = [["Hotop", "Tom", "Male", "09/25/1971", "Blue"],
                    ["Hotop", "Tom", "Male", "08/25/1971", "Blue"]]

      sorted_rows = [["Hotop", "Tom", "Male", "08/25/1971", "Blue"],
                     ["Hotop", "Tom", "Male", "09/25/1971", "Blue"]]

      expect(CSVSorter.new(input_rows).sort_by_date_asc).to eq(sorted_rows)
    end

    it 'sorts by last name desc' do
      input_rows = [["Geronimo", "Tom", "Male", "Blue", "08/25/1971"],
                    ["Hotop", "Tom", "Male", "Blue", "09/25/1971"]]

      sorted_rows = [["Hotop", "Tom", "Male", "Blue", "09/25/1971"],
                     ["Geronimo", "Tom", "Male", "Blue", "08/25/1971"]]


      expect(CSVSorter.new(input_rows).sort_by_last_name_desc).to eq(sorted_rows)
    end

    it 'sorts by gender then last name asc' do
      input_rows = [["Hotop", "Tom", "Male", "Blue", "09/25/1971"],
                    ["Geronimo", "Tom", "Male", "Blue", "08/25/1971"],
                    ["Coca", "Andrea", "Female", "Blue", "09/25/1971"]]

      sorted_rows = [["Coca", "Andrea", "Female", "Blue", "09/25/1971"],
                     ["Geronimo", "Tom", "Male", "Blue", "08/25/1971"],
                     ["Hotop", "Tom", "Male", "Blue", "09/25/1971"]]

      expect(CSVSorter.new(input_rows).sort_by_gender_then_last_name_asc).to eq(sorted_rows)
    end
  end

  describe 'format_rows' do
    it 'formats csv rows for better console output' do
      input_row = ["Hotop", "Tom", "Male", "Blue", "09/25/1971"]

      output = capture_stdout { Formatter.new.format_row(input_row) }
      expect(output).to include "Hotop               Tom"
    end
  end

  describe 'run' do
    context 'unsuccessful run' do
      let(:file_parser) {FileParser.new(invalid_args)}

      it 'raises an error when there arent three input files' do
        output = capture_stdout { file_parser.run }
        expect(output).to include "Not the right number of arguments."
      end
    end


    context 'successful run' do
      let(:file_parser) {FileParser.new(valid_args)}

      it 'runs successfully' do
        output = capture_stdout { file_parser.run }
        expect(output).to include "OUTPUT"
      end
    end
  end

  # after(:all) do
  #   File.truncate("master_file", 0) if File.exist?("master_file")
  #   File.truncate("tmp", 0) if File.exist?("tmp")
  # end
end