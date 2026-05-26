module Explorer
  extend self

  def read_file(path)
    File.new(path)
  end

  def read_lines_from(file)
    file.each_line(chomp: true)
  end
end
