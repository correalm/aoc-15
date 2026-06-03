require_relative "../logger/logger"

module Day3
  extend self

  extend Logger

  Coordinate = Struct.new(:x, :y)

  class Deliverer
    attr_reader :visited_houses_coordinates

    def initialize
      @last_delivery_coordinate = Coordinate.new(0, 0)
      @visited_houses_coordinates = Set.new([@last_delivery_coordinate])
    end

    def self.parse_delivery_instruction(instruction)
      case instruction
      when "^" then Coordinate.new(1, 0)
      when "v" then Coordinate.new(-1, 0)
      when ">" then Coordinate.new(0, 1)
      when "<" then Coordinate.new(0, -1)
      else raise "Unknown direction #{instruction}"
      end
    end

    def delivery_on(instruction)
      next_coordinate = get_next_coordinate_from(instruction)

      @visited_houses_coordinates.add next_coordinate

      @last_delivery_coordinate = next_coordinate
    end

    def visited_houses_count
      @visited_houses_coordinates.size
    end

    private

    def get_next_coordinate_from(instruction)
      Coordinate.new(@last_delivery_coordinate.x + instruction.x,
                     @last_delivery_coordinate.y + instruction.y)
    end
  end
  
  def part_one
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      line = file.readline


      santa = Deliverer.new
      line.strip.each_char{ |c| santa.delivery_on(Deliverer.parse_delivery_instruction(c)) }

      log(day: 3, part: 1, result: santa.visited_houses_count)
    end
  end

  def part_two
    File.open(File.expand_path("puzzle.txt", __dir__)) do |file|
      line = file.readline

      santa = Deliverer.new
      robo_santa = Deliverer.new

      line.strip.each_char.with_index do |c, index|
        is_santa_step = index % 2 == 0

        if is_santa_step
          santa.delivery_on(Deliverer.parse_delivery_instruction(c))
        else
          robo_santa.delivery_on(Deliverer.parse_delivery_instruction(c))
        end
      end

      result = santa.visited_houses_coordinates.union(robo_santa.visited_houses_coordinates).size
      log(day: 3, part: 2, result: result)
    end
  end
end

Day3.part_one
Day3.part_two
