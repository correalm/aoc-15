module Day2
  extend self

  def call
    file = read_file

    lines = read_lines_from(file)
    parsed_lines = lines.map{ |line| parse(line) }

    result = parsed_lines.map do |dimension|
      calculate_total_area(calculate_surface_area_of(dimension),
                           find_small_side_of(dimension))
    end

    p result.sum

    file.close
  end

  private

  Dimension = Struct.new("Dimension", :length, :width, :height)

  def calculate_total_area(surface_area, extra)
    surface_area + extra
  end

  def calculate_surface_area_of(dimension)
    (2 * dimension.length * dimension.width) +
    (2 * dimension.width * dimension.height) +
    (2 * dimension.height * dimension.length)
  end

  def find_small_side_of(dimension)
    l = dimension.length
    w = dimension.width
    h = dimension.height

    [(l*w), (w*h), (h*l)].min
  end

  def parse(line)
    # each line is lxwxh (10x1x1)
    values = line.split("x")

    Dimension.new(values[ 0 ].to_i, values[ 1 ].to_i, values[ 2 ].to_i)
  end

  def read_file
    File.new('puzzle.txt')
  end

  def read_lines_from(file)
    file.each_line(chomp: true)
  end
end

Day2.call
