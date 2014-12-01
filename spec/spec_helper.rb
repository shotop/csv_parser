require 'rspec'

require_relative '../file_sorter'

RSpec.configure do |config|
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