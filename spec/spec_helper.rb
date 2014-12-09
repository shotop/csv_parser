require 'rspec'
require 'rack'
require 'rack/test'
require 'rack/server'
require 'grape'

require_relative '../file_parser'
require_relative '../lib/file_combiner'
require_relative '../lib/csv_preprocessor'
require_relative '../lib/csv_sorter'
require_relative '../lib/argument_validator'
require_relative '../lib/formatter'
require_relative '../api/file_parser_api'



RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end