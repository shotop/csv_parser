require 'csv'
require_relative 'csv_sorter'
require_relative 'formatter'

class JsonFormatter < Formatter
  def initialize
    super
  end

  def format_for_json(sort)
    master = CSV.read(Dir.glob("../**/master_csv").first).to_a

    sorted_csv = CSVSorter.new(master).send(sort)

    records = Hash.new { |h,k| h[k] = [] }

    sorted_csv.each do |row|
      records[:Records] << Hash[@header[0..-1].zip(row[0..-1])]
    end
    records
  end
end