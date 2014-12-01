class FileSorter
  attr_reader :arguments

  def initialize(arguments)
    @arguments = arguments
  end

  def arguments_valid?
    @arguments.length == 3 ? true : false
  end
end