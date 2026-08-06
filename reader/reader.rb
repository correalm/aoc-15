module Reader
  def read_lines(filename:, dir:)
    File.foreach(File.expand_path(filename, dir))
  end

  def read_line(filename:, dir:)
    File.open(File.expand_path(filename, dir)).readline
  end
end
