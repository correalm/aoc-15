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
        coordinate = get_new_coordinate_from(last_know_coordinate, parse_next_move(c))

        coordinates.add coordinate

        last_know_coordinate = coordinate
      end

      p coordinates.size
    end
  end

  def part_two
  end

  private

  def get_new_coordinate_from(last_know_coordinate, next_move)
    Coordinate.new(last_know_coordinate.x + next_move.x,
                   last_know_coordinate.y + next_move.y)
  end

  def parse_next_move(c)
    case c
    when "^" then Coordinate.new(1, 0)
    when "v" then Coordinate.new(-1, 0)
    when ">" then Coordinate.new(0, 1)
    when "<" then Coordinate.new(0, -1)
    else raise "Unknown direction #{c}"
    end
  end
end

Day3.part_one
Day3.part_two
