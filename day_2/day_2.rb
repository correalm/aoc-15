require_relative "../logger/logger"

module Day2
  extend self

  extend Logger

  Box = Struct.new(:length, :width, :height)

  private_constant :Box

  def part_one
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      parsed_lines = parse_lines_from(file)

      result = parsed_lines.map do |box|
        calculate_total_area(calculate_surface_area_of(box),
                             find_small_side_of(box))
      end

      log(day: 2, part: 1, result: result.sum)
    end
  end

  def part_two
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      parsed_lines = parse_lines_from(file)

      result = parsed_lines.map do |box|
        cubic_volume = calculate_cubic_volume_of(box)
        smallest_perimeter = find_smallest_perimeter_of(box)

        cubic_volume + smallest_perimeter
      end

      log(day: 2, part: 2, result: result.sum)
    end
  end

  private

  def calculate_total_area(surface_area, extra)
    surface_area + extra
  end

  def calculate_cubic_volume_of(box)
    box.length * box.width * box.height
  end

  def calculate_surface_area_of(box)
    (2 * box.length * box.width) +
    (2 * box.width * box.height) +
    (2 * box.height * box.length)
  end

  def find_small_side_of(box)
    l = box.length
    w = box.width
    h = box.height

    [(l*w), (w*h), (h*l)].min
  end

  def find_smallest_perimeter_of(box)
    l = box.length
    w = box.width
    h = box.height

    [(2*l + 2*w), (2*w + 2*h), (2*h + 2*l)].min
  end

  def parse_lines_from(file)
    file.each_line(chomp: true).lazy.map{ |l| parse(l) }
  end

  def parse(line)
    # each line is lxwxh (10x1x1)
    values = line.split("x")

    Box.new(values[ 0 ].to_i, values[ 1 ].to_i, values[ 2 ].to_i)
  end
end

Day2.part_one
Day2.part_two
