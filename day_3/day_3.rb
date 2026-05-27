module Day3
  extend self

  Coordinate = Struct.new(:x, :y)
  
  def part_one
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      line = file.readline

      start = Coordinate.new(0, 0)
      coordinates = Set.new([start])

      last_know_coordinate = start

      line.strip.each_char do |c|
        coordinate = get_new_coordinate(last_know_coordinate, parse_coordinate(c))

        coordinates.add coordinate

        last_know_coordinate = coordinate
      end

      p coordinates.size
    end
  end

  def part_two
  end

  private

  def get_new_coordinate(last_know_coordinate, new_coordinate)
    Coordinate.new(last_know_coordinate.x + new_coordinate[:x],
                   last_know_coordinate.y + new_coordinate[:y])
  end

  def parse_coordinate(c)
    case c
    when "^" then { x:  1, y: 0 }
    when "v" then { x: -1, y: 0 }
    when ">" then { y:  1, x: 0 }
    when "<" then { y: -1, x: 0 }
    else raise "Unknown direction #{c}"
    end
  end
end

Day3.part_one
Day3.part_two
