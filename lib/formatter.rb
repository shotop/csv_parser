class Formatter
  def initialize
    @header = ["LastName", "FirstName", "Gender", "DateOfBirth", "FavoriteColor"]
    @master = CSV.read(Dir.glob("../**/master_csv").first).to_a
  end
end
