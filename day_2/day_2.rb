module Day2
  extend self

  def part_one
    file = read_file
    parsed_lines = parse_lines_from(file)

    result = parsed_lines.map do |dimension|
      calculate_total_area(calculate_surface_area_of(dimension),
                           find_small_side_of(dimension))
    end

    p "Part I: #{result.sum}"

    file.close
  end

  def part_two
    file = read_file
    parsed_lines = parse_lines_from(file)

    result = parsed_lines.map do |dimension|
      cubic_volume = calculate_cubic_volume_of(dimension)
      smallest_perimeter = find_smallest_perimeter_of(dimension)

      cubic_volume + smallest_perimeter
    end

    p "Part II: #{result.sum}"

    file.close
  end

  private

  Dimension = Struct.new("Dimension", :length, :width, :height)

  def calculate_total_area(surface_area, extra)
    surface_area + extra
  end

  def calculate_cubic_volume_of(dimension)
    dimension.length * dimension.width * dimension.height
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

  def find_smallest_perimeter_of(dimension)
    l = dimension.length
    w = dimension.width
    h = dimension.height

    [(2*l + 2*w), (2*w + 2*h), (2*h + 2*l)].min
  end

  def parse_lines_from(file)
    lines = read_lines_from(file)
    lines.map{ |line| parse(line) }
  end

  def read_lines_from(file)
    file.each_line(chomp: true)
  end

  def parse(line)
    # each line is lxwxh (10x1x1)
    values = line.split("x")

    Dimension.new(values[ 0 ].to_i, values[ 1 ].to_i, values[ 2 ].to_i)
  end

  def read_file
    File.new('puzzle.txt')
  end
end

Day2.part_one
Day2.part_two
