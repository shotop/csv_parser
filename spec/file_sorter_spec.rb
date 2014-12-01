require 'spec_helper'

describe "file_sorter" do

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
end