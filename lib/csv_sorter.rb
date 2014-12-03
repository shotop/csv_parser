require 'time'

class CSVSorter
  def initialize(csv)
    @csv = csv
  end

  def sort_by_date_asc
    @csv.sort_by! {|column| Time.strptime(column[4], "%m/%d/%Y")}
  end

  def sort_by_last_name_desc
    @csv.sort_by! {|column| column[0]}.reverse
  end

  def sort_by_gender_then_last_name_asc
    @csv.sort_by! {|column| [column[2], column[0]]}
  end
end