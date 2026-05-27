module Day3
  extend self

  Coordinate = Struct.new(:x, :y)
  
  def part_one
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      line = file.readline

      start = Coordinate.new(0, 0)
      coordinates = Set.new([start])

      last_know_position = start

      count_of_visited_houses = 1

      line.strip.each_char do |c|
        coordinate = get_new_coordinate(last_know_position, parse_coordinate(c))

        count_of_visited_houses += 1 unless coordinates.include? coordinate

        coordinates.add coordinate

        last_know_position = coordinate
      end

      p count_of_visited_houses
    end
  end

  def part_two
  end

  private

  def get_new_coordinate(last_know_position, new_coordinate)
    coordinate = Coordinate.new(last_know_position[:x], last_know_position[:y])
    coordinate.x += new_coordinate[:x]
    coordinate.y += new_coordinate[:y]

    coordinate
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
