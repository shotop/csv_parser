require 'spec_helper'

describe "file_sorter" do
  before(:each) do
    File.delete("master_file") if File.exist?("master_file")
  end

  let(:valid_args) { ["ReverbCommaTestData", "ReverbPipeTestData", "ReverbSpaceTestData"] }
  let(:invalid_args) { ["ReverbCommaTestData", "ReverbPipeTestData"] }

  describe '#arguments_valid?' do

    context 'valid arguments' do

      let(:file_sorter) {FileSorter.new(valid_args)}

      it 'is true when arguments are valid' do
        expect(file_sorter.arguments_valid?).to be true
      end
    end

    context 'invalid arguments' do

      let(:file_sorter) {FileSorter.new(invalid_args)}

      it 'is false when arguments are invalid' do
        expect(file_sorter.arguments_valid?).to be false
      end
    end
  end

  describe '#preprocess_input' do

    let(:file_sorter) {FileSorter.new(valid_args)}
    let(:comma_separated_data) {valid_args[0]}
    let(:pipe_separated_data) {valid_args[1]}
    let(:space_separated_data) {valid_args[2]}

    context 'processing input data with various delimiters' do

      it 'parses comma-separated data' do
        result = [["Hotop", "Tom", "Male", "Blue", "09/25/1971"]]

        processed_csv = file_sorter.preprocess_input(comma_separated_data)

        expect(processed_csv).to eq(result)
      end

      it 'parses pipe-separated data' do
        result = [["Coca", "Andrea", "Female", "Blue", "02/25/1983"]]

        processed_csv = file_sorter.preprocess_input(pipe_separated_data)

        expect(processed_csv).to eq(result)
      end

      it 'parses space-separated data' do
        result = [["Gerard", "Tom", "Male", "Blue", "02/26/1983"]]

        processed_csv = file_sorter.preprocess_input(space_separated_data)

        expect(processed_csv).to eq(result)
      end
    end
  end

  describe '#combine_inputs' do
    let(:file_sorter) {FileSorter.new(valid_args)}

    it 'creates the master file' do
      file_sorter.combine_inputs(valid_args[0], valid_args[1], valid_args[2])

      expect(File.exists?('master_file')).to be true
    end

    it 'appends input data to master file' do

      contents = [["Hotop", "Tom", "Male", "Blue", "09/25/1971"],
                  ["Coca", "Andrea", "Female", "Blue", "02/25/1983"],
                  ["Gerard", "Tom", "Male", "Blue", "02/26/1983"]]

      file_sorter.combine_inputs(valid_args[0], valid_args[1], valid_args[2])

      expect(CSV.read('master_file')).to eq(contents)
    end
  end
end