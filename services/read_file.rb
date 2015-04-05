class ReadFile
  PATH_TO_FILE = "#{File.dirname(__FILE__)}/../data/poker.txt"

  def call
    file = File.read(PATH_TO_FILE).split
  end
end